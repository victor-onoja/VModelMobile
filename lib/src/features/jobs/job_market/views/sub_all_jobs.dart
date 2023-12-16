import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vmodel/src/core/utils/costants.dart';
import 'package:vmodel/src/core/utils/helper_functions.dart';
import 'package:vmodel/src/features/dashboard/feed/widgets/share.dart';
import 'package:vmodel/src/features/jobs/job_market/controller/all_jobs_controller.dart';
import 'package:vmodel/src/features/jobs/job_market/controller/job_provider.dart';
import 'package:vmodel/src/features/jobs/job_market/model/job_post_model.dart';
import 'package:vmodel/src/features/jobs/job_market/views/filter_bottom_sheet.dart';
import 'package:vmodel/src/features/jobs/job_market/views/job_detail_creative_updated.dart';
import 'package:vmodel/src/features/jobs/job_market/widget/job_sub_item.dart';
import 'package:vmodel/src/res/assets/app_asset.dart';
import 'package:vmodel/src/res/icons.dart';
import 'package:vmodel/src/shared/rend_paint/render_svg.dart';
import 'package:vmodel/src/vmodel.dart';

import '../../../../core/utils/debounce.dart';
import '../controller/all_jobs_search_controller.dart';
import '../widget/business_user/business_my_jobs_card.dart';

class SubAllJobs extends ConsumerStatefulWidget {
  // final List<JobPostModel> job;
  static const routeName = 'allJobs';
  final String title;
  final List<JobPostModel> jobs;
  const SubAllJobs({super.key, required this.title, required this.jobs});

  @override
  ConsumerState<SubAllJobs> createState() => _AllJobsState();
}

class _AllJobsState extends ConsumerState<SubAllJobs> {
  String selectedVal1 = "Photographers";
  String selectedVal2 = "Models";
  final selectedPanel = ValueNotifier<String>('jobs');
  final TextEditingController _searchController = TextEditingController();
  bool enableLargeTile = false;
  bool _hideFloatingButton = true;
  final showGrid = ValueNotifier(true);
  late final Debounce _debounce;
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    // _debounce = Debounce(delay: Duration(milliseconds: 300));
    // _scrollController.addListener(() {
    //   final maxScroll = _scrollController.position.maxScrollExtent;
    //   final currentScroll = _scrollController.position.pixels;
    //   final delta = SizerUtil.height * 0.2;
    //   if (maxScroll - currentScroll <= delta) {
    //     _debounce(() {
    //       ref.read(allJobsProvider.notifier).fetchMoreData();
    //     });
    //   }
    // });
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
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          leading: isAllJob.isAllJobs ? null : const VWidgetsBackButton(),
          title: Text(
            "${widget.title}",
            style: Theme.of(context).textTheme.displayLarge!.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                // enableLargeTile == true
                showGrid.value = !showGrid.value;
              },
              icon: ValueListenableBuilder(
                  valueListenable: showGrid,
                  builder: (context, value, child) {
                    if (value) {
                      return RenderSvg(
                        svgPath: VIcons.viewSwitch,
                        color:
                            Theme.of(context).iconTheme.color?.withOpacity(.6),
                      );
                    } else {
                      return RenderSvg(
                        svgPath: VIcons.viewSwitch,
                      );
                    }
                  }),
            ),
          ],
        ),
        body: RefreshIndicator.adaptive(
          onRefresh: () async {
            HapticFeedback.lightImpact();
            await ref.refresh(allJobsProvider.future);
          },
          child: ValueListenableBuilder(
              valueListenable: showGrid,
              builder: (context, value, child) {
                if (value)
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(15, 20, 15, 0),
                    child: GridView.builder(
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      itemCount: widget.jobs.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 20,
                        childAspectRatio: 0.65,
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        return Column(
                          children: [
                            JobSubItem(
                              item: widget.jobs[index],
                              onTap: () => navigateToRoute(
                                context,
                                JobDetailPageUpdated(job: widget.jobs[index]),
                              ),
                              onLongPress: () {},
                            ),
                          ],
                        );
                      },
                    ),
                  );

                return Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 8,
                  ),
                  child: ListView.separated(
                      itemCount: widget.jobs.length,
                      separatorBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: Divider(),
                        );
                      },
                      itemBuilder: (context, index) {
                        if (index == 0) {
                          return SizedBox(height: 20);
                        }
                        return Column(
                          children: [
                            // addVerticalSpacing(10),
                            VWidgetsBusinessMyJobsCard(
                              // profileImage: VmodelAssets2.imageContainer,
                              noOfApplicants: widget.jobs[index].noOfApplicants,
                              profileImage:
                                  widget.jobs[index].creator!.profilePictureUrl,
                              // profileName: "Male Models Wanted in london",
                              jobTitle: widget.jobs[index].jobTitle,
                              // jobDescription:
                              //     "Hello, We’re looking for models, influencers and photographers to assist us with our end of the year shoot. We want 2 male models,",
                              jobPriceOption: widget
                                  .jobs[index].priceOption.tileDisplayName,
                              jobDescription:
                                  widget.jobs[index].shortDescription,
                              enableDescription: enableLargeTile,
                              location: widget.jobs[index].jobType,
                              date: widget.jobs[index].createdAt
                                  .getSimpleDateOnJobCard(),
                              appliedCandidateCount: "16",
                              // jobBudget: "450",
                              jobBudget: VConstants.noDecimalCurrencyFormatterGB
                                  .format(
                                      widget.jobs[index].priceValue.round()),
                              candidateType: "Female",
                              // navigateToRoute(
                              //     context, JobDetailPage(job: jobs[index]));
                              onItemTap: () {
                                navigateToRoute(
                                    context,
                                    JobDetailPageUpdated(
                                        job: widget.jobs[index]));
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
                            ),
                          ],
                        );
                      }),
                );
              }),
        ),
        floatingActionButton: _hideFloatingButton
            ? null
            : FloatingActionButton(
                backgroundColor: Theme.of(context).primaryColor,
                onPressed: () {},
                child: IconButton(
                  onPressed: () {
                    showModalBottomSheet(
                      isScrollControlled: true,
                      isDismissible: true,
                      useRootNavigator: true,
                      backgroundColor: Colors.transparent,
                      context: context,
                      builder: (context) => Container(
                        // height: 500,
                        decoration: BoxDecoration(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(13),
                            topRight: Radius.circular(13),
                          ),
                        ),
                        // color: VmodelColors.white,
                        child: const JobMarketFilterBottomSheet(),
                      ),
                    );
                  },
                  icon: RenderSvg(
                    svgPath: VIcons.filterIcon,
                    color: Theme.of(context).scaffoldBackgroundColor,
                  ),
                ),
              ));
  }

  // Widget _titleSearch() {
  //   return SafeArea(
  //     child: Column(
  //       children: [
  //         addVerticalSpacing(60),
  //         Expanded(
  //           child: Container(
  //             margin: const EdgeInsets.symmetric(horizontal: 24),
  //             child: ValueListenableBuilder(
  //                 valueListenable: selectedPanel,
  //                 builder: (context, value, child) {
  //                   return Row(
  //                     children: [
  //                       Expanded(
  //                         flex: 3,
  //                         child: SearchTextFieldWidget(
  //                           showInputBorder: false,
  //                           hintText: value == 'jobs'
  //                               ? "Eg: Last minute stylists needed ASAP"
  //                               : "Eg: Model Wanted",
  //                           controller: _searchController,
  //                           enabledBorder: InputBorder.none,
  //                           onChanged: (val) {
  //                             _debounce(() {
  //                               ref
  //                                   .watch(allJobsSearchTermProvider.notifier)
  //                                   .state = val;
  //                             });
  //                           },
  //                         ),
  //                       ),
  //                     ],
  //                   );
  //                 }),
  //           ),
  //         ),
  //         addVerticalSpacing(20),
  //       ],
  //     ),
  //   );
  // }
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
