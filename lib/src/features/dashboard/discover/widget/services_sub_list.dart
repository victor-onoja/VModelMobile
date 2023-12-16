import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vmodel/src/core/utils/enum/service_job_status.dart';
import 'package:vmodel/src/core/utils/helper_functions.dart';

import '../../../../res/assets/app_asset.dart';
import '../../../../res/res.dart';
import '../../../../shared/carousel_indicators.dart';
import '../../../../vmodel.dart';
import '../../../jobs/job_market/controller/jobs_controller.dart';
import '../../../jobs/job_market/model/job_post_model.dart';
import '../../../jobs/job_market/views/job_detail_creative_updated.dart';
import '../../../jobs/job_market/widget/business_user/business_my_jobs_card.dart';
import '../../../settings/views/booking_settings/models/service_package_model.dart';
import '../../feed/widgets/share.dart';
import '../../new_profile/profile_features/services/views/new_service_detail.dart';

class JobsCarouselTile extends ConsumerStatefulWidget {
  const JobsCarouselTile({
    super.key,
    required this.title,
    this.isService = false,
    this.showDescription = false,
    required this.isCurrentUser,
    // required this.popularJobs,
  });

  final String title;
  final bool isService;
  final bool showDescription;
  final bool isCurrentUser;
  // final List<JobPostModel> jobs;

  @override
  ConsumerState<JobsCarouselTile> createState() => _JobsCarouselTileState();
}

class _JobsCarouselTileState extends ConsumerState<JobsCarouselTile> {
  int _currentIndex = 0;
  List<JobPostModel> jobs = [];
  List<ServicePackageModel> services = [];
  final itemsPerPage = 3;

  @override
  Widget build(BuildContext context) {
    if (widget.isService) {
      services = ref.watch(popularServicesProvider).valueOrNull ?? [];
      print("service ${services.isEmpty}");
    } else {
      jobs = ref.watch(popularJobsProvider).valueOrNull ?? [];
      print("jobs ${jobs.isEmpty}");
    }

    return Column(
      children: [
        addVerticalSpacing(10),
        GestureDetector(
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 13),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.title,
                  style: Theme.of(context).textTheme.displayMedium!.copyWith(
                        fontWeight: FontWeight.w600,
                        // color: VmodelColors.mainColor,
                      ),
                ),
              ],
            ),
          ),
        ),
        addVerticalSpacing(9),
        CarouselSlider(
          items: List.generate(
            !widget.isService
                ? (jobs.length / itemsPerPage).ceil()
                : (services.length / itemsPerPage).ceil(),
            (index) => GestureDetector(
              child: ListView.builder(
                itemCount: _itemCount,
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final indx = (_currentIndex) * itemsPerPage;
                  JobPostModel? jobItem;
                  ServicePackageModel? serviceItem;
                  // print("iuwehnfiuweh ${jobs[index + indx].status}");
                  if (!widget.isService) {
                    if (jobs[index + indx].status.apiValue !=
                        ServiceOrJobStatus.expired)
                      jobItem = jobs[index + indx];
                  } else {
                    serviceItem = services[index + indx];
                  }
                  return VWidgetsBusinessMyJobsCard(
                    onItemTap: () {
                      if (!widget.isService)
                        navigateToRoute(
                            context, JobDetailPageUpdated(job: jobs[index]));
                      else
                        navigateToRoute(
                            context,
                            ServicePackageDetail(
                              username: serviceItem!.user!.displayName,
                              isCurrentUser: widget.isCurrentUser,
                              service: serviceItem,
                            ));
                    },
                    noOfApplicants:
                        widget.isService ? null : jobItem!.noOfApplicants,
                    enableDescription: widget.showDescription,
                    profileImage: widget.isService
                        ? serviceItem!.banner.isNotEmpty
                            ? serviceItem.banner[0].thumbnail
                            : serviceItem.user!.thumbnailUrl ??
                                serviceItem.user!.profilePictureUrl
                        : jobItem!.creator!.profilePictureUrl,
                    jobPriceOption: widget.isService
                        ? serviceItem!.servicePricing.tileDisplayName
                        : jobItem!.priceOption.tileDisplayName,
                    location: widget.isService
                        ? serviceItem!.serviceType.simpleName
                        : jobItem!.jobType,
                    jobTitle: widget.isService
                        // ? "I will model for your food brand and other products"
                        ? "${serviceItem?.title}"
                        : jobItem!.jobTitle,
                    jobDescription:
                        "Hello, We’re looking for models, influencers and photographers to assist us with our end of the year shoot. We want 2 male models,",
                    date: widget.isService
                        ? "${serviceItem?.createdAt.getSimpleDateOnJobCard()}"
                        : "${jobItem!.createdAt.getSimpleDateOnJobCard()}",
                    appliedCandidateCount: "16",
                    jobBudget: widget.isService
                        ? "${VMString.poundSymbol}${serviceItem?.price.round()}"
                        : "${VMString.poundSymbol}${jobItem!.priceValue.round()}",
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
                  // return VWidgetDiscoverServiceItemTile(
                  //   imageWidget: SizedBox(
                  //     width: 50,
                  //     height: 50,
                  //     child: widget.isService
                  //         ? ProfilePicture(
                  //             url: serviceItem?.user?.profilePictureUrl,
                  //             showBorder: false,
                  //           )
                  //         : Container(
                  //             decoration: BoxDecoration(
                  //                 color: VmodelColors.appBarBackgroundColor,
                  //                 borderRadius: const BorderRadius.all(
                  //                   Radius.circular(8),
                  //                 ),
                  //                 image: DecorationImage(
                  //                   image: CachedNetworkImageProvider(
                  //                       // profileImage!,
                  //                       // "assets/images/jobs_market_images/jobm.jpeg",
                  //                       '${jobItem?.creator.profilePictureUrl}'),
                  //                   fit: BoxFit.cover,
                  //                 )),
                  //             // child: Image.asset(
                  //             //     // fit: BoxFit.cover,
                  //             //     ),
                  //           ),
                  //   ),
                  //   profileImage: VmodelAssets2.imageContainer,
                  //   profileName: widget.isService
                  //       // ? "I will model for your food brand and other products"
                  //       ? "${serviceItem?.title}"
                  //       : '${jobItem?.jobTitle}',
                  //   jobDescription:
                  //       "Hello, We’re looking for models, influencers and photographers to assist us with our end of the year shoot. We want 2 male models,",
                  //   rating: "4.5 (30)",
                  //   time: "3:30 hr",
                  //   appliedCandidateCount: "16",
                  //   jobBudget: widget.isService
                  //       ? "${serviceItem?.price.round()}"
                  //       : "${jobItem?.priceValue.round()}",
                  //   candidateType: "Female",
                  //   onItemTap: () {
                  //     if (widget.isService) {
                  //       navigateToRoute(
                  //           context,
                  //           ServicePackageDetail(
                  //             service: serviceItem!,
                  //             isCurrentUser: false,
                  //             username: '${serviceItem.user?.username}',
                  //           ));
                  //     } else {
                  //       navigateToRoute(
                  //           context, JobDetailPageUpdated(job: jobItem!));
                  //     }
                  //   },
                  //   shareJobOnPressed: () {
                  //     showModalBottomSheet(
                  //       isScrollControlled: true,
                  //       isDismissible: true,
                  //       useRootNavigator: true,
                  //       backgroundColor: Colors.transparent,
                  //       context: context,
                  //       builder: (context) => const ShareWidget(
                  //         shareLabel: 'Share Job',
                  //         shareTitle: "Male Models Wanted in london",
                  //         shareImage: VmodelAssets2.imageContainer,
                  //         shareURL: "Vmodel.app/job/tilly's-bakery-services",
                  //       ),
                  //     );
                  //   },
                  // );
                },
                // children: List<Widget>.generate(4, (index) {
                //   // return VWidgetsBusinessMyJobTwoTilesCard(
                //   return VWidgetDiscoverServiceItemTile(
                //     imageWidget: SizedBox(
                //       width: 50,
                //       height: 50,
                //       child: widget.isService
                //           ? const ProfilePicture(
                //               url: VConstants.testImage,
                //               showBorder: false,
                //             )
                //           : Container(
                //               decoration: const BoxDecoration(
                //                   color: VmodelColors.appBarBackgroundColor,
                //                   borderRadius: BorderRadius.all(
                //                     Radius.circular(8),
                //                   ),
                //                   image: DecorationImage(
                //                     image: AssetImage(
                //                       // profileImage!,
                //                       "assets/images/jobs_market_images/jobm.jpeg",
                //                     ),
                //                     fit: BoxFit.cover,
                //                   )),
                //               // child: Image.asset(
                //               //     // fit: BoxFit.cover,
                //               //     ),
                //             ),
                //     ),
                //     profileImage: VmodelAssets2.imageContainer,
                //     profileName: widget.isService
                //         ? "I will model for your food brand and other products"
                //         : "Male Models Wanted in london",
                //     jobDescription:
                //         "Hello, We’re looking for models, influencers and photographers to assist us with our end of the year shoot. We want 2 male models,",
                //     rating: "4.5 (30)",
                //     time: "3:30 hr",
                //     appliedCandidateCount: "16",
                //     jobBudget: "450",
                //     candidateType: "Female",
                //     shareJobOnPressed: () {
                //       showModalBottomSheet(
                //         isScrollControlled: true,
                //         isDismissible: true,
                //         useRootNavigator: true,
                //         backgroundColor: Colors.transparent,
                //         context: context,
                //         builder: (context) => const ShareWidget(
                //           shareLabel: 'Share Job',
                //           shareTitle: "Male Models Wanted in london",
                //           shareImage: VmodelAssets2.imageContainer,
                //           shareURL: "Vmodel.app/job/tilly's-bakery-services",
                //         ),
                //       );
                //     },
                //   );
                // }),
              ),
            ),
            //     Image.asset(
            //   widget.imageList[index],
            //   width: double.infinity,
            //   height: double.infinity,
            //   fit: BoxFit.cover,
            // ),
          ),
          carouselController: CarouselController(),
          options: CarouselOptions(
            height: widget.showDescription ? 538 : 348,
            padEnds: true,

            viewportFraction: 1,
            // aspectRatio: 1,
            initialPage: 0,
            enableInfiniteScroll: true,
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
        VWidgetsCarouselIndicator(
          currentIndex: _currentIndex,
          totalIndicators: (jobs.length / 4).ceil(),
        ),
      ],
    );
  }

  int get _itemCount {
    if (widget.isService) {
      return ((_currentIndex + 1) * itemsPerPage) > services.length
          ? services.length % itemsPerPage
          : itemsPerPage;
    } else {
      return ((_currentIndex + 1) * itemsPerPage) > jobs.length
          ? jobs.length % itemsPerPage
          : itemsPerPage;
    }
  }
}
