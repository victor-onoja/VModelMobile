import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vmodel/src/core/cache/local_storage.dart';
import 'package:vmodel/src/core/routing/navigator_1.0.dart';
import 'package:vmodel/src/core/utils/browser_laucher.dart';
import 'package:vmodel/src/core/utils/helper_functions.dart';
import 'package:vmodel/src/core/utils/shared.dart';
import 'package:vmodel/src/features/dashboard/new_profile/profile_features/expanded_bio/expanded_bio_homepage.dart.dart';
import 'package:vmodel/src/features/dashboard/new_profile/profile_features/widgets/book_now/book_now_service.dart';
import 'package:vmodel/src/features/dashboard/new_profile/profile_features/widgets/social_accounts_feature/social_accounts_textfield.dart';
import 'package:vmodel/src/features/dashboard/new_profile/views/business_profile/local/local_business_profile_buttons.widget.dart';
import 'package:vmodel/src/features/dashboard/new_profile/widgets/business_profile_subinfo.dart';
import 'package:vmodel/src/features/dashboard/new_profile/widgets/profile_widget.dart';
import 'package:vmodel/src/features/messages/views/messages_homepage.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/shared/popup_dialogs/confirmation_popup.dart';
import 'package:vmodel/src/shared/popup_dialogs/customisable_popup.dart';
import 'package:vmodel/src/shared/popup_dialogs/popup_without_save.dart';

import '../../../../../../core/controller/app_user_controller.dart';
import '../../../../../../core/models/app_user.dart';
import '../../../../../../core/models/user_socials.dart';
import '../../../../../../shared/response_widgets/toast.dart';
import '../../../../../connection/controller/provider/connection_provider.dart';
import '../../../../../create_coupons/controller/create_coupon_controller.dart';
import '../../../../../reviews/views/reviews_view.dart';
import '../../../../../settings/views/booking_settings/controllers/service_packages_controller.dart';
import '../../../../../settings/views/my_network/my_network.dart';
import '../../../../profile/controller/profile_controller.dart';
import '../../../controller/user_jobs_controller.dart';
import '../../../widgets/popup_profile_picture.dart';
import '../../../widgets/socials_bottom_sheet.dart';

class LocalBusinessProfileHeaderWidget extends ConsumerStatefulWidget {
  const LocalBusinessProfileHeaderWidget({
    super.key,
    required this.username,
  });
  final String username;

  @override
  ConsumerState<LocalBusinessProfileHeaderWidget> createState() =>
      _BusinessProfileHeaderWidgetState();
}

class _BusinessProfileHeaderWidgetState
    extends ConsumerState<LocalBusinessProfileHeaderWidget> {
  TextEditingController instagramController = TextEditingController();
  TextEditingController twitterController = TextEditingController();
  TextEditingController facebookController = TextEditingController();
  TextEditingController pinterestController = TextEditingController();
  TextEditingController tiktokController = TextEditingController();
  TextEditingController youtubeController = TextEditingController();
  bool isAccountActive = true;
  bool isUserPrivate = false;

  bool isCurrentUser = false;
  @override
  void initState() {
    super.initState();
    isCurrentUser =
        ref.read(appUserProvider.notifier).isCurrentUser(widget.username);
  }

  privateUserBookingState() {
    setState(() {
      isUserPrivate = !isUserPrivate;
    });
  }

  @override
  Widget build(BuildContext context) {
    // final authNotifier = ref.watch(authProvider.notifier);
    // final authNot = authNotifier.state;
    // final appUser = ref.watch(appUserProvider);
    // final user = appUser.valueOrNull;

    final apiUsername =
        ref.watch(userNameForApiRequestProvider(widget.username));

    VAppUser? user;
    if (isCurrentUser) {
      final appUser = ref.watch(appUserProvider);
      user = appUser.valueOrNull;
    } else {
      final appUser = ref.watch(profileProvider(widget.username));
      user = appUser.valueOrNull;
    }
    final hasServicePackage = ref.watch(hasServiceProvider(apiUsername));
    final hasCoupon = ref.watch(hasCouponProvider(apiUsername));
    final userHasJob = ref.watch(hasJobsProvider(apiUsername));

    // final userHasJob =
    //     ref.watch(userHasJobProvider("${user?.username}")).valueOrNull ?? false;

    // final userState = ref.watch(profileProvider(widget.username));
    // final user = userState.valueOrNull;
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
            VWidgetsProfileCard(
              profileImage: '${user?.profilePictureUrl}',
              profileImageThumbnail: '${user?.thumbnailUrl}',
              // mainBio: user?.bio,
              onWebsiteURLTap: () {
                VUtilsBrowserLaucher.lauchWebBrowserWithUrl("${user?.website}");
              },
              user: user,
              onTapExpandIcon: () {
                navigateToRoute(context,
                    ExpandedBioHomepage(username: '${user?.username}'));
              },

              onLongPressProfilePicture: () {
                HapticFeedback.lightImpact();
                showPopupHeadshot(
                    context, user?.profilePictureUrl, user?.thumbnailUrl);
              },
              onTapProfile: () {
                closeAnySnack();
                showDialog(
                    context: context,
                    builder: ((context) => VWidgetsCustomisablePopUp(
                          option1: "Change",
                          option2: "Delete",
                          popupTitle: "Edit Image",
                          popupDescription: "",
                          onPressed1: () async {
                            selectAndCropImage().then((value) async {
                              print(value);
                              if (value != null && value != "") {
                                ref
                                    .read(appUserProvider.notifier)
                                    .uploadProfilePicture(value,
                                        onProgress: (sent, total) {
                                  final percentUploaded = (sent / total);
                                  print(
                                      '########## $value\n [$percentUploaded%]  sent: $sent ---- total: $total');
                                });
                              }
                            });

                            Navigator.pop(context);
                          },
                          onPressed2: () {
                            Navigator.pop(context);
                            showDialog(
                                context: context,
                                builder: ((context) =>
                                    VWidgetsConfirmationPopUp(
                                      popupTitle: "Delete Confirmation",
                                      popupDescription:
                                          "Are you sure you want to delete your profile photo?",
                                      onPressedYes: () async {
                                        Navigator.pop(context);
                                      },
                                      onPressedNo: () {
                                        Navigator.pop(context);
                                      },
                                    )));
                          },
                        )));
              },
            ),
            addVerticalSpacing(12),

            /// For Sub info of profile
            VWidgetsBusinessProfileSubInfoDetails(
              isCurrentUser: isCurrentUser,
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

            addVerticalSpacing(12),
            VWidgetsLocalBusinessProfileButtons(
              bookNowOnPressed: () {
                privateUserBookingState();
                bookNowFunction(context);
              },
              topPicksOnPressed: () {},
              messagesOnPressed: () {
                navigateToRoute(context, const MessagingHomePage());
              },
              onNetworkPressed: () {
                ref.refresh(getConnections);
                // navigateToRoute(context, const NetworkPage());
                navigateToRoute(context, const MyNetwork());
              },
              socialAccoutsOnPressed: () async {
                if (user?.socials != null && user!.socials!.hasSocial) {
                  showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      builder: (context) {
                        return SocialsBottomSheet(
                          title: 'Socials',
                          userSocials: user!.socials!,
                        );
                      });
                } else {
                  VWidgetShowResponse.showToast(ResponseEnum.warning,
                      message: "No socials available");
                }
              },
              socialAccoutsLongPressed: () {
                closeAnySnack();
                showDialog(
                        context: context,
                        builder: ((context) =>
                            socialAccountsLongPress(context, user?.socials)))
                    .then((value) async {
                  // final newSocials = UserSocials(
                  //   youtube: youtubeController.text.trim(),
                  //   facebook: facebookController.text.trim(),
                  //   instagram: instagramController.text.trim(),
                  //   tiktok: tiktokController.text.trim(),
                  //   pinterest: pinterestController.text.trim(),
                  //   twitter: twitterController.text.trim(),
                  // );

                  // if (user?.socials != null && user!.socials == newSocials) {
                  //   return;
                  // }

                  // VLoader.changeLoadingState(true);
                  // await ref
                  //     .read(appUserProvider.notifier)
                  //     .updateSocialUsernames(
                  //       youtube: youtubeController.text.trim(),
                  //       facebook: facebookController.text.trim(),
                  //       instagram: instagramController.text.trim(),
                  //       tiktok: tiktokController.text.trim(),
                  //       pinterest: pinterestController.text.trim(),
                  //       twitter: twitterController.text.trim(),
                  //     );
                  // VLoader.changeLoadingState(false);
                });
              },
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

  ///Social Accounts Long Press Function
  VWidgetsPopUpWithoutSaveButton socialAccountsLongPress(
      BuildContext context, UserSocials? socials) {
    youtubeController.text = socials?.youtube?.username ?? '';
    facebookController.text = socials?.facebook?.username ?? '';
    instagramController.text = socials?.instagram?.username ?? '';
    tiktokController.text = socials?.tiktok?.username ?? '';
    pinterestController.text = socials?.pinterest?.username ?? '';
    twitterController.text = socials?.twitter?.username ?? '';

    return VWidgetsPopUpWithoutSaveButton(
      popupTitle: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Add Accounts",
                  style: Theme.of(context).textTheme.displayLarge!.copyWith(
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).primaryColor,
                      )),
            ],
          ),
        ],
      ),
      popupField: Column(
        children: [
          _socialItem(
              controller: instagramController,
              title: "Instagram",
              preferenceKey: 'instagram_username'),
          _socialItem(
              controller: tiktokController,
              title: "Tiktok",
              preferenceKey: 'tiktok_username'),
          _socialItem(
              controller: youtubeController,
              title: "Youtube",
              preferenceKey: 'youtube_username'),
          _socialItem(
              controller: twitterController,
              title: "Twitter",
              preferenceKey: 'twitter_username'),
          _socialItem(
              controller: facebookController,
              title: "Facebook",
              preferenceKey: 'facebook_username'),
          _socialItem(
              controller: pinterestController,
              title: "Pinterest",
              preferenceKey: 'pinterest_username'),
        ],
      ),
    );
  }

  SocialAccountsTextField _socialItem({
    required TextEditingController controller,
    required String title,
    required String preferenceKey,
  }) {
    return SocialAccountsTextField(
      // socialAccountName: "Instagram",
      socialAccountName: title,
      onTap: () {},
      // isAccountActive: isAccountActive,
      textController: controller,
      onPressedSave: () {},
      onChanged: (value) async {
        if (instagramController.text != "") {
          await VModelSharedPrefStorage()
              // .putString('Instagram_username', instagramController.text);
              .putString(preferenceKey, controller.text);
        } else {
          VWidgetShowResponse.showToast(
            ResponseEnum.warning,
            message: "Please fill the field",
          );
        }
      },
    );
  }
}
