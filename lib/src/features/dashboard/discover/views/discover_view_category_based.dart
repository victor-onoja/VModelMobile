import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vmodel/src/features/dashboard/discover/models/mock_data.dart';
import 'package:vmodel/src/features/jobs/job_market/views/search_field.dart';
// import 'package:vmodel/src/features/dashboard/discover/views/discover_photo_search/discover_photo_search.dart';
// import 'package:vmodel/src/features/vmagazine/views/vMagzine_view.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/vmodel.dart';

import '../../../../core/controller/app_user_controller.dart';
import '../../dash/controller.dart';
import '../../new_profile/views/other_profile_router.dart';
import '../controllers/discover_controller.dart';
import '../controllers/discover_talent.dart';
import '../widget/category_section.dart';
import 'discover_view_category_detail.dart';

class CategoryDiscoverViewNew extends ConsumerStatefulWidget {
  const CategoryDiscoverViewNew({super.key});

  @override
  ConsumerState<CategoryDiscoverViewNew> createState() =>
      _CategoryDiscoverViewNewState();
}

class _CategoryDiscoverViewNewState
    extends ConsumerState<CategoryDiscoverViewNew> {
  String typingText = "";
  bool isLoading = true;
  bool showRecentSearches = false;

  FocusNode myFocusNode = FocusNode();
  late Future getFeaturedTalents;
  late Future getRisingTalents;
  late Future getPhotgraphers;
  late Future getPetModels;

  final TextEditingController _searchController = TextEditingController();

  changeTypingState(String val) {
    typingText = val;
    setState(() {});
  }

  // Future getFeaturedTalent ()async{

  // }

  @override
  void initState() {
    // startLoading();
    super.initState();
    // getFeaturedTalents = DiscoverController().feaaturedList(3, 1);
    // getRisingTalents = DiscoverController().risingTalent(3, 1);
    // getPhotgraphers = DiscoverController().photographers(3, 1);
    // getPetModels = DiscoverController().petModels(3, 1);
    ref
        .read(discoverProvider.notifier)
        .updateSearchController(_searchController);
    myFocusNode.addListener(() {
      if (myFocusNode.hasFocus) {
        showRecentSearches = true;
      } else {
        showRecentSearches = false;
      }
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    myFocusNode.dispose();
    super.dispose();
  }

  // Future getFeaturedTalentList() async {
  //   final discoverRepoInstance = DiscoverRepository.instance;

  //   var data = await discoverRepoInstance.getFeaturedTalents(4, 4);

  //   print('-----$data ----- featured list');

  //   return data;
  // }

  // startLoading() {
  //   Future.delayed(const Duration(seconds: 3), () {
  //     setState(() {
  //       isLoading = false;
  //     });
  //   });
  // }

  String selectedChip = "Models";
  @override
  Widget build(BuildContext context) {
    // return DiscoverPageTest();
    final discoverProviderState = ref.watch(discoverProvider);
    final discoverTalentState = ref.watch(discoverTalentProvider);

    final _featuredData = ref.watch(feaaturedListProvider);
    final _photographersData = ref.watch(photographersProvider);
    final _risingTalentsData = ref.watch(risingTalentsProvider);
    final _petModelData = ref.watch(petModelProvider);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            // snap: _snap,
            floating: true,
            expandedHeight: 190.0,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              background: _titleSearch(),
            ),
            // leadingWidth: 150,
            leading: const SizedBox.shrink(),
            elevation: 1,
            backgroundColor: Colors.white,
            // actions: [
            //   Padding(
            //     padding: const EdgeInsets.only(top: 0, right: 0),
            //     child: Row(
            //       children: [
            //         IconButton(
            //           onPressed: () {
            //             navigateToRoute(
            //                 context, const CategoryDiscoverDetail());
            //           },
            //           icon: const RenderSvg(
            //             svgPath: VIcons.notification,
            //           ),
            //         ),
            //       ],
            //     ),
            //     // child: ,
            //   ),
            // ],
          ),
          discoverProviderState.when(data: (data) {
            // if (showRecentSearches) {
            //   return DiscoverUserSearchMainView();
            // }
            // if (!showRecentSearches)
            return SliverList.list(
              children: [
                addVerticalSpacing(10),
                _featuredData.when(data: (_data) {
                  return CategorySection(
                    onTap: (value) => _navigateToUserProfile(value),
                    onCategoryChanged: (value) {},
                    title: 'Service categories',
                    items: [
                      ..._data,
                      ..._data,
                    ],
                    route: const CategoryDiscoverDetail(
                      title: 'Service categories',
                    ),
                  );
                }, error: (((error, stackTrace) {
                  return Container();
                })), loading: () {
                  return CategorySection(
                    onTap: (value) => _navigateToUserProfile(value),
                    onCategoryChanged: (value) {},
                    title: 'Service categories',
                    items: recentlyViewed,
                    route: const CategoryDiscoverDetail(
                      title: 'Service categories',
                    ),
                    // route: ViewAllScreen(
                    //   onItemTap: (value) =>
                    //       _navigateToUserProfile(value, isViewAll: true),
                    //   title: "Featured talent",
                    //   dataList: recentlyViewed,
                    //   getList: DiscoverController().feaaturedList,
                    // ),
                  );
                }),
                addVerticalSpacing(10),
                _risingTalentsData.when(data: (_data) {
                  return CategorySection(
                    onTap: (value) => _navigateToUserProfile(value),
                    onCategoryChanged: (value) {},
                    title: 'Job categories',
                    items: [
                      ..._data,
                      ..._data,
                    ],
                    route: const CategoryDiscoverDetail(
                      title: 'Job categories',
                    ),
                  );
                }, error: (((error, stackTrace) {
                  return Container();
                })), loading: () {
                  return CategorySection(
                    onTap: (value) => _navigateToUserProfile(value),
                    onCategoryChanged: (value) {},
                    title: 'Job categories',
                    items: recentlyViewed,
                    route: const CategoryDiscoverDetail(
                      title: 'Job categories',
                    ),
                  );
                }),
                addVerticalSpacing(10),
                _risingTalentsData.when(data: (_data) {
                  return CategorySection(
                    onTap: (value) => _navigateToUserProfile(value),
                    onCategoryChanged: (value) {},
                    title: 'Talent categories',
                    items: [
                      ..._data,
                      ..._data,
                    ],
                    route: const CategoryDiscoverDetail(
                      title: 'Talent categories',
                    ),
                  );
                }, error: ((error, stackTrace) {
                  return Container();
                }), loading: () {
                  return CategorySection(
                    onTap: (value) => _navigateToUserProfile(value),
                    onCategoryChanged: (value) {},
                    title: 'Talent categories',
                    items: recentlyViewed,
                    route: const CategoryDiscoverDetail(
                      title: 'Talent categories',
                    ),
                  );
                }),
                addVerticalSpacing(24),
              ],
            );
          }, error: (err, st) {
            return const Text('Error');
          }, loading: () {
            return const Text('Error');
          }),
        ],
      ),
    );
  }

  Widget _titleSearch() {
    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: addVerticalSpacing(50),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 13),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Discover Categoryy",
                  style: Theme.of(context).textTheme.displayLarge!.copyWith(
                        fontWeight: FontWeight.w600,
                        color: VmodelColors.mainColor,
                        fontSize: 16.sp,
                      ),
                ),
              ],
            ),
          ),
          addVerticalSpacing(10),
          Padding(
            padding: const VWidgetsPagePadding.horizontalSymmetric(18),
            child: SearchTextFieldWidget(
              hintText: "Search...",
              controller: _searchController,
              // onChanged: (val) {},

              onTapOutside: (event) {
                RenderBox? textBox = context.findRenderObject() as RenderBox?;
                Offset? offset = textBox?.localToGlobal(Offset.zero);
                double top = offset?.dy ?? 0;
                top += 200;
                double bottom = top + (textBox?.size.height ?? 0);
                if (event is PointerDownEvent) {
                  if (event.position.dy >= 140) {
                    // Tapped within the bounds of the ListTile, do nothing
                    return;
                  } else {}
                }

                // Tapped outside the ListTile, unfocus the text field and reset the displayed users
                // setState(() {
                //   textFieldFocus.unfocus();
                //   displayedUsers = allUsers;
                // });
                myFocusNode.unfocus();
                // setState(() {
                //   showRecentSearches = false;
                // });
              },
              onTap: () {
                if (_searchController.text.isNotEmpty) {
                  ref
                      .read(discoverProvider.notifier)
                      .searchUsers(_searchController.text.trim());
                }
                setState(() {
                  // showRecentSearches = true;
                });
              },
              focusNode: myFocusNode,
              onChanged: (val) {
                ref.read(discoverProvider.notifier).searchUsers(val);
                // changeTypingState(typingText);
                setState(() {
                  typingText = val;
                });
              },
            ),
          ),
          const SizedBox(height: 5),

          // Padding(
          //   padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 12),
          //   child: Container(
          //     padding: const EdgeInsets.all(15),
          //     decoration: BoxDecoration(
          //         color: const Color(0xFFD9D9D9),
          //         borderRadius: BorderRadius.circular(8)),
          //     child: Container(
          //       padding: const EdgeInsets.all(2),
          //       decoration: BoxDecoration(
          //           color: VmodelColors.white,
          //           borderRadius: BorderRadius.circular(8)),
          //       child: Padding(
          //         padding: const EdgeInsets.symmetric(horizontal: 15),
          //         child: Row(
          //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //           children: [
          //             IconButton(
          //               onPressed: () {
          //                 // navigateToRoute(context, const LocalServices());
          //               },
          //               icon: const RenderSvg(
          //                 svgPath: VIcons.addServiceOutline,
          //               ),
          //             ),
          //             IconButton(
          //               onPressed: () {
          //                 // navigateToRoute(context, AllJobs(job: job));
          //               },
          //               icon: const RenderSvg(
          //                 svgPath: VIcons.alignVerticalIcon,
          //               ),
          //             ),
          //             IconButton(
          //               onPressed: () {
          //                 navigateToRoute(context, const Explore());
          //               },
          //               icon: const RenderSvg(
          //                 svgPath: VIcons.searchIcon,
          //               ),
          //             ),
          //           ],
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
          // const SizedBox(height: 10),
        ],
      ),
    );
  }

  void _navigateToUserProfile(String username, {bool isViewAll = false}) {
    final isCurrentUser =
        ref.read(appUserProvider.notifier).isCurrentUser(username);
    if (isCurrentUser) {
      if (isViewAll) goBack(context);
      ref.read(dashTabProvider.notifier).changeIndexState(3);
    } else {
      navigateToRoute(
        context,
        OtherProfileRouter(username: username),
      );
    }
  }

/**

  */
}
