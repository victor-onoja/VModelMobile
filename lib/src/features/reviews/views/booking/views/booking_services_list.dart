import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vmodel/src/core/utils/helper_functions.dart';

import '../../../../../core/utils/costants.dart';
import '../../../../../vmodel.dart';
import '../../../../settings/views/booking_settings/controllers/service_packages_controller.dart';
import '../widgets/item_card.dart';
import 'booking_service_detail.dart';

class BookingServicesList extends ConsumerStatefulWidget {
  const BookingServicesList({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _BookingServicesListState();
}

class _BookingServicesListState extends ConsumerState<BookingServicesList> {
  @override
  Widget build(BuildContext context) {
    final services = ref.watch(servicePackagesProvider(null));
    return services.when(data: (value) {
      return RefreshIndicator.adaptive(
        onRefresh: () async {
          HapticFeedback.lightImpact();
          ref.refresh(servicePackagesProvider(null).future);
        },
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: 60.h),
          child: ListView.separated(
            shrinkWrap: true,
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
            itemBuilder: (context, index) {
              var item = value[index];
              // final displayPrice = (item['price'] as double);

              return VWidgetsBusinessBookingItemCard(
                onItemTap: () {
                  navigateToRoute(
                      context,
                      BookingServiceDetail(
                        service: item,
                        isCurrentUser: true,
                        username: 'user?.username',
                        // username: '${user?.username}',
                      ));
                },
                statusColor: item.status.statusColor(item.processing),
                enableDescription: false,
                profileImage: item.banner.isNotEmpty
                    ? item.banner.first.thumbnail
                    : item.user!.thumbnailUrl,
                jobPriceOption: item.servicePricing.tileDisplayName,
                location: item.serviceType.simpleName,
                noOfApplicants: 0,
                profileName: item.title,
                jobDescription: item.description,
                date: item.createdAt.getSimpleDateOnJobCard(),
                appliedCandidateCount: "16",
                jobBudget: VConstants.noDecimalCurrencyFormatterGB
                    .format(item.price.round()),
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

              // return VWidgetsBookingServiceCardWidget(
              //   statusColor: item.status.statusColor(item.processing),
              //   showDescription: false,
              //   onTap: () {
              //     navigateToRoute(
              //         context,
              //         BookingServiceDetail(
              //           service: item,
              //           isCurrentUser: true,
              //           username: 'user?.username',
              //           // username: '${user?.username}',
              //         ));
              //   },
              //   serviceName: item.title,
              //   bannerUrl:
              //       item.banner.isNotEmpty ? item.banner.first.thumbnail : null,
              //   serviceType: item.servicePricing
              //       .tileDisplayName, // Add your service type logic here
              //   serviceLocation: item.serviceType.simpleName,
              //   serviceCharge: item.price,
              //   discount: item.percentDiscount ?? 0,
              //   serviceDescription: item.description,
              //   date: item.createdAt.getSimpleDateOnJobCard(),
              // );
            },
          ),
        ),
      );
    }, error: (err, stackTrace) {
      return Text('There was an error showing services $stackTrace');
    }, loading: () {
      return const Center(child: CircularProgressIndicator.adaptive());
    });
  }
}
