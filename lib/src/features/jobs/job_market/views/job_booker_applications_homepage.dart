import 'dart:developer' as dev;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vmodel/src/core/routing/navigator_1.0.dart';
import 'package:vmodel/src/core/utils/shared.dart';
import 'package:vmodel/src/features/dashboard/dash/controller.dart';
import 'package:vmodel/src/features/dashboard/new_profile/views/other_profile_router.dart';
import 'package:vmodel/src/features/jobs/job_market/controller/jobs_controller.dart';
import 'package:vmodel/src/features/jobs/job_market/widget/business_user/job_booker_applications_view_page_card_widget.dart';
import 'package:vmodel/src/res/assets/app_asset.dart';
import 'package:vmodel/src/shared/appbar/appbar.dart';
import 'package:vmodel/src/shared/loader/full_screen_dialog_loader.dart';
import 'package:vmodel/src/shared/response_widgets/toast.dart';

import '../../../../core/controller/app_user_controller.dart';
import '../../../../shared/loader/loader_progress.dart';
import '../../../../shared/shimmer/jobShimmerPage.dart';
import '../../../dashboard/profile/view/webview_page.dart';
import '../../../reviews/views/booking/controller/booking_controller.dart';
import '../../../reviews/views/booking/model/booking_data.dart';
import '../model/job_post_model.dart';

class JobBookerApplicationsHomepage extends ConsumerStatefulWidget {
  const JobBookerApplicationsHomepage({super.key, required this.job});
  final JobPostModel job;

  @override
  ConsumerState<JobBookerApplicationsHomepage> createState() =>
      _JobBookerApplicationsHomepageState();
}

class _JobBookerApplicationsHomepageState
    extends ConsumerState<JobBookerApplicationsHomepage> {
  late final BookingData bookingData;

  @override
  void initState() {
    super.initState();
    // dev.log('>>>>GGGGGGGGGGG>>>> ${widget.job.toMap()}');
    bookingData = BookingData(
      module: BookingModule.JOB,
      moduleId: widget.job.id,
      title: widget.job.jobTitle,
      price: widget.job.priceValue,
      pricingOption:
          BookingData.getPricingOptionFromServicePeriod(widget.job.priceOption),
      bookingType: BookingData.getBookingType(widget.job.jobType),
      // bookingType: BookingType.ON_LOCATION,
      haveBrief: false,
      deliverableType: widget.job.deliverablesType,
      expectDeliverableContent: widget.job.isDigitalContent,
      usageType: int.tryParse('${widget.job.usageType?.id}'),
      usageLength: int.tryParse('${widget.job.usageLength?.id}'),
      brief: widget.job.brief ?? '',
      briefLink: widget.job.briefLink ?? '',
      briefFile: widget.job.briefFile,
      bookedUser: '',
      startDate: DateTime.now(),
      address: widget.job.jobLocation.toMap(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final jobOffers =
        ref.watch(jobApplicationProvider(int.parse(widget.job.id)));
    return jobOffers.when(data: (data) {
      if (data!.isEmpty) {
        return Scaffold(
            appBar: const VWidgetsAppBar(
              leadingIcon: VWidgetsBackButton(),
              appbarTitle: "Offers",
            ),
            body: Center(
              child: Text("No offers have been made yet.",
                  style: Theme.of(context).textTheme.displayMedium?.copyWith(
                        fontSize: 14,
                        color: Theme.of(context).primaryColor.withOpacity(.5),
                        fontWeight: FontWeight.w400,
                      )),
            ));
      }
      return Scaffold(
        appBar: const VWidgetsAppBar(
          leadingIcon: VWidgetsBackButton(),
          appbarTitle: "Offers",
        ),
        body: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            physics:
                AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
            itemCount: data.length,
            separatorBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Divider(),
              );
            },
            itemBuilder: (context, index) {
              return VWidgetsJobBookerApplicationsCard(
                isOfferAccepted: data[index].accepted,
                profileName: data[index].applicant?.username ?? '',
                displayName: data[index].applicant?.displayName,
                profileImage: VmodelAssets2.imageContainer,
                profileType: data[index].applicant?.label ?? '',
                rating: "4.9",
                ratingCount: "150",
                profilePictureUrl:
                    '${data[index].applicant?.profilePictureUrl}',
                profilePictureUrlThumbnail:
                    data[index].applicant?.thumbnailUrl ?? '',
                isIDVerified: data[index].applicant?.isVerified ?? false,
                isBlueTickVerified:
                    data[index].applicant?.blueTickVerified ?? false,
                offerPrice: data[index].proposedPrice?.toInt().toString(),
                onPressedViewProfile: () {
                  _navigateToUserProfile(data[index].applicant?.username ?? "");
                },
                onPressedAcceptOffer: (username) async {
                  dev.log(
                      'OOOOOOOKKKKKKKKKKK ${data[index].proposedPrice?.toInt()}');
                  // showDialog(
                  //   context: context,
                  //   builder: (context) => LoaderProgress(
                  //     done: true,
                  //     loading: false,
                  //   ),
                  // );
                  final userBooking = bookingData.copyWith(
                    bookedUser: username,
                    price: data[index].proposedPrice,
                  );
                  // return;
                  // final bookingId =
                  VLoader.changeLoadingState(true);
                  ref
                      .read(createBookingProvider(userBooking).future)
                      .then((value) {
                    dev.log('::::::::Booking id is ${value}');
                    createAandOpenPaymentLink(value ?? '');
                  });

                  // if (data[index].accepted ?? false) {
                  //   VWidgetShowResponse.showToast(ResponseEnum.warning,
                  //       message: "You have already accepted this offer");
                  //   return;
                  // }

                  // final parsedId = int.tryParse("${data[index].id}");
                  // if (parsedId == null) {
                  //   VWidgetShowResponse.showToast(ResponseEnum.warning,
                  //       message: "Job id incorrect");
                  //   return;
                  // }
                  // await ref
                  //     .read(jobApplicationProvider(int.parse(widget.job.id))
                  //         .notifier)
                  //     .acceptApplicationOffer(
                  //       applicationId: parsedId,
                  //       acceptApplication: true,
                  //     );
                },
              );
            }),
        // SingleChildScrollView(
        //   padding: const VWidgetsPagePadding.horizontalSymmetric(16),
        //   child:

        //   Column(
        //     children: [
        //       addVerticalSpacing(15),
        //       for (int index = 0; index < data.length; index++)
        //         VWidgetsJobBookerApplicationsCard(
        //           isOfferAccepted: data[index].accepted,
        //           profileName: data[index].applicant?.username ?? '',
        //           displayName: data[index].applicant?.displayName,
        //           profileImage: VmodelAssets2.imageContainer,
        //           profileType: data[index].applicant?.label ?? '',
        //           rating: "4.9",
        //           ratingCount: "150",
        //           profilePictureUrl:
        //               '${data[index].applicant?.profilePictureUrl}',
        //           profilePictureUrlThumbnail:
        //               data[index].applicant?.thumbnailUrl ?? '',
        //           isIDVerified: data[index].applicant?.isVerified ?? false,
        //           offerPrice: data[index].proposedPrice?.toInt().toString(),
        //           onPressedViewProfile: () {
        //             _navigateToUserProfile(
        //                 data[index].applicant?.username ?? "");
        //           },
        //           onPressedAcceptOffer: () async {
        //             if (data[index].accepted ?? false) {
        //               VWidgetShowResponse.showToast(ResponseEnum.warning,
        //                   message: "You have already accepted this offer");
        //               return;
        //             }

        //             final parsedId = int.tryParse("${data[index].id}");
        //             if (parsedId == null) {
        //               VWidgetShowResponse.showToast(ResponseEnum.warning,
        //                   message: "Job id incorrect");
        //               return;
        //             }
        //             await ref
        //                 .read(jobApplicationProvider(widget.jobId!).notifier)
        //                 .acceptApplicationOffer(
        //                   applicationId: parsedId,
        //                   acceptApplication: true,
        //                 );
        //           },
        //         ),
        //     ],
        //   ),
        // ),
      );
    }, error: (error, stackTrace) {
      return Scaffold(body: Center(child: Text("Error: $error")));
    }, loading: () {
      return const JobShimmerPage(showTrailing: false);
    });
  }

  void createAandOpenPaymentLink(String bookingId) async {
    ref.read(createPaymentProvider(bookingId).future).then((value) {
      // goBack(context);
      VLoader.changeLoadingState(false);
      final paymentLink = value['paymentLink'];
      navigateToRoute(context, WebViewPage(url: paymentLink));
    });
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
