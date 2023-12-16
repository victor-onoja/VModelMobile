import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vmodel/src/core/utils/debounce.dart';
import 'package:vmodel/src/features/archived/views/archived_view.dart';
import 'package:vmodel/src/features/jobs/job_market/views/search_field.dart';
import 'package:vmodel/src/features/saved/controller/provider/saved_jobs_proiver.dart';
import 'package:vmodel/src/features/saved/controller/provider/user_boards_controller.dart';
import 'package:vmodel/src/features/saved/views/saved_services.dart';
import 'package:vmodel/src/features/saved/views/search_saved_services.dart';
import 'package:vmodel/src/features/saved/widgets/post_board_card.dart';
import 'package:vmodel/src/res/icons.dart';
import 'package:vmodel/src/shared/appbar/appbar.dart';
import 'package:vmodel/src/shared/rend_paint/render_svg.dart';
import 'package:vmodel/src/vmodel.dart';

import '../../../shared/empty_page/empty_page.dart';
import '../controller/provider/current_selected_board_provider.dart';
import '../controller/provider/saved_provider.dart';
import 'explore_v2.dart';

class BoardsSearchPage extends ConsumerStatefulWidget {
  const BoardsSearchPage({super.key});
  static const routeName = 'boards';

  @override
  ConsumerState<BoardsSearchPage> createState() => _BoardsSearchPageState();
}

class _BoardsSearchPageState extends ConsumerState<BoardsSearchPage>
    with TickerProviderStateMixin {
  late final TabController tabController;
  final tabTitles = ['Posts', 'Services'];
  String _searchText = '';

  final _debounce = Debounce();

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: tabTitles.length, vsync: this);
    tabController.addListener(_searchOnPageChanged);
  }

  _searchOnPageChanged() {
    switch (tabController.index) {
      case 0:
        _debounce(() {
          ref.read(userBoardsSearchProvider.notifier).state = _searchText;
        });
        break;
      case 1:
        _debounce(() {
          ref.read(savedSearchTextProvider.notifier).state = _searchText;
        });
        break;
    }
    // if (tabController.index == 0) {
    // } else if (tabController.index == 1) {}
  }

  @override
  void dispose() {
    super.dispose();
    ref.invalidate(userBoardsSearchProvider);
    tabController.removeListener(_searchOnPageChanged);
    tabController.dispose();
    _debounce.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userPostBoards = ref.watch(userPostBoardsProvider);
    final queryString = ref.watch(savedSearchTextProvider);
    return Scaffold(
      appBar: VWidgetsAppBar(
        leadingIcon: const VWidgetsBackButton(),
        appbarTitle: "Boards",
        trailingIcon: [
          IconButton(
            onPressed: () {
              navigateToRoute(context, const ArchivedView());
            },
            icon: RenderSvg(
              svgPath: VIcons.archiveIcon,
              svgHeight: 24,
              svgWidth: 24,
              color: Theme.of(context).iconTheme.color,
            ),
          ),
        ],
        appBarHeight: 140,
        customBottom: PreferredSize(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 10, 16, 0),
                  child: SearchTextFieldWidget(
                    hintText: 'Photo',
                    autofocus: true,
                    onChanged: (val) {
                      _searchText = val;
                      _searchOnPageChanged();
                      // if (tabController.index == 0) {
                      //   _debounce(() {
                      //     ref.read(userBoardsSearchProvider.notifier).state =
                      //         val;
                      //   });
                      // } else if (tabController.index == 1) {
                      //   _debounce(() {
                      //     ref.read(savedSearchTextProvider.notifier).state =
                      //         val;
                      //     // ref.watch(searchSavedServicesProvider(val));
                      //   });
                      // }
                    },
                  ),
                ),
                TabBar(
                    controller: tabController,
                    labelStyle:
                        Theme.of(context).textTheme.displayMedium!.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                    unselectedLabelStyle: Theme.of(context)
                        .textTheme
                        .displayMedium
                        ?.copyWith(
                            color:
                                Theme.of(context).primaryColor.withOpacity(.9)),
                    tabs: tabTitles.map((e) => Tab(text: e)).toList()),
              ],
            ),
            preferredSize: Size.fromHeight(56)),
      ),
      body: TabBarView(
        controller: tabController,
        children: [
          userPostBoards.when(
              data: (data) {
                if (data.isEmpty) {
                  return EmptyPage(
                    svgPath: VIcons.documentLike,
                    svgSize: 30,
                    // title: 'No Posts Yet',
                    subtitle: 'No boards found',
                  );
                }
                return GridView.builder(
                  itemCount: data.length,
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                    childAspectRatio: .85,
                  ),
                  itemBuilder: (context, index) {
                    return PostBoardsCard(
                      image: '${data[index].coverImageUrl!}',
                      title: data[index].title,
                      onTap: () {
                        ref
                            .read(currentSelectedBoardProvider.notifier)
                            .setOrUpdateBoard(
                              SelectedBoard(
                                board: data[index],
                                source: SelectedBoardSource.userCreatd,
                              ),
                            );
                        navigateToRoute(
                            context,
                            ExploreV2(
                              title: data[index].title,
                              providerType: BoardProvider.userCreated,
                              // userPostBoard: widget.boards[index],
                            ));
                      },
                    );
                  },
                );
              },
              error: (error, stackTrace) {
                print('$error $stackTrace');
                return Text('An error occured');
              },
              loading: () =>
                  Center(child: CircularProgressIndicator.adaptive())),

          SavedServicesHomepage(),
          // SearchSavedServicesHomepage(),
        ],
      ),
    );
  }
}
