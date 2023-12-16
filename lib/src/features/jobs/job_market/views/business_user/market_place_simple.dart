import 'package:flutter/services.dart';
import 'package:flutter_animated_icons/lottiefiles.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:vmodel/src/core/controller/app_user_controller.dart';
import 'package:vmodel/src/core/utils/debounce.dart';
import 'package:vmodel/src/core/utils/enum/discover_category_enum.dart';
import 'package:vmodel/src/features/dashboard/discover/controllers/discover_controller.dart';
import 'package:vmodel/src/features/dashboard/new_profile/user_offerings/views/tabbed_user_offerings.dart';
import 'package:vmodel/src/features/jobs/job_market/controller/all_jobs_search_controller.dart';
import 'package:vmodel/src/features/jobs/job_market/controller/job_provider.dart';
import 'package:vmodel/src/features/jobs/job_market/controller/local_services_controller.dart';
import 'package:vmodel/src/features/jobs/job_market/views/all_jobs.dart';
import 'package:vmodel/src/features/jobs/job_market/views/all_jobs_search_widget.dart';
import 'package:vmodel/src/features/jobs/job_market/views/search_field.dart';
import 'package:vmodel/src/features/jobs/job_market/widget/flexible_space_fade.dart';
import 'package:vmodel/src/features/vmodel_credits/views/vmc_history_main.dart';
import 'package:vmodel/src/res/icons.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/shared/rend_paint/render_svg.dart';
import 'package:vmodel/src/vmodel.dart';

import '../../../../../shared/shimmer/jobShimmerPage.dart';
import '../../controller/all_jobs_controller.dart';
import '../../controller/coupons_controller.dart';
import '../../controller/jobs_controller.dart';
import '../category_services.dart';
import '../coupons_search_result.dart';
import '../coupons_simplified.dart';
import '../marketplace_home.dart';
import '../marketplace_jobs_simplified.dart';
import '../marketplace_services_simplified.dart';
import '../services_search_results.dart';

final providerItemCount = StateProvider<int>((ref) => 3);

class BusinessMyJobsPageMarketplaceSimple extends ConsumerStatefulWidget {
  const BusinessMyJobsPageMarketplaceSimple({super.key});
  static const routeName = 'marketplace_simple';

  @override
  ConsumerState<BusinessMyJobsPageMarketplaceSimple> createState() =>
      _BusinessMyJobsPageMarketplaceSimpleState();
}

class _BusinessMyJobsPageMarketplaceSimpleState
    extends ConsumerState<BusinessMyJobsPageMarketplaceSimple>
    with TickerProviderStateMixin {
  String selectedVal1 = "Photographers";
  String selectedVal2 = "Models";
  late AnimationController _bellController;

  late ScrollController _scrollController;
  double _scrollOffset = 0.0;

  int initialPage = 0;
  bool issearching = false;
  // bool? gridView;
  bool? sponsored;
  bool enableLargeTile = false;
  final showSearchBar = ValueNotifier(false);

  String typingText = "";
  bool isLoading = true;
  // bool showRecentSearches = false;
  bool isSearchActive = false;

  final selectedPanel = ValueNotifier<String>('jobs');

  // FocusNode myFocusNode = FocusNode();

  final TextEditingController _searchController = TextEditingController();
  final _debounce = Debounce();

  // List<DiscoverItemObject> _ca = [];

  int itemCount = 3;
  int _tabIndex = 0;
  // final CarouselController _controller = CarouselController();

  DiscoverCategory? _discoverCategoryType = DiscoverCategory.values.first;

  late final TabController tabController;
  final tabTitles = ['Home', 'Jobs', 'Services', 'Coupons'];

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: tabTitles.length, vsync: this);
    sponsored = false;
    _bellController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    tabController.addListener(tabControllerListener);
    ref
        .read(discoverProvider.notifier)
        .updateSearchController(_searchController);
    ref
        .read(discoverProvider.notifier)
        .updateSearchController(_searchController);
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      _scrollOffset = _scrollController.offset;
      setState(() {});
    });
  }

  void tabControllerListener() {
    _tabIndex = tabController.index;
    if (isSearchActive) {
      print('[oosi] clearing search');
      _searchController.text = '';
      jobsSearch('');
      // setState(() {});
    }
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    // myFocusNode.dispose();
    _bellController.dispose();
    _searchController.dispose();
    _debounce.dispose();
    tabController.removeListener(tabControllerListener);

    super.dispose();
  }

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
    TextTheme textTheme = Theme.of(context).textTheme;
    final currentUser = ref.watch(appUserProvider).valueOrNull;
    final isCurrentUser =
        ref.read(appUserProvider.notifier).isCurrentUser(currentUser?.username);
    // ref.watch(popularJobsProvider);
    // ref.watch(popularServicesProvider);
    final jobsState = ref.watch(jobsProvider);
    final isAllJob = ref.watch(jobSwitchProvider.notifier);
    final _featuredData = ref.watch(feaaturedListProvider);
    return WillPopScope(
        onWillPop: () async {
          moveAppToBackGround();
          return false;
        },
        child: isAllJob.isAllJobs
            ? AllJobs()
            : jobsState.when(data: (jobs) {
                return Scaffold(
                    body: RefreshIndicator.adaptive(
                  onRefresh: () async {
                    HapticFeedback.lightImpact();
                    await ref.refresh(jobsProvider.future);
                  },
                  child: NestedScrollView(
                    controller: _scrollController,
                    // reverse: true,
                    physics: const AlwaysScrollableScrollPhysics(
                        parent: BouncingScrollPhysics()),
                    headerSliverBuilder: (context, innerBoxIsScrolled) {
                      return [
                        SliverAppBar(
                          leadingWidth: 130,
                          leading: Padding(
                            padding: const EdgeInsets.only(left: 16, top: 14),
                            child: Text(
                              "VMODEL",
                              style: TextStyle(
                                fontFamily: "SF",
                                color: Theme.of(context)
                                    .bottomNavigationBarTheme
                                    .selectedItemColor,
                                fontSize: 25,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),

                          pinned: true,
                          floating: true,
                          expandedHeight: 171.0,
                          flexibleSpace: FlexibleSpaceBar(
                            background: _titleSearch(textTheme, context),

                            // FlutterLogo(),
                          ),
                          // leadingWidth: 150,
                          // leading: const SizedBox.shrink(),

                          elevation: 0,
                          actions: [
                            GestureDetector(
                              onTap: () => navigateToRoute(
                                  context,
                                  UserOfferingsTabbedView(
                                    username: currentUser?.username,
                                  )),
                              child: RenderSvg(
                                svgPath: VIcons.servicesIcon,
                                color: Theme.of(context)
                                    .buttonTheme
                                    .colorScheme
                                    ?.onSecondary,
                              ),
                            ),
                            IconButton(
                              color: Theme.of(context).iconTheme.color,
                              splashRadius: 50,
                              iconSize: 30,
                              onPressed: () {
                                navigateToRoute(
                                    context, const NotificationMain());
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
                          ],
                        ),
                      ];
                    },
                    body: Container(
                      height: SizerUtil.height,
                      child: TabBarView(controller: tabController, children: [
                        if (typingText.isNotEmpty) AllJobsSearch(),
                        if (typingText.isEmpty) MarketplaceHome(),

                        if (typingText.isNotEmpty) AllJobsSearch(),
                        if (typingText.isEmpty) JobsSimplified(),

                        if (typingText.isNotEmpty) ServicesSearchResult(),
                        if (typingText.isEmpty) MarketPlaceServicesTabPage(),
                        // categoryView(
                        //     DiscoverCategory.service);

                        // categoryView(DiscoverCategory.service),

                        if (typingText.isNotEmpty) CouponsSearchResult(),
                        if (typingText.isEmpty) CouponsSimple(),
                      ]),
                    ),
                  ),
                ));
              }, error: (err, stackTrace) {
                return const Center(
                  child: Text('Error loading jobs'),
                );
              }, loading: () {
                return const JobShimmerPage();
              }));
  }

  Widget _titleSearch(TextTheme textTheme, BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          Column(
            children: [
              addVerticalSpacing(50),
              Container(
                alignment: Alignment.center,
                height: 34,
                child: TabBar(
                    labelStyle: textTheme.displayLarge!.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                    unselectedLabelStyle: Theme.of(context)
                        .textTheme
                        .displayLarge
                        ?.copyWith(
                            color:
                                Theme.of(context).primaryColor.withOpacity(.9)),
                    controller: tabController,
                    onTap: (value) {
                      if (value == 2) {
                        _discoverCategoryType = DiscoverCategory.service;
                        // setState(() {
                        //   _tabIndex = value;
                        // });
                      } else {
                        _discoverCategoryType = DiscoverCategory.job;
                      }
                      setState(() {
                        _tabIndex = value;
                      });
                    },
                    labelPadding: EdgeInsets.symmetric(horizontal: 16),
                    isScrollable: true,
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    indicatorPadding: EdgeInsets.symmetric(horizontal: 10),
                    tabs: tabTitles.map((e) => Tab(text: e)).toList()
                    // [
                    //   Tab(text: "Home"),
                    //   Tab(text: "Jobs"),
                    //   Tab(text: "Services"),
                    //   Tab(text: "Coupons"),
                    // ],
                    ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 18),
                child: SearchTextFieldWidget(
                  controller: _searchController,
                  onFocused: (value) {
                    isSearchActive = value;
                    print("[oosi] search focus is $isSearchActive");
                  },
                  onChanged: (val) {
                    jobsSearch(val);
                  },
                  hintText: "Search...",
                ),
              ),
            ],
          ),
          FlexibleSpaceFade(
            scrollOffset: _scrollOffset,
          ),
        ],
      ),
    );
  }

  void jobsSearch(String query) {
    print("[jiww0] $_tabIndex all jobs search $query");
    _debounce(() {
      switch (_tabIndex) {
        case 1: //jobs
          ref.read(allJobsSearchTermProvider.notifier).state = query;
          break;
        case 2: //services
          ref.read(allServiceSearchProvider.notifier).state = query;
          break;
        case 3: //coupons
          ref.read(allCouponsSearchProvider.notifier).state = query;
          break;
      }
    });
    typingText = query;
    setState(() {});
  }

  void navigateCategoryServices(String category) {
    ref.read(selectedJobsCategoryProvider.notifier).state = category;
    switch (//DiscoverCategory.job) {
        _discoverCategoryType) {
      case DiscoverCategory.job:
        navigateToRoute(context, AllJobs(title: category));
        break;
      default:
        navigateToRoute(context, CategoryServices(title: category));
        break;
    }
  }
}

// class FadingFlexibleSpaceBar extends StatefulWidget {
//   @override
//   State<FadingFlexibleSpaceBar> createState() => _FadingFlexibleSpaceBarState();
// }

// class _FadingFlexibleSpaceBarState extends State<FadingFlexibleSpaceBar> {
//   @override
//   Widget build(BuildContext context) {
//     return SliverFadeTransition(
//       opacity: SliverAppBarDelegate(
//         beginFade: 0.0,
//         endFade: 1.0,
//       ),
//       sliver: Container(
//         decoration: BoxDecoration(
//           image: DecorationImage(
//             image: AssetImage(
//                 'your_background_image.jpg'), // Replace with your image
//             fit: BoxFit.cover,
//           ),
//         ),
//       ),
//     );
//   }
// }
