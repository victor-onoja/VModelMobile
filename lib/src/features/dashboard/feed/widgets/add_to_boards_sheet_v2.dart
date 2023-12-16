import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vmodel/src/core/network/checkConnection.dart';
import 'package:vmodel/src/features/dashboard/feed/controller/new_feed_provider.dart';
import 'package:vmodel/src/features/dashboard/feed/widgets/comment/create_new_board_dialogue.dart';
import 'package:vmodel/src/features/saved/views/saved_user_post.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/shared/job_service_section_container.dart';
import 'package:vmodel/src/shared/popup_dialogs/response_dialogue.dart';

import '../../../../core/utils/enum/upload_ratio_enum.dart';
import '../../../../core/utils/helper_functions.dart';
import '../../../../shared/modal_pill_widget.dart';
import '../../../../shared/picture_styles/rounded_square_avatar.dart';
import '../../../../shared/picture_styles/vmodel_network_image.dart';
import '../../../../shared/shimmer/post_shimmer.dart';
import '../../../../vmodel.dart';
import '../../../saved/controller/provider/saved_provider.dart';
import '../../../saved/controller/provider/user_boards_controller.dart';
import '../../discover/models/mock_data.dart';

class AddToBoardsSheetV2 extends ConsumerStatefulWidget {
  const AddToBoardsSheetV2({
    Key? key,
    required this.postId,
    required this.currentSavedValue,
    // required this.savePost,
    // required this.showLoader,
    required this.onSaveToggle,
  }) : super(key: key);
  final int postId;
  final bool currentSavedValue;
  final ValueChanged<bool> onSaveToggle;
  // final ValueNotifier<bool> showLoader;

  @override
  ConsumerState<AddToBoardsSheetV2> createState() => _AddToBoardsSheetV2State();
}

class _AddToBoardsSheetV2State extends ConsumerState<AddToBoardsSheetV2> {
  final mockBoardTitles = ["Photography", "Modelling"];
  final ValueNotifier<String> _completionText = ValueNotifier('');
  final boardsPostHasBeenAddedIDs = [];

  @override
  initState() {
    super.initState();
    savePost();
  }

  @override
  Widget build(BuildContext context) {
    final allPosts = ref.watch(getsavedPostProvider);
    final userCreatedBoards = ref.watch(userPostBoardsProvider);

    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.vertical(top: Radius.circular(10))),
      child: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            addVerticalSpacing(15),
            const Align(
                alignment: Alignment.center, child: VWidgetsModalPill()),
            addVerticalSpacing(8),
            GestureDetector(
              onTap: () async {
                HapticFeedback.lightImpact();
                showDialog(
                    context: context,
                    builder: (context) {
                      return CreateNewBoardDialog(
                        controller: TextEditingController(),
                        onSave: (title) async {
                          final Map<int, bool> success = await ref
                              .read(userPostBoardsProvider.notifier)
                              .createPostBoardAndAddPost(title,
                                  postId: widget.postId);
                          if (success.values.first && context.mounted) {
                            goBack(context);
                            responseDialog(context, "Board created");

                            boardsPostHasBeenAddedIDs.add(success.keys.first);
                            setState(() {});
                          }
                        },
                      );
                    });
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Flexible(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        "New Board",
                        style:
                            Theme.of(context).textTheme.displaySmall?.copyWith(
                                  // fontWeight: FontWeight.w600,
                                  color: Theme.of(context)
                                      .textTheme
                                      .displaySmall
                                      ?.color
                                      ?.withOpacity(0.5),
                                ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SectionContainer(
              topRadius: 0,
              bottomRadius: 0,
              // padding: EdgeInsets.all(8),
              height: 8.5.h,
              child: Row(
                children: [
                  // addHorizontalSpacing(16),
                  Expanded(
                    flex: 2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ValueListenableBuilder(
                            valueListenable: _completionText,
                            builder: (context, value, _) {
                              return Text(
                                value,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context)
                                    .textTheme
                                    .displayMedium
                                    ?.copyWith(fontWeight: FontWeight.w600),
                              );
                            }),
                        addVerticalSpacing(4),
                        Text(
                          'All posts',
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context)
                              .textTheme
                              .displaySmall
                              ?.copyWith(
                                color: Theme.of(context)
                                    .textTheme
                                    .displaySmall
                                    ?.color
                                    ?.withOpacity(0.5),
                              ),
                        ),
                      ],
                    ),
                  ),

                  allPosts.maybeWhen(data: (values) {
                    return RoundedSquareAvatar(
                      url: '${firstPostThumbnailOrNull(values)}',
                      thumbnail: '${firstPostThumbnailOrNull(values)}',
                      radius: 3,
                      size: UploadAspectRatio.portrait.sizeFromX(30),
                      errorWidget: ColoredBox(color: Colors.grey.shade400),
                    );
                  }, orElse: () {
                    return RoundedSquareAvatar(
                      url: '',
                      thumbnail: '',
                      radius: 3,
                      size: UploadAspectRatio.portrait.sizeFromX(30),
                      errorWidget: ColoredBox(color: Colors.grey.shade400),
                    );
                  }),
                  // addHorizontalSpacing(16),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 8, top: 16),
              child: Text(
                "Boards",
                style: Theme.of(context)
                    .textTheme
                    .displayMedium
                    ?.copyWith(fontWeight: FontWeight.w700),
              ),
            ),
            Divider(thickness: 0.5, height: 20),
            ListView.separated(
              shrinkWrap: true,
              // padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              physics: NeverScrollableScrollPhysics(),
              itemCount: fewBoards(userCreatedBoards.valueOrNull?.length),
              separatorBuilder: (context, index) {
                return Divider(thickness: 0.5, height: 20);
              },
              itemBuilder: (context, index) {
                return userCreatedBoards.when(data: (items) {
                  if (items.isEmpty) return SizedBox.shrink();
                  return GestureDetector(
                    onTap: () {
                      HapticFeedback.lightImpact();
                      ref.read(userPostBoardsProvider.notifier).savePostToBoard(
                            postId: widget.postId,
                            boardId: items[index].id,
                          );
                    },
                    child: Container(
                      color: Colors.transparent,
                      child: Row(
                        children: [
                          RoundedSquareAvatar(
                            url: '',
                            thumbnail: '',
                            radius: 3,
                            size: UploadAspectRatio.portrait.sizeFromX(30),
                            imageWidget: VWidgetNetworkImage(
                              url: '${items[index].coverImageUrl}',
                              errorWidget: SizedBox.shrink(),
                            ),
                            // Image.asset(
                            //   userTypesMockImages.first,
                            //   fit: BoxFit.cover,
                            // ),
                          ),
                          addHorizontalSpacing(16),
                          Expanded(
                            flex: 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  items[index].title,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context)
                                      .textTheme
                                      .displayMedium
                                      ?.copyWith(fontWeight: FontWeight.w600),
                                ),
                                countText(items[index].numberOfPosts),
                              ],
                            ),
                          ),
                          addHorizontalSpacing(16),
                          addText(
                            context,
                            postId: widget.postId,
                            boardId: items[index].id,
                          ),
                        ],
                      ),
                    ),
                  );
                }, error: (error, stackTrace) {
                  return Text('Error');
                }, loading: () {
                  return CircularProgressIndicator.adaptive();
                });
                // ...mockBoardTitles.map((e) {
                //   return Padding(
                //     padding: EdgeInsets.only(top: 10),
                //     child: Column(
                //       mainAxisSize: MainAxisSize.min,
                //       children: [
                //         Row(
                //           children: [
                //             RoundedSquareAvatar(
                //               url: '',
                //               thumbnail: '',
                //               radius: 3,
                //               size: UploadAspectRatio.portrait.sizeFromX(30),
                //               imageWidget: Image.asset(
                //                 userTypesMockImages.first,
                //                 fit: BoxFit.cover,
                //               ),
                //             ),
                //             addHorizontalSpacing(16),
                //             Expanded(
                //               flex: 2,
                //               child: Text(
                //                 e,
                //                 overflow: TextOverflow.ellipsis,
                //                 style: Theme.of(context)
                //                     .textTheme
                //                     .displayMedium
                //                     ?.copyWith(fontWeight: FontWeight.w600),
                //               ),
                //             ),
                //             addHorizontalSpacing(16),
                //             countText(14),
                //           ],
                //         ),
                //         addVerticalSpacing(10),
                //         Divider(thickness: 0.5, height: 20),
                //       ],
                //     ),
                //   );
                // }).toList(),
              },
            ),
            addVerticalSpacing(22),
          ],
        ),
      ),
    );
  }

  int fewBoards(int? total) {
    if (total == null) return 0;
    return min(total, 5);
  }

  Widget countText(int count) {
    return Text(
      "${VMString.bullet} $count Posts",
      style: Theme.of(context).textTheme.displaySmall?.copyWith(
            // fontWeight: FontWeight.w600,
            fontSize: 10.sp,
            color: Theme.of(context)
                .textTheme
                .displaySmall
                ?.color
                ?.withOpacity(0.5),
          ),
    );
  }

  Widget addText(BuildContext context, {required int postId, int? boardId}) {
    return Consumer(
      builder: (context, ref, child) => GestureDetector(
        onTap: () {
          ref
              .read(userPostBoardsProvider.notifier)
              .savePostToBoard(postId: postId, boardId: boardId)
              .then((isSuccess) {
            if (!isSuccess) return;
            boardsPostHasBeenAddedIDs.add(boardId);
            setState(() {});
          });
        },
        child: boardsPostHasBeenAddedIDs.contains(boardId)
            ? Icon(Icons.check)
            : Text(
                "Add",
                style: Theme.of(context).textTheme.displaySmall?.copyWith(
                      // fontWeight: FontWeight.w600,
                      color: Theme.of(context)
                          .textTheme
                          .displaySmall
                          ?.color
                          ?.withOpacity(0.5),
                    ),
              ),
      ),
    );
  }

  Future<bool> savePost() async {
    final connected = await checkConnection();
    if (connected) {
      HapticFeedback.lightImpact();

      final result = await ref.read(mainFeedProvider.notifier).onSavePost(
          postId: widget.postId, currentValue: widget.currentSavedValue);

      ref.invalidate(getsavedPostProvider);
      // await showModalBottomSheet(
      //   context: context,
      //   isScrollControlled: true,
      //   useSafeArea: true,
      //   backgroundColor: Colors.transparent,
      //   builder: (context) {
      //     return AddToBoardsSheetV2(
      //       postId: wid      // await showModalBottomSheet(
      //   context: context,
      //   isScrollControlled: true,
      //   useSafeArea: true,
      //   backgroundColor: Colors.transparent,
      //   builder: (context) {
      //     return AddToBoardsSheetV2(
      //       postId: widget.postId,
      //       currentSavedValue: widget.currentSavedValue,
      //       // saveBool: saveBool,
      //       // savePost: () {
      //       //   savePost();
      //       // },
      //       // showLoader: showLoader,
      //     );
      //   },
      // );get.postId,
      //       currentSavedValue: widget.currentSavedValue,
      //       // saveBool: saveBool,
      //       // savePost: () {
      //       //   savePost();
      //       // },
      //       // showLoader: showLoader,
      //     );
      //   },
      // );
      if (context.mounted) {
        _completionText.value = _saveStateFromSucessResult(result)
            ? "Added to boards"
            : "Removed from boards";

        // responseDialog(
        //     context,
        //     _saveStateFromSucessResult(result)
        //         ? "Saved to boards"
        //         : "Removed from boards");
      }
      // _toggleSaveState();
      // if (!result) {
      //   _toggleSaveState();
      // }

      ref.read(showSavedProvider.notifier).state =
          !ref.read(showSavedProvider.notifier).state;

      return result;
    } else {
      if (context.mounted) {
        responseDialog(context, "No connection", body: "Try again");
      }

      // await Future.delayed(Duration(seconds: 2));
      // Navigator.pop(context);
    }

    return false;
  }

  bool _saveStateFromSucessResult(bool success) {
    print(
        '[o29s] result: $success, current-value: ${widget.currentSavedValue}');
    bool newValue = widget.currentSavedValue;
    if (success) {
      newValue = !widget.currentSavedValue;
    }
    widget.onSaveToggle(newValue);
    return newValue;
  }
}
