import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vmodel/src/core/utils/helper_functions.dart';

import '../../../../../core/utils/costants.dart';
import '../../../../../vmodel.dart';
import '../../../../dashboard/new_profile/controller/user_jobs_controller.dart';
import 'booking_job_detail.dart';
import '../widgets/item_card.dart';

class BookingJobsList extends ConsumerStatefulWidget {
  const BookingJobsList({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _BookingJobsListState();
}

class _BookingJobsListState extends ConsumerState<BookingJobsList> {
  @override
  Widget build(BuildContext context) {
    final userJobs = ref.watch(userJobsProvider(null));
    return userJobs.when(data: (value) {
      return RefreshIndicator.adaptive(
        onRefresh: () async {
          HapticFeedback.lightImpact();
          ref.refresh(userJobsProvider(null).future);
        },
        child: ListView.separated(
          padding: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
          physics:
              AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
          itemCount: value.length,
          separatorBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Divider(),
            );
          },
          itemBuilder: (conc, index) {
            final jobItem = value[index];
            return VWidgetsBusinessBookingItemCard(
              onItemTap: () {
                navigateToRoute(context, BookingJobDetailPage(job: jobItem));
              },
              statusColor: jobItem.status.statusColor(jobItem.processing),
              enableDescription: false,
              profileImage: jobItem.creator!.thumbnailUrl,
              jobPriceOption: jobItem.priceOption.tileDisplayName,
              location: jobItem.jobType,
              noOfApplicants: jobItem.noOfApplicants,
              profileName: jobItem.jobTitle,
              jobDescription: jobItem.shortDescription,
              date: jobItem.createdAt.getSimpleDateOnJobCard(),
              appliedCandidateCount: "16",
              jobBudget: VConstants.noDecimalCurrencyFormatterGB
                  .format(jobItem.priceValue.round()),
              candidateType: "Female",
              shareJobOnPressed: () {
                // showModalBottomSheet(
                //   isScrollControlled: true,
                //   isDismissible: true,
                //   useRootNavigator: true,
                //   backgroundColor: Colors.transparent,
                //   context: context,
                //   builder: (context) => const ShareWidget(
                //     shareLabel: 'Share Job',
                //     shareTitle: "Male Models Wanted in london",
                //     shareImage: VmodelAssets2.imageContainer,
                //     shareURL: "Vmodel.app/job/tilly's-bakery-services",
                //   ),
                // );
              },
            );
          },
        ),
      );
    }, error: (err, stackTrace) {
      return Text('There was an error showing services $stackTrace');
    }, loading: () {
      return const Center(child: CircularProgressIndicator.adaptive());
    });
  }
}
