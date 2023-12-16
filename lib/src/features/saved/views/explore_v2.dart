import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vmodel/src/features/saved/controller/provider/user_boards_controller.dart';
import 'package:vmodel/src/vmodel.dart';
import 'package:vmodel/src/res/icons.dart';
import '../../../res/res.dart';
import '../../../shared/bottom_sheets/confirmation_bottom_sheet.dart';
import '../../../shared/bottom_sheets/tile.dart';
import '../../../shared/buttons/text_button.dart';
import '../../../shared/empty_page/empty_page.dart';

import '../../../core/utils/debounce.dart';
import '../../../shared/loader/full_screen_dialog_loader.dart';
import '../../../shared/modal_pill_widget.dart';
import '../../../shared/popup_dialogs/response_dialogue.dart';
import '../../../shared/rend_paint/render_svg.dart';
import '../../authentication/register/provider/user_types_controller.dart';
import '../../dashboard/feed/widgets/comment/create_new_board_dialogue.dart';
import '../controller/provider/board_posts_controller.dart';
import '../controller/provider/current_selected_board_provider.dart';
import '../controller/provider/saved_provider.dart';
import '../../dashboard/feed/model/feed_model.dart';
import '../../dashboard/discover/controllers/explore_provider.dart';
import '../model/user_post_board_model.dart';
import 'feed_post_grid.dart';
import 'select_board_cover_img_grid.dart';

class ExploreV2 extends ConsumerStatefulWidget {
  const ExploreV2({
    super.key,
    required this.providerType,
    required this.title,
    // this.userPostBoard,
    // this.userPostBoard?.id,
  });

  final BoardProvider providerType;
  // final UserPostBoard? userPostBoard;
  final String title;
  // final int? userPostBoard?.id;

  @override
  ExploreV2State createState() => ExploreV2State();
}

class ExploreV2State extends ConsumerState<ExploreV2> {
  // ExplorePostGridModel? gallery;
  final TextEditingController _searchController = TextEditingController();
  late final Debounce _debounce;
  final ValueNotifier<bool> _showLoading = ValueNotifier(false);
  String _mTitle = '';

  @override
  initState() {
    super.initState();
    _mTitle = widget.title;
    _debounce = Debounce(delay: Duration(milliseconds: 300));
  }

  @override
  dispose() {
    super.dispose();
    _debounce.dispose();
    ref.invalidate(currentSelectedBoardProvider);
  }

  @override
  Widget build(BuildContext context) {
    // final galleries =
    //     ref.watch(filteredExplorePostGridListProvider("lorysonja"));
    // final userState = ref.watch(profileProvider("lorysonja"));
    // final user = userState.valueOrNull;

    final selectedBoard = ref.watch(currentSelectedBoardProvider);
    final userTypes = ref.watch(accountTypesProvider);
    AsyncValue<List<FeedPostSetModel>?> savedData;
    switch (widget.providerType) {
      case BoardProvider.allPosts:
        savedData = ref.watch(getsavedPostProvider);
        break;
      case BoardProvider.hidden:
        savedData = ref.watch(getHiddenPostProvider);
        break;
      case BoardProvider.userCreated:
        if (isUserBoardNull(selectedBoard)) {
          return EmptyPage(
            svgPath: VIcons.documentLike,
            svgSize: 30,
            subtitle: 'Invalid id',
          );
        }
        savedData = ref.watch(boardPostsProvider(selectedBoard!.board.id));
        break;
    }

    // final savedData = ref.watch(getsavedPostProvider);

    return Scaffold(
        // appBar: VWidgetsAppBar(
        //   leadingIcon:
        //       exlporePage.isExploreV2 ? null : const VWidgetsBackButton(),
        //   appbarTitle: "ExploreV2",
        //   // customBottom: ,
        // ),
        body: NestedScrollView(
      headerSliverBuilder: (context, innerBoxIsScrolled) {
        return [
          SliverAppBar(
            pinned: true,
            floating: true,
            // expandedHeight: 117,
            title: Text(
              _mTitle,
              style: Theme.of(context).textTheme.displayLarge!.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            centerTitle: true,
            // flexibleSpace: FlexibleSpaceBar(
            //   centerTitle: true,
            //   background: _titleSearch(),
            // ),
            // leadingWidth: 15j,
            leading: const VWidgetsBackButton(),
            elevation: 0,
            actions: [
              if (!isUserBoardNull(selectedBoard))
                IconButton(
                  onPressed: () {
                    _showMoreBottomSheet();
                  },
                  icon: const RenderSvg(svgPath: VIcons.moreIcon),
                ),
            ],
          ),
        ];
      },
      body: savedData.when(data: (value) {
        if (value == null || value.isEmpty) {
          return const EmptyPage(
            svgSize: 30,
            svgPath: VIcons.gridIcon,
            // title: 'No Galleries',
            subtitle: 'No content',
          );
        }

        return ExplorePostGrid(
          boardId: selectedBoard?.board.id,
          isSaved: false,
          isCurrentUser: false,
          albumID: 'Slll',
          username: "user!.username",
          userProfilePictureUrl: "",
          userProfileThumbnailUrl: '',
          posts: value,
        );
      }, error: (err, stackTrace) {
        print(stackTrace);
        return Text('There was an error $err');
      }, loading: () {
        return const Center(child: CircularProgressIndicator.adaptive());
      }),
    ));
  }

  Future<void> _showMoreBottomSheet() {
    final selectedBoard = ref.watch(currentSelectedBoardProvider);
    return showModalBottomSheet<void>(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (BuildContext context) {
          return Container(
              padding: const EdgeInsets.only(left: 16, right: 16),
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(13),
                  topRight: Radius.circular(13),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  addVerticalSpacing(15),
                  const Align(
                      alignment: Alignment.center, child: VWidgetsModalPill()),
                  addVerticalSpacing(25),
                  VWidgetsBottomSheetTile(
                    onTap: () {
                      if (isUserBoardNull(selectedBoard)) {
                        return;
                      }
                      if (context.mounted) {
                        popSheet(context);
                      }
                      navigateToRoute(
                          context,
                          SelectedBoardCoverGrid(
                            boardId: selectedBoard!.board.id,
                          ));
                    },
                    message: "Change Cover",
                  ),
                  if (!isUserBoardNull(selectedBoard))
                    const Divider(thickness: 0.5),
                  if (!isUserBoardNull(selectedBoard))
                    VWidgetsBottomSheetTile(
                      onTap: () async {
                        if (isUserBoardNull(selectedBoard)) {
                          return;
                        }

                        VLoader.changeLoadingState(true);
                        final success = await ref
                            .read(userPostBoardsProvider.notifier)
                            .togglePinnedStatus(
                              boardId: selectedBoard.board.id,
                              // pinnedStatus: selectedBoard!.pinned,
                            );
                        VLoader.changeLoadingState(false);
                        if (success && context.mounted) {
                          goBack(context);
                          responseDialog(
                              context,
                              selectedBoard.board.pinned
                                  ? "Board unpinned"
                                  : 'Board pinned');
                        }
                      },
                      message: selectedBoard!.board.pinned
                          ? "Unpin Board"
                          : "Pin Board",
                    ),
                  const Divider(thickness: 0.5),
                  if (!isUserBoardNull(selectedBoard))
                    VWidgetsBottomSheetTile(
                        onTap: () async {
                          if (isUserBoardNull(selectedBoard)) {
                            return;
                          }

                          showDialog(
                              context: context,
                              builder: (context) {
                                return CreateNewBoardDialog(
                                  title: 'Rename board',
                                  buttonText: 'Rename',
                                  controller: TextEditingController(),
                                  onSave: (title) async {
                                    final success = await ref
                                        .read(userPostBoardsProvider.notifier)
                                        .renameUserBoard(
                                          newTitle: title,
                                          boardId: selectedBoard!.board.id,
                                        );
                                    _mTitle = title.trim();
                                    setState(() {});
                                    await Future.delayed(
                                      Duration(milliseconds: 500),
                                    );
                                    if (success && context.mounted) {
                                      goBack(context);
                                      goBack(context);
                                      responseDialog(context, "Board renamed");
                                    }
                                  },
                                );
                              });

                          // VLoader.changeLoadingState(false);
                        },
                        message: 'Rename board'),
                  const Divider(thickness: 0.5),
                  VWidgetsBottomSheetTile(
                      showWarning: true,
                      onTap: () {
                        if (isUserBoardNull(selectedBoard)) {
                          return;
                        }
                        if (context.mounted) {
                          goBack(context);
                        }
                        _showDeleteConfirmation();
                      },
                      message: 'Delete Board'),
                  addVerticalSpacing(24),
                ],
              ));
        });
  }

  // getProvider

  bool isUserBoardNull(SelectedBoard? board) {
    return board == null;
  }

  void _showDeleteConfirmation() {
    final selectedBoard = ref.watch(currentSelectedBoardProvider);

    showModalBottomSheet<Widget>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return StatefulBuilder(builder: (context, setState) {
          return Container(
            padding: const EdgeInsets.only(left: 16, right: 16),
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(13),
                topRight: Radius.circular(13),
              ),
            ),
            child: VWidgetsConfirmationBottomSheet(
              title: "Are you sure you want to delete comment?",
              actions: [
                ValueListenableBuilder(
                    valueListenable: _showLoading,
                    builder: (context, value, _) {
                      return VWidgetsTextButton(
                        text: 'Delete',
                        showLoadingIndicator: value,
                        onPressed: () async {
                          _showLoading.value = true;

                          VLoader.changeLoadingState(true);
                          final success = await ref
                              .read(userPostBoardsProvider.notifier)
                              .deleteUserBoard(
                                boardId: selectedBoard!.board.id,
                                // pinnedStatus: selectedBoard!.pinned,
                              );
                          VLoader.changeLoadingState(false);
                          if (success) {
                            goBack(context);
                            goBack(context);
                            responseDialog(context,
                                '${selectedBoard.board.title} deleted');
                          }
                          _showLoading.value = false;
                          if (context.mounted) {
                            goBack(context);
                          }
                        },
                      );
                    }),
                // if (!showLoader)
                const Divider(
                  thickness: 0.5,
                ),
                // Connect
                // if (!showLoader)
                VWidgetsBottomSheetTile(
                    onTap: () {
                      if (context.mounted) {
                        goBack(context);
                      }
                    },
                    message: 'Cancel')
              ],
            ),
          );
        });
      },
    );
  }
}
