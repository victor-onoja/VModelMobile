import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:vmodel/src/core/utils/helper_functions.dart';
import 'package:vmodel/src/features/dashboard/profile/controller/profile_controller.dart';
import 'package:vmodel/src/features/jobs/job_market/controller/job_controller.dart';
import 'package:vmodel/src/features/jobs/job_market/model/job_post_model.dart';
import 'package:vmodel/src/res/icons.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/shared/appbar/appbar.dart';
import 'package:vmodel/src/shared/bottom_sheets/confirmation_bottom_sheet.dart';
import 'package:vmodel/src/shared/bottom_sheets/tile.dart';
import 'package:vmodel/src/shared/loader/full_screen_dialog_loader.dart';
import 'package:vmodel/src/shared/rend_paint/render_svg.dart';
import 'package:vmodel/src/vmodel.dart';

import '../../../../../../core/controller/app_user_controller.dart';
import '../../../../../../core/models/app_user.dart';
import '../../../../../../core/utils/costants.dart';
import '../../../../../../res/assets/app_asset.dart';
import '../../../../../../shared/modal_pill_widget.dart';
import '../../../../../jobs/job_market/views/job_detail_creative_updated.dart';
import '../../../../../jobs/job_market/widget/business_user/business_my_jobs_card.dart';
import '../../../../feed/widgets/share.dart';
import '../../../controller/user_jobs_controller.dart';

class UserJobsPage extends ConsumerStatefulWidget {
  const UserJobsPage({
    super.key,
    required this.username,
    this.showAppBar = true,
  });
  final String? username;
  final bool showAppBar;

  @override
  ConsumerState<UserJobsPage> createState() => UserJobsPageState();
}

class UserJobsPageState extends ConsumerState<UserJobsPage> {
  bool isCurrentUser = false;
  bool enableLargeTile = false;
  bool sortByRecent = true;
  @override
  void initState() {
    super.initState();
    isCurrentUser =
        ref.read(appUserProvider.notifier).isCurrentUser(widget.username);
  }

  @override
  Widget build(BuildContext context) {
    // final services = ref.watch(userServices(widget.username));
    VAppUser? user;
    if (isCurrentUser) {
      final appUser = ref.watch(appUserProvider);
      user = appUser.valueOrNull;
    } else {
      final appUser = ref.watch(profileProvider(widget.username));
      user = appUser.valueOrNull;
    }
    final requestUsername =
        ref.watch(userNameForApiRequestProvider('${widget.username}'));
    final userJobs = ref.watch(userJobsProvider(requestUsername));
    print('List of services');
    print(userJobs);
    return Scaffold(
      appBar: !widget.showAppBar
          ? null
          : VWidgetsAppBar(
              leadingIcon: const VWidgetsBackButton(),
              appbarTitle: isCurrentUser ? "My Jobs" : "User Jobs",
              trailingIcon: [
                GestureDetector(
                  onTap: () {
                    enableLargeTile == true
                        ? setState(() {
                            enableLargeTile = false;
                          })
                        : setState(() {
                            enableLargeTile = true;
                          });
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
                if (isCurrentUser)
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
                                    borderRadius: BorderRadius.only(
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
                                      GestureDetector(
                                        onTap: () {
                                          print("object");
                                          sortByRecent = true;
                                          if (mounted) setState(() {});
                                          if (context.mounted) goBack(context);
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 6.0,
                                          ),
                                          child: GestureDetector(
                                            child: Text(
                                              'Most Recent',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .displayMedium!
                                                  .copyWith(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Theme.of(context)
                                                          .primaryColor),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const Divider(thickness: 0.5),
                                      GestureDetector(
                                        onTap: () {
                                          sortByRecent = false;
                                          if (mounted) setState(() {});
                                          if (context.mounted) goBack(context);
                                        },
                                        child: Padding(
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
                                      ),
                                      addVerticalSpacing(40),
                                    ],
                                  ));
                            });
                      },
                      icon: const RenderSvg(
                        svgPath: VIcons.sort,
                      )),
                if (isCurrentUser)
                  addHorizontalSpacing(0)
                else
                  addHorizontalSpacing(10),
              ],
            ),
      body: userJobs.when(data: (items) {
        // sort services by created at date descending

        print('user service location ${user?.location?.locationName}');
        // return value.fold((p0) => Text(p0.message), (p0) {
        if (items.isEmpty) {
          return SingleChildScrollView(
            padding: const VWidgetsPagePadding.horizontalSymmetric(18),
            child: Column(
              children: [
                addVerticalSpacing(20),
                SizedBox(
                  height: MediaQuery.of(context).size.height *
                      0.7, // Expand to fill available space
                  child: Center(
                    child: Text(
                      'No jobs available',
                      style:
                          Theme.of(context).textTheme.displayMedium?.copyWith(
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
        items.sort((a, b) {
          var first = a.createdAt;
          var last = b.createdAt;
          if (sortByRecent) return first.compareTo(last);
          return last.compareTo(first);
        });
        return RefreshIndicator.adaptive(
          onRefresh: () async{
            HapticFeedback.lightImpact();
              ref.refresh(userJobsProvider(requestUsername).future);},
          child: ListView.separated(
            // shrinkWrap: true,
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            physics:
                AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
            itemCount: items.length,
            separatorBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Divider(),
              );
            },
            itemBuilder: (context, index) {
              var jobItem = items[index];
              // print('service value $item');
              // final displayPrice = (item['price'] as double);

              return Slidable(
                endActionPane: ActionPane(
                  extentRatio: isCurrentUser ? .2 : 0.5,
                  motion: const StretchMotion(),
                  children: [
                    if (!isCurrentUser)
                      SlidableAction(
                        onPressed: (context) {
                          showModalBottomSheet(
                            isScrollControlled: true,
                            isDismissible: true,
                            useRootNavigator: true,
                            backgroundColor: Colors.transparent,
                            context: context,
                            builder: (context) => ShareWidget(
                              shareLabel: 'Share Service',
                              shareTitle: "${jobItem.jobTitle}",
                              shareImage: VmodelAssets2.imageContainer,
                              shareURL:
                                  "Vmodel.app/job/tilly's-bakery-services",
                            ),
                          );
                        },
                        foregroundColor: Colors.white,
                        backgroundColor:
                            const Color.fromARGB(255, 224, 224, 224),
                        label: 'Share',
                      ),
                    if (!isCurrentUser)
                      SlidableAction(
                        onPressed: (context) async {
                          await ref
                              .read(jobDetailProvider(jobItem.id).notifier)
                              .saveJob(jobItem.id);
                        },
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.grey,
                        label: 'Save',
                      ),
                    
                    if (isCurrentUser)
                      SlidableAction(
                        onPressed: (context) {
                          deleteJobModalSheet(context, jobItem);
                        },
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.red,
                        label: 'Delete',
                      ),
                  ],
                ),
                child: VWidgetsBusinessMyJobsCard(
                  onItemTap: () {
                    navigateToRoute(
                        context, JobDetailPageUpdated(job: items[index]));
                  },
                  statusColor: jobItem.status.statusColor(jobItem.processing),
                  enableDescription: enableLargeTile,
                  profileImage: jobItem.creator!.profilePictureUrl,
                  jobPriceOption: jobItem.priceOption.tileDisplayName,
                  location: jobItem.jobType,
                  noOfApplicants: jobItem.noOfApplicants,
                  jobTitle: jobItem.jobTitle,
                  jobDescription: jobItem.shortDescription,
                  date: jobItem.createdAt.getSimpleDateOnJobCard(),
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
                ),
              );
            },
          ),
        );
      }, error: (err, stackTrace) {
        return Text('There was an error showing services $stackTrace');
      }, loading: () {
        return const Center(child: CircularProgressIndicator.adaptive());
      }),
    );
  }

  Future<dynamic> deleteJobModalSheet(BuildContext context, JobPostModel item) {
    return showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (context) {
          return Container(
            decoration: BoxDecoration(
              // color: VmodelColors.appBarBackgroundColor,
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(13),
                topRight: Radius.circular(13),
              ),
            ),
            child: VWidgetsConfirmationBottomSheet(
              actions: [
                VWidgetsBottomSheetTile(
                    onTap: () async {
                      VLoader.changeLoadingState(true);
                      await ref
                          .read(userJobsProvider(null).notifier)
                          .deleteJob(item.id);

                      VLoader.changeLoadingState(false);
                      if (mounted) {
                        // goBack(context);
                        Navigator.of(context)..pop();
                      }
                    },
                    message: 'Yes'),
                const Divider(thickness: 0.5),
                VWidgetsBottomSheetTile(
                    onTap: () {
                      popSheet(context);
                    },
                    message: 'No'),
                const Divider(thickness: 0.5),
              ],
            ),
          );
        });
  }
}
