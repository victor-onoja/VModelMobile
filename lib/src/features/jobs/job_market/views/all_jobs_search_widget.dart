import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/shared/shimmer/search_shimmer.dart';
import 'package:vmodel/src/vmodel.dart';

import '../../../../core/utils/costants.dart';
import '../../../../res/assets/app_asset.dart';
import '../../../dashboard/feed/widgets/share.dart';
import '../controller/all_jobs_search_controller.dart';
import '../widget/business_user/business_my_jobs_card.dart';
import 'job_detail_creative_updated.dart';

class AllJobsSearch extends ConsumerStatefulWidget {
  const AllJobsSearch({
    super.key,
    this.enableLargeTile = false,
  });

  final bool enableLargeTile;

  @override
  ConsumerState<AllJobsSearch> createState() => AllJobsSearchState();
}

class AllJobsSearchState extends ConsumerState<AllJobsSearch> {
  bool isCurrentUser = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final searchedJobsResult = ref.watch(searchJobsProvider);
    print('List of services');
    print(searchedJobsResult);
    return searchedJobsResult.when(data: (items) {
      if (items.isEmpty) {
        return SingleChildScrollView(
          padding: const VWidgetsPagePadding.horizontalSymmetric(18),
          child: Column(
            children: [
              addVerticalSpacing(20),
              SizedBox(
                height: MediaQuery.of(context).size.height *
                    0.5, // Expand to fill available space
                child: Center(
                  child: Text(
                    'No jobs available',
                    style: Theme.of(context).textTheme.displayMedium?.copyWith(
                          color: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.color
                              ?.withOpacity(0.5),
                          // fontWeight: FontWeight.w400,
                          fontSize: 14,
                        ),
                  ),
                ),
              )
            ],
          ),
        );
      }
      return ListView.builder(
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        physics: const BouncingScrollPhysics(),
        itemCount: items.length,
        itemBuilder: (context, index) {
          var jobItem = items[index];
          // print('service value $item');
          // final displayPrice = (item['price'] as double);

          return VWidgetsBusinessMyJobsCard(
            onItemTap: () {
              navigateToRoute(context, JobDetailPageUpdated(job: items[index]));
            },
            noOfApplicants: jobItem.noOfApplicants,
            enableDescription: widget.enableLargeTile,
            profileImage: jobItem.creator!.profilePictureUrl,
            jobPriceOption: jobItem.priceOption.tileDisplayName,
            location: jobItem.jobType,
            jobTitle: jobItem.jobTitle,
            jobDescription: jobItem.shortDescription,
            date: "3:30 hr",
            appliedCandidateCount: "16",
            jobBudget: VConstants.noDecimalCurrencyFormatterGB
                .format(jobItem.priceValue.round()),
            candidateType: "Female",
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
                  shareURL: "Vmodel.app/job/tilly's-bakery-services",
                ),
              );
            },
          );
        },
      );
    }, error: (err, stackTrace) {
      return Text('There was an error showing services $stackTrace');
    }, loading: () {
      return SearchShimmerPage();
    });
  }
}
