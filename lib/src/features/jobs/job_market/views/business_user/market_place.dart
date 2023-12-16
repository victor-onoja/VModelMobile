import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vmodel/src/core/controller/app_user_controller.dart';
import 'package:vmodel/src/core/utils/costants.dart';
import 'package:vmodel/src/core/utils/enum/discover_category_enum.dart';
import 'package:vmodel/src/features/dashboard/dash/controller.dart';
import 'package:vmodel/src/features/dashboard/discover/controllers/discover_controller.dart';
import 'package:vmodel/src/features/dashboard/discover/models/discover_item.dart';
import 'package:vmodel/src/features/dashboard/discover/models/mock_data.dart';
import 'package:vmodel/src/features/dashboard/discover/widget/category_section.dart';
import 'package:vmodel/src/features/dashboard/new_profile/views/other_profile_router.dart';
import 'package:vmodel/src/features/jobs/job_market/controller/job_provider.dart';
import 'package:vmodel/src/features/jobs/job_market/model/job_post_model.dart';
import 'package:vmodel/src/features/jobs/job_market/views/all_jobs.dart';
import 'package:vmodel/src/features/jobs/job_market/views/coupons.dart';
import 'package:vmodel/src/features/jobs/job_market/views/local_services.dart';
import 'package:vmodel/src/features/jobs/job_market/views/search_field.dart';
import 'package:vmodel/src/res/icons.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/shared/rend_paint/render_svg.dart';
import 'package:vmodel/src/vmodel.dart';

import '../../../../../core/utils/enum/upload_ratio_enum.dart';
import '../../../../../shared/shimmer/jobShimmerPage.dart';
import '../../../../dashboard/discover/views/discover_view_category_detail.dart';
import '../../widget/carousel_with_close.dart';
import '../../../../dashboard/discover/widget/services_sub_list.dart';
import '../../controller/jobs_controller.dart';

final providerItemCount = StateProvider<int>((ref) => 3);

class BusinessMyJobsPageMarketplace extends ConsumerStatefulWidget {
  const BusinessMyJobsPageMarketplace({super.key});
  static const routeName = 'marketplace';

  @override
  ConsumerState<BusinessMyJobsPageMarketplace> createState() =>
      _BusinessMyJobsPageMarketplaceState();
}

class _BusinessMyJobsPageMarketplaceState
    extends ConsumerState<BusinessMyJobsPageMarketplace> {
  String selectedVal1 = "Photographers";
  String selectedVal2 = "Models";

  // final CarouselController _controller = CarouselController();
  // List<String> carouselImages = [
  //   'assets/images/svg_images/pexels-nadezhda-diskant-5878803.svg',
  //   'assets/images/svg_images/pexels-nadezhda-diskant-5878803.svg',
  //   'assets/images/svg_images/pexels-nadezhda-diskant-5878803.svg',
  //   'assets/images/svg_images/pexels-nadezhda-diskant-5878803.svg',
  // ];
  int initialPage = 0;
  bool issearching = false;
  // bool? gridView;
  bool? sponsored;
  bool enableLargeTile = false;

  String typingText = "";
  bool isLoading = true;
  bool showRecentSearches = false;

  final selectedPanel = ValueNotifier<String>('jobs');

  FocusNode myFocusNode = FocusNode();

  final TextEditingController _searchController = TextEditingController();

  List<DiscoverItemObject> _ca = [];

  int itemCount = 3;

  @override
  void initState() {
    super.initState();

    sponsored = false;
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
    _ca = List.generate(VConstants.tempCategories.length, (index) {
      return DiscoverItemObject(
          name: VConstants.tempCategories[index],
          image: mockDiscoverCategoryAssets[index],
          userType: '',
          label: '',
          username: '');
    });
  }

  void _onCategoryChanged(DiscoverCategory currentList) {
    int start = 0;
    int end = 1;
    switch (currentList) {
      case DiscoverCategory.job:
        start = 0;
        end = VConstants.tempCategories.length;
        break;
      case DiscoverCategory.service:
        start = 0;
        end = VConstants.tempCategories.length;
        break;
      default:
        end = VConstants.tempCategories.length;
    }
    final subList = VConstants.tempCategories.sublist(start, end);
    final subAssets = mockDiscoverCategoryAssets.sublist(start, end);
    _ca = List.generate(subList.length, (index) {
      return DiscoverItemObject(
          name: subList[index],
          image: subAssets[index],
          userType: '',
          label: '',
          username: '');
    });

    print('[mm] sss $currentList subList AAAQQQQZZZ ${subList.length}');
    setState(() {});
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    myFocusNode.dispose();
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
    final currentUser = ref.watch(appUserProvider).valueOrNull;
    final isCurrentUser =
        ref.read(appUserProvider.notifier).isCurrentUser(currentUser?.username);
    ref.watch(popularJobsProvider);
    ref.watch(popularServicesProvider);
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
                    await ref.refresh(jobsProvider.future);
                  },
                  child: CustomScrollView(
                    // physics: const BouncingScrollPhysics(),
                    physics: const AlwaysScrollableScrollPhysics(
                        parent: BouncingScrollPhysics()),
                    slivers: [
                      SliverAppBar(
                        // title: Text(
                        //   'llll',
                        //   style: TextStyle(color: Colors.red),
                        // ),
                        pinned: true,
                        // floating: true,
                        expandedHeight: 170.0,
                        flexibleSpace: FlexibleSpaceBar(
                          centerTitle: true,
                          // title: _isShrink
                          //     ? const Text(
                          //         "Profile",
                          //         style: TextStyle(color: Colors.red),
                          //       )
                          //     : null,
                          background: _titleSearch(job: jobs),

                          // FlutterLogo(),
                        ),
                        // leadingWidth: 150,
                        leading: const SizedBox.shrink(),

                        elevation: 0,
                        // actions: [
                        //   Padding(
                        //     padding: const EdgeInsets.only(top: 0, right: 0),
                        //     child: Row(
                        //       children: [
                        //         IconButton(
                        //           onPressed: () {
                        //             showModalBottomSheet<void>(
                        //                 context: context,
                        //                 backgroundColor: Colors.transparent,
                        //                 builder: (BuildContext context) {
                        //                   return Container(
                        //                     padding: const EdgeInsets.only(
                        //                         left: 16, right: 16),
                        //                     decoration: BoxDecoration(
                        //                       color: Theme.of(context)
                        //                           .scaffoldBackgroundColor,
                        //                       borderRadius:
                        //                           const BorderRadius.only(
                        //                         topLeft: Radius.circular(13),
                        //                         topRight: Radius.circular(13),
                        //                       ),
                        //                     ),
                        //                     child: SelectJobServiceBottomsheet(
                        //                       selected: selectedPanel.value,
                        //                       onJobsTap: () {
                        //                         selectedPanel.value = "jobs";
                        //                       },
                        //                       onServicesTap: () {
                        //                         selectedPanel.value =
                        //                             "services";
                        //                       },
                        //                     ),
                        //                   );
                        //                 });
                        //           },
                        //           icon: const RenderSvg(
                        //               svgPath: VIcons.jobSwitchIcon),
                        //         ),
                        //         // IconButton(
                        //         //   onPressed: () {
                        //         //     navigateToRoute(
                        //         //         context, const CategoryDiscoverViewNew());
                        //         //   },
                        //         //   icon: const RenderSvg(
                        //         //     svgPath: VIcons.notification,
                        //         //   ),
                        //         // ),
                        //       ],
                        //     ),
                        //     // child: ,
                        //   ),

                        // ],
                      ),
                      ValueListenableBuilder(
                          valueListenable: selectedPanel,
                          builder: (context, value, child) {
                            return SliverList.list(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 15, left: 12, right: 12),
                                  child: Container(
                                    padding: const EdgeInsets.all(15),
                                    decoration: BoxDecoration(
                                        // color: const Color(0xFFD9D9D9),
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary
                                            .withOpacity(0.5),
                                        borderRadius: BorderRadius.circular(8)),
                                    child: Container(
                                      padding: const EdgeInsets.all(2),
                                      decoration: BoxDecoration(
                                          // color: VmodelColors.white,
                                          // color: Theme.of(context).colorScheme.onSecondary,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onSecondary,
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            IconButton(
                                              onPressed: () {
                                                HapticFeedback.lightImpact();
                                                navigateToRoute(context,
                                                    const LocalServices());
                                                //[go_route]
                                                // context.pushNamed(
                                                //     LocalServices.routeName);
                                              },
                                              icon: RenderSvg(
                                                svgPath: VIcons.servicesIcon,
                                                color: Theme.of(context)
                                                    .iconTheme
                                                    .color,
                                              ),
                                            ),
                                            IconButton(
                                              onPressed: () {
                                                HapticFeedback.lightImpact();
                                                navigateToRoute(
                                                    context, AllJobs());
                                                //[go_route]
                                                // context.pushNamed(
                                                //     AllJobs.routeName);
                                              },
                                              icon: RenderSvg(
                                                svgPath:
                                                    VIcons.alignVerticalIcon,
                                                color: Theme.of(context)
                                                    .iconTheme
                                                    .color,
                                              ),
                                            ),
                                            IconButton(
                                              onPressed: () {
                                                HapticFeedback.lightImpact();
                                                navigateToRoute(
                                                    context, const Coupons());
                                                //[go_route]
                                                // context.pushNamed(
                                                //     Coupons.routeName);
                                              },
                                              icon: RenderSvg(
                                                svgPath: VIcons.couponIcon,
                                                color: Theme.of(context)
                                                    .iconTheme
                                                    .color,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 3),
                                _featuredData.when(data: (_data) {
                                  return CategorySection(
                                    onTap: (value) =>
                                        _navigateToUserProfile(value),
                                    onCategoryChanged: (value) {
                                      _onCategoryChanged(value);
                                    },
                                    title: 'Service categories',
                                    items: _ca,
                                    route: const CategoryDiscoverDetail(
                                      title: 'Service categories',
                                    ),
                                  );
                                }, error: (((error, stackTrace) {
                                  return Container();
                                })), loading: () {
                                  return CategorySection(
                                    onTap: (value) =>
                                        _navigateToUserProfile(value),
                                    onCategoryChanged: (value) {
                                      _onCategoryChanged(value);
                                    },
                                    title: 'Service categories',
                                    items: _ca,
                                    route: const CategoryDiscoverDetail(
                                      title: 'Service categories',
                                    ),
                                  );
                                }),

                                // addVerticalSpacing(5),

                                if (value == 'jobs')
                                  JobsCarouselTile(
                                    title: "Recommended jobs",
                                    isCurrentUser: isCurrentUser,
                                    showDescription: enableLargeTile,
                                  )
                                else
                                  JobsCarouselTile(
                                    title: "Recommended Services",
                                    isService: true,
                                    isCurrentUser: isCurrentUser,
                                    showDescription: enableLargeTile,
                                  ),
                                JobsCarouselTile(
                                  isCurrentUser: isCurrentUser,
                                  title: "Jobs around you",
                                  showDescription: enableLargeTile,
                                ),
                                addVerticalSpacing(10),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 16),
                                  child: Text("Sponsored",
                                      style: Theme.of(context)
                                          .textTheme
                                          .displayLarge
                                          ?.copyWith(
                                            color: Theme.of(context)
                                                .primaryColor
                                                .withOpacity(0.3),
                                          )),
                                ),
                                addVerticalSpacing(20),
                                CarouselWithClose(
                                  aspectRatio: UploadAspectRatio.square.ratio,
                                ),
                                addVerticalSpacing(10),
                              ],
                            );
                          }),

                      // ValueListenableBuilder(valueListenable: valueListenable, builder: builder)
                      // AlljobsCarousel(jobs),
                      // SliverList.list(
                      //   children: [
                      //     AlljobsCarousel(
                      //       jobs,
                      //       enableLargeTile: enableLargeTile,
                      //     )
                      //   ],
                      // ),
                      // SliverList.builder(
                      //     itemCount: jobs.length + 1,
                      //     itemBuilder: (context, index) {
                      //       if (index == jobs.length) {
                      //         return const FeedEndWidget(
                      //           mainText:
                      //               'Looks like you have caught up with everything',
                      //           subText: 'Check back later for more updates',
                      //         );
                      //       }
                      //       return VWidgetsBusinessMyJobsCard(
                      //         // profileImage: VmodelAssets2.imageContainer,
                      //         profileImage:
                      //             jobs[index].creator.profilePictureUrl,
                      //         // profileName: "Male Models Wanted in london",
                      //         profileName: jobs[index].jobTitle,
                      //         // jobDescription:
                      //         //     "Hello, We’re looking for models, influencers and photographers to assist us with our end of the year shoot. We want 2 male models,",
                      //         jobPriceOption:
                      //             jobs[index].priceOption.tileDisplayName,
                      //         jobDescription: jobs[index].shortDescription,
                      //         enableDescription: enableLargeTile,
                      //         location: jobs[index].jobType,
                      //         time: "3:30 hr",
                      //         appliedCandidateCount: "16",
                      //         // jobBudget: "450",
                      //         jobBudget: VConstants
                      //             .noDecimalCurrencyFormatterGB
                      //             .format(jobs[index].priceValue.round()),
                      //         candidateType: "Female",
                      //         // navigateToRoute(
                      //         //     context, JobDetailPage(job: jobs[index]));
                      //         onItemTap: () {
                      //           navigateToRoute(context,
                      //               JobDetailPageUpdated(job: jobs[index]));
                      //         },
                      //         shareJobOnPressed: () {
                      //           showModalBottomSheet(
                      //             isScrollControlled: true,
                      //             isDismissible: true,
                      //             useRootNavigator: true,
                      //             backgroundColor: Colors.transparent,
                      //             context: context,
                      //             builder: (context) => const ShareWidget(
                      //               shareLabel: 'Share Job',
                      //               shareTitle:
                      //                   "Male Models Wanted in london",
                      //               shareImage: VmodelAssets2.imageContainer,
                      //               shareURL:
                      //                   "Vmodel.app/job/tilly's-bakery-services",
                      //             ),
                      //           );
                      //         },
                      //       );

                      //     })
                    ],
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

  Widget _titleSearch({required List<JobPostModel> job}) {
    return SafeArea(
      child: Column(
        children: [
          addVerticalSpacing(50),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 13),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  // "Jobs & Services",
                  "VModel",
                  style: Theme.of(context).textTheme.displayLarge!.copyWith(
                        fontWeight: FontWeight.w600,
                        // color: VmodelColors.mainColor,
                        fontSize: 16.sp,
                      ),
                ),
              ],
            ),
          ),
          addVerticalSpacing(10),
          Expanded(
            child: Container(
              // padding: const VWidgetsPagePadding.horizontalSymmetric(18),
              margin: const EdgeInsets.symmetric(horizontal: 18),
              // padding: EdgeInsets.symmetric(vertical: ),

              // decoration: BoxDecoration(
              // border: Border(
              //   bottom: BorderSide(
              //     // color: VmodelColors.primaryColor,
              //     // color: Theme.of(context).colorScheme.primary,
              //     color: Theme.of(context).colorScheme.onSurface,
              //     width: 2,
              //   ),
              // ),
              // ),
              child: ValueListenableBuilder(
                  valueListenable: selectedPanel,
                  builder: (context, value, child) {
                    return Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: SearchTextFieldWidget(
                            // showInputBorder: false,
                            hintText: value == 'jobs'
                                ? "Eg: Model Wanted"
                                : "Eg: Last minute stylists needed ASAP",
                            controller: _searchController,
                            // enabledBorder: InputBorder.none,
                            // onChanged: (val) {},
                          ),
                        ),
                        // Flexible(
                        //   child: DropdownButton<String>(
                        //     borderRadius: BorderRadius.circular(12),
                        //     padding: const EdgeInsets.only(left: 20),
                        //     value: value,
                        //     alignment: Alignment.centerRight,
                        //     isDense: true,
                        //     underline: const SizedBox.shrink(),
                        //     items: const [
                        //       DropdownMenuItem(
                        //           value: 'jobs', child: Text('Jobs')),
                        //       DropdownMenuItem(
                        //           value: 'services', child: Text('Services'))
                        //     ],

                        //     onChanged: (val) {
                        //       selectedPanel.value = val!;
                        //     },
                        //     // trailingIcon: const Padding(
                        //     //   padding: EdgeInsets.only(right: 60),
                        //     //   child: Icon(Icons.keyboard_arrow_down_rounded,
                        //     //       color: VmodelColors.primaryColor),
                        //     // ),
                        //     // inputDecorationTheme: const InputDecorationTheme(
                        //     //     isCollapsed: true,
                        //     //     contentPadding: EdgeInsets.all(0),
                        //     //     border: UnderlineInputBorder(
                        //     //         borderSide: BorderSide(
                        //     //             color: VmodelColors.primaryColor, width: 2)),
                        //     //     isDense: true),
                        //     // initialSelection: 'jobs',
                        //     // dropdownMenuEntries: const [
                        //     //   DropdownMenuEntry(
                        //     //     label: "Jobs",
                        //     //     value: "jobs",
                        //     //   ),
                        //     //   DropdownMenuEntry(
                        //     //     label: "Services",
                        //     //     value: "services",
                        //     //   ),
                        //     // ],
                        //     // onSelected: (val) {
                        //     //   print(val);
                        //     //   if (val == 'jobs') {
                        //     //     selectedPanel.value = val!;
                        //     //   }

                        //     //   if (val == 'services') {
                        //     //     selectedPanel.value = val!;
                        //     //   }
                        //     // },
                        //   ),
                        // )
                      ],
                    );
                  }),
            ),
          ),
          const SizedBox(height: 16),
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
  RefreshIndicator _oldBody(
      BuildContext context, AsyncValue<List<JobPostModel>> jobsState) {
    return RefreshIndicator(
      onRefresh: () async {
        ref.invalidate(jobsProvider);
      },
      child: Padding(
        padding: const VWidgetsPagePadding.horizontalSymmetric(10),
        child: Column(
          children: [
            addVerticalSpacing(20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 13),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Jobs",
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
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            // if (!showRecentSearches)
            // for (int i = 0; i < 10; i++)
            // gridView == true
            //     ? VWidgetsBusinessMyCardGrid(
            //         cardImage: VmodelAssets2.imageContainer,
            //         profileName: "Male Models Wanted in london",
            //         jobDescription:
            //             "Hello, We’re looking for models, influencers and photographers to assist us with our end of the year shoot. We want 2 male models,",
            //         location: "London",
            //         time: "3:30 hr",
            //         appliedCandidateCount: "16",
            //         jobBudget: "450",
            //         candidateType: "Female",
            //         cardOnPressed: () {
            //           navigateToRoute(
            //               context, const JobDetailPage());
            //         },
            //         shareJobOnPressed: () {
            //           showModalBottomSheet(
            //             isScrollControlled: true,
            //             isDismissible: true,
            //             useRootNavigator: true,
            //             backgroundColor: Colors.transparent,
            //             context: context,
            //             builder: (context) => const ShareWidget(
            //               shareLabel: 'Share Job',
            //               shareTitle:
            //                   "Male Models Wanted in london",
            //               shareImage:
            //                   VmodelAssets2.imageContainer,
            //               shareURL:
            //                   "Vmodel.app/job/tilly's-bakery-services",
            //             ),
            //           );
            //         },
            //       )
            //     :
            // if (twoTiles)
            jobsState.when(data: (jobs) {
              return Expanded(
                child: ListView.builder(
                    itemCount: jobs.length,
                    itemBuilder: (context, index) {
                      return VWidgetsBusinessMyJobsCard(
                        // profileImage: VmodelAssets2.imageContainer,
                        profileImage: jobs[index].creator.profilePictureUrl,
                        // profileName: "Male Models Wanted in london",
                        profileName: jobs[index].jobTitle,
                        // jobDescription:
                        //     "Hello, We’re looking for models, influencers and photographers to assist us with our end of the year shoot. We want 2 male models,",
                        jobPriceOption: jobs[index].priceOption.tileDisplayName,
                        jobDescription: jobs[index].shortDescription,
                        enableDescription: enableLargeTile,
                        location: jobs[index].jobType,
                        time: "3:30 hr",
                        appliedCandidateCount: "16",
                        // jobBudget: "450",
                        jobBudget: VConstants.noDecimalCurrencyFormatterGB
                            .format(jobs[index].priceValue.round()),
                        candidateType: "Female",
                        // navigateToRoute(
                        //     context, JobDetailPage(job: jobs[index]));
                        onItemTap: () {
                          navigateToRoute(
                              context, JobDetailPageUpdated(job: jobs[index]));
                        },
                        shareJobOnPressed: () {
                          showModalBottomSheet(
                            isScrollControlled: true,
                            isDismissible: true,
                            useRootNavigator: true,
                            backgroundColor: Colors.transparent,
                            context: context,
                            builder: (context) => const ShareWidget(
                              shareLabel: 'Share Job',
                              shareTitle: "Male Models Wanted in london",
                              shareImage: VmodelAssets2.imageContainer,
                              shareURL:
                                  "Vmodel.app/job/tilly's-bakery-services",
                            ),
                          );
                        },
                      );
                      // return Container(
                      //     color: Colors.primaries[index % 17],
                      //     padding: EdgeInsets.all(32),
                      //     child: Text("Hello $index"));
                    }),
              );
              // return Expanded(
              //   child: SingleChildScrollView(
              //     child: Column(
              //       children: List<Widget>.generate(
              //         jobs.length,
              //         (index) {
              //           // if (twoTiles)
              //           return VWidgetsBusinessMyJobsCard(
              //             // profileImage: VmodelAssets2.imageContainer,
              //             profileImage:
              //                 jobs[index].creator.profilePictureUrl,
              //             // profileName: "Male Models Wanted in london",
              //             profileName: jobs[index].jobTitle,
              //             // jobDescription:
              //             //     "Hello, We’re looking for models, influencers and photographers to assist us with our end of the year shoot. We want 2 male models,",
              //             jobPriceOption:
              //                 jobs[index].priceOption.tileDisplayName,
              //             jobDescription: jobs[index].shortDescription,
              //             enableDescription: enableLargeTile,
              //             location: jobs[index].jobType,
              //             time: "3:30 hr",
              //             appliedCandidateCount: "16",
              //             // jobBudget: "450",
              //             jobBudget: VConstants
              //                 .noDecimalCurrencyFormatterGB
              //                 .format(jobs[index].priceValue.round()),
              //             candidateType: "Female",
              //             shareJobOnPressed: () {
              //               showModalBottomSheet(
              //                 isScrollControlled: true,
              //                 isDismissible: true,
              //                 useRootNavigator: true,
              //                 backgroundColor: Colors.transparent,
              //                 context: context,
              //                 builder: (context) => const ShareWidget(
              //                   shareLabel: 'Share Job',
              //                   shareTitle:
              //                       "Male Models Wanted in london",
              //                   shareImage:
              //                       VmodelAssets2.imageContainer,
              //                   shareURL:
              //                       "Vmodel.app/job/tilly's-bakery-services",
              //                 ),
              //               );
              //             },
              //           );
              //         },
              //         // child: ,
              //       ),
              //     ),
              //   ),
              // );
            }, error: (err, stackTrace) {
              return const Expanded(
                child: Center(
                  child: Text('Error loading jobs'),
                ),
              );
            }, loading: () {
              return const Expanded(
                  child: Center(child: CircularProgressIndicator()));
            }),

            // if (!twoTiles)
            // Expanded(
            //   child: SingleChildScrollView(
            //     child: Column(
            //       children: List<Widget>.generate(jobs.length, (index) {
            //         return VWidgetsBusinessMyJobTwoTilesCard(
            //           // profileImage: VmodelAssets2.imageContainer,
            //           // profileImage: VConstants.testImage,
            //           profileImage:
            //               jobs[index].creator.profilePictureUrl,
            //           profileName: jobs[index].jobTitle,
            //           // jobDescription:
            //           //     "Hello, We're looking for models, influencers and photographers to assist us with our end of the year shoot. We want 2 male models,",
            //           jobDescription: jobs[index].shortDescription,
            //           // location: "London",
            //           location: jobs[index].jobType,
            //           time: "3:30 hr",
            //           appliedCandidateCount: "16",
            //           jobBudget: "450",
            //           candidateType: "Female",
            //           shareJobOnPressed: () {
            //             showModalBottomSheet(
            //               isScrollControlled: true,
            //               isDismissible: true,
            //               useRootNavigator: true,
            //               backgroundColor: Colors.transparent,
            //               context: context,
            //               builder: (context) => const ShareWidget(
            //                 shareLabel: 'Share Job',
            //                 shareTitle: "Male Models Wanted in london",
            //                 shareImage: VmodelAssets2.imageContainer,
            //                 shareURL:
            //                     "Vmodel.app/job/tilly's-bakery-services",
            //               ),
            //             );
            //           },
            //         );
            //       }).toList(),
            //     ),
            //   ),
            // ),

            // ListView.builder(
            //     shrinkWrap: true,
            //     itemCount: jobs.length,
            //     itemBuilder: (BuildContext context, int index) {
            //       return VWidgetsBusinessMyJobTwoTilesCard(
            //         profileImage: VmodelAssets2.imageContainer,
            //         profileName: jobs[index].jobTitle,
            //         jobDescription:
            //             "Hello, We’re looking for models, influencers and photographers to assist us with our end of the year shoot. We want 2 male models,",
            //         location: "London",
            //         time: "3:30 hr",
            //         appliedCandidateCount: "16",
            //         jobBudget: "450",
            //         candidateType: "Female",
            //         shareJobOnPressed: () {
            //           showModalBottomSheet(
            //             isScrollControlled: true,
            //             isDismissible: true,
            //             useRootNavigator: true,
            //             backgroundColor: Colors.transparent,
            //             context: context,
            //             builder: (context) => const ShareWidget(
            //               shareLabel: 'Share Job',
            //               shareTitle:
            //                   "Male Models Wanted in london",
            //               shareImage:
            //                   VmodelAssets2.imageContainer,
            //               shareURL:
            //                   "Vmodel.app/job/tilly's-bakery-services",
            //             ),
            //           );
            //         },
            //       );
            //     },
            //     // child: ,
            //   ),
          ],
        ),
      ),
    );
  }
   */

  // VWidgetsAppBar _oldAppBar(BuildContext context) {
  //   return VWidgetsAppBar(
  //     appbarTitle: "",
  //     leadingWidth: 150,
  //     leadingIcon: Padding(
  //       padding: const EdgeInsets.only(top: 10, left: 8, bottom: 5),
  //       child: Row(
  //         children: [
  //           Flexible(
  //             child: IconButton(
  //               onPressed: () {},
  //               icon: GestureDetector(
  //                 onTap: () {
  //                   enableLargeTile == true
  //                       ? setState(() {
  //                           enableLargeTile = false;
  //                         })
  //                       : setState(() {
  //                           enableLargeTile = true;
  //                         });
  //                 },
  //                 //  onTap: () {
  //                 //   twoTiles == true
  //                 //       ? setState(() {
  //                 //           gridView = true;
  //                 //           twoTiles = false;
  //                 //         })
  //                 //       : gridView == true
  //                 //           ? setState(() {
  //                 //               gridView = false;
  //                 //               twoTiles = false;
  //                 //             })
  //                 //           : setState(() {
  //                 //               twoTiles = true;
  //                 //             });
  //                 // },
  //                 child: RenderSvg(
  //                   svgPath:
  //                       // gridView == true
  //                       //     ? "assets/images/svg_images/Group 626053.svg"
  //                       enableLargeTile == true
  //                           ? "assets/images/svg_images/Group 626048.svg"
  //                           : "assets/images/svg_images/Group 626045.svg",
  //                   svgHeight: 30,
  //                   svgWidth: 0,
  //                 ),
  //               ),
  //             ),
  //           )
  //         ],
  //       ),
  //     ),
  //     elevation: 0,
  //     backgroundColor: Colors.white,
  //     trailingIcon: [
  //       IconButton(
  //         onPressed: () {
  //           showModalBottomSheet(
  //             isScrollControlled: true,
  //             isDismissible: true,
  //             useRootNavigator: true,
  //             backgroundColor: Colors.transparent,
  //             context: context,
  //             builder: (context) => Container(
  //               // height: 500,
  //               decoration: BoxDecoration(
  //                 color: VmodelColors.background,
  //                 borderRadius: const BorderRadius.only(
  //                   topLeft: Radius.circular(13),
  //                   topRight: Radius.circular(13),
  //                 ),
  //               ),
  //               // color: VmodelColors.white,
  //               child: const JobMarketFilterBottomSheet(),
  //             ),
  //           );
  //         },
  //         icon: const RenderSvg(
  //           svgPath: VIcons.filterIcon,
  //         ),
  //       ),
  //     ],
  //   );
  // }
}

//
