import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vmodel/src/core/cache/hive_provider.dart';
import 'package:vmodel/src/features/create_coupons/add_coupons.dart';
import 'package:vmodel/src/features/dashboard/discover/models/discover_item.dart';
import 'package:vmodel/src/features/dashboard/discover/views/discover_user_search.dart/views/dis_search_main_screen.dart';
import 'package:vmodel/src/features/dashboard/discover/views/explore.dart';
// import 'package:vmodel/src/features/dashboard/discover/views/discover_photo_search/discover_photo_search.dart';
import 'package:vmodel/src/features/dashboard/discover/views/sub_screens/view_all.dart';
import 'package:vmodel/src/features/dashboard/discover/widget/discover_sub_list.dart';
import 'package:vmodel/src/features/dashboard/discover/widget/user_types_widget.dart';
import 'package:vmodel/src/features/dashboard/discover/widget/vmagazine_row.dart';
import 'package:vmodel/src/features/jobs/job_market/widget/flexible_space_fade.dart';
import 'package:vmodel/src/features/messages/views/messages_homepage.dart';
// import 'package:vmodel/src/features/vmagazine/views/vMagzine_view.dart';
import 'package:vmodel/src/res/icons.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/shared/buttons/primary_button.dart';
import 'package:vmodel/src/shared/hint_dilaogue.dart';
import 'package:vmodel/src/shared/rend_paint/render_svg.dart';
import 'package:vmodel/src/shared/shimmer/discoverShimmerPage.dart';
import 'package:vmodel/src/vmodel.dart';

import '../../../../core/controller/app_user_controller.dart';
import '../../../../core/utils/costants.dart';
import '../../../../core/utils/debounce.dart';
import '../../../../core/utils/enum/discover_category_enum.dart';
import '../../../../core/utils/enum/discover_search_tabs_enum.dart';
import '../../../../core/utils/helper_functions.dart';
import '../../../../shared/carousel_indicators.dart';
import '../../../../shared/shimmer/post_shimmer.dart';
import '../../../faq_s/views/popular_faqs_page.dart';
import '../../../jobs/job_market/views/search_field.dart';
import '../../../jobs/job_market/widget/coupons_row_section.dart';
import '../../../jobs/job_market/widget/recent_viewed_users_row.dart';
import '../../../refer_and_earn/views/invite_and_earn_homepage.dart';
import '../../../saved/views/boards_search.dart';
import '../../creation_tools/creation_tools.dart';
import '../../dash/controller.dart';
import '../../new_profile/views/other_profile_router.dart';
import '../../profile/view/webview_page.dart';
import '../controllers/composite_search_controller.dart';
import '../controllers/discover_controller.dart';
import '../controllers/discover_talents_near_your.dart';
import '../controllers/explore_provider.dart';
import '../controllers/follow_connect_controller.dart';
import '../controllers/hash_tag_search_controller.dart';
import '../controllers/recent_hash_tags_controller.dart';
import '../controllers/vell_articles_controller.dart';
import '../models/mock_data.dart';
import '../widget/dark_gradient_overlay.dart';
import '../widget/discover_sub_item_error_widget.dart';
import '../widget/recently_viewed_all.dart';
import '../widget/vell_magazine_articles_section.dart';
import 'discover_verified_section.dart';
import 'sub_screens/vell_articles_view_all.dart';

class DiscoverViewV3 extends ConsumerStatefulWidget {
  const DiscoverViewV3({super.key, this.refreshIndicatorKey});
  final GlobalKey<RefreshIndicatorState>? refreshIndicatorKey;

  @override
  ConsumerState<DiscoverViewV3> createState() => _DiscoverViewV3();
}

class _DiscoverViewV3 extends ConsumerState<DiscoverViewV3> {
  String typingText = "";
  bool isLoading = true;
  bool showRecentSearches = false;
  bool isExpanded = false;

  FocusNode searchfocus = FocusNode();

  ScrollController _controller = ScrollController();

  // FocusNode myFocusNode = FocusNode();
  late Future getFeaturedTalents;
  late Future getRisingTalents;
  late Future getPhotgraphers;
  late Future getPetModels;

  final TextEditingController _searchController = TextEditingController();
  // late final List<DiscoverItemObject> _categoryItems;
  // List<DiscoverItemObject> _ca = [];
  final DiscoverCategory _discoverCategoryType = DiscoverCategory.values.first;

  late final Debounce _debounce;
  bool showHint = false;

  double _scrollOffset = 0.0;
  int? initialSearchPageIndex = 0;

  changeTypingState(String val) {
    typingText = val;
    setState(() {});
  }

  @override
  void initState() {
    // startLoading();
    super.initState();

    _debounce = Debounce(delay: Duration(milliseconds: 300));
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //   if (ref.watch(showRecentViewProvider)) {
    //     ref.read(searchTabProvider.notifier).state = 1;
    //     initialSearchPageIndex = 1;
    //     final text = ref.watch(hashTagSearchProvider);
    //     _searchController.text = text!;
    //     searchfocus.requestFocus();
    //   } else {
    //     initialSearchPageIndex = 0;
    //   }
    //   if (mounted) setState(() {});
    // });

    ref
        .read(discoverProvider.notifier)
        .updateSearchController(_searchController);
    hideHint();
    _controller.addListener(() {
      // if ((_controller.position.userScrollDirection ==
      //         ScrollDirection.forward) &&
      //     ((_scrollOffset / 100).clamp(0, 1).toDouble()) != 0.0) {
      //   _scrollOffset = 0.0;
      //   if (mounted) setState(() {});
      //   return;
      // }
      // if (((_scrollOffset / 100).clamp(0, 1).toDouble()) != 1.0) {
      _scrollOffset = _controller.offset;
      // if (mounted) setState(() {});
      // }
    });
    initialSearchString();
  }

  void initialSearchString() {
    final searchTabIndex = ref.read(searchTabProvider);
    if (searchTabIndex == DiscoverSearchTab.hashtags.index) {
      // final query = ref.read(hashTagSearchProvider);
      _searchController.text = ref.read(hashTagSearchProvider) ?? '';
    }
  }

  void hideHint() async {
    if (!showHint) {
      await Future.delayed(Duration(seconds: 2));
      if (mounted) setState(() => showHint = true);
      await Future.delayed(Duration(seconds: 4));
      if (mounted) setState(() => showHint = false);
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    // myFocusNode.dispose();
    _debounce.dispose();
    // ref.invalidate(showRecentViewProvider);
    super.dispose();
  }

  List<String> imageList = [
    "assets/images/discover_categories/cat_art_design.jpg",
    "assets/images/discover_categories/cat_cooking.jpg",
    "assets/images/discover_categories/cat_event_planning.jpg",
    "assets/images/discover_categories/cat_photographer.jpg",
  ];
  String selectedChip = "Models";
  @override
  Widget build(BuildContext context) {
    final recentlyViewedProfileList = ref.watch(hiveStoreProvider.notifier);
    final recents = recentlyViewedProfileList.getRecentlyViewedList();
    final discoverProviderState = ref.watch(discoverProvider);
    final exlporePage = ref.watch(exploreProvider.notifier);
    ref.watch(accountToFollowProvider);
    ref.watch(hashTagSearchProvider);

    var key1 = GlobalKey();

    return Scaffold(
      body: exlporePage.isExplore
          ? const Explore()
          : Stack(
              children: [
                CustomScrollView(
                  controller: _controller,
                  physics: const AlwaysScrollableScrollPhysics(
                      parent: BouncingScrollPhysics()),
                  slivers: [
                    SliverAppBar(
                      pinned: true,

                      floating: true,
                      expandedHeight: 170.0,
                      title: Text(
                        "Discover",
                        style:
                            Theme.of(context).textTheme.displayLarge!.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                      ),
                      centerTitle: true,
                      flexibleSpace: FlexibleSpaceBar(
                        centerTitle: true,
                        background: _titleSearch(),
                      ),
                      // leadingWidth: 150,
                      leading: const SizedBox.shrink(),
                      elevation: 0,
                      actions: [
                        GestureDetector(
                            onTap: () =>
                                navigateToRoute(context, MessagingHomePage()),
                            child: Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child:
                                  RenderSvg(svgPath: VIcons.message_unselected),
                            )),
                      ],
                    ),
                    discoverProviderState.when(data: (discoverItems) {
                      if (ref.watch(showRecentViewProvider)) {
                        return DiscoverUserSearchMainView(
                          initialSearchPageIndex: initialSearchPageIndex,
                        );
                      }

                      if (discoverItems == null) {
                        return SliverToBoxAdapter(child: Text('Got null data'));
                      }

                      return SliverList.list(
                        children: [
                          if (recents.isNotEmpty)
                            RecentViewedUsersSection(
                              title: 'Recently viewed',
                              users: recents,
                              onTap: (username) =>
                                  _navigateToUserProfile(username),
                              onViewAllTap: () async {
                                await navigateToRoute(
                                    context, RecentlyViewedAll());
                                ref.watch(hiveStoreProvider.notifier);
                                widget.refreshIndicatorKey?.currentState
                                    ?.show();
                                setState(() {});
                              },
                            ),
                          HorizontalCouponSection(
                            title: 'Hottest Coupons',
                          ),

                          GestureDetector(
                            onTap: () {
                              HapticFeedback.lightImpact();
                              navigateToRoute(
                                  context, AddNewCouponHomepage(context));
                            },
                            child: createCoupon(context),
                          ),
                          addVerticalSpacing(20),
                          UserTypesWidget(
                            scrollBack: () {
                              // double scrollAmount = 1000.0;
                              // await Future.delayed(Duration(milliseconds: 200));
                              Scrollable.ensureVisible(key1.currentContext!);
                              // _controller.animateTo(
                              //   _controller.offset -
                              //       scrollAmount, // Scroll to the top
                              //   duration:
                              //       Duration(milliseconds: 500), // Adjust as needed
                              //   curve: Curves
                              //       .ease, // Adjust the animation curve as needed
                              // );
                            },
                            key: key1,
                            mockImages: userTypesMockImages,
                            title: "Trending now",
                          ),
                          addVerticalSpacing(10),
                          GestureDetector(
                            onTap: () {
                              HapticFeedback.lightImpact();
                              navigateToRoute(
                                  context, const ReferAndEarnHomepage());
                            },
                            child: inviteAndWin(context),
                          ),
                          addVerticalSpacing(20),
                          DiscoverSubList(
                            onTap: (value) => _navigateToUserProfile(value),
                            title: 'Spotlight',
                            items: _getSubListOfData(
                                discoverItems.featuredTalents),
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
                              onItemTap: (value) => _navigateToUserProfile(
                                  value,
                                  isViewAll: true),
                            ),
                          ),
                          addVerticalSpacing(10),

                          DiscoverSubList(
                            onTap: (value) => _navigateToUserProfile(value),
                            title: 'Rising talent',
                            items:
                                _getSubListOfData(discoverItems.risingTalents),
                            onViewAllTap: () {
                              ref.read(viewAllDataProvider.notifier).state =
                                  discoverItems.risingTalents;
                              navigateToRoute(context,
                                  ViewAllScreen(title: 'Rising talent'));
                              // context.pushNamed(
                              //   ViewAllScreen.routeName,
                              //   pathParameters: {'title': 'Rising talent'},
                              // );
                            },
                            route: ViewAllScreen(
                              onItemTap: (value) => _navigateToUserProfile(
                                  value,
                                  isViewAll: true),
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
                                onItemTap: (value) => _navigateToUserProfile(
                                    value,
                                    isViewAll: true),
                                title: 'Talent near you',
                                // dataList: items,
                                // getList: DiscoverController().feaaturedList,
                              ),
                            );
                          }, orElse: () {
                            return DiscoverSubListError(
                                title: 'Talents near you');
                            // return SizedBox.shrink();
                          }),

                          addVerticalSpacing(10),

                          // addVerticalSpacing(48),
                          // const VellMagazineSection(),
                          // addVerticalSpacing(32),
                          DiscoverSubList(
                            onTap: (value) => _navigateToUserProfile(value),
                            title: 'Most Popular',
                            items:
                                _getSubListOfData(discoverItems.popularTalents),
                            onViewAllTap: () {
                              ref.read(viewAllDataProvider.notifier).state =
                                  discoverItems.popularTalents;
                              navigateToRoute(context,
                                  ViewAllScreen(title: 'Most Popular'));
                              // context.pushNamed(
                              //   ViewAllScreen.routeName,
                              //   pathParameters: {'title': 'Most Popular'},
                              // );
                            },
                            route: ViewAllScreen(
                              onItemTap: (value) => _navigateToUserProfile(
                                  value,
                                  isViewAll: true),
                              title: "Most Popular",
                              // dataList: discoverItems.popularTalents,
                              // getList: DiscoverController().feaaturedList,
                            ),
                          ),

                          addVerticalSpacing(20),
                          creationTools(context),
                          // GestureDetector(
                          //   onTap: () {
                          //     navigateToRoute(context, const CreationTools());
                          //   },
                          //   child: Container(
                          //     width: 100.w,
                          //     height: 100,
                          //     margin: EdgeInsets.symmetric(horizontal: 16),
                          //     decoration: BoxDecoration(
                          //       color: Colors.amber,
                          //       borderRadius: BorderRadius.circular(10),
                          //     ),
                          //     child: Stack(
                          //       children: [
                          //         ClipRRect(
                          //           borderRadius: BorderRadius.circular(10),
                          //           child: CachedNetworkImage(
                          //             imageUrl: VMString.testImageUrl,
                          //             fadeInDuration: Duration.zero,
                          //             fadeOutDuration: Duration.zero,
                          //             width: double.maxFinite,
                          //             height: double.maxFinite,
                          //             filterQuality: FilterQuality.medium,
                          //             fit: BoxFit.cover,
                          //             // fit: BoxFit.contain,
                          //             placeholder: (context, url) {
                          //               return const PostShimmerPage();
                          //             },
                          //             errorWidget: (context, url, error) =>
                          //                 const Icon(Icons.error),
                          //           ),
                          //         ),
                          //         Positioned.fill(
                          //           child: DarkGradientOverlay(
                          //               bottomColor: Colors.black54),
                          //         ),
                          //         Positioned(
                          //           left: 0,
                          //           bottom: 20,
                          //           child: Padding(
                          //             padding: const EdgeInsets.symmetric(
                          //                 horizontal: 8, vertical: 4),
                          //             child: Text(
                          //               "Creation Tools",
                          //               style: context.textTheme.displayMedium!
                          //                   .copyWith(
                          //                 fontWeight: FontWeight.w600,
                          //                 color: Colors.white,
                          //               ),
                          //             ),
                          //           ),
                          //         ),
                          //       ],
                          //     ),
                          //   ),
                          // ),
                          addVerticalSpacing(36),
                          GestureDetector(
                            onTap: () {
                              navigateToRoute(
                                  context, const BoardsSearchPage());
                            },
                            child: Container(
                              width: 100.w,
                              height: 100,
                              margin: EdgeInsets.symmetric(horizontal: 16),
                              decoration: BoxDecoration(
                                color: Colors.amber,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: CachedNetworkImage(
                                      imageUrl: VMString.testImageUrl3,
                                      fadeInDuration: Duration.zero,
                                      fadeOutDuration: Duration.zero,
                                      width: double.maxFinite,
                                      height: double.maxFinite,
                                      filterQuality: FilterQuality.medium,
                                      fit: BoxFit.cover,
                                      // fit: BoxFit.contain,
                                      placeholder: (context, url) {
                                        return const PostShimmerPage();
                                      },
                                      errorWidget: (context, url, error) =>
                                          const Icon(Icons.error),
                                    ),
                                  ),
                                  Positioned.fill(
                                    child: DarkGradientOverlay(
                                        bottomColor: Colors.black54),
                                  ),
                                  Positioned(
                                    left: 0,
                                    bottom: 0,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 8, bottom: 16),
                                      child: Text(
                                        "Discover boards",
                                        style: context.textTheme.displayMedium!
                                            .copyWith(
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          addVerticalSpacing(36),

                          ref.watch(vellArticlesProvider).when(data: (items) {
                            return VellMagazineArticlesSection(
                              onTap: (value) => _navigateToUserProfile(value),
                              title: 'Vell magazine',
                              articles: items,
                              onViewAllTap: () {
                                ref
                                    .read(vellArticlesViewAllDataProvider
                                        .notifier)
                                    .state = items;
                                navigateToRoute(
                                    context,
                                    VellArticlesViewAllScreen(
                                        title: 'Vell magazine'));
                                // context.pushNamed(
                                //   ViewAllScreen.routeName,
                                //   pathParameters: {'title': 'Talent near you'},
                                // );
                              },
                              route: ViewAllScreen(
                                onItemTap: (value) => _navigateToUserProfile(
                                    value,
                                    isViewAll: true),
                                title: 'Vell magazine',
                                // dataList: items,
                                // getList: DiscoverController().feaaturedList,
                              ),
                            );
                          }, loading: () {
                            return Center(
                              child: CircularProgressIndicator.adaptive(),
                            );
                            // return SizedBox.shrink();
                          }, error: ((error, stackTrace) {
                            return DiscoverSubListError(title: 'Vell magazine');
                          })),
                          addVerticalSpacing(20),

                          if (!ref.watch(showRecentViewProvider))
                            DiscoverVerifiedSection(),
                          addVerticalSpacing(10),

                          // addVerticalSpacing(10),
                          GestureDetector(
                            child: const VMagazineRow(
                              icon: VIcons.menuFAQ,
                              title: "Help centre",
                              subTitle: "",
                              showTitleOnly: true,
                            ),
                            onTap: () {
                              HapticFeedback.lightImpact();
                              navigateToRoute(
                                  context, const PopularFAQsHomepage());
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
                    }),
                  ],
                ),
                if (showHint)
                  HintDialogue(
                    onTapDialogue: () => setState(() => showHint = false),
                    text: 'Tap to access messages',
                  )
              ],
            ),
    );
  }

  Widget userTypesWidget(BuildContext context) {
    return Column(
      key: Key("value"),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          alignment: Alignment.topCenter,
          child: Wrap(
            spacing: 1,
            runSpacing: 13,
            children: [
              if (isExpanded)
                for (var index = 0;
                    index < VConstants.tempCategories.length;
                    index++)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: SizerUtil.height * 0.22,
                      width: SizerUtil.height * .203,
                      alignment: Alignment.bottomCenter,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Theme.of(context).colorScheme.secondary,
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage(
                            userTypesMockImages[index],
                          ),
                        ),
                      ),
                      child: Container(
                        height: SizerUtil.height,
                        width: SizerUtil.width,
                        alignment: Alignment.bottomCenter,
                        padding: EdgeInsets.only(bottom: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            gradient: const LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                stops: [0.6, 1],
                                colors: [Colors.transparent, Colors.black87])),
                        child: Text(
                          VConstants.tempCategories[index],
                          style: Theme.of(context)
                              .textTheme
                              .displayLarge!
                              .copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                      ),
                    ),
                  ),
              if (!isExpanded)
                for (var index = 0; index < 2; index++)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: SizerUtil.height * 0.22,
                      width: SizerUtil.height * .203,
                      alignment: Alignment.bottomCenter,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage(
                            userTypesMockImages[index],
                          ),
                        ),
                      ),
                      child: Container(
                        height: SizerUtil.height,
                        width: SizerUtil.width,
                        alignment: Alignment.bottomCenter,
                        padding: EdgeInsets.only(bottom: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            gradient: const LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                stops: [0.6, 1],
                                colors: [Colors.transparent, Colors.black87])),
                        child: Text(
                          VConstants.tempCategories[index],
                          style: Theme.of(context)
                              .textTheme
                              .displayLarge!
                              .copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                      ),
                    ),
                  ),
            ],
          ),
        ),
        addVerticalSpacing(10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 13),
          child: VWidgetsPrimaryButton(
            buttonColor: Theme.of(context).colorScheme.secondary,
            onPressed: () => setState(() => isExpanded = !isExpanded),
            buttonTitle: isExpanded ? "Collapse" : "Expand",
            buttonTitleTextStyle:
                Theme.of(context).textTheme.displayLarge!.copyWith(
                      color: Theme.of(context).buttonTheme.colorScheme!.primary,
                      fontWeight: FontWeight.w600,
                      // fontSize: 12.sp,
                    ),
          ),
        )
      ],
    );
  }

  Widget createCoupon(BuildContext context) {
    return Container(
      // height: 100,
      margin: EdgeInsets.symmetric(horizontal: 16),
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Theme.of(context).buttonTheme.colorScheme!.secondary,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              GestureDetector(
                  onTap: () {},
                  child: Icon(
                    Icons.add,
                    size: 20,
                  )),
              Text(
                "Create your own",
                style: context.textTheme.displayMedium!.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          addVerticalSpacing(10),
          Text(
            "${VMString.bullet} Add your coupons, earn rewards when they're used",
            style: context.textTheme.displaySmall!.copyWith(fontSize: 10.sp),
            maxLines: 2,
          ),
          // addVerticalSpacing(5),
          // Text(
          //   "${VMString.bullet} Get notifications when your coupon get copied by your audience",
          //   style: context.textTheme.displaySmall!.copyWith(fontSize: 10.sp),
          //   maxLines: 2,
          // ),
        ],
      ),
    );
  }

  Container inviteAndWin(BuildContext context) {
    return Container(
      // height: 100,
      margin: EdgeInsets.symmetric(horizontal: 16),
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Theme.of(context).buttonTheme.colorScheme!.secondary,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "Invite and Earn",
                style: context.textTheme.displayMedium!.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          addVerticalSpacing(10),
          Text(
            "${VMString.bullet} Invite your friends and earn a reward within the app.",
            style: context.textTheme.displaySmall!.copyWith(fontSize: 10.sp),
            maxLines: 2,
          ),
          addVerticalSpacing(5),
          Text(
            "${VMString.bullet} Get £10 when your invite completes their first job.",
            style: context.textTheme.displaySmall!.copyWith(fontSize: 10.sp),
            maxLines: 2,
          ),
        ],
      ),
    );
  }

  Widget creationTools(BuildContext context) {
    return GestureDetector(
      onTap: () {
        HapticFeedback.lightImpact();
        navigateToRoute(context, const CreationTools());
      },
      child: Container(
        // height: 100,
        margin: EdgeInsets.symmetric(horizontal: 16),
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Theme.of(context).buttonTheme.colorScheme!.secondary,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  "Creation Tools",
                  style: context.textTheme.displayMedium!.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            addVerticalSpacing(10),
            RichText(
                maxLines: 2,
                text: TextSpan(text: '', children: [
                  TextSpan(
                    text: "${VMString.bullet}",
                    style: context.textTheme.displaySmall!.copyWith(
                      fontSize: 10.sp,
                    ),
                  ),
                  TextSpan(
                    text: " Split",
                    style: context.textTheme.displaySmall!.copyWith(
                      fontSize: 10.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text: " your photos into the frames you want!",
                    style: context.textTheme.displaySmall!
                        .copyWith(fontSize: 10.sp),
                  ),
                ])),
            addVerticalSpacing(5),
            RichText(
                maxLines: 2,
                text: TextSpan(text: '', children: [
                  TextSpan(
                    text: "${VMString.bullet}",
                    style: context.textTheme.displaySmall!.copyWith(
                      fontSize: 10.sp,
                    ),
                  ),
                  TextSpan(
                    text: " Print",
                    style: context.textTheme.displaySmall!.copyWith(
                      fontSize: 10.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text: " a portfolio",
                    style: context.textTheme.displaySmall!
                        .copyWith(fontSize: 10.sp),
                  ),
                ])),
          ],
        ),
      ),
    );
  }

  Widget _titleSearch() {
    return SafeArea(
      child: Stack(
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              addVerticalSpacing(70),
              Container(
                padding: const VWidgetsPagePadding.horizontalSymmetric(18),
                alignment: Alignment.bottomCenter,
                child: SearchTextFieldWidget(
                  hintText: "Search a user or hashtag...",
                  controller: _searchController,
                  // onChanged: (val) {},
                  focusNode: searchfocus,
                  onTapOutside: (event) {
                    // ref.invalidate(showRecentViewProvider);
                    // _searchController.clear();
                    RenderBox? textBox =
                        context.findRenderObject() as RenderBox?;
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
                  // focusNode: myFocusNode,
                  onCancel: () {
                    initialSearchPageIndex = 0;
                    ref.invalidate(searchTabProvider);
                    ref.invalidate(hashTagSearchProvider);
                    _searchController.text = '';
                    showRecentSearches = false;
                    typingText = '';
                    // myFocusNode.unfocus();
                    setState(() {});
                    searchfocus.unfocus();

                    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                    ref.read(showRecentViewProvider.notifier).state = false;
                    // });
                  },
                  onChanged: (val) {
                    // final tabIndex = ref.watch(searchTabProvider);

                    _debounce(
                      () {
                        ref
                            .read(compositeSearchProvider.notifier)
                            .updateState(query: val);
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
              // if (ref.watch(showRecentViewProvider))
              ref.watch(recentHashTagsProvider).maybeWhen(data: (items) {
                return Container(
                  height: 50,
                  // padding: EdgeInsets.symmetric(horizontal: 16),
                  child: ListView.builder(
                    itemCount: items.length + 1,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      if (index == 0 || index == items.length)
                        return SizedBox(width: 15);
                      final item = items[index - 1];
                      return Padding(
                        padding: const EdgeInsets.only(right: 5, left: 5),
                        child: GestureDetector(
                          onTap: () {
                            searchfocus.requestFocus();
                            initialSearchPageIndex = 1;
                            showRecentSearches = true;
                            _searchController.text = formatAsHashtag(item);
                            ref.invalidate(hashTagProvider);
                            WidgetsBinding.instance
                                .addPostFrameCallback((timeStamp) {
                              ref.read(showRecentViewProvider.notifier).state =
                                  true;
                              ref.read(hashTagSearchProvider.notifier).state =
                                  formatAsHashtag(item);

                              ref.read(searchTabProvider.notifier).state = 1;
                            });
                          },
                          child: Chip(
                            backgroundColor: Theme.of(context)
                                .buttonTheme
                                .colorScheme!
                                .secondary,
                            side: BorderSide.none,
                            // labelPadding: EdgeInsets.zero,
                            // padding: EdgeInsets.only(left: 0, right: 10),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            // avatar: Icon(Icons.arrow_outward_outlined, size: 20),
                            label: Text(
                              // "#" + items[index],
                              formatAsHashtag(item),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              }, orElse: () {
                return Container(
                  height: 50,
                  // padding: EdgeInsets.symmetric(horizontal: 16),
                  child: ListView.builder(
                    itemCount: VConstants.tempCategories.length + 1,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      if (index == 0 ||
                          index == VConstants.tempCategories.length)
                        return SizedBox(width: 15);
                      final item = VConstants.tempCategories[index - 1];
                      return Padding(
                        padding: const EdgeInsets.only(right: 5, left: 5),
                        child: GestureDetector(
                          onTap: () {
                            searchfocus.requestFocus();
                            initialSearchPageIndex = 1;
                            showRecentSearches = true;
                            _searchController.text = formatAsHashtag(item);
                            ref.invalidate(hashTagProvider);
                            WidgetsBinding.instance
                                .addPostFrameCallback((timeStamp) {
                              ref.read(showRecentViewProvider.notifier).state =
                                  true;
                              ref.read(hashTagSearchProvider.notifier).state =
                                  formatAsHashtag(item);

                              ref.read(searchTabProvider.notifier).state = 1;
                            });
                          },
                          child: Chip(
                            backgroundColor: Theme.of(context)
                                .buttonTheme
                                .colorScheme!
                                .secondary,
                            side: BorderSide.none,
                            // labelPadding: EdgeInsets.zero,
                            // padding: EdgeInsets.only(left: 0, right: 10),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            // avatar: Icon(Icons.arrow_outward_outlined, size: 20),
                            label: Text(formatAsHashtag(item)),
                          ),
                        ),
                      );
                    },
                  ),
                );
              }),
            ],
          ),
          // FlexibleSpaceFade(scrollOffset: _scrollOffset),
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
