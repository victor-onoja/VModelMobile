import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:vmodel/src/core/models/app_user.dart';
import 'package:vmodel/src/core/models/location_model.dart';
import 'package:vmodel/src/core/utils/enum/service_job_status.dart';
import 'package:vmodel/src/core/utils/enum/service_pricing_enum.dart';
import 'package:vmodel/src/core/utils/helper_functions.dart';
import 'package:vmodel/src/features/applications/controller/my_applications_controller.dart';
import 'package:vmodel/src/features/applications/model/my_application_model.dart';
import 'package:vmodel/src/features/jobs/job_market/model/job_post_model.dart';
import 'package:vmodel/src/features/jobs/job_market/widget/business_user/business_my_jobs_card.dart';
import 'package:vmodel/src/shared/appbar/appbar.dart';
import 'package:vmodel/src/shared/response_widgets/error_dialogue.dart';
import 'package:vmodel/src/shared/shimmer/jobShimmerPage.dart';
import 'package:vmodel/src/vmodel.dart';

import '../../../core/utils/costants.dart';
import '../../../res/assets/app_asset.dart';
import '../../../res/icons.dart';
import '../../../res/res.dart';
import '../../../shared/modal_pill_widget.dart';
import '../../../shared/rend_paint/render_svg.dart';
import '../../dashboard/feed/widgets/share.dart';
import '../../jobs/job_market/views/job_detail_creative_updated.dart';

class ApplicationsPage extends ConsumerStatefulWidget {
  const ApplicationsPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ApplicationsPageState();
}

class _ApplicationsPageState extends ConsumerState<ApplicationsPage> {
  bool enableLargeTile = false;
  int pageNumber = 1;

  String getRelativeDate(DateTime inputDate) {
    // Get the current date
    DateTime now = DateTime.now();

    // Calculate the start and end of the current week
    DateTime startOfWeek = now.subtract(Duration(days: now.weekday - 1));
    DateTime endOfWeek = now.add(Duration(days: 7 - now.weekday));

    // Calculate the start and end of the previous week
    DateTime startOfLastWeek = startOfWeek.subtract(Duration(days: 7));
    DateTime endOfLastWeek = endOfWeek.subtract(Duration(days: 7));

    // Check if the date falls within "This week"
    if (inputDate.isAfter(startOfWeek) && inputDate.isBefore(endOfWeek)) {
      return "This week";
    }

    // Check if the date falls within "Last week"
    if (inputDate.isAfter(startOfLastWeek) &&
        inputDate.isBefore(endOfLastWeek)) {
      return "Last week";
    }

    // Get the name of the previous month
    String previousMonth =
        DateFormat('MMMM').format(DateTime(now.year, now.month - 1, 1));

    // Get the name of the previous year
    String previousYear = DateFormat('yyyy').format(DateTime(now.year - 1));

    return previousMonth + " (last month), " + previousYear + " (last year)";
  }

  bool isLoading = false;
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      pageNumber = pageNumber + 1;
      // ref
      //     .read(myApplicationProvider.notifier)
      //     .getMyApplications(pageCount: 10, pageNumber: pageNumber);
    }
  }

  @override
  Widget build(BuildContext context) {
    final jobApplication = ref.watch(myApplicationProvider);

    return WillPopScope(
        onWillPop: () async {
          moveAppToBackGround();
          return false;
        },
        child: jobApplication.when(data: (applications) {
          final groupedApplications = groupJobApplications(applications!);
          if (applications.isNotEmpty)
            return Scaffold(
              appBar: VWidgetsAppBar(
                appbarTitle: "My applications",
                leadingIcon: const VWidgetsBackButton(),
                trailingIcon: [
                  IconButton(
                      onPressed: () {
                        showModalBottomSheet(
                            context: context,
                            backgroundColor: Colors.transparent,
                            builder: (BuildContext context) {
                              return Container(
                                  padding: const EdgeInsets.only(
                                    left: 16,
                                    right: 16,
                                    bottom:
                                        VConstants.bottomPaddingForBottomSheets,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Theme.of(context)
                                        .scaffoldBackgroundColor,
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(13),
                                      topRight: Radius.circular(13),
                                    ),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      addVerticalSpacing(15),
                                      const Align(
                                          alignment: Alignment.center,
                                          child: VWidgetsModalPill()),
                                      addVerticalSpacing(25),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 6.0),
                                        child: GestureDetector(
                                          child: Text('Most Recent',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .displayMedium!
                                                  .copyWith(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Theme.of(context)
                                                          .primaryColor)),
                                        ),
                                      ),
                                      const Divider(thickness: 0.5),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 6.0),
                                        child: GestureDetector(
                                          child: Text('Earliest',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .displayMedium!
                                                  .copyWith(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Theme.of(context)
                                                          .primaryColor)),
                                        ),
                                      ),
                                      addVerticalSpacing(40),
                                    ],
                                  ));
                            });
                      },
                      icon: const RenderSvg(
                        svgPath: VIcons.sort,
                      ))
                ],
              ),
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: RefreshIndicator.adaptive(
                  displacement: 20,
                  edgeOffset: -20,
                  triggerMode: RefreshIndicatorTriggerMode.onEdge,

                  // notificationPredicate: (notification) {
                  //   return notification.depth == 2;
                  // },
                  onRefresh: () async {
                    HapticFeedback.lightImpact();
                    await ref.refresh(myApplicationProvider.future);
                  },
                  child: ListView.builder(
                      itemCount: groupedApplications.length,
                      itemBuilder: (context, index) {
                        print(groupedApplications.length);
                        final group = groupedApplications.keys.elementAt(index);
                        final applications = groupedApplications[group];
                        if (groupedApplications.length > 0)
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  group,
                                  style: Theme.of(context)
                                      .textTheme
                                      .displayLarge
                                      ?.copyWith(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700,
                                      ),
                                ),
                              ),
                              Column(
                                children: [
                                  for (var index = 0;
                                      index < applications!.length;
                                      index++)
                                    VWidgetsBusinessMyJobsCard(
                                      // profileImage: VmodelAssets2.imageContainer,

                                      profileImage: applications[index]
                                              .job!
                                              .creator!
                                              .profilePicture ??
                                          null,
                                      // profileName: "Male Models Wanted in london",
                                      jobTitle:
                                          applications[index].job!.jobTitle,
                                      // jobDescription:
                                      //     "Hello, We’re looking for models, influencers and photographers to assist us with our end of the year shoot. We want 2 male models,",
                                      jobPriceOption:
                                          applications[index].accepted!
                                              ? 'Booked'
                                              : 'Applied',
                                      jobDescription: applications[index]
                                          .job!
                                          .shortDescription,
                                      enableDescription: enableLargeTile,
                                      location:
                                          applications[index].job!.jobType,
                                      noOfApplicants: applications[index]
                                          .job!
                                          .noOfApplicants,
                                      date: applications[index]
                                          .dateCreated!
                                          .getSimpleDateOnJobCard(),
                                      appliedCandidateCount: "16",
                                      // jobBudget: "450",
                                      jobBudget: VConstants
                                          .noDecimalCurrencyFormatterGB
                                          .format(applications[index]
                                              .job!
                                              .priceValue!
                                              .round()),
                                      candidateType: "Female",
                                      // navigateToRoute(
                                      //     context, JobDetailPage(job: jobs[index]));
                                      onItemTap: () {
                                        navigateToRoute(
                                            context,
                                            JobDetailPageUpdated(
                                                job: JobPostModel(
                                              saves: null,
                                              id: applications[index].id!,
                                              jobTitle: applications[index]
                                                  .job!
                                                  .jobTitle!,
                                              jobType: applications[index]
                                                  .job!
                                                  .jobType!,
                                              priceOption: ServicePeriod
                                                  .servicePeriodByApiValue(
                                                      applications[index]
                                                          .job!
                                                          .priceOption!),
                                              priceValue: applications[index]
                                                  .job!
                                                  .priceValue!,
                                              talents: applications[index]
                                                  .job!
                                                  .talents!,
                                              preferredGender:
                                                  applications[index]
                                                      .job!
                                                      .preferredGender!,
                                              shortDescription:
                                                  applications[index]
                                                      .job!
                                                      .shortDescription!,
                                              noOfApplicants: 0,
                                              jobLocation: LocationData(
                                                  latitude: double.parse(
                                                      applications[index]
                                                          .job!
                                                          .jobLocation!
                                                          .latitude!),
                                                  longitude: double.parse(
                                                      applications[index]
                                                          .job!
                                                          .jobLocation!
                                                          .longitude!),
                                                  locationName:
                                                      applications[index]
                                                          .job!
                                                          .jobLocation!
                                                          .locationName!),
                                              jobDelivery: [],
                                              deliverablesType:
                                                  applications[index]
                                                      .job!
                                                      .deliveryType!,
                                              isDigitalContent:
                                                  applications[index]
                                                      .job!
                                                      .isDigitalContent!,
                                              acceptingMultipleApplicants:
                                                  applications[index]
                                                      .job!
                                                      .acceptMultiple!,
                                              minAge: applications[index]
                                                  .job!
                                                  .minAge!,
                                              maxAge: applications[index]
                                                  .job!
                                                  .maxAge!,
                                              createdAt: DateTime.parse(
                                                  applications[index]
                                                      .job!
                                                      .createdAt!),
                                              creator: VAppUser(
                                                firstName: applications[index]
                                                    .job!
                                                    .creator!
                                                    .firstName!,
                                                email: "",
                                                lastName: "",
                                                username: applications[index]
                                                    .job!
                                                    .creator!
                                                    .username!,
                                                displayName: "",
                                                isVerified: false,
                                                blueTickVerified: false,
                                                alertOnProfileVisit: false,
                                                whoCanConnectWithMe: '',
                                                whoCanFeatureMe: '',
                                                whoCanMessageMe: '',
                                                whoCanViewMyNetwork: '',
                                              ),
                                              paused: false,
                                              closed: false,
                                              processing: false,
                                              status: ServiceOrJobStatus.active,
                                            )));
                                      },
                                      shareJobOnPressed: () {
                                        showModalBottomSheet(
                                          isScrollControlled: true,
                                          isDismissible: true,
                                          useRootNavigator: true,
                                          backgroundColor: Colors.transparent,
                                          context: context,
                                          builder: (context) =>
                                              const ShareWidget(
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
                                    )
                                ],
                              ),
                            ],
                          );

                        return Center(
                          child: Column(
                            children: [
                              addVerticalSpacing(300),
                              Text("There are no applications yet"),
                            ],
                          ),
                        );
                      }),
                ),
              ),
            );
          return CustomErrorDialogWithScaffold(
              onTryAgain: () => ref.invalidate(myApplicationProvider),
              title: 'My Applications');
        }, loading: () {
          return const JobShimmerPage(showTrailing: false);
        }, error: (error, stackTrace) {
          return CustomErrorDialogWithScaffold(
              onTryAgain: () => ref.invalidate(myApplicationProvider),
              title: 'My Applications');
        }));
  }

  Map<String, List<MyJobApplicationModel>> groupJobApplications(
      List<MyJobApplicationModel> applications) {
    final groupedApplications = <String, List<MyJobApplicationModel>>{};

    for (final application in applications) {
      final dateCreated = application.dateCreated;
      if (dateCreated != null) {
        final now = DateTime.now();
        final difference = now.difference(dateCreated);

        if (difference.inDays <= 7) {
          _addToGroup(groupedApplications, 'This week', application);
        } else if (difference.inDays <= 14) {
          // Last week
          _addToGroup(groupedApplications, 'Last week', application);
        } else if (difference.inDays <= 30) {
          // Last month
          _addToGroup(groupedApplications, 'Last month', application);
        } else if (difference.inDays <= 365) {
          _addToGroup(groupedApplications, _getMonth(dateCreated), application);
        } else {
          _addToGroup(
              groupedApplications, dateCreated.year.toString(), application);
        }
      }
    }

    return groupedApplications;
  }

  void _addToGroup(Map<String, List<MyJobApplicationModel>> groupedApplications,
      String groupName, MyJobApplicationModel application) {
    if (!groupedApplications.containsKey(groupName)) {
      groupedApplications[groupName] = [];
    }
    groupedApplications[groupName]!.add(application);
  }

  String _getMonth(DateTime date) {
    final DateFormat formatter = DateFormat('MMMM');
    return formatter.format(date);
  }
}
