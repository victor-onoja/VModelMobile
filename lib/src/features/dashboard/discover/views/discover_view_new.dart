import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_animated_icons/lottiefiles.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:vmodel/src/features/dashboard/discover/models/discover_item.dart';
import 'package:vmodel/src/features/dashboard/discover/views/discover_user_search.dart/views/dis_search_main_screen.dart';
import 'package:vmodel/src/features/dashboard/discover/views/explore.dart';
// import 'package:vmodel/src/features/dashboard/discover/views/discover_photo_search/discover_photo_search.dart';
import 'package:vmodel/src/features/dashboard/discover/views/sub_screens/view_all.dart';
import 'package:vmodel/src/features/dashboard/discover/widget/discover_sub_list.dart';
import 'package:vmodel/src/features/dashboard/discover/widget/vmagazine_row.dart';
import 'package:vmodel/src/features/vmodel_credits/views/vmc_history_main.dart';
// import 'package:vmodel/src/features/vmagazine/views/vMagzine_view.dart';
import 'package:vmodel/src/res/icons.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/shared/rend_paint/render_svg.dart';
import 'package:vmodel/src/shared/shimmer/discoverShimmerPage.dart';
import 'package:vmodel/src/vmodel.dart';

import '../../../../core/controller/app_user_controller.dart';
import '../../../../core/utils/costants.dart';
import '../../../../core/utils/debounce.dart';
import '../../../../core/utils/enum/discover_category_enum.dart';
import '../../../../shared/carousel_indicators.dart';
import '../../../faq_s/views/popular_faqs_page.dart';
import '../../../jobs/job_market/views/search_field.dart';
import '../../dash/controller.dart';
import '../../new_profile/views/other_profile_router.dart';
import '../../profile/view/webview_page.dart';
import '../controllers/discover_controller.dart';
import '../controllers/discover_talents_near_your.dart';
import '../controllers/explore_provider.dart';
import '../controllers/follow_connect_controller.dart';
import '../widget/discover_sub_item_error_widget.dart';
import 'discover_verified_section.dart';

class DiscoverViewNew extends ConsumerStatefulWidget {
  const DiscoverViewNew({super.key});

  @override
  ConsumerState<DiscoverViewNew> createState() => _DiscoverViewNewState();
}

class _DiscoverViewNewState extends ConsumerState<DiscoverViewNew>
    with TickerProviderStateMixin {
  String typingText = "";
  bool isLoading = true;
  bool showRecentSearches = false;

  FocusNode myFocusNode = FocusNode();
  late Future getFeaturedTalents;
  late Future getRisingTalents;
  late Future getPhotgraphers;
  late Future getPetModels;

  final TextEditingController _searchController = TextEditingController();
  // late final List<DiscoverItemObject> _categoryItems;
  // List<DiscoverItemObject> _ca = [];
  final DiscoverCategory _discoverCategoryType = DiscoverCategory.values.first;
  late AnimationController _bellController;
  late final Debounce _debounce;

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
    _bellController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    // getFeaturedTalents = DiscoverController().feaaturedList(3, 1);
    // getRisingTalents = DiscoverController().risingTalent(3, 1);
    // getPhotgraphers = DiscoverController().photographers(3, 1);
    // getPetModels = DiscoverController().petModels(3, 1);

    _debounce = Debounce(delay: Duration(milliseconds: 300));

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

  // void _onCategoryChanged(DiscoverCategory currentList) {
  //   int start = 0;
  //   int end = 1;
  //   switch (currentList) {
  //     case DiscoverCategory.job:
  //       start = 3;
  //       end = 6;
  //       break;
  //     case DiscoverCategory.talent:
  //       start = 2;
  //       end = 6;
  //       break;
  //     default:
  //       end = 3;
  //   }
  //   final subList = VConstants.tempCategories.sublist(start, end);
  //   final subAssets = mockDiscoverCategoryAssets.sublist(start, end);
  //   _ca = List.generate(subList.length, (index) {
  //     return DiscoverItemObject(subList[index], subAssets[index], '', '', '',
  //         '', '', '', '', '', '', '', '');
  //   });

  //   print('[mm] sss $currentList subList AAAQQQQZZZ ${subList.length}');
  //   setState(() {});
  // }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    _bellController.dispose();
    _searchController.dispose();
    myFocusNode.dispose();
    _debounce.dispose();
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
  List<String> imageList = [
    "assets/images/discover_categories/cat_art_design.jpg",
    "assets/images/discover_categories/cat_cooking.jpg",
    "assets/images/discover_categories/cat_event_planning.jpg",
    "assets/images/discover_categories/cat_photographer.jpg",
  ];
  String selectedChip = "Models";
  @override
  Widget build(BuildContext context) {
    // return DiscoverPageTest();
    final discoverProviderState = ref.watch(discoverProvider);
    // final popularGallery = ref.watch(popularGalleryProvider);
    // final discoverTalentState = ref.watch(discoverTalentProvider);
    // final _featuredData = ref.watch(feaaturedListProvider);
    // final _photographersData = ref.watch(photographersProvider);
    // final _risingTalentsData = ref.watch(risingTalentsProvider);
    // final _petModelData = ref.watch(petModelProvider);
    final exlporePage = ref.watch(exploreProvider.notifier);
    ref.watch(accountToFollowProvider);

    return Scaffold(
      body: exlporePage.isExplore
          ? const Explore()
          : CustomScrollView(
              physics: const AlwaysScrollableScrollPhysics(
                  parent: BouncingScrollPhysics()),
              slivers: [
                SliverAppBar(
                  pinned: true,
                  // snap: _snap,
                  floating: true,
                  expandedHeight: 130.0,
                  title: Text(
                    "Discover",
                    style: Theme.of(context).textTheme.displayLarge!.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  flexibleSpace: FlexibleSpaceBar(
                    centerTitle: true,
                    background: _titleSearch(),
                  ),
                  // leadingWidth: 150,
                  leading: const SizedBox.shrink(),
                  elevation: 1,
                  // backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  actions: [
                    IconButton(
                      color: Theme.of(context).iconTheme.color,
                      splashRadius: 50,
                      iconSize: 30,
                      onPressed: () {
                        navigateToRoute(context, const NotificationMain());
                        // context.pushNamed(NotificationMain.routeName);

                        // if (_bellController.isAnimating) {
                        //   _bellController.reset();
                        // } else {
                        //   _bellController.repeat();
                        // }
                      },
                      icon: Lottie.asset(
                        LottieFiles.$63128_bell_icon,
                        controller: _bellController,
                        height: 30,
                        fit: BoxFit.cover,
                        delegates: LottieDelegates(
                          values: [
                            ValueDelegate.color(
                              const ['**', 'wave_2 Outlines', '**'],
                              value: Theme.of(context).primaryColor,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 0, right: 0),
                      child: Row(
                        children: [
                          //  IconButton(
                          //   onPressed: () {
                          //     navigateToRoute(context, const MapSearch());
                          //   },
                          //   icon: const RenderSvg(
                          //     svgPath: VIcons.gridIcon,
                          //   ),
                          // ),

                          // IconButton(
                          //   onPressed: () {
                          //     navigateToRoute(context, const Explore());
                          //   },
                          //   icon: const RenderSvg(
                          //     svgPath: VIcons.gridIcon,
                          //   ),
                          // ),
                          // IconButton(
                          //   onPressed: () {
                          //     navigateToRoute(
                          //         context, const CategoryDiscoverViewNew());
                          //   },
                          //   icon: const RenderSvg(
                          //     svgPath: VIcons.notification,
                          //   ),
                          // ),
                        ],
                      ),
                      // child: ,
                    ),
                  ],
                ),
                // if (!showRecentSearches)
                // SliverToBoxAdapter(child: addVerticalSpacing(20)),
                // if (!showRecentSearches) DiscoverVerifiedSection(),
                // SliverToBoxAdapter(child: addVerticalSpacing(10)),
                discoverProviderState.when(data: (discoverItems) {
                  if (ref.watch(showRecentViewProvider)) {
                    return DiscoverUserSearchMainView();
                  }
                  // if (!showRecentSearches)

                  if (discoverItems == null) {
                    return SliverToBoxAdapter(child: Text('Got null data'));
                  }

                  return SliverList.list(
                    children: [
                      // if (!showRecentSearches) addVerticalSpacing(0.h),

                      if (!ref.watch(showRecentViewProvider))
                        DiscoverVerifiedSection(),
                      addVerticalSpacing(10),

                      // addVerticalSpacing(16),
                      // // addVerticalSpacing(10),
                      // _featuredData.when(data: (_data) {
                      //   return CategorySection(
                      //     onTap: (value) => _navigateToUserProfile(value),
                      //     onCategoryChanged: (value) {
                      //       _onCategoryChanged(value);
                      //       print('[mm] sss $value subList ${_ca.length}  ');
                      //     },
                      //     title: 'Service categories yy',
                      //     items: _ca,
                      //     route: const CategoryDiscoverDetail(
                      //       title: 'Service categories yy',
                      //     ),
                      //   );
                      // }, error: (((error, stackTrace) {
                      //   return Container();
                      // })), loading: () {
                      //   // return const CircularProgressIndicator();
                      //   return CategorySection(
                      //     onTap: (value) => _navigateToUserProfile(value),
                      //     onCategoryChanged: (value) {
                      //       _onCategoryChanged(value);
                      //     },
                      //     title: 'Service categories yy',
                      //     items: _ca,
                      //     route: const CategoryDiscoverDetail(
                      //       title: 'Service categories yy',
                      //     ),
                      //     // route: ViewAllScreen(
                      //     //   onItemTap: (value) =>
                      //     //       _navigateToUserProfile(value, isViewAll: true),
                      //     //   title: "Featured talent",
                      //     //   dataList: recentlyViewed,
                      //     //   getList: DiscoverController().feaaturedList,
                      //     // ),
                      //   );
                      // }),
                      // popularGallery.when(
                      //   data: (data) {
                      //     return
                      // DiscoverGallerySubList(imageList: imageList),
                      //   },
                      //   loading: () {
                      //     return Container();
                      //   },
                      //   error: (error, stackTrace) {
                      //     return Text("data");
                      //   },
                      // ),

                      addVerticalSpacing(10),
                      DiscoverSubList(
                        onTap: (value) => _navigateToUserProfile(value),
                        title: 'Spotlight',
                        items: _getSubListOfData(discoverItems.featuredTalents),
                        onViewAllTap: () {
                          ref.read(viewAllDataProvider.notifier).state =
                              discoverItems.featuredTalents;
                          navigateToRoute(
                              context, ViewAllScreen(title: 'Spotlight'));
                          // context.pushNamed(
                          //   ViewAllScreen.routeName,
                          //   pathParameters: {'title': 'spotlight'},
                          // );
                        },
                        route: ViewAllScreen(
                          title: "Spotlight",
                          // dataList: discoverItems.featuredTalents,
                          // getList: DiscoverController().feaaturedList,
                          onItemTap: (value) =>
                              _navigateToUserProfile(value, isViewAll: true),
                        ),
                      ),
                      addVerticalSpacing(10),

                      DiscoverSubList(
                        onTap: (value) => _navigateToUserProfile(value),
                        title: 'Rising talent',
                        items: _getSubListOfData(discoverItems.risingTalents),
                        onViewAllTap: () {
                          ref.read(viewAllDataProvider.notifier).state =
                              discoverItems.risingTalents;
                          navigateToRoute(
                              context, ViewAllScreen(title: 'Rising talent'));
                          // context.pushNamed(
                          //   ViewAllScreen.routeName,
                          //   pathParameters: {'title': 'Rising talent'},
                          // );
                        },
                        route: ViewAllScreen(
                          onItemTap: (value) =>
                              _navigateToUserProfile(value, isViewAll: true),
                          title: "Rising talent",
                          // dataList: discoverItems.risingTalents,
                          // getList: DiscoverController().risingTalent,
                        ),
                      ),
                      addVerticalSpacing(10),

                      ref.watch(talentsNearYouProvider).maybeWhen(
                          data: (items) {
                        return DiscoverSubList(
                          onTap: (value) => _navigateToUserProfile(value),
                          title: 'Talent near you',
                          items: _getSubListOfData(items),
                          onViewAllTap: () {
                            ref.read(viewAllDataProvider.notifier).state =
                                items;
                            navigateToRoute(context,
                                ViewAllScreen(title: 'Talent near you'));
                            // context.pushNamed(
                            //   ViewAllScreen.routeName,
                            //   pathParameters: {'title': 'Talent near you'},
                            // );
                          },
                          route: ViewAllScreen(
                            onItemTap: (value) =>
                                _navigateToUserProfile(value, isViewAll: true),
                            title: 'Talent near you',
                            // dataList: items,
                            // getList: DiscoverController().feaaturedList,
                          ),
                        );
                      }, orElse: () {
                        return DiscoverSubListError(title: 'Talents near you');
                        // return SizedBox.shrink();
                      }),

                      // addVerticalSpacing(10),

                      addVerticalSpacing(48),
                      const VellMagazineSection(),
                      // Text(
                      //   'Vell Magazine',
                      //   style: Theme.of(context).textTheme.displayMedium!.copyWith(
                      //         // fontWeight: FontWeight.w600,
                      //         color: VmodelColors.mainColor,
                      //         fontSize: 18.sp,
                      //       ),
                      // ),
                      addVerticalSpacing(32),
                      DiscoverSubList(
                        onTap: (value) => _navigateToUserProfile(value),
                        title: 'Most Popular',
                        items: _getSubListOfData(discoverItems.popularTalents),
                        onViewAllTap: () {
                          ref.read(viewAllDataProvider.notifier).state =
                              discoverItems.popularTalents;
                          navigateToRoute(
                              context, ViewAllScreen(title: 'Most Popular'));
                          // context.pushNamed(
                          //   ViewAllScreen.routeName,
                          //   pathParameters: {'title': 'Most Popular'},
                          // );
                        },
                        route: ViewAllScreen(
                          onItemTap: (value) =>
                              _navigateToUserProfile(value, isViewAll: true),
                          title: "Most Popular",
                          // dataList: discoverItems.popularTalents,
                          // getList: DiscoverController().feaaturedList,
                        ),
                      ),

                      addVerticalSpacing(10),
                      DiscoverSubList(
                        onTap: (value) => _navigateToUserProfile(value),
                        title: 'Recommended Photographers',
                        items: _getSubListOfData(discoverItems.photographers),
                        onViewAllTap: () {
                          ref.read(viewAllDataProvider.notifier).state =
                              discoverItems.photographers;
                          navigateToRoute(
                              context,
                              ViewAllScreen(
                                  title: 'Recommended Photographers'));
                          // context.pushNamed(
                          //   ViewAllScreen.routeName,
                          //   pathParameters: {
                          //     'title': 'Recommended Photographers'
                          //   },
                          // );
                        },
                        route: ViewAllScreen(
                          onItemTap: (value) =>
                              _navigateToUserProfile(value, isViewAll: true),
                          title: "Recommended Photographers",
                          // dataList: discoverItems.photographers,
                          // getList: DiscoverController().photographers,
                        ),
                      ),

                      // addVerticalSpacing(10),
                      // DiscoverSubList(
                      //   onTap: (value) => _navigateToUserProfile(value),
                      //   title: 'Browse pet models',
                      //   items: _getSubListOfData(discoverItems.petModels),
                      //   route: ViewAllScreen(
                      //     onItemTap: (value) =>
                      //         _navigateToUserProfile(value, isViewAll: true),
                      //     title: "Browse pet models",
                      //     dataList: discoverItems.petModels,
                      //     // getList: DiscoverController().petModels,
                      //   ),
                      // ),
                      // addVerticalSpacing(10),
                      // ref.watch(recommendedBusinessesProvider).maybeWhen(
                      //     data: (items) {
                      //   return DiscoverSubList(
                      //     onTap: (value) => _navigateToUserProfile(value),
                      //     title: 'Recommended businesses to follow',
                      //     items: _getSubListOfData(items),
                      //     route: ViewAllScreen(
                      //       onItemTap: (value) =>
                      //           _navigateToUserProfile(value, isViewAll: true),
                      //       title: "Recommended businesses to follow",
                      //       dataList: items,
                      //       // getList: DiscoverController().risingTalent,
                      //     ),
                      //   );
                      // }, orElse: () {
                      //   return DiscoverSubListError(
                      //     title: 'Recommended businesses to follow',
                      //   );
                      //   // return SizedBox.shrink();
                      // }),

                      addVerticalSpacing(32),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Help',
                              style: Theme.of(context)
                                  .textTheme
                                  .displayMedium!
                                  .copyWith(
                                    fontWeight: FontWeight.w600,
                                    // color: VmodelColors.mainColor,
                                  ),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        child: const VMagazineRow(
                          title:
                              "Getting Started: A Beginner's Guide to VModel",
                          subTitle:
                              "Read our article on “How to perfect your profile before clients see it",
                        ),
                        onTap: () {
                          navigateToRoute(context, const PopularFAQsHomepage());
                        },
                      ),
                      addVerticalSpacing(25),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Shortcuts and tricks',
                              style: Theme.of(context)
                                  .textTheme
                                  .displayMedium!
                                  .copyWith(
                                    fontWeight: FontWeight.w600,
                                    // color: VmodelColors.mainColor,
                                  ),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        child: const VMagazineRow(
                          title:
                              "Discover the power of efficiency with \"Shortcuts and Tricks\".",
                          subTitle: "",
                        ),
                        onTap: () {
                          navigateToRoute(context, const PopularFAQsHomepage());
                        },
                      ),
                    ],
                  );
                }, error: (error, stackTrace) {
                  return SliverFillRemaining(
                      child: Center(
                          child: Text(
                    'Oops, something went wrong\nPull down to refresh',
                    textAlign: TextAlign.center,
                  )));
                }, loading: () {
                  return const SliverFillRemaining(
                      child: DiscoverShimmerPage(shouldHaveAppBar: false));
                })
              ],
            ),
    );
  }

  Widget _titleSearch() {
    return SafeArea(
      child: Column(
        children: [
          addVerticalSpacing(70),
          Padding(
            padding: const VWidgetsPagePadding.horizontalSymmetric(18),
            child: SearchTextFieldWidget(
              hintText: "Search...",
              controller: _searchController,
              // onChanged: (val) {},

              onTapOutside: (event) {
                // ref.invalidate(showRecentViewProvider);
                // _searchController.clear();
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
                  ref.read(showRecentViewProvider.notifier).state = true;
                } else {
                  ref.read(showRecentViewProvider.notifier).state = false;
                }
              },
              focusNode: myFocusNode,
              onChanged: (val) {
                _debounce(
                  () {
                    ref.read(discoverProvider.notifier).searchUsers(val);
                  },
                );
                // changeTypingState(typingText);
                setState(() {
                  typingText = val;
                });
                if (val.isNotEmpty) {
                  ref.read(showRecentViewProvider.notifier).state = true;
                } else {
                  ref.read(showRecentViewProvider.notifier).state = false;
                }
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

  List<DiscoverItemObject> _getSubListOfData(List<DiscoverItemObject> data) {
    try {
      return data.sublist(0, 8);
    } catch (e) {
      return data;
    }
  }

  List<DiscoverItemObject> _getSubListOf(List<DiscoverItemObject> data) {
    try {
      return data.sublist(0, 8);
    } catch (e) {
      return data;
    }
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
  _oldBody() {
    return discoverProviderState.when(data: (data) {
      return ListView(
        shrinkWrap: true,
        children: [
          addVerticalSpacing(20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 13),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Discoverlllll",
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
            child: VWidgetsDiscoverSearchTextField(
              hintText: "Search...",
              controller: _searchController,
              // onChanged: (val) {},

              onTapOutside: (event) {
                // Check if the tap event occurred within the bounds of the ListTile
                RenderBox? textBox = context.findRenderObject() as RenderBox?;
                Offset? offset = textBox?.localToGlobal(Offset.zero);
                double top = offset?.dy ?? 0;
                double bottom = top + (textBox?.size.height ?? 0);

                if (event is PointerDownEvent) {
                  if (event.position.dy >= top && event.position.dy <= bottom) {
                    // Tapped within the bounds of the ListTile, do nothing
                    return;
                  }
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
                print(
                    '+++++++++////////////++++++++++ ${_searchController.text}');
                if (_searchController.text.isNotEmpty) {
                  ref
                      .read(discoverProvider.notifier)
                      .searchUsers(_searchController.text.trim());
                }
                setState(() {
                  showRecentSearches = true;
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
          // Padding(
          //   padding: const VWidgetsPagePadding.horizontalSymmetric(18),
          //   child: VWidgetsPrimaryTextFieldWithTitle(
          //     controller: _searchController,
          //     onTapOutside: (event) {
          //       // Check if the tap event occurred within the bounds of the ListTile
          //       RenderBox? textBox = context.findRenderObject() as RenderBox?;
          //       Offset? offset = textBox?.localToGlobal(Offset.zero);
          //       double top = offset?.dy ?? 0;
          //       double bottom = top + (textBox?.size.height ?? 0);

          //       if (event is PointerDownEvent) {
          //         if (event.position.dy >= top && event.position.dy <= bottom) {
          //           // Tapped within the bounds of the ListTile, do nothing
          //           return;
          //         }
          //       }

          //       // Tapped outside the ListTile, unfocus the text field and reset the displayed users
          //       // setState(() {
          //       //   textFieldFocus.unfocus();
          //       //   displayedUsers = allUsers;
          //       // });
          //       myFocusNode.unfocus();
          //       // setState(() {
          //       //   showRecentSearches = false;
          //       // });
          //     },
          //     onTap: () {
          //       print(
          //           '+++++++++////////////++++++++++ ${_searchController.text}');
          //       if (_searchController.text.isNotEmpty) {
          //         ref
          //             .read(discoverProvider.notifier)
          //             .searchUsers(_searchController.text.trim());
          //       }
          //       setState(() {
          //         showRecentSearches = true;
          //       });
          //     },
          //     focusNode: myFocusNode,
          //     hintText: "vicki",
          //     onChanged: (val) {
          //       ref.read(discoverProvider.notifier).searchUsers(val);
          //       // changeTypingState(typingText);
          //       setState(() {
          //         typingText = val;
          //       });
          //     },

          //     //!Switching photo functionality with map search till photo search is ready
          //     prefixIcon: null,

          //     // IconButton(
          //     //   onPressed: () async {
          //     //     // var x = await determinePosition();
          //     //     if (!mounted) return;
          //     //     navigateToRoute(context, const MapSearchView());
          //     //   },
          //     //   padding: const EdgeInsets.only(right: 0),
          //     //   icon: const RenderSvgWithoutColor(
          //     //     svgPath: VIcons.directionIcon,
          //     //     svgHeight: 24,
          //     //     svgWidth: 24,
          //     //   ),
          //     // ),
          //     // suffixIcon: IconButton(
          //     //   onPressed: () {
          //     //     if (typingText.isNotEmpty) {
          //     //       changeTypingState(typingText);
          //     //     } else {
          //     //       typingText = "na";
          //     //     }
          //     //   } = false,
          //     //   padding: const EdgeInsets.only(right: 0),
          //     //   icon: const RenderSvgWithoutColor(
          //     //     svgPath: VIcons.searchNormal,
          //     //     svgHeight: 24,
          //     //     svgWidth: 24,
          //     //   ),
          //     // ),
          //   ),
          // ),
          if (!showRecentSearches)
            Column(
              children: [
                //
                // SizedBox(
                //   height: 56,
                //   child: ListView.builder(
                //     padding: const EdgeInsets.symmetric(horizontal: 14),
                //     scrollDirection: Axis.horizontal,
                //     itemCount: categories.length,
                //     itemBuilder: (BuildContext context, int index) {
                //       return CategoryButton(
                //         isSelected: selectedChip == categories[index],
                //         text: categories[index],
                //         onPressed: () => setState(
                //             () => selectedChip = categories[index]),
                //       );
                //     },
                //   ),
                // ),
                //! Experimental tries
                // addVerticalSpacing(25),
                // VWidgetsRecentlyViewedWidget(
                //   profileUrl: '',
                //   onTapTitle: () {},
                //   onTapProfile: () {},
                // ),
                //!

                addVerticalSpacing(10),
                const JobsCarouselTile(
                  title: "Popular Sevices",
                  isService: true,
                ),
                addVerticalSpacing(10),
                const JobsCarouselTile(
                  title: "Popular jobs",
                ),
                addVerticalSpacing(10),
                DiscoverSubList(
                  title: 'Featured talent',
                  items: recentlyViewed,
                  route: ViewAllScreen(
                    title: "Recently Viewed",
                    dataList: recentlyViewed,
                  ),
                ),
                addVerticalSpacing(10),
                DiscoverSubList(
                  title: 'Rising talent',
                  items: recentlyViewed,
                  route: ViewAllScreen(
                    title: "Recently Viewed",
                    dataList: recentlyViewed,
                  ),
                ),
                addVerticalSpacing(48),
                const VellMagazineSection(),
                // Text(
                //   'Vell Magazine',
                //   style: Theme.of(context).textTheme.displayMedium!.copyWith(
                //         // fontWeight: FontWeight.w600,
                //         color: VmodelColors.mainColor,
                //         fontSize: 18.sp,
                //       ),
                // ),
                addVerticalSpacing(32),
                DiscoverSubList(
                  title: 'Most popular',
                  items: recentlyViewed,
                  route: ViewAllScreen(
                    title: "Most popular",
                    dataList: mostPopular,
                  ),
                ),
                addVerticalSpacing(10),
                DiscoverSubList(
                  title: 'Recommended Photographers',
                  items: recentlyViewed,
                  route: ViewAllScreen(
                    title: "Most popular",
                    dataList: mostPopular,
                  ),
                ),
                // GestureDetector(
                //   onTap: () {
                //     navigateToRoute(context, const VMagazineView());
                //   },
                //   child: Padding(
                //     padding: const EdgeInsets.only(top: 15, bottom: 10),
                //     child: Image.asset(
                //       'assets/images/models/vmagazine.png',
                //       fit: BoxFit.cover,
                //       width: double.infinity,
                //       height: 150,
                //     ),
                //   ),
                // ),
                addVerticalSpacing(10),
                DiscoverSubList(
                  title: 'Browse pet models',
                  items: petModels,
                  route: ViewAllScreen(
                    title: "Local",
                    dataList: petModels,
                  ),
                ),
                addVerticalSpacing(32),
                // const VMagazineRow(
                //   image: 'assets/images/models/listTile_3.png',
                //   title: "How to create the perfect looking VModel Portfolio",
                //   subTitle:
                //       "Read our article on “How to perfect your profile before clients see it”",
                // ),
                // DiscoverSubList(
                //     title: 'Browse models',
                //     items: petModels,
                //     route: ViewAllScreen(
                //       title: "Browse models",
                //       dataList: petModels,
                //     )),
                // DiscoverSubList(
                //   title: 'Photographers',
                //   items: photoModels,
                //   eachUserHasProfile: true,
                //   route: ViewAllScreen(
                //     title: "Photographers",
                //     dataList: photoModels,
                //   ),
                // ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Help',
                        style:
                            Theme.of(context).textTheme.displayMedium!.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: VmodelColors.mainColor,
                                ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  child: const VMagazineRow(
                    title: "Getting Started: A Beginner's Guide to VModel",
                    subTitle:
                        "Read our article on “How to perfect your profile before clients see it",
                  ),
                  onTap: () {
                    navigateToRoute(context, const PopularFAQsHomepage());
                  },
                ),
                GestureDetector(
                  child: const VMagazineRow(
                    title: "Navigating the VModel App: A Step-by-Step Tutorial",
                    subTitle:
                        "Read our article on “How to perfect your profile before clients see it",
                  ),
                  onTap: () {
                    navigateToRoute(context, const PopularFAQsHomepage());
                  },
                ),
                InkWell(
                  onTap: () {
                    navigateToRoute(context, const PopularFAQsHomepage());
                  },
                  child: const VMagazineRow(
                    title:
                        "Creating an Impressive Portfolio on VModel: Tips and Tricks",
                    subTitle:
                        "Read our article on “How to perfect your profile before clients see it",
                  ),
                ),
                GestureDetector(
                  child: const VMagazineRow(
                    title:
                        "Booking Gigs on VModel: How to Maximize Your Opportunities",
                    subTitle:
                        "Read our article on “How to perfect your profile before clients see it",
                  ),
                  onTap: () {
                    navigateToRoute(context, const PopularFAQsHomepage());
                  },
                ),
                GestureDetector(
                  child: const VMagazineRow(
                    title: "How to create the perfect looking VModel Portfolio",
                    subTitle:
                        "Read our article on “How to perfect your profile before clients see it",
                  ),
                  onTap: () {
                    navigateToRoute(context, const PopularFAQsHomepage());
                  },
                ),
                InkWell(
                  onTap: () {
                    navigateToRoute(context, const PopularFAQsHomepage());
                  },
                  child: const VMagazineRow(
                    title:
                        "Unlock Rewards: Understanding the VModel Points System",
                    subTitle:
                        "Read our article on “How to perfect your profile before clients see it",
                  ),
                ),
              ],
            ),
          if (showRecentSearches)
            const Column(
              children: [
                DiscoverUserSearchMainView(),
              ],
            ),
        ],
      );
    }, error: (error, stackTrace) {
      return Container(height: 100, width: 300, color: Colors.red);
    }, loading: () {
      return const DiscoverShimmerPage(shouldHaveAppBar: false);
    });
  }

  */
}

class VellMagazineSection extends StatelessWidget {
  const VellMagazineSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RenderSvg(
          svgPath: VIcons.vellMagazineLogo,
          svgHeight: 24,
          svgWidth: 100.w,
        ),
        // addVerticalSpacing(10),
        CarouselWidget(
          height: 450,
          carouselItems: List.generate(
            VConstants.vellMagMockImages.length,
            (index) => GestureDetector(
              onTap: () {
                navigateToRoute(context,
                    WebViewPage(url: VConstants.vellMagArticleLinks[index]));
              },
              child: Image.asset(
                VConstants.vellMagMockImages[index],
                width: double.maxFinite,
                fit: BoxFit.fill,
              ),
              //     CachedNetworkImage(
              //   imageUrl: VConstants.testImage,
              //   fit: BoxFit.cover,
              //   width: double.maxFinite,
              // )
            ),
          ),
        ),
      ],
    );
  }
}

class CarouselWidget extends StatefulWidget {
  const CarouselWidget({
    super.key,
    required this.carouselItems,
    this.isShowIndicator = true,
    this.enableInfiniteScroll = true,
    this.height,
  });

  final List<Widget> carouselItems;
  final bool isShowIndicator;
  final bool enableInfiniteScroll;
  final double? height;

  @override
  State<CarouselWidget> createState() => _CarouselWidgetState();
}

class _CarouselWidgetState extends State<CarouselWidget> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          items: widget.carouselItems,
          carouselController: CarouselController(),
          options: CarouselOptions(
            height: widget.height,
            padEnds: false,
            viewportFraction: 1,
            // aspectRatio: 3 / 2,
            initialPage: 0,
            enableInfiniteScroll: true,
            enlargeStrategy: CenterPageEnlargeStrategy.zoom,
            onPageChanged: (index, reason) {
              _currentIndex = index;
              setState(() {});
            },
          ),
          // options: CarouselOptions(
          //     autoPlay: true,
          //     enlargeCenterPage: true,
          //     aspectRatio: 2.0,
          //     onPageChanged: (index, reason) {
          //       setState(() {
          //         _current = index;
          //       });
          //     }),
        ),
        addVerticalSpacing(10),
        VWidgetsCarouselIndicator(
          currentIndex: _currentIndex,
          totalIndicators: 3,
        ),
      ],
    );
  }
}

class NewUserData {
  final String id;
  final String name;
  final String subName;
  final String imgPath;

  NewUserData({
    required this.id,
    required this.name,
    required this.subName,
    required this.imgPath,
  });
}

List<NewUserData> userDataList() {
  // Dummy user data list
  return [
    NewUserData(
      id: '1',
      name: 'John Doe',
      subName: 'Model',
      imgPath: 'assets/images/users/john_doe.png',
    ),
    NewUserData(
      id: '2',
      name: 'Jane Smith',
      subName: 'Photographer',
      imgPath: 'assets/images/users/jane_smith.png',
    ),
    NewUserData(
      id: '3',
      name: 'Mike Johnson',
      subName: 'Model',
      imgPath: 'assets/images/users/mike_johnson.png',
    ),
    // Add more users here
  ];
}

class UserSearch {
  static List<NewUserData> searchUsers(String query, List<NewUserData> users) {
    // Perform search based on query and return filtered users
    final filteredUsers = users.where((user) =>
        user.name.toLowerCase().contains(query.toLowerCase()) ||
        user.subName.toLowerCase().contains(query.toLowerCase()));
    return filteredUsers.toList();
  }
}



/** 
_oldDiscoverBodyNow () {
  
                      addVerticalSpacing(10),
                      _featuredData.when(data: (_data) {
                        return DiscoverSubList(
                          onTap: (value) => _navigateToUserProfile(value),
                          title: 'Featured talent',
                          items: _data,
                          route: ViewAllScreen(
                            title: "Featured talent",
                            dataList: _data,
                            getList: DiscoverController().feaaturedList,
                            onItemTap: (value) =>
                                _navigateToUserProfile(value, isViewAll: true),
                          ),
                        );
                      }, error: (((error, stackTrace) {
                        return Container();
                      })), loading: () {
                        return DiscoverSubList(
                          onTap: (value) => _navigateToUserProfile(value),
                          title: 'Featured talent',
                          items: recentlyViewed,
                          route: ViewAllScreen(
                            onItemTap: (value) =>
                                _navigateToUserProfile(value, isViewAll: true),
                            title: "Featured talent",
                            dataList: recentlyViewed,
                            getList: DiscoverController().feaaturedList,
                          ),
                        );
                      }),
                      addVerticalSpacing(10),

                      _risingTalentsData.when(data: (_data) {
                        return DiscoverSubList(
                          onTap: (value) => _navigateToUserProfile(value),
                          title: 'Rising talent',
                          items: _data,
                          route: ViewAllScreen(
                            onItemTap: (value) =>
                                _navigateToUserProfile(value, isViewAll: true),
                            title: "Rising talent",
                            dataList: _data,
                            getList: DiscoverController().risingTalent,
                          ),
                        );
                      }, error: (((error, stackTrace) {
                        return Container();
                      })), loading: () {
                        return DiscoverSubList(
                          onTap: (value) => _navigateToUserProfile(value),
                          title: 'Rising talent',
                          items: recentlyViewed,
                          route: ViewAllScreen(
                            onItemTap: (value) =>
                                _navigateToUserProfile(value, isViewAll: true),
                            title: "Rising talent",
                            dataList: recentlyViewed,
                            getList: DiscoverController().risingTalent,
                          ),
                        );
                      }),
                      addVerticalSpacing(10),

                      _risingTalentsData.when(data: (_data) {
                        return DiscoverSubList(
                          onTap: (value) => _navigateToUserProfile(value),
                          title: 'Talents near you',
                          items: _data,
                          route: ViewAllScreen(
                            onItemTap: (value) =>
                                _navigateToUserProfile(value, isViewAll: true),
                            title: 'Talents near you',
                            dataList: _data,
                            getList: DiscoverController().feaaturedList,
                          ),
                        );
                      }, error: (((error, stackTrace) {
                        return Container();
                      })), loading: () {
                        return DiscoverSubList(
                          onTap: (value) => _navigateToUserProfile(value),
                          title: 'Talents near you',
                          items: recentlyViewed,
                          route: ViewAllScreen(
                            onItemTap: (value) =>
                                _navigateToUserProfile(value, isViewAll: true),
                            title: 'Talents near you',
                            dataList: recentlyViewed,
                            getList: DiscoverController().feaaturedList,
                          ),
                        );
                      }),

                      // addVerticalSpacing(10),

                      addVerticalSpacing(48),
                      const VellMagazineSection(),
                      // Text(
                      //   'Vell Magazine',
                      //   style: Theme.of(context).textTheme.displayMedium!.copyWith(
                      //         // fontWeight: FontWeight.w600,
                      //         color: VmodelColors.mainColor,
                      //         fontSize: 18.sp,
                      //       ),
                      // ),
                      addVerticalSpacing(32),
                      _risingTalentsData.when(data: (_data) {
                        return DiscoverSubList(
                          onTap: (value) => _navigateToUserProfile(value),
                          title: 'Most Popular',
                          items: _data,
                          route: ViewAllScreen(
                            onItemTap: (value) =>
                                _navigateToUserProfile(value, isViewAll: true),
                            title: "Most Popular",
                            dataList: _data,
                            getList: DiscoverController().feaaturedList,
                          ),
                        );
                      }, error: (((error, stackTrace) {
                        return Container();
                      })), loading: () {
                        return DiscoverSubList(
                          onTap: (value) => _navigateToUserProfile(value),
                          title: 'Most Popular',
                          items: recentlyViewed,
                          route: ViewAllScreen(
                            onItemTap: (value) =>
                                _navigateToUserProfile(value, isViewAll: true),
                            title: "Most Popular",
                            dataList: recentlyViewed,
                            getList: DiscoverController().feaaturedList,
                          ),
                        );
                      }),

                      addVerticalSpacing(10),
                      _photographersData.when(data: (_data) {
                        return DiscoverSubList(
                          onTap: (value) => _navigateToUserProfile(value),
                          title: 'Recommended Photographers',
                          items: _data,
                          route: ViewAllScreen(
                            onItemTap: (value) =>
                                _navigateToUserProfile(value, isViewAll: true),
                            title: "Recommended Photographers",
                            dataList: _data,
                            getList: DiscoverController().photographers,
                          ),
                        );
                      }, error: (((error, stackTrace) {
                        return Container();
                      })), loading: () {
                        return DiscoverSubList(
                          onTap: (value) => _navigateToUserProfile(value),
                          title: 'Recommended Photographers',
                          items: recentlyViewed,
                          route: ViewAllScreen(
                            onItemTap: (value) =>
                                _navigateToUserProfile(value, isViewAll: true),
                            title: "Recommended Photographers",
                            dataList: recentlyViewed,
                            getList: DiscoverController().photographers,
                          ),
                        );
                      }),

                      addVerticalSpacing(10),
                      _petModelData.when(
                        data: (_data) {
                          return DiscoverSubList(
                            onTap: (value) => _navigateToUserProfile(value),
                            title: 'Browse pet models',
                            items: _data,
                            route: ViewAllScreen(
                              onItemTap: (value) => _navigateToUserProfile(
                                  value,
                                  isViewAll: true),
                              title: "Browse pet models",
                              dataList: _data,
                              getList: DiscoverController().petModels,
                            ),
                          );
                        },
                        error: (((error, stackTrace) {
                          return Container();
                        })),
                        loading: () {
                          return DiscoverSubList(
                            onTap: (value) => _navigateToUserProfile(value),
                            title: 'Browse pet models',
                            items: recentlyViewed,
                            route: ViewAllScreen(
                              title: "Browse pet models",
                              dataList: recentlyViewed,
                              getList: DiscoverController().petModels,
                              onItemTap: (value) => _navigateToUserProfile(
                                  value,
                                  isViewAll: true),
                            ),
                          );
                        },
                      ),

                      addVerticalSpacing(10),

                      _risingTalentsData.when(
                        data: (_data) {
                          return DiscoverSubList(
                            onTap: (value) => _navigateToUserProfile(value),
                            title: 'Recommended businesses to follow',
                            items: _data,
                            route: ViewAllScreen(
                              onItemTap: (value) => _navigateToUserProfile(
                                  value,
                                  isViewAll: true),
                              title: "Recommended businesses to follow",
                              dataList: _data,
                              getList: DiscoverController().risingTalent,
                            ),
                          );
                        },
                        error: (((error, stackTrace) {
                          return Container();
                        })),
                        loading: () {
                          return DiscoverSubList(
                            onTap: (value) => _navigateToUserProfile(value),
                            title: 'Recommended businesses to follow',
                            items: recentlyViewed,
                            route: ViewAllScreen(
                              title: "Recommended businesses to follow",
                              dataList: recentlyViewed,
                              getList: DiscoverController().feaaturedList,
                              onItemTap: (value) => _navigateToUserProfile(
                                  value,
                                  isViewAll: true),
                            ),
                          );
                        },
                      ),
}
*/