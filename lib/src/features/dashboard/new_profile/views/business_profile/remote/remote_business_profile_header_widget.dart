import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vmodel/src/features/connection/controller/provider/connection_provider.dart';
import 'package:vmodel/src/features/dashboard/new_profile/profile_features/expanded_bio/expanded_bio_homepage.dart.dart';
import 'package:vmodel/src/features/dashboard/new_profile/profile_features/services/views/services_homepage.dart';
import 'package:vmodel/src/features/dashboard/profile/controller/profile_controller.dart';
import 'package:vmodel/src/features/messages/controller/messages_controller.dart';
import 'package:vmodel/src/features/messages/views/messages_chat_screen.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/shared/bottom_sheets/confirmation_bottom_sheet.dart';
import 'package:vmodel/src/vmodel.dart';

import '../../../../../../core/utils/browser_laucher.dart';
import '../../../../../../shared/bottom_sheets/picture_confirmation_bottom_sheet.dart';
import '../../../../../../shared/bottom_sheets/tile.dart';
import '../../../../../../shared/response_widgets/toast.dart';
import '../../../../../create_coupons/controller/create_coupon_controller.dart';
import '../../../../../reviews/views/reviews_view.dart';
import '../../../../../settings/views/booking_settings/controllers/service_packages_controller.dart';
import '../../../../feed/controller/new_feed_provider.dart';
import '../../../controller/user_jobs_controller.dart';
import '../../../widgets/business_profile_subinfo.dart';
import '../../../widgets/socials_bottom_sheet.dart';
import 'remote_business_profile_buttons.dart';
import '../../../widgets/popup_profile_picture.dart';
import '../../../widgets/profile_widget.dart';

final showConnectProvider = StateProvider((ref) => false);
final showRequestConnectionProvider = StateProvider((ref) => false);

class RemoteBusinessProfileHeaderWidget extends ConsumerStatefulWidget {
  const RemoteBusinessProfileHeaderWidget({
    super.key,
    required this.username,
    required this.connectionStatus,
    required this.connectionId,
    this.profilePictureUrl,
    required this.profilePictureUrlThumbnail,
  });

  final String username;
  final String? profilePictureUrl;
  final String? profilePictureUrlThumbnail;
  final String? connectionStatus;
  final int? connectionId;

  @override
  ConsumerState<RemoteBusinessProfileHeaderWidget> createState() =>
      _RemoteBusinessProfileHeaderWidgetState();
}

class _RemoteBusinessProfileHeaderWidgetState
    extends ConsumerState<RemoteBusinessProfileHeaderWidget> {
  bool isAccountActive = true;
  bool isBioEmpty = true;
  bool isUserPrivate = false;
  bool isConnected = false;

  privateUserBookingState() {
    setState(() {
      isUserPrivate = !isUserPrivate;
    });
  }

  @override
  Widget build(BuildContext context) {
    // final appUser = ref.watch(appUserProvider);
    final appUser = ref.watch(profileProvider(widget.username));
    final user = appUser.valueOrNull;
    final hasServicePackage = ref.watch(hasServiceProvider(widget.username));
    final hasCoupon = ref.watch(hasCouponProvider(widget.username));
    final userHasJob = ref.watch(hasJobsProvider("${user?.username}"));
    // final userHasJob =
    //     ref.watch(userHasJobProvider("${user?.username}")).valueOrNull ?? false;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        // color: Colors.white,
        color: Theme.of(context).scaffoldBackgroundColor,
      ),
      child: Padding(
        padding: const VWidgetsPagePadding.horizontalSymmetric(18),
        child: Wrap(
          crossAxisAlignment: WrapCrossAlignment.start,
          children: [
            // VWidgetsOtherUserProfileCard(
            VWidgetsProfileCard(
              profileImage: '${user?.profilePictureUrl}',
              profileImageThumbnail: '${user?.thumbnailUrl}',
              // mainBio: user?.bio,
              user: user,
              // mainBio: user?.bio,
              onWebsiteURLTap: () {
                VUtilsBrowserLaucher.lauchWebBrowserWithUrl("${user?.website}");
              },

              onTapExpandIcon: () {
                navigateToRoute(
                    context,
                    ExpandedBioHomepage(
                      username: widget.username,
                    ));
              },
              onTapProfile: () {
                showPopupHeadshot(
                    context, user?.profilePictureUrl, user?.thumbnailUrl);
              },
            ),
            addVerticalSpacing(12),

            /// For Sub info of profile

            VWidgetsBusinessProfileSubInfoDetails(
              isCurrentUser: false,
              stars: "4.9 (34)",
              address: user?.location?.locationName ?? '',
              // companyUrl: user?.website,
              hasCoupon: hasCoupon,
              hasJob: userHasJob,
              hasService: hasServicePackage,
              // onPressedCompanyURL: () {
              //   VUtilsBrowserLaucher.lauchWebBrowserWithUrl("${user?.website}");
              // },
              userName: user?.username,
              userType: user?.userType,
              onRatingTap: () {
                navigateToRoute(context, ReviewsUI());
              },
            ),

            // VWidgetsProfileSubInfoDetails(
            //   stars: "4.9",
            //   userRatingCount: "34",
            //   address: user?.location?.locationName ?? '',
            //   hasService: hasServicePackage,
            //   hasCoupon: hasCoupon,
            //   userName: '${user?.username}',
            //   userType: user?.userType,
            // ),

            // VWidgetsProfileSubInfoDetails(
            //   stars: "4.9",
            //   userRatingCount: "34",
            //   address: user?.location?.locationName ?? '',
            //   hasService: hasServicePackage,
            //   hasCoupon: hasCoupon,
            //   userName: '${user?.username}',
            //   userType: user?.userType,
            // ),

            addVerticalSpacing(12),

            VWidgetsOtherBusinessProfileButtons(
              username: widget.username,
              enableSocialButton: user?.socials?.hasSocial,
              // connectionStatus: widget.connectionStatus,
              connectOnPressed: () {
                // navigateToRoute(context, const NetworkPage());
                ref
                    .read(connectionProvider)
                    .updateConnection(true, user?.connectionId ?? -1);
                ref.refresh(profileProvider(widget.username));
                ref.read(showConnectProvider.notifier).state = true;
                ref.refresh(profileProvider(widget.username));
                ref.invalidate(mainFeedProvider);
              },
              removeOnPressed: () {
                HapticFeedback.lightImpact();
                ref.read(showConnectProvider.notifier).state = false;
              },
              requestConnectOnPressed: () {
                showModalBottomSheet(
                    context: context,
                    backgroundColor: Colors.transparent,
                    builder: (context) {
                      return Container(
                        padding: const EdgeInsets.only(left: 16, right: 16),
                        decoration: BoxDecoration(
                          // color: VmodelColors.appBarBackgroundColor,
                          color: context.theme.scaffoldBackgroundColor,
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
                                  HapticFeedback.lightImpact();
                                  ref
                                      .read(profileProvider(widget.username)
                                          .notifier)
                                      .followUser(widget.username);
                                },
                                message: 'Follow'),
                            const Divider(
                              thickness: 0.5,
                            ),
                            // Connect
                            VWidgetsBottomSheetTile(
                                onTap: () {
                                  HapticFeedback.lightImpact();
                                  popSheet(context);
                                  ref
                                      .read(connectionProvider)
                                      .requestConnection(user!.username);
                                  ref.refresh(profileProvider(widget.username));
                                  // navigateToRoute(context, const NetworkPage());
                                  ref
                                      .read(showRequestConnectionProvider
                                          .notifier)
                                      .state = true;
                                  ref.refresh(profileProvider(widget.username));
                                  ref.invalidate(mainFeedProvider);
                                },
                                message: 'Connect')
                          ],
                        ),
                      );
                    });
              },
              removeRequestOnPressed: () {
                //now
                _removeConnectionConfirmation(context);

                // print(widget.connectionId);
                // ref.read(connectionProvider).deleteConnection(
                //     int.parse(widget.connectionId!.toString().trim()));
                // ref.refresh(profileProvider(widget.username));
                // ref.read(showRequestConnectionProvider.notifier).state = false;
                // ref.refresh(profileProvider(widget.username));
              },
              // connected: ref.read(showConnectProvider.notifier).state,
              requestCnnection:
                  ref.read(showRequestConnectionProvider.notifier).state,
              messagesOnPressed: () async {
                await ref
                    .watch(messageProvider)
                    .createChat(user!.username, widget.username);
                final prefs = await SharedPreferences.getInstance();
                int? id = prefs.getInt('id');
                ref.refresh(getConversation(id!));
                if (context.mounted) {
                  navigateToRoute(
                      context,
                      MessagesChatScreen(
                        id: id,
                        profilePicture: user.profilePictureUrl,
                        username: widget.username,
                        label: user.label,
                      ));
                }
                // navigateToRoute(context, const MessagingHomePage());
              },
              servicesOnPressed: () {
                navigateToRoute(
                    context,
                    ServicesHomepage(
                      username: user?.username,
                    ));
              },
              socialAccountsOnPressed: () async {
                if (user?.socials != null && user!.socials!.hasSocial) {
                  showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      builder: (context) {
                        return SocialsBottomSheet(
                          title: 'Socials',
                          userSocials: user.socials!,
                        );
                      });
                } else {
                  VWidgetShowResponse.showToast(ResponseEnum.warning,
                      message: "No socials available");
                }
                // showDialog(
                //     context: context,
                //     builder: ((context) =>
                //         _socialAccountsOnPressed(context, user?.socials)));
              },
              connectionStatus: '${user?.connectionStatus}',
            ),

            addVerticalSpacing(5),
          ],
        ),
      ),
    );
  }

  void showPopupHeadshot(
      BuildContext context, String? url, String? thumbnailUrl) {
    showGeneralDialog(
        barrierColor: Colors.black.withOpacity(0.5),
        transitionBuilder: (context, a1, a2, widget) {
          return AlignTransition(
            alignment: Tween<AlignmentGeometry>(
                    begin: const Alignment(-3.7, -1.1), end: Alignment.center)
                .animate(a1),
            child: ScaleTransition(
              scale: Tween<double>(begin: 0, end: 1.0).animate(a1),
              child: FadeTransition(
                opacity: Tween<double>(begin: 0, end: 1.0).animate(a1),
                child: PopupHeadshot(
                  url: url,
                  thumbnailUrl: thumbnailUrl,
                ),
              ),
            ),
          );
          // return AnimatedContainer(
          //   duration: Duration(milliseconds: 300),
          //   width: ,
          //   child: PopupHeadshot(url: url),
          // );
        },
        transitionDuration: const Duration(milliseconds: 200),
        barrierDismissible: true,
        barrierLabel: '',
        context: context,
        pageBuilder: (context, animation1, animation2) {
          return Container();
        });
  }

  bool _showSocialText(String? social) {
    return social != null && social.trim().isNotEmpty;
  }

  Future<void> _removeConnectionConfirmation(BuildContext context) {
    String message = '';
    if (widget.connectionStatus == 'connection_request_sent') {
      message = 'Cancel request';
    } else if (widget.connectionStatus == 'connection_request_accepted') {
      message = 'Remove connection';
    }

    return showModalBottomSheet<void>(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (BuildContext context) {
          return Consumer(builder: (context, ref, child) {
            return Container(
                padding: const EdgeInsets.only(left: 16, right: 16),
                decoration: const BoxDecoration(
                  color: VmodelColors.appBarBackgroundColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(13),
                    topRight: Radius.circular(13),
                  ),
                ),
                child: VWidgetsConfirmationWithPictureBottomSheet(
                  username: widget.username,
                  profilePictureUrl: widget.profilePictureUrl,
                  profileThumbnailUrl: widget.profilePictureUrlThumbnail,
                  dialogMessage:
                      "You will not be able to see updates or message ${widget.username}. Are you certain you want to proceed?",
                  actions: [
                    // Unfollow
                    VWidgetsBottomSheetTile(
                        onTap: () {
                          // print(widget.connectionId);
                          // ref.read(connectionProvider).deleteConnection(
                          //     int.parse(
                          //         widget.connectionId!.toString().trim()));
                          // ref.refresh(profileProvider(widget.username));
                          // ref
                          //     .read(showRequestConnectionProvider.notifier)
                          //     .state = false;
                          // ref.refresh(profileProvider(widget.username));
                          // if (context.mounted) goBack(context);
                        },
                        message: 'Unfollow'),
                    const Divider(
                      thickness: 0.5,
                    ),
                    // Remove connection
                    VWidgetsBottomSheetTile(
                        onTap: () {
                          print(widget.connectionId);
                          ref.read(connectionProvider).deleteConnection(
                              int.parse(
                                  widget.connectionId!.toString().trim()));
                          ref.refresh(profileProvider(widget.username));
                          ref
                              .read(showRequestConnectionProvider.notifier)
                              .state = false;
                          ref.refresh(profileProvider(widget.username));
                          if (context.mounted) goBack(context);
                        },
                        message: message)
                  ],
                ));
          });
        });
  }
}
