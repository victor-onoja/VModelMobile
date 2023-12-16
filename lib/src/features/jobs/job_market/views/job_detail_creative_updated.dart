import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vmodel/src/core/controller/app_user_controller.dart';
import 'package:vmodel/src/core/utils/helper_functions.dart';
import 'package:vmodel/src/core/utils/validators_mixins.dart';
import 'package:vmodel/src/features/dashboard/new_profile/other_user_profile/other_user_profile.dart';
import 'package:vmodel/src/features/dashboard/new_profile/profile_features/services/widgets/readmore_service_description.dart';
import 'package:vmodel/src/features/jobs/job_market/controller/recently_viewed_jobs_controller.dart';
import 'package:vmodel/src/features/jobs/job_market/controller/similar_jobs_controller.dart';
import 'package:vmodel/src/features/jobs/job_market/views/job_details_sub_list.dart';
import 'package:vmodel/src/features/jobs/job_market/views/sub_all_jobs.dart';
import 'package:vmodel/src/features/jobs/job_market/widget/business_user/job_details_apply_popup.dart';
import 'package:vmodel/src/res/gap.dart';
import 'package:vmodel/src/shared/empty_page/empty_page.dart';
import 'package:vmodel/src/shared/loader/full_screen_dialog_loader.dart';
import 'package:vmodel/src/shared/response_widgets/toast.dart';
import 'package:vmodel/src/vmodel.dart';

import '../../../../core/utils/costants.dart';
import '../../../../core/utils/enum/service_pricing_enum.dart';
import '../../../../res/colors.dart';
import '../../../../res/icons.dart';
import '../../../../shared/appbar/appbar.dart';
import '../../../../shared/buttons/brand_outlined_button.dart';
import '../../../../shared/buttons/primary_button.dart';
import '../../../../shared/job_service_section_container.dart';
import '../../../../shared/modal_pill_widget.dart';
import '../../../../shared/rend_paint/render_svg.dart';
import '../../../../shared/shimmer/job_detail_shimmer.dart';
import '../../../dashboard/new_profile/controller/user_jobs_controller.dart';
import '../../../dashboard/new_profile/profile_features/widgets/profile_picture_widget.dart';
import '../../../dashboard/new_profile/views/other_profile_router.dart';
import '../../create_jobs/controller/create_job_controller.dart';
import '../../create_jobs/views/create_job_view_first.dart';
import '../controller/job_controller.dart';
import '../controller/jobs_controller.dart';
import '../model/job_post_model.dart';
import '../../../../shared/bottom_sheets/description_detail_bottom_sheet.dart';
import 'job_booker_applications_homepage.dart';

class JobDetailPageUpdated extends ConsumerStatefulWidget {
  final JobPostModel job;

  const JobDetailPageUpdated({
    Key? key,
    required this.job,
  }) : super(key: key);

  @override
  ConsumerState<JobDetailPageUpdated> createState() =>
      _JobDetailPageUpdatedState();
}

class _JobDetailPageUpdatedState extends ConsumerState<JobDetailPageUpdated> {
  bool isSaved = false;
  int saves = 0;

  Duration _maxDuration = Duration.zero;
  bool isCurrentUser = false;
  bool tempIsExpired = false;

  @override
  void initState() {
    super.initState();

    for (var item in widget.job.jobDelivery) {
      _maxDuration += item.dateDuration;
    }
  }

  @override
  Widget build(BuildContext context) {
    print("jobId ${widget.job.id}");
    final jobDetail = ref.watch(jobDetailProvider(widget.job.id));
    final similarJobs =
        ref.watch(similarJobsProvider(int.parse(widget.job.id)));
    final recentlyViewedJobs = ref.watch(recentlyViewedJobsProvider);
    final currentUser = ref.watch(appUserProvider).valueOrNull;
    isCurrentUser = ref
        .read(appUserProvider.notifier)
        .isCurrentUser(jobDetail.value?.creator!.username);
    final userJobs = ref.watch(userJobsProvider(widget.job.creator!.username));
    return jobDetail.when(data: (value) {
      if (value != null) {
        saves = value.saves!;
        isSaved = value.userSaved!;
        return Scaffold(
            appBar: VWidgetsAppBar(
              elevation: 0,
              // backgroundColor: VmodelColors.white,
              // centerTitle: true,
              titleWidget: Text(
                'Details',
                style: Theme.of(context).textTheme.displayMedium!.copyWith(
                      fontWeight: FontWeight.w600,
                      // color: Theme.of(context).primaryColor,
                    ),
              ),

              leadingIcon: const VWidgetsBackButton(),
              trailingIcon: [
                IconButton(
                  icon: isCurrentUser
                      ? const RenderSvg(svgPath: VIcons.galleryEdit)
                      : NormalRenderSvgWithColor(
                          svgPath: VIcons.viewOtherProfileMenu,
                          color: Theme.of(context).iconTheme.color,
                        ),
                  onPressed: () {
                    //Menu settings
                    if (isCurrentUser) {
                      _showJobCreatorBottomSheet(context,
                          hasApplicants:
                              (value.applicationSet?.isNotEmpty ?? false));
                    } else {
                      _showJobViewerBottomSheet(context);
                    }
                  },
                ),
              ],
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // SectionContainer(
                  //   // height: 100,
                  //   // width: double.maxFinite,
                  //   // padding: const EdgeInsets.all(16),
                  //   topRadius: 16,
                  //   bottomRadius: 0,
                  //   child: Text(
                  //     value.jobTitle,
                  //     textAlign: TextAlign.center,
                  //     style: Theme.of(context).textTheme.displayLarge!.copyWith(
                  //           fontSize: 19,
                  //           fontWeight: FontWeight.w600,
                  //           // color: VmodelColors.primaryColor,
                  //         ),
                  //   ),
                  // ),
                  // addVerticalSpacing(2),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Row(
                      //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            navigateToRoute(
                              context,
                              OtherProfileRouter(
                                  username: "${value.creator?.username}"),
                            );
                          },
                          child: ProfilePicture(
                            showBorder: false,
                            displayName: '${value.creator?.displayName}',
                            url: value.creator?.profilePictureUrl,
                            headshotThumbnail: value.creator?.thumbnailUrl,
                            size: 56,
                          ),
                        ),
                        addHorizontalSpacing(10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () {
                                navigateToRoute(
                                    context,
                                    OtherUserProfile(
                                        username:
                                            "${value.creator?.username}"));
                              },
                              child: Text(
                                "${value.creator?.username}",
                                style: Theme.of(context)
                                    .textTheme
                                    .displayMedium!
                                    .copyWith(
                                      fontWeight: FontWeight.w600,
                                      // color: VmodelColors.primaryColor,
                                    ),
                              ),
                            ),
                            addVerticalSpacing(4),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const RenderSvg(
                                  svgPath: VIcons.star,
                                  svgHeight: 12,
                                  svgWidth: 12,
                                  // color: VmodelColors.primaryColor,
                                ),
                                addHorizontalSpacing(4),
                                Text(
                                  '4.5',
                                  style: Theme.of(context)
                                      .textTheme
                                      .displaySmall!
                                      .copyWith(
                                        fontWeight: FontWeight.w600,
                                        // color: VmodelColors.primaryColor,
                                      ),
                                ),
                                addHorizontalSpacing(4),
                                Text('(25)',
                                    style:
                                        Theme.of(context).textTheme.displaySmall
                                    // !
                                    // .copyWith(color: VmodelColors.primaryColor,),
                                    ),
                              ],
                            ),
                            addVerticalSpacing(4),
                            if (value.creator?.location?.locationName != null)
                              Text(
                                value.creator?.location?.locationName ?? '',
                                style: Theme.of(context)
                                    .textTheme
                                    .displaySmall!
                                    .copyWith(
                                      fontWeight: FontWeight.w500,
                                      color:
                                          //  VmodelColors.primaryColor
                                          //     .withOpacity(0.5),
                                          Theme.of(context)
                                              .textTheme
                                              .displaySmall
                                              ?.color
                                              ?.withOpacity(0.5),
                                    ),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  addVerticalSpacing(20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      value.jobTitle,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.displayLarge!.copyWith(
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                            // color: VmodelColors.primaryColor,
                          ),
                    ),
                  ),
                  addVerticalSpacing(20),
                  DescriptionText(
                    readMore: () {
                      _showBottomSheet(
                        context,
                        briefLink: value.briefLink,
                        content: value.shortDescription,
                        title: 'Description',
                      );
                    },
                    text: value.shortDescription,
                  ),
                  addVerticalSpacing(10),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          value.createdAt.getSimpleDate(),
                          style: Theme.of(context)
                              .textTheme
                              .displaySmall!
                              .copyWith(
                                fontWeight: FontWeight.w500,
                                fontSize: 13,
                                color: // VmodelColors.primaryColor.withOpacity(0.5),
                                    Theme.of(context)
                                        .textTheme
                                        .displaySmall
                                        ?.color
                                        ?.withOpacity(0.5),
                              ),
                        ),
                        addHorizontalSpacing(8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const RenderSvg(
                              svgPath: VIcons.jobDetailApplicants,
                              svgHeight: 20,
                              svgWidth: 20,
                            ),
                            addHorizontalSpacing(8),
                            GestureDetector(
                              onTap: () {
                                bool isCurrentUser = false;
                                isCurrentUser = ref
                                    .read(appUserProvider.notifier)
                                    .isCurrentUser(value.creator!.username);
                                if (isCurrentUser)
                                  navigateToRoute(
                                    context,
                                    JobBookerApplicationsHomepage(
                                      // jobId: int.parse(widget.job.id),
                                      job: value,
                                    ),
                                  );
                              },
                              child: Text(
                                '${value.applicationSet?.length ?? 0} offers',
                                style: Theme.of(context)
                                    .textTheme
                                    .displayMedium!
                                    .copyWith(
                                      fontWeight: FontWeight.w500,
                                      // color: VmodelColors.primaryColor,
                                    ),
                              ),
                            ),
                          ],
                        ),
                        // iconText(
                        //     assetIcon: VIcons.jobDetailGender,
                        //     text: value.preferredGender.capitalizeFirstVExt),
                      ],
                    ),
                  ),
                  addVerticalSpacing(10),
                  Divider(),

                  addVerticalSpacing(2),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (!value.category.isEmptyOrNull)
                        _jobPersonRow(context,
                            field: 'Category', value: '${value.category}'),
                      _jobPersonRow(context,
                          field: 'Looking for a', value: value.talents.first),
                      _jobPersonRow(context,
                          field: 'Location', value: value.jobType),
                      if (value.jobType.toLowerCase() != "remote")
                        _jobPersonRow(context,
                            field: 'Address',
                            value: value.jobLocation.locationName),
                      _datesRow(context,
                          field: 'Job date', value: value.jobDelivery),
                      _jobPersonRow(context,
                          field: 'Gender',
                          value: value.preferredGender.capitalizeFirstVExt),
                      _jobPersonRow(
                        context,
                        field: 'Status',
                        value:
                            value.processing ? 'Processing' : "${value.status}",
                      ),
                      addVerticalSpacing(10),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          // mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            if (value.hasBrief) addHorizontalSpacing(16),
                            if (value.hasBrief)
                              VWidgetsOutlinedButton(
                                buttonText: 'Read brief',
                                onPressed: () {
                                  _showBottomSheet(context,
                                      title: 'Creative Brief',
                                      content: value.brief ?? '',
                                      briefLink: value.briefLink);
                                },
                              ),
                          ],
                        ),
                      ),
                      _jobPersonRow(
                        context,
                        field: 'Accepting multiple applicants',
                        value: value.acceptingMultipleApplicants ? 'Yes' : "No",
                      ),
                      addVerticalSpacing(10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Divider(),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          addVerticalSpacing(16),
                          _headingText(context, title: 'Price'),
                          addVerticalSpacing(16),
                          _priceDetails(context, value),
                          addVerticalSpacing(32),
                        ]),
                  ),

                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (value.isDigitalContent)
                        _jobPersonRow(context,
                            field: 'Content license',
                            value:
                                '${value.usageType?.name.capitalizeFirstVExt}'),

                      if (value.isDigitalContent)
                        _jobPersonRow(context,
                            field: 'Content license length',
                            value:
                                '${value.usageLength?.name.capitalizeFirstVExt}'),

                      if (value.ethnicity != null)
                        _jobPersonRow(context,
                            field: 'Ethnicity',
                            value: '${value.ethnicity?.simpleName}'),

                      if (value.size != null)
                        _jobPersonRow(context,
                            field: 'Size', value: '${value.size?.simpleName}'),

                      if (value.talentHeight != null)
                        _jobPersonRow(context,
                            field: 'Height',
                            value:
                                "${value.talentHeight!['value']}${value.talentHeight!['unit']}"),

                      if (value.minAge > 0)
                        _jobPersonRow(context,
                            field: 'Age',
                            value: "${value.minAge}-${value.maxAge} years old"),
                      // _jobPersonRow(context,
                      //     field: '', value: 'Photographer'),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Text(
                                'Deliverables',
                                style: Theme.of(context)
                                    .textTheme
                                    .displayMedium!
                                    .copyWith(
                                      fontWeight: FontWeight.w600,
                                      height: 1.7,
                                      // color: VmodelColors.primaryColor,
                                      // fontSize: 12,
                                    ),
                              ),
                            ),
                            addHorizontalSpacing(16),
                            VWidgetsOutlinedButton(
                              buttonText: 'Read',
                              padding: EdgeInsets.zero,
                              buttonTitleTextStyle: Theme.of(context)
                                  .textTheme
                                  .displayMedium!
                                  .copyWith(
                                    fontWeight: FontWeight.w500,

                                    // color: VmodelColors.primaryColor,
                                    // fontSize: 12,
                                  ),
                              onPressed: () {
                                _showBottomSheet(
                                  context,
                                  title: 'Deliverables',
                                  content: value.deliverablesType,
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  addVerticalSpacing(32),
                  if (!tempIsExpired && !isCurrentUser) addVerticalSpacing(32),
                  if (!tempIsExpired && !isCurrentUser)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: VWidgetsPrimaryButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: ((context) => VWidgetsApplyPopUp(
                                    popupTitle: "Proposed Rate",
                                    onPressedApply: (value) async {
                                      if (tempIsExpired || isCurrentUser) {
                                        VWidgetShowResponse.showToast(
                                            ResponseEnum.warning,
                                            message: "Cannot apply for job.");
                                        return;
                                      }

                                      await ref
                                          .read(jobsProvider.notifier)
                                          .applyForJob(
                                              jobId: int.parse(widget.job.id),
                                              proposedPrice: value);

                                      ref.invalidate(
                                          jobDetailProvider(widget.job.id));
                                      if (context.mounted) {
                                        goBack(context);
                                      }
                                    },
                                  )));
                        },
                        buttonTitle: 'Apply',
                        enableButton: value != null
                            ? !value.hasUserApplied("${currentUser?.username}")
                            : true,
                      ),
                    ),
                  addVerticalSpacing(32),
                  if (currentUser?.username != widget.job.creator?.username)
                    userJobs.when(
                      data: (data) {
                        if (data.isEmpty) return SizedBox.shrink();
                        return JobSubList(
                          isCurrentUser: isCurrentUser,
                          items: data,
                          onViewAllTap: () => navigateToRoute(
                              context,
                              SubAllJobs(
                                jobs: data,
                                title: "All jobs",
                              )),
                          onTap: (value) {},
                          title: 'More jobs by this user',
                          username: '',
                        );
                      },
                      error: (Object error, StackTrace stackTrace) {
                        return Text("Error");
                      },
                      loading: () {
                        return CircularProgressIndicator.adaptive();
                      },
                    ),
                  if (currentUser?.username != widget.job.creator?.username)
                    similarJobs.when(
                      data: (data) {
                        if (data.isEmpty) return SizedBox.shrink();
                        return JobSubList(
                          isCurrentUser: isCurrentUser,
                          items: data,
                          onViewAllTap: () => navigateToRoute(
                              context,
                              SubAllJobs(
                                jobs: data,
                                title: "Similar jobs",
                              )),
                          onTap: (value) {},
                          title: 'Similar jobs',
                          username: '',
                        );
                      },
                      error: (Object error, StackTrace stackTrace) {
                        return Text("Error");
                      },
                      loading: () {
                        return CircularProgressIndicator.adaptive();
                      },
                    ),
                  if (currentUser?.username != widget.job.creator?.username)
                    recentlyViewedJobs.when(
                      data: (data) {
                        if (data.isEmpty) return SizedBox.shrink();
                        return JobSubList(
                          isCurrentUser: isCurrentUser,
                          items: data,
                          onViewAllTap: () => navigateToRoute(
                              context,
                              SubAllJobs(
                                jobs: data,
                                title: "Recently viewed jobs",
                              )),
                          onTap: (value) {},
                          title: 'Recently viewed jobs',
                          username: '',
                        );
                      },
                      error: (Object error, StackTrace stackTrace) {
                        return Text("Error");
                      },
                      loading: () {
                        return CircularProgressIndicator.adaptive();
                      },
                    ),
                  addVerticalSpacing(32),
                ],
              ),
            ));
      }
      return Scaffold(
        appBar: VWidgetsAppBar(
          elevation: 0,
          // backgroundColor: VmodelColors.white,
          // centerTitle: true,
          titleWidget: Text(
            'Details',
            style: Theme.of(context).textTheme.displayMedium!.copyWith(
                  fontWeight: FontWeight.w600,
                  // color: Theme.of(context).primaryColor,
                ),
          ),

          leadingIcon: const VWidgetsBackButton(),
        ),
        body: Center(
          child: Text("This job does not exist"),
        ),
      );
    }, error: ((error, stackTrace) {
      print('$error \n $stackTrace');
      return const EmptyPage(
          svgPath: VIcons.aboutIcon,
          svgSize: 24,
          subtitle: "Error occured fetching job details");
    }), loading: () {
      return Scaffold(
          body: Center(child: const CircularProgressIndicator.adaptive()));
    });
  }

  bool _isFieldNotNullOrEmpty(
    dynamic attribute,
  ) {
    if (attribute is String?) return !attribute.isEmptyOrNull;
    return attribute != null;
  }

  Future<void> _showJobViewerBottomSheet(BuildContext context) {
    return showModalBottomSheet<void>(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (BuildContext context) {
          return Container(
            padding: const EdgeInsets.only(left: 16, right: 16),
            decoration: BoxDecoration(
              // color: VmodelColors.appBarBackgroundColor,
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(13),
                topRight: Radius.circular(13),
              ),
            ),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  addVerticalSpacing(15),
                  const Align(
                      alignment: Alignment.center, child: VWidgetsModalPill()),
                  addVerticalSpacing(25),
                  _optionItem(context, title: "Share"),
                  const Divider(thickness: 0.5),
                  _optionItem(context, title: "Save"),
                  const Divider(thickness: 0.5),
                  _optionItem(context, title: "Report"),
                  const Divider(thickness: 0.5),
                  addVerticalSpacing(40),
                ]),
          );
        });
  }

  Future<void> _showJobCreatorBottomSheet(BuildContext context,
      {required bool hasApplicants}) {
    return showModalBottomSheet<void>(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (BuildContext context) {
          return Consumer(builder: (context, ref, child) {
            final jobDetail =
                ref.watch(jobDetailProvider(widget.job.id)).valueOrNull;

            return Container(
              padding: const EdgeInsets.only(left: 16, right: 16),
              decoration: BoxDecoration(
                // color: VmodelColors.appBarBackgroundColor,
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(13),
                  topRight: Radius.circular(13),
                ),
              ),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    addVerticalSpacing(15),
                    const Align(
                        alignment: Alignment.center,
                        child: VWidgetsModalPill()),
                    if (!hasApplicants) addVerticalSpacing(25),
                    if (!hasApplicants)
                      _optionItem(
                        context,
                        title: "Edit",
                        onOptionTapped: () {
                          if (jobDetail == null) {
                            VWidgetShowResponse.showToast(ResponseEnum.warning,
                                message: "Cannot edit job");
                            return;
                          }
                          ref
                              .read(
                                  selectedDateTimeAndDurationProvider.notifier)
                              // .setAll(widget.job.jobDelivery);
                              .setAll(jobDetail.jobDelivery);
                          navigateToRoute(
                              context,
                              CreateJobFirstPage(
                                isEdit: true,
                                job: jobDetail,
                              ));
                        },
                      ),
                    const Divider(thickness: 0.5),
                    _optionItem(context, title: "Duplicate",
                        onOptionTapped: () async {
                      if (jobDetail == null) {
                        return;
                      }

                      VLoader.changeLoadingState(true);
                      final success = await ref
                          .read(selectedDateTimeAndDurationProvider.notifier)
                          .duplicateJob(data: jobDetail.duplicateDataMap());

                      if (success) {
                        //invalidate user jobs
                        await ref.refresh(userJobsProvider(null));
                        VLoader.changeLoadingState(false);
                        //invalidate main jobs page
                        ref.invalidate(jobsProvider);
                        print('[yyt] b4 if');
                        if (context.mounted) {
                          print('[yyt] Double pop');
                          Navigator.of(context)
                            ..pop()
                            ..pop();
                        }
                      } else {
                        VLoader.changeLoadingState(false);
                      }
                    }),
                    const Divider(thickness: 0.5),
                    _optionItem(context,
                        title: (jobDetail?.paused ?? false)
                            ? "Resume"
                            : "Pause", onOptionTapped: () async {
                      VLoader.changeLoadingState(true);
                      await ref
                          .read(jobDetailProvider(widget.job.id).notifier)
                          .pauseOrResumeJob(widget.job.id);
                      VLoader.changeLoadingState(false);
                      popSheet(context);
                    }),
                    const Divider(thickness: 0.5),
                    _optionItem(context, title: "Close",
                        onOptionTapped: () async {
                      VLoader.changeLoadingState(true);
                      final isSuccess = await ref
                          .read(jobDetailProvider(widget.job.id).notifier)
                          .closeJob(widget.job.id);
                      VLoader.changeLoadingState(false);
                      if (mounted && isSuccess) {
                        Navigator.of(context)
                          ..pop()
                          ..pop();
                      }
                    }),
                    const Divider(thickness: 0.5),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6.0),
                      child: GestureDetector(
                        onTap: () async {
                          VLoader.changeLoadingState(true);
                          final isSuccess = await ref
                              .read(userJobsProvider(null).notifier)
                              .deleteJob(jobDetail?.id);
                          if (mounted && isSuccess) {
                            Navigator.of(context)
                              ..pop()
                              ..pop();
                          }
                          VLoader.changeLoadingState(false);
                        },
                        child: Text('Delete Job',
                            style: Theme.of(context)
                                .textTheme
                                .displayMedium!
                                .copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: VmodelColors.error)),
                      ),
                    ),
                    addVerticalSpacing(40),
                  ]),
            );
          });
        });
  }

  Padding _optionItem(BuildContext context,
      {required String title, VoidCallback? onOptionTapped}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: GestureDetector(
        onTap: onOptionTapped,
        child: Text(
          title,
          style: Theme.of(context).textTheme.displayMedium!.copyWith(
                fontWeight: FontWeight.w600,
                // color: VmodelColors.primaryColor,
              ),
        ),
      ),
    );
  }

  Future<dynamic> _showBottomSheet(BuildContext context,
      {required String title, required String content, String? briefLink}) {
    return showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) {
          return DetailBottomSheet(
            title: title,
            content: content,
            briefLink: briefLink,
          );
        });
  }

  Text _headingText(BuildContext context, {required String title}) {
    return Text(
      title,
      style: Theme.of(context).textTheme.displayLarge!.copyWith(
            fontWeight: FontWeight.w600,
            // color: VmodelColors.primaryColor,
          ),
    );
  }

  Column _priceDetails(BuildContext context, JobPostModel job) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    VConstants.noDecimalCurrencyFormatterGB
                        .format(job.priceValue),
                    style: Theme.of(context).textTheme.displayLarge!.copyWith(
                          fontWeight: FontWeight.w600,
                          color: // VmodelColors.primaryColor.withOpacity(0.3),
                              Theme.of(context)
                                  .textTheme
                                  .displayLarge
                                  ?.color
                                  ?.withOpacity(0.3),
                        ),
                  ),
                  Text(
                    job.priceOption.tileDisplayName,
                    style: Theme.of(context).textTheme.displayLarge!.copyWith(
                          fontWeight: FontWeight.w500,
                          color: // VmodelColors.primaryColor.withOpacity(0.3),

                              Theme.of(context)
                                  .textTheme
                                  .displayLarge
                                  ?.color
                                  ?.withOpacity(0.3),
                        ),
                  )
                ],
              ),
            ),
            addHorizontalSpacing(4),
            Flexible(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  if (job.priceOption == ServicePeriod.hour)
                    Text(
                      // '8 x 300',
                      '${_maxDuration.dayHourMinuteSecondFormatted()} x ${job.priceValue.round()}',
                      style: Theme.of(context).textTheme.displayLarge!.copyWith(
                            fontWeight: FontWeight.w500,
                            color: // VmodelColors.primaryColor.withOpacity(0.3),

                                Theme.of(context)
                                    .textTheme
                                    .displayLarge
                                    ?.color
                                    ?.withOpacity(0.3),
                          ),
                    ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Text(
                        'Total',
                        textAlign: TextAlign.end,
                        style:
                            Theme.of(context).textTheme.displayLarge!.copyWith(
                                  fontWeight: FontWeight.w500,
                                  color: // VmodelColors.primaryColor.withOpacity(0.3),
                                      Theme.of(context)
                                          .textTheme
                                          .displayLarge
                                          ?.color
                                          ?.withOpacity(0.3),
                                ),
                      ),
                      addHorizontalSpacing(8),
                      Flexible(
                        child: Text(
                          // '2,400',
                          job.priceOption == ServicePeriod.hour
                              ? VConstants.noDecimalCurrencyFormatterGB.format(
                                  getTotalPrice(
                                      _maxDuration, job.priceValue.toString()))
                              : VConstants.noDecimalCurrencyFormatterGB
                                  .format(job.priceValue),
                          textAlign: TextAlign.end,
                          style: Theme.of(context)
                              .textTheme
                              .displayLarge!
                              .copyWith(
                                fontWeight: FontWeight.w600,
                                fontSize: 24,
                                // color: VmodelColors.primaryColor
                              ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            )
          ],
        )
      ],
    );
  }

  Widget _datesRow(BuildContext context,
      {required String field, required List<JobDeliveryDate> value}) {
    final now = DateTime.now();

    String output = '';
    if (value.length > 1) {
      final firstDate = value.first.date;
      final lastDate = value.last.date;
      final int differenceInDays = (lastDate.difference(now)).inDays;
      print('[xjos] ${differenceInDays}');
      if (differenceInDays < 0) {
        output = "Expired";
        tempIsExpired = true;
        setState(() {});
      } else if (firstDate.year == lastDate.year) {
        if (firstDate.month == lastDate.month) {
          output = VConstants.dayDateFormatter.format(firstDate);
        } else {
          output = VConstants.dayMonthDateFormatter.format(firstDate);
        }
      } else {
        output = VConstants.simpleDateFormatter.format(firstDate);
      }
      output = '$output-${VConstants.simpleDateFormatter.format(lastDate)}';
    } else {
      output = VConstants.simpleDateFormatter.format(value.first.date);
    }

    final int differenceInDays = (value.first.date.difference(now)).inDays;
    print('[xjos] ${differenceInDays}');
    if (differenceInDays < 0) {
      output = "Expired";
    }
    return _jobPersonRow(context, field: field, value: output);
  }

  Widget _jobPersonRow(BuildContext context,
      {required String field, required String value}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            field,
            style: Theme.of(context).textTheme.displayMedium!.copyWith(
                  fontWeight: FontWeight.w600,
                  height: 1.7,
                  // color: VmodelColors.primaryColor,
                  // fontSize: 12,
                ),
          ),
          addHorizontalSpacing(32),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: Theme.of(context).textTheme.displayMedium!.copyWith(
                    fontWeight: FontWeight.w500,
                    height: 1.7,
                    // color: VmodelColors.primaryColor,
                    // fontSize: 12,
                  ),
            ),
          ),
        ],
      ),
    );
  }

  Widget iconText({required String assetIcon, required String text}) {
    return Row(
      children: [
        RenderSvg(svgPath: assetIcon, svgHeight: 16, svgWidth: 16),
        addHorizontalSpacing(8),
        Text(
          text,
          style: Theme.of(context).textTheme.displayMedium!.copyWith(
                fontWeight: FontWeight.w600,
                height: 1.7,
                // color: VmodelColors.primaryColor,
                // fontSize: 12,
              ),
        ),
      ],
    );
  }
}
