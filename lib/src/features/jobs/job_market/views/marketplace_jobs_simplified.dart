import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vmodel/src/core/utils/debounce.dart';
import 'package:vmodel/src/res/gap.dart';
import 'package:vmodel/src/vmodel.dart';
import '../../../../core/utils/costants.dart';
import '../../../../core/utils/enum/discover_category_enum.dart';
import '../../../../core/utils/enum/upload_ratio_enum.dart';
import '../../../dashboard/discover/models/mock_data.dart';
import '../controller/all_jobs_controller.dart';
import '../controller/coupons_controller.dart';
import '../controller/recommended_jobs.dart';
import '../widget/carousel_with_close.dart';
import 'all_jobs.dart';
import 'job_details_sub_list.dart';
import 'sub_all_jobs.dart';

class JobsSimplified extends ConsumerStatefulWidget {
  const JobsSimplified({super.key});
  static const routeName = 'allJobsSimplified';

  @override
  ConsumerState<JobsSimplified> createState() => _JobsSimplifiedState();
}

class _JobsSimplifiedState extends ConsumerState<JobsSimplified> {
  final TextEditingController _searchController = TextEditingController();
  late final Debounce _debounce;
  ScrollController _scrollController = ScrollController();
  DiscoverCategory? _discoverCategoryType = DiscoverCategory.values.first;

  @override
  void initState() {
    _debounce = Debounce(delay: Duration(milliseconds: 300));
    //Todo implement jobs pagination
    // _scrollController.addListener(() {
    //   final maxScroll = _scrollController.position.maxScrollExtent;
    //   final currentScroll = _scrollController.position.pixels;
    //   final delta = SizerUtil.height * 0.2;
    //   if (maxScroll - currentScroll <= delta) {
    //     _debounce(() {
    //       ref.read(allCouponsProvider.notifier).fetchMoreData();
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
    // final allJobsSimplified = ref.watch(allCouponsProvider);
    final recommendedJobs =
        ref.watch(recommendedJobsProvider); //userJobsProvider("gg500"));

    return RefreshIndicator.adaptive(
      onRefresh: () async {
        HapticFeedback.lightImpact();
        await ref.refresh(recommendedJobsProvider.future);
      },
      child: SingleChildScrollView(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          CarouselWithClose(
            aspectRatio: UploadAspectRatio.wide.ratio,
            padding: EdgeInsets.zero,
            autoPlay: false,
            height: 180,
            cornerRadius: 0,
            children: List.generate(mockMarketPlaceJobsImages.length, (index) {
              return GestureDetector(
                onTap: () {
                  if (index == 1) {
                    navigateCategoryJobs('Modelling');
                  }
                },
                child: Container(
                  height: 180,
                  width: 90.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    image: DecorationImage(
                      image: AssetImage(mockMarketPlaceJobsImages[index]),
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
              );
            }),
          ),
          addVerticalSpacing(16),
          recommendedJobs.when(
            data: (data) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: JobSubList(
                  isCurrentUser: false,
                  items: data,
                  onViewAllTap: () => navigateToRoute(
                      context,
                      SubAllJobs(
                        jobs: data,
                        title: "Recommended jobs",
                      )),
                  onTap: (value) {},
                  title: 'Recommended jobs',
                  username: '',
                ),
              );
            },
            error: (Object error, StackTrace stackTrace) {
              return Text("Error");
            },
            loading: () {
              return CircularProgressIndicator.adaptive();
            },
          ),
          // SizedBox(
          //   height: 200,
          //   child: ListView.separated(
          //     shrinkWrap: true,
          //     physics: BouncingScrollPhysics(),
          //     scrollDirection: Axis.horizontal,
          //     padding: EdgeInsets.symmetric(horizontal: 16),
          //     itemCount: mockMarketPlaceImages.length,
          //     separatorBuilder: (context, index) {
          //       return SizedBox(width: 20);
          //     },
          //     itemBuilder: (context, index) {
          //       return GestureDetector(
          //         onTap: () {
          //           if (index == 0)
          //             navigateToRoute(context, const PopularFAQsHomepage());
          //         },
          //         child: Container(
          //           width: 150,
          //           // margin: EdgeInsets.symmetric(
          //           //     horizontal: 16, vertical: 8),
          //           clipBehavior: Clip.hardEdge,
          //           decoration: BoxDecoration(
          //             color: Colors.black,
          //             borderRadius: BorderRadius.circular(5),
          //           ),
          //           child: Image.asset(
          //             mockMarketPlaceImages[index],
          //             fit: BoxFit.cover,
          //           ),
          //         ),
          //       );
          //     },
          //   ),
          // ),
          // const SizedBox(height: 20),
          ListView.separated(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 16),
            itemCount: VConstants.tempCategories.length + 1,
            separatorBuilder: (context, index) {
              return Divider();
            },
            itemBuilder: (context, index) {
              if (index == 0)
                return GestureDetector(
                  onTap: () {
                    navigateCategoryJobs(null);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    color: Colors.transparent,
                    child: Text(
                      "All ${DiscoverCategory.job.shortName}",
                      style:
                          Theme.of(context).textTheme.displayMedium?.copyWith(
                                fontWeight: FontWeight.w500,
                              ),
                    ),
                  ),
                );
              return GestureDetector(
                onTap: () =>
                    navigateCategoryJobs(VConstants.tempCategories[index - 1]),
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  color: Colors.transparent,
                  child: Text(
                    VConstants.tempCategories[index - 1],
                    style: Theme.of(context).textTheme.displayMedium?.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                ),
              );
            },
          ),
          addVerticalSpacing(10),
          // ),
          addVerticalSpacing(10),
        ]),
      ),
    );
  }

  void navigateCategoryJobs(String? category) {
    ref.read(selectedJobsCategoryProvider.notifier).state = category ?? '';
    if (category == null) //All jobs
      navigateToRoute(context, AllJobs());
    else
      navigateToRoute(context, AllJobs(title: category));
  }
}
