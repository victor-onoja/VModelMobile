import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vmodel/src/features/dashboard/new_profile/controller/block_user_controller.dart';
import 'package:vmodel/src/features/dashboard/new_profile/other_user_profile/other_user_profile_connections.dart';
import 'package:vmodel/src/features/dashboard/new_profile/other_user_profile/widgets/block_user_widget.dart';
import 'package:vmodel/src/features/dashboard/new_profile/other_user_profile/widgets/report_account_popUp_widget.dart';
import 'package:vmodel/src/features/dashboard/profile/controller/profile_controller.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/res/ui_constants.dart';
import 'package:vmodel/src/vmodel.dart';

import '../../../../../core/utils/enum/album_type.dart';
import '../../../../../shared/bottom_sheets/confirmation_bottom_sheet.dart';
import '../../../../../shared/bottom_sheets/tile.dart';
import '../../../../../shared/modal_pill_widget.dart';
import '../../../../print/controller/print_gallery_controller.dart';
import '../../../../print/views/print_profile.dart';

class VWidgetsOtherUserProfileFunctionality extends ConsumerStatefulWidget {
  final String username;
  final String? connectionStatus;
  final bool isPostNotificationOn;
  final bool isJobNotificationOn;
  final bool isCouponNotificationOn;
  const VWidgetsOtherUserProfileFunctionality({
    required this.isPostNotificationOn,
    required this.isJobNotificationOn,
    required this.isCouponNotificationOn,
    required this.username,
    required this.connectionStatus,
    super.key,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _VWidgetsOtherUserProfileFunctionalityState();
}

class _VWidgetsOtherUserProfileFunctionalityState
    extends ConsumerState<VWidgetsOtherUserProfileFunctionality> {
  bool userBlock = false;
  bool isPostNotificationOn = false;
  bool isJobNotificationOn = false;
  bool isCouponNotificationOn = false;

  @override
  void initState() {
    isPostNotificationOn = widget.isPostNotificationOn;
    isCouponNotificationOn = widget.isCouponNotificationOn;
    isJobNotificationOn = widget.isJobNotificationOn;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userState = ref.watch(profileProvider(widget.username));
    final user = userState.valueOrNull;
    final blockedUsers = ref.watch(blockUserProvider);
    bool isBlocked = ref.watch(isUserBlockedProvider(widget.username));

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          addVerticalSpacing(15),
          const Align(alignment: Alignment.center, child: VWidgetsModalPill()),
          addVerticalSpacing(24),
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 6.0),
              child: Text("Network",
                  style: Theme.of(context).textTheme.displayMedium!.copyWith(
                        fontWeight: FontWeight.w600,
                        // color: VmodelColors.primaryColor,
                      ))),
          addVerticalSpacing(10),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 6.0),
            child: GestureDetector(
              onTap: () {
                if (widget.connectionStatus == 'no_connection') {
                } else if (user?.allowConnectionView == true) {
                  navigateToRoute(
                      context,
                      OtherUserProfileConnect(
                        username: widget.username,
                      ));
                } else {}
              },
              child: widget.connectionStatus == 'no_connection'
                  ? Text('View Connections',
                      style:
                          Theme.of(context).textTheme.displayMedium!.copyWith(
                                fontWeight: FontWeight.normal,
                                // color: VmodelColors.greyColor,
                              ))
                  : user?.allowConnectionView == true
                      ? Text('View Connections',
                          style: Theme.of(context)
                              .textTheme
                              .displayMedium!
                              .copyWith(
                                fontWeight: FontWeight.normal,
                                // color: Theme.of(context).primaryColor,
                              ))
                      : Text('View Connections',
                          style: Theme.of(context)
                              .textTheme
                              .displayMedium!
                              .copyWith(
                                fontWeight: FontWeight.normal,
                                // color: VmodelColors.greyColor,
                              )),
            ),
            // GestureDetector(
            //   onTap: () {
            //     navigateToRoute(context,
            //         OtherUserProfileConnect(username: widget.username));
            //   },
            //   child: Text('View Connections',
            //       style: Theme.of(context).textTheme.displayMedium!.copyWith(
            //             fontWeight: FontWeight.w600,
            //             color: Theme.of(context).primaryColor,
            //           )),
            // ),
          ),
          addVerticalSpacing(10),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 6.0),
            child: GestureDetector(
                onTap: () {
                  HapticFeedback.lightImpact();
                  if (user.isFollowing!) {
                    ref
                        .read(profileProvider(widget.username).notifier)
                        .unFollowUser(widget.username);
                  } else {
                    ref
                        .read(profileProvider(widget.username).notifier)
                        .followUser(widget.username);
                  }
                  popSheet(context);
                },
                child:
                    // widget.connectionStatus == 'no_connection'
                    //     ?
                    Text(user!.isFollowing! ? "Unfollow" : 'Follow',
                        style:
                            Theme.of(context).textTheme.displayMedium!.copyWith(
                                  fontWeight: FontWeight.normal,
                                  // color: VmodelColors.primaryColor,
                                ))
                // : user?.allowConnectionView == true
                //     ? Text('View Connections',
                //         style:
                //             Theme.of(context).textTheme.displayMedium!.copyWith(
                //                   fontWeight: FontWeight.normal,
                //                   color: Theme.of(context).primaryColor,
                //                 ))
                //     : Text('View Connections',
                //         style:
                //             Theme.of(context).textTheme.displayMedium!.copyWith(
                //                   fontWeight: FontWeight.normal,
                //                   color: VmodelColors.greyColor,
                //                 )),

                ),
            // GestureDetector(
            //   onTap: () {
            //     navigateToRoute(context,
            //         OtherUserProfileConnect(username: widget.username));
            //   },
            //   child: Text('View Connections',
            //       style: Theme.of(context).textTheme.displayMedium!.copyWith(
            //             fontWeight: FontWeight.w600,
            //             color: Theme.of(context).primaryColor,
            //           )),
            // ),
          ),
          addVerticalSpacing(10),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 6.0),
            child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);

                  printPortfolio(context);
                },
                child: Text('Print',
                    style: Theme.of(context).textTheme.displayMedium!.copyWith(
                          fontWeight: FontWeight.normal,
                          // color: VmodelColors.primaryColor,
                        ))),
          ),
          addVerticalSpacing(10),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 6.0),
            child: isBlocked
                ? GestureDetector(
                    onTap: () async {
                      Navigator.pop(context);
                      userBlock = await ref
                          .read(blockUserProvider.notifier)
                          .unBlockUser(userName: widget.username);
                      setState(() {});
                    },
                    child: Text('Un-Block',
                        style: Theme.of(context)
                            .textTheme
                            .displayMedium!
                            .copyWith(
                                fontWeight: FontWeight.normal,
                                color: const Color.fromRGBO(224, 44, 35, 1))),
                  )
                : GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      blockUserFinalModal(context);
                    },
                    child: Text('Block',
                        style:
                            Theme.of(context).textTheme.displayMedium!.copyWith(
                                  fontWeight: FontWeight.normal,
                                  // color: VmodelColors.primaryColor,
                                ))),
          ),
          addVerticalSpacing(10),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 6.0),
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
                reportUserFinalModal(context, user.profilePictureUrl);
              },
              child: Text('Report account',
                  style: Theme.of(context).textTheme.displayMedium!.copyWith(
                        fontWeight: FontWeight.normal,
                        // color: Theme.of(context).primaryColor,
                      )),
            ),
          ),
          addVerticalSpacing(25),
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 6.0),
              child: Text("Notifications",
                  style: Theme.of(context).textTheme.displayMedium!.copyWith(
                        fontWeight: FontWeight.w600,
                        // color: VmodelColors.primaryColor,
                      ))),
          addVerticalSpacing(10),
          // Padding(
          //   padding: const EdgeInsets.symmetric(vertical: 6.0),
          //   child: GestureDetector(
          //       onTap: () {
          //         isPostNotificationOn = !isPostNotificationOn;
          //         setState(() {});
          //       },
          //       child: Text(
          //           isPostNotificationOn
          //               ? 'Turn off post notifications'
          //               : 'Turn on post notifications',
          //           style: Theme.of(context).textTheme.displayMedium!.copyWith(
          //               fontWeight: FontWeight.normal,
          //               color: VmodelColors.primaryColor))),
          // ),
          // addVerticalSpacing(10),
          // Padding(
          //   padding: const EdgeInsets.symmetric(vertical: 6.0),
          //   child: GestureDetector(
          //       onTap: () {
          //         isJobNotificationOn = !isJobNotificationOn;
          //         setState(() {});
          //       },
          //       child: Text(
          //           isJobNotificationOn
          //               ? 'Turn on job notifications'
          //               : 'Turn off job notifications',
          //           style: Theme.of(context).textTheme.displayMedium!.copyWith(
          //               fontWeight: FontWeight.normal,
          //               color: VmodelColors.primaryColor))),
          // ),
          // addVerticalSpacing(5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Post notifications',
                  style: Theme.of(context).textTheme.displayMedium!.copyWith(
                        fontWeight: FontWeight.normal,
                        // color: VmodelColors.primaryColor,
                      )),
              Switch.adaptive(
                  activeColor: UIConstants.switchActiveColor(context),
                  value: isPostNotificationOn,
                  onChanged: (value) {
                    isPostNotificationOn = value;
                    setState(() {});
                    ref
                        .read(profileProvider(user.username).notifier)
                        .toggleFollowingNotification(
                          notifyOnCoupon: isCouponNotificationOn,
                          notifyOnJob: isJobNotificationOn,
                          notifyOnPost: isPostNotificationOn,
                          username: user.username,
                        );
                  }),
            ],
          ),
          // addVerticalSpacing(5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Job notifications',
                  style: Theme.of(context).textTheme.displayMedium!.copyWith(
                        fontWeight: FontWeight.normal,
                        // color: VmodelColors.primaryColor
                      )),
              Switch.adaptive(
                  activeColor: UIConstants.switchActiveColor(context),
                  value: isJobNotificationOn,
                  onChanged: (value) {
                    isJobNotificationOn = value;

                    setState(() {});
                    ref
                        .read(profileProvider(user.username).notifier)
                        .toggleFollowingNotification(
                          notifyOnCoupon: isCouponNotificationOn,
                          notifyOnJob: isJobNotificationOn,
                          notifyOnPost: isPostNotificationOn,
                          username: user.username,
                        );
                  }),
            ],
          ),
          // addVerticalSpacing(5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Coupons notifications',
                  style: Theme.of(context).textTheme.displayMedium!.copyWith(
                        fontWeight: FontWeight.normal,
                      )),
              Switch.adaptive(
                  activeColor: UIConstants.switchActiveColor(context),
                  value: isCouponNotificationOn,
                  onChanged: (value) {
                    isCouponNotificationOn = value;
                    setState(() {});
                    ref
                        .read(profileProvider(user.username).notifier)
                        .toggleFollowingNotification(
                          notifyOnCoupon: isCouponNotificationOn,
                          notifyOnJob: isJobNotificationOn,
                          notifyOnPost: isPostNotificationOn,
                          username: user.username,
                        );
                  }),
            ],
          ),
          // addVerticalSpacing(5),
          // Padding(
          //   padding: const EdgeInsets.symmetric(vertical: 6.0),
          //   child: isBlocked
          //       ? GestureDetector(
          //           onTap: () async {
          //             userBlock = await ref
          //                 .read(blockUserProvider.notifier)
          //                 .unBlockUser(userName: widget.username);
          //             setState(() {});
          //           },
          //           child: Text('Un-Block',
          //               style: Theme.of(context)
          //                   .textTheme
          //                   .displayMedium!
          //                   .copyWith(
          //                       fontWeight: FontWeight.normal,
          //                       color: const Color.fromRGBO(224, 44, 35, 1))),
          //         )
          //       : GestureDetector(
          //           onTap: () {
          //             blockUserFinalModal(context);
          //           },
          //           child: Text('Block',
          //               style: Theme.of(context)
          //                   .textTheme
          //                   .displayMedium!
          //                   .copyWith(
          //                       fontWeight: FontWeight.w600,
          //                       color: VmodelColors.primaryColor))),
          // ),
          // addVerticalSpacing(5),

          addVerticalSpacing(40),
        ],
      ),
    );
  }

  Future<void> printPortfolio(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (context) {
          return Consumer(builder: (context, ref, _) {
            return Container(
              padding: const EdgeInsets.only(left: 16, right: 16),
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(13),
                  topRight: Radius.circular(13),
                ),
              ),
              child: VWidgetsConfirmationBottomSheet(
                actions: [
                  // Follow
                  VWidgetsBottomSheetTile(
                      onTap: () {
                        //Using string interpolation is intentional
                        ref
                            .read(printGalleryTypeFilterProvider(
                                    '${widget.username}')
                                .notifier)
                            .state = AlbumType.portfolio;
                        popSheet(context);
                        navigateToRoute(context,
                            PrintProfile(username: '${widget.username}'));
                      },
                      message: "Portfolio"),
                  const Divider(
                    thickness: 0.5,
                  ),

                  VWidgetsBottomSheetTile(
                      onTap: () async {
                        //Using string interpolation is intentional
                        ref
                            .read(printGalleryTypeFilterProvider(
                                    '${widget.username}')
                                .notifier)
                            .state = AlbumType.polaroid;
                        popSheet(context);
                        navigateToRoute(context,
                            PrintProfile(username: '${widget.username}'));
                      },
                      message: 'Polaroid')
                ],
              ),
            );
          });
        });
  }

  Future<void> blockUserFinalModal(BuildContext context) {
    return showModalBottomSheet<void>(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (BuildContext context) {
          return Container(
              padding: const EdgeInsets.only(left: 16, right: 16),
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(13),
                  topRight: Radius.circular(13),
                ),
              ),
              child: VWidgetsBlockUser(
                isCouponNotificationOn: widget.isCouponNotificationOn,
                isJobNotificationOn: widget.isJobNotificationOn,
                isPostNotificationOn: widget.isPostNotificationOn,
                username: widget.username,
                connectionStatus: widget.connectionStatus!,
              ));
        });
  }

  Future<void> reportUserFinalModal(
    BuildContext context,
    String? url,
  ) {
    return showModalBottomSheet<void>(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (BuildContext context) {
          return Container(
              padding: const EdgeInsets.only(left: 16, right: 16),
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(13),
                  topRight: Radius.circular(13),
                ),
              ),
              child: VWidgetsReportAccount(
                isCouponNotificationOn: widget.isCouponNotificationOn,
                isJobNotificationOn: widget.isJobNotificationOn,
                isPostNotificationOn: widget.isPostNotificationOn,
                username: widget.username,
                connectionStatus: widget.connectionStatus!,
              ));
        });
  }

  // Future<void> returnOtherUserFunction() {
  //   return showModalBottomSheet<void>(
  //       context: context,
  //       backgroundColor: Colors.transparent,
  //       builder: (BuildContext context) {
  //         return Container(
  //           padding: const EdgeInsets.only(left: 16, right: 16),
  //           decoration: const BoxDecoration(
  //             color: VmodelColors.appBarBackgroundColor,
  //             borderRadius: BorderRadius.only(
  //               topLeft: Radius.circular(13),
  //               topRight: Radius.circular(13),
  //             ),
  //           ),
  //           child: VWidgetsOtherUserProfileFunctionality(
  //               connectionStatus: widget.connectionStatus,
  //               username: widget.username),
  //         );
  //       });
  // }
}
