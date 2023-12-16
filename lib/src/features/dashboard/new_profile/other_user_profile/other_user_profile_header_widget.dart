import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vmodel/src/core/routing/navigator_1.0.dart';
import 'package:vmodel/src/core/utils/shared.dart';
import 'package:vmodel/src/features/booking/views/create_booking/views/create_booking_first.dart';
import 'package:vmodel/src/features/connection/controller/provider/connection_provider.dart';
import 'package:vmodel/src/features/dashboard/new_profile/other_user_profile/other_user_profile_buttons.dart';
import 'package:vmodel/src/features/dashboard/new_profile/profile_features/expanded_bio/expanded_bio_homepage.dart.dart';
import 'package:vmodel/src/features/dashboard/new_profile/widgets/profile_subinfo_widget.dart';
import 'package:vmodel/src/features/dashboard/profile/controller/profile_controller.dart';
import 'package:vmodel/src/features/messages/controller/messages_controller.dart';
import 'package:vmodel/src/features/messages/views/messages_chat_screen.dart';
import 'package:vmodel/src/features/settings/views/booking_settings/controllers/unavailable_days_controller.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/shared/bottom_sheets/confirmation_bottom_sheet.dart';

import '../../../../core/utils/enum/album_type.dart';
import '../../../../shared/bottom_sheets/picture_confirmation_bottom_sheet.dart';
import '../../../../shared/bottom_sheets/tile.dart';
import '../../../../shared/response_widgets/toast.dart';
import '../../../create_coupons/controller/create_coupon_controller.dart';
import '../../../reviews/views/reviews_view.dart';
import '../../../settings/views/booking_settings/controllers/service_packages_controller.dart';
import '../../feed/controller/new_feed_provider.dart';
import '../controller/gallery_controller.dart';
import '../controller/user_jobs_controller.dart';
import '../user_offerings/views/tabbed_user_offerings.dart';
import '../widgets/popup_profile_picture.dart';
import '../widgets/profile_widget.dart';
import '../widgets/socials_bottom_sheet.dart';

final showConnectProvider = StateProvider((ref) => false);
final showRequestConnectionProvider = StateProvider((ref) => false);

class OtherUserProfileHeaderWidget extends ConsumerStatefulWidget {
  const OtherUserProfileHeaderWidget({
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
  ConsumerState<OtherUserProfileHeaderWidget> createState() =>
      _OtherUserProfileHeaderWidgetState();
}

class _OtherUserProfileHeaderWidgetState
    extends ConsumerState<OtherUserProfileHeaderWidget> {
  bool isAccountActive = true;
  bool isBioEmpty = true;
  bool isUserPrivate = false;
  bool isConnected = false;
  List<DateTime> unavailableDates = [];

  privateUserBookingState() {
    setState(() {
      isUserPrivate = !isUserPrivate;
    });
  }

  @override
  Widget build(BuildContext context) {
    // final appUser = ref.watch(appUserProvider);
    final unavailableDays = ref.watch(unavailableDaysProvider(widget.username));
    unavailableDays.whenData(
      (value) {
        unavailableDates.clear();
        for (var data in value) {
          unavailableDates.add(data.date!);
        }
      },
    );
    final appUser = ref.watch(profileProvider(widget.username));
    final user = appUser.valueOrNull;
    final hasServicePackage = ref.watch(hasServiceProvider(widget.username));
    final hasCoupon = ref.watch(hasCouponProvider(widget.username));

    final userHasJob = ref.watch(hasJobsProvider("${user?.username}"));

    // final userHasJob =
    // ref.watch(userHasJobProvider("${user?.username}")).valueOrNull ?? false;

    return Container(
      width: double.infinity,
      decoration:
          BoxDecoration(color: Theme.of(context).scaffoldBackgroundColor),
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
              onTapExpandIcon: () {
                navigateToRoute(
                    context,
                    ExpandedBioHomepage(
                      username: widget.username,
                    ));
              },
              onTapProfile: () {
                print(
                    '[skkk] thumb ${user?.thumbnailUrl} pp: ${user?.profilePictureUrl}');
                showPopupHeadshot(
                    context, user?.profilePictureUrl, user?.thumbnailUrl);
              },
            ),
            addVerticalSpacing(12),

            /// For Sub info of profile
            VWidgetsProfileSubInfoDetails(
              stars: "4.9",
              userRatingCount: "34",
              address: user?.location?.locationName ?? '',
              hasService: hasServicePackage,
              hasCoupon: hasCoupon,
              hasJob: userHasJob,
              userName: '${user?.username}',
              userType: user?.userType,
              onRatingTap: () {
                navigateToRoute(context, ReviewsUI());
              },
            ),

            addVerticalSpacing(12),

            VWidgetsOtherUserProfileButtons(
              username: widget.username,
              enableSocialButton: user?.socials?.hasSocial,
              isFollowing: user?.isFollowing,
              // connectionStatus: widget.connectionStatus,
              connectOnPressed: () async {
                // navigateToRoute(context, const NetworkPage());
                ref.read(connectionProcessingProvider.notifier).state = true;
                await ref
                    .read(connectionProvider)
                    .updateConnection(true, widget.connectionId!);
                ref.refresh(profileProvider(widget.username));
                ref.read(showConnectProvider.notifier).state = true;
                ref.refresh(profileProvider(widget.username));
                ref.invalidate(mainFeedProvider);
                ref.read(connectionProcessingProvider.notifier).state = false;
              },
              removeOnPressed: () async {
                ref.read(showConnectProvider.notifier).state = false;
              },
              requestConnectOnPressed: () async {
                await showModalBottomSheet(
                    context: context,
                    backgroundColor: Colors.transparent,
                    builder: (context) {
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
                                onTap: () async {
                                  HapticFeedback.lightImpact();
                                  ref
                                      .read(
                                          connectionProcessingProvider.notifier)
                                      .state = true;
                                  if (user.isFollowing!) {
                                    await ref
                                        .read(profileProvider(widget.username)
                                            .notifier)
                                        .unFollowUser(widget.username);
                                  }
                                  if (!user.isFollowing!) {
                                    await ref
                                        .read(profileProvider(widget.username)
                                            .notifier)
                                        .followUser(widget.username);
                                  }

                                  ref
                                      .read(
                                          connectionProcessingProvider.notifier)
                                      .state = false;
                                  popSheet(context);
                                },
                                message:
                                    user!.isFollowing! ? "Unfollow" : 'Follow'),
                            const Divider(
                              thickness: 0.5,
                            ),
                            // Connect
                            VWidgetsBottomSheetTile(
                                onTap: () async {
                                  HapticFeedback.lightImpact();
                                  popSheet(context);
                                  ref
                                      .read(
                                          connectionProcessingProvider.notifier)
                                      .state = true;
                                  await ref
                                      .read(connectionProvider)
                                      .requestConnection(user.username);
                                  ref.refresh(profileProvider(widget.username));
                                  // navigateToRoute(context, const NetworkPage());
                                  ref
                                      .read(showRequestConnectionProvider
                                          .notifier)
                                      .state = true;
                                  ref.refresh(profileProvider(widget.username));
                                  ref.invalidate(mainFeedProvider);
                                  ref
                                      .read(
                                          connectionProcessingProvider.notifier)
                                      .state = false;
                                },
                                message: 'Connect')
                          ],
                        ),
                      );
                    });
              },
              removeRequestOnPressed: () async {
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
              polaroidOnPressed: () async {
                // ref.read(showPolaroidProvider.notifier).state =
                //     !ref.read(showPolaroidProvider.notifier).state;
                final currentValue = ref
                    .read(galleryTypeFilterProvider(widget.username).notifier);
                currentValue.state = currentValue.state == AlbumType.polaroid
                    ? AlbumType.portfolio
                    : AlbumType.polaroid;
              },
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
              servicesOnPressed: () async {
                navigateToRoute(
                  context,
                  UserOfferingsTabbedView(
                    username: user?.username,
                  ),
                  // ServicesHomepage(
                  //   username: user?.username,
                  // ),
                );
              },
              bookNowOnPressed: () async {
                // privateUserBookingState();
                // bookNowFunction(context);
                if (user == null) return;
                navigateToRoute(
                    context,
                    CreateBookingFirstPage(
                      unavailableDates: unavailableDates,
                      username: user.username,
                      displayName: user.displayName,
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
              connectionStatus: widget.connectionStatus,
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
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(13),
                    topRight: Radius.circular(13),
                  ),
                ),
                child: VWidgetsConfirmationWithPictureBottomSheet(
                  username: widget.username,
                  profilePictureUrl: widget.profilePictureUrl,
                  profileThumbnailUrl: widget.profilePictureUrl,
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
                        onTap: () async {
                          popSheet(context);
                          // ref
                          //     .read(connectionProcessingProvider.notifier)
                          //     .state = true;
                          print(widget.connectionId);
                          await ref.read(connectionProvider).deleteConnection(
                              int.parse(
                                  widget.connectionId!.toString().trim()));
                          ref
                              .read(connectionProcessingProvider.notifier)
                              .state = false;
                          // ref.refresh(profileProvider(widget.username));
                          // ref
                          //     .read(showRequestConnectionProvider.notifier)
                          //     .state = false;
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
