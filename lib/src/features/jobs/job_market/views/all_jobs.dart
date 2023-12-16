import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:vmodel/src/core/controller/app_user_controller.dart';
import 'package:vmodel/src/core/models/app_user.dart';
import 'package:vmodel/src/core/utils/costants.dart';
import 'package:vmodel/src/core/utils/helper_functions.dart';
import 'package:vmodel/src/core/utils/validators_mixins.dart';
import 'package:vmodel/src/features/dashboard/feed/widgets/share.dart';
import 'package:vmodel/src/features/jobs/job_market/controller/all_jobs_controller.dart';
import 'package:vmodel/src/features/jobs/job_market/controller/job_controller.dart';
import 'package:vmodel/src/features/jobs/job_market/controller/job_provider.dart';
import 'package:vmodel/src/features/jobs/job_market/views/all_jobs_end_widget.dart';
import 'package:vmodel/src/features/jobs/job_market/views/job_detail_creative_updated.dart';
import 'package:vmodel/src/features/jobs/job_market/views/search_field.dart';
import 'package:vmodel/src/features/jobs/job_market/widget/job_sub_item.dart';
import 'package:vmodel/src/res/assets/app_asset.dart';
import 'package:vmodel/src/res/gap.dart';
import 'package:vmodel/src/res/icons.dart';
import 'package:vmodel/src/shared/appbar/appbar.dart';
import 'package:vmodel/src/shared/rend_paint/render_svg.dart';
import 'package:vmodel/src/shared/shimmer/jobShimmerPage.dart';
import 'package:vmodel/src/vmodel.dart';

import '../../../../core/utils/debounce.dart';
import '../../../../shared/response_widgets/error_dialogue.dart';
import '../controller/all_jobs_search_controller.dart';
import '../widget/business_user/business_my_jobs_card.dart';

class AllJobs extends ConsumerStatefulWidget {
  // final List<JobPostModel> job;
  static const routeName = 'allJobs';
  final String? title;
  const AllJobs({super.key, this.title = "All"});

  @override
  ConsumerState<AllJobs> createState() => _AllJobsState();
}

class _AllJobsState extends ConsumerState<AllJobs> {
  String selectedVal1 = "Photographers";
  String selectedVal2 = "Models";
  final selectedPanel = ValueNotifier<String>('jobs');
  final TextEditingController _searchController = TextEditingController();
  bool enableLargeTile = false;
  bool isCurrentUser = false;
  bool showGrid = true;
  late final Debounce _debounce;
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    _debounce = Debounce(delay: Duration(milliseconds: 300));
    _scrollController.addListener(() {
      final maxScroll = _scrollController.position.maxScrollExtent;
      final currentScroll = _scrollController.position.pixels;
      final delta = SizerUtil.height * 0.2;
      if (maxScroll - currentScroll <= delta) {
        _debounce(() {
          ref.read(allJobsProvider.notifier).fetchMoreData();
        });
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
    _debounce.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final searchProviderState = ref.watch(allJobsSearchTermProvider);
    final jobsState = ref.watch(allJobsProvider);
    final isAllJob = ref.watch(jobSwitchProvider.notifier);
    VAppUser? user;
    final appUser = ref.watch(appUserProvider);

    user = appUser.valueOrNull;
    return jobsState.when(data: (jobs) {
      if (jobs.isNotEmpty)
        return Scaffold(
          body: SafeArea(
            child: RefreshIndicator.adaptive(
              onRefresh: () async {
                HapticFeedback.lightImpact();
                await ref.refresh(allJobsProvider.future);
              },
              child: CustomScrollView(
                // physics: const BouncingScrollPhysics(),
                physics: const AlwaysScrollableScrollPhysics(
                    parent: BouncingScrollPhysics()),
                controller: _scrollController,
                slivers: [
                  SliverAppBar(
                    expandedHeight: 125.0,
                    elevation: 0,
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    leading: const VWidgetsBackButton(),
                    flexibleSpace: FlexibleSpaceBar(background: _titleSearch()),
                    title: Text(
                      "${widget.title} Jobs",
                      style: Theme.of(context).textTheme.displayLarge!.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    floating: true,
                    pinned: true,
                    actions: [
                      if (!showGrid)
                        GestureDetector(
                          onTap: () {
                            enableLargeTile = !enableLargeTile;
                            setState(() {});
                          },
                          child: enableLargeTile
                              ? RenderSvg(
                                  svgPath: VIcons.jobTileModeIcon,
                                )
                              : RotatedBox(
                                  quarterTurns: 2,
                                  child: RenderSvg(
                                    svgPath: VIcons.jobTileModeIcon,
                                  ),
                                ),
                        ),
                      IconButton(
                        onPressed: () {
                          showGrid == true
                              ? setState(() {
                                  showGrid = false;
                                })
                              : setState(() {
                                  showGrid = true;
                                });
                        },
                        icon: showGrid
                            ? RenderSvg(
                                svgPath: VIcons.viewSwitch,
                              )
                            : RotatedBox(
                                quarterTurns: 2,
                                child: RenderSvg(
                                  svgPath: VIcons.viewSwitch,
                                ),
                              ),
                      ),
                    ],
                  ),
                  if (jobs.isNotEmpty)
                    if (showGrid)
                      SliverPadding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        sliver: SliverGrid.builder(
                          itemCount: jobs.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 20,
                            childAspectRatio: 0.65,
                          ),
                          itemBuilder: (BuildContext context, int index) {
                            return JobSubItem(
                              item: jobs[index],
                              onTap: () => navigateToRoute(
                                context,
                                JobDetailPageUpdated(job: jobs[index]),
                              ),
                              onLongPress: () {},
                            );
                          },
                        ),
                      ),
                  if (jobs.isNotEmpty)
                    if (!showGrid)
                      SliverPadding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        sliver: SliverList.separated(
                            itemCount: jobs.length,
                            separatorBuilder: (context, index) {
                              return Padding(
                                padding: EdgeInsets.symmetric(horizontal: 16),
                                child: Divider(),
                              );
                            },
                            itemBuilder: (context, index) {
                              return Slidable(
                                enabled: user!.username !=
                                    jobs[index].creator!.username,
                                endActionPane: ActionPane(
                                    extentRatio: 0.5,
                                    motion: const StretchMotion(),
                                    children: [
                                      if (user.username !=
                                          jobs[index].creator!.username)
                                        SlidableAction(
                                          onPressed: (context) {
                                            showModalBottomSheet(
                                              isScrollControlled: true,
                                              isDismissible: true,
                                              useRootNavigator: true,
                                              backgroundColor:
                                                  Colors.transparent,
                                              context: context,
                                              builder: (context) => ShareWidget(
                                                shareLabel: 'Share Service',
                                                shareTitle:
                                                    "${jobs[index].jobTitle}",
                                                shareImage: VmodelAssets2
                                                    .imageContainer,
                                                shareURL:
                                                    "Vmodel.app/job/tilly's-bakery-services",
                                              ),
                                            );
                                          },
                                          foregroundColor: Colors.white,
                                          backgroundColor: const Color.fromARGB(
                                              255, 224, 224, 224),
                                          label: 'Share',
                                        ),
                                      if (user.username !=
                                          jobs[index].creator!.username)
                                        SlidableAction(
                                          onPressed: (context) async {
                                            await ref
                                                .read(jobDetailProvider(
                                                        jobs[index].id)
                                                    .notifier)
                                                .saveJob(jobs[index].id);
                                          },
                                          foregroundColor: Colors.white,
                                          backgroundColor: Colors.grey,
                                          label: 'Save',
                                        ),
                                    ]),
                                child: VWidgetsBusinessMyJobsCard(
                                  // profileImage: VmodelAssets2.imageContainer,
                                  noOfApplicants: jobs[index].noOfApplicants,
                                  profileImage:
                                      jobs[index].creator!.profilePictureUrl,
                                  // profileName: "Male Models Wanted in london",
                                  jobTitle: jobs[index].jobTitle,
                                  // jobDescription:
                                  //     "Hello, We’re looking for models, influencers and photographers to assist us with our end of the year shoot. We want 2 male models,",
                                  jobPriceOption:
                                      jobs[index].priceOption.tileDisplayName,
                                  jobDescription: jobs[index].shortDescription,
                                  enableDescription: enableLargeTile,
                                  location: jobs[index].jobType,
                                  date: jobs[index]
                                      .createdAt
                                      .getSimpleDateOnJobCard(),
                                  appliedCandidateCount: "16",
                                  // jobBudget: "450",
                                  jobBudget: VConstants
                                      .noDecimalCurrencyFormatterGB
                                      .format(jobs[index].priceValue.round()),
                                  candidateType: "Female",
                                  // navigateToRoute(
                                  //     context, JobDetailPage(job: jobs[index]));
                                  onItemTap: () {
                                    navigateToRoute(context,
                                        JobDetailPageUpdated(job: jobs[index]));
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
                                        shareTitle:
                                            "Male Models Wanted in london",
                                        shareImage:
                                            VmodelAssets2.imageContainer,
                                        shareURL:
                                            "Vmodel.app/job/tilly's-bakery-services",
                                      ),
                                    );
                                  },
                                ),
                              );
                            }),
                      ),
                  if (searchProviderState.isEmptyOrNull || jobs.isNotEmpty)
                    AllJobsEndWidget()
                ],
              ),
            ),
          ),
        );

      return Scaffold(
        appBar: VWidgetsAppBar(
          appbarTitle: "${widget.title} Jobs",
          leadingIcon: const VWidgetsBackButton(),
        ),
        body: RefreshIndicator.adaptive(
          color: Theme.of(context).primaryColor,
          onRefresh: () async {
            ref.invalidate(allJobsProvider);
          },
          child: Center(
            child: ListView(
              children: [
                addVerticalSpacing(300),
                Center(
                  child: Text(
                    "No jobs here..\nPull down to refresh",
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            ),
          ),
        ),
      );
    }, loading: () {
      return const JobShimmerPage(showTrailing: true);
    }, error: (error, stackTrace) {
      print("jkcnwe $error $stackTrace");
      return CustomErrorDialogWithScaffold(
        onTryAgain: () => ref.invalidate(allJobsProvider),
        title: "${widget.title} Jobs",
      );
    });
  }

  Widget _titleSearch() {
    return SafeArea(
      child: Column(
        children: [
          addVerticalSpacing(60),
          Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 24),
              child: ValueListenableBuilder(
                  valueListenable: selectedPanel,
                  builder: (context, value, child) {
                    return Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: SearchTextFieldWidget(
                            showInputBorder: false,
                            hintText: value == 'jobs'
                                ? "Eg: Last minute stylists needed ASAP"
                                : "Eg: Model Wanted",
                            controller: _searchController,
                            enabledBorder: InputBorder.none,
                            onChanged: (val) {
                              _debounce(() {
                                ref
                                    .watch(allJobsSearchTermProvider.notifier)
                                    .state = val;
                              });
                            },
                          ),
                        ),
                      ],
                    );
                  }),
            ),
          ),
          addVerticalSpacing(20),
        ],
      ),
    );
  }
}

 

// class ShrinkingTitle extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return AnimatedBuilder(
//       animation: ScrollController(),
//       builder: (BuildContext context, Widget? child) {
//         double offset = (MediaQuery.of(context).padding.top +
//                 kToolbarHeight -
//                 kTextTabBarHeight) -
//             ScrollController().;
//         double fontSize = offset > 0 ? offset / 5.0 + 20.0 : 20.0; // Adjust the values as needed

//         return Text(
//           'Shrinking Title',
//           style: TextStyle(fontSize: fontSize),
//         );
//       },
//     );
//   }
// }
