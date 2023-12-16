import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vmodel/src/res/icons.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/shared/rend_paint/render_svg.dart';
import 'package:vmodel/src/vmodel.dart';

import '../../../../core/controller/app_user_controller.dart';
import '../../../../core/models/app_user.dart';
import '../../../../core/utils/helper_functions.dart';
import '../../../../shared/text_bottom_sheet.dart';
import '../../../../shared/username_verification.dart';
import '../../../../shared/text_fields/profile_input_field.dart';
import '../../../suite/views/business_opening_times/widgets/closed_or_open_now_text.dart';
import '../../../suite/views/business_opening_times/widgets/opening_hours_bottomsheet.dart';
import '../profile_features/widgets/profile_picture_widget.dart';
import 'user_attributes_bottom_sheet.dart';

class VWidgetsProfileCard extends ConsumerWidget {
  final String? profileImage;
  final String? profileImageThumbnail;
  // final String? mainBio;
  final VoidCallback? onWebsiteURLTap;
  final VoidCallback onTapExpandIcon;
  final VoidCallback onTapProfile;
  final VoidCallback? onLongPressProfilePicture;
  final VAppUser? user;

  const VWidgetsProfileCard({
    super.key,
    required this.profileImage,
    required this.profileImageThumbnail,
    // required this.mainBio,
    required this.onTapExpandIcon,
    required this.onTapProfile,
    this.onLongPressProfilePicture,
    required this.user,
    this.onWebsiteURLTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final appUser = ref.watch(appUserProvider);
    // final user = appUser.valueOrNull;
    bool isCurrentUser = false;
    isCurrentUser =
        ref.read(appUserProvider.notifier).isCurrentUser(user?.username);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: onTapProfile,
              onLongPress: onLongPressProfilePicture,
              child: Hero(
                  tag: 'headshot',
                  child: ProfilePicture(
                    size: 85,
                    displayName: user?.displayName,
                    url: profileImage,
                    headshotThumbnail: profileImageThumbnail,
                    showBorder: false,
                  )),
            ),
            addHorizontalSpacing(10),
            // Text(
            //   '200 Followers',
            //   // textAlign: Text,
            //   style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            //         color: Theme.of(context).primaryColor.withOpacity(0.3),
            //       ),
            // ),
            // GestureDetector(
            //   onTap: () {
            //     navigateToRoute(context, const NotificationsView());
            //   },
            //   child: const RenderSvg(
            //     svgPath: VIcons.notification,
            //   ),
            // ),
          ],
        ),
        addVerticalSpacing(8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                GestureDetector(
                  onLongPress: isCurrentUser
                      ? () {
                          HapticFeedback.lightImpact();
                          navigateToRoute(
                              context,
                              ProfileInputField(
                                title: "Display name",
                                value: user?.displayName ?? '',
                                // isBio: true,
                                onSave: (newValue) async {
                                  await ref
                                      .read(appUserProvider.notifier)
                                      .updateProfile(displayName: newValue);
                                },
                              ));
                        }
                      : null,
                  child: VerifiedUsernameWidget(
                    username: '${user?.username}',
                    displayName: '${user?.displayName}',
                    showDisplayName: true,
                    textStyle:
                        Theme.of(context).textTheme.displayLarge?.copyWith(
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                              // color: Theme.of(context).primaryColor.withOpacity(1),
                            ),
                    isVerified: user?.isVerified,
                    blueTickVerified: user?.blueTickVerified,
                  ),
                ),
                addHorizontalSpacing(16),
                if (user?.isBusinessAccount ?? false)
                  InkResponse(
                    onTap: () {
                      showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          builder: (context) {
                            return OpeningHoursBottomSheet(
                              username: '${user?.username}',
                              displayName: '${user?.displayName}',
                              label: '${user?.labelOrUserType}',
                              profilePictureThumbnail: user?.thumbnailUrl,
                            );
                          });
                    },
                    child: OpenNowOrClosedText(isOpen: false),
                  ),
              ],
            ),
            InkResponse(
              onTap: () {
                showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    builder: (context) {
                      return UserAttributesBottomSheet(
                        title: 'More Information',
                        user: user,
                      );
                    });
              },
              child: NormalRenderSvgWithColor(
                svgPath: VIcons.linkIcon,
                color: Theme.of(context).iconTheme.color,
              ),
            ),
          ],
        ),
        addVerticalSpacing(5),
        Row(
          children: [
            if (user != null && user!.isBusinessAccount!)
              Text(
                user?.label != null
                    ? '${user?.label} ${user?.zodiacSign}'
                    : '${user?.userType}',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).primaryColor.withOpacity(0.5),
                    ),
              ),
            if (user != null && !(user!.isBusinessAccount!))
              Text(
                user?.label != null
                    ? '${user?.label} ${getZodicaSignByName(user?.zodiacSign)}'
                    : '${user?.userType}',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).primaryColor.withOpacity(0.5),
                    ),
              ),
            if (user?.website != null) addHorizontalSpacing(6),
            if (user?.website != null)
              Expanded(
                child: GestureDetector(
                  onTap: onWebsiteURLTap,
                  child: Text(
                    "${VMString.bullet} ${user?.website}",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: Theme.of(context).textTheme.displayMedium?.copyWith(
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w500,
                          color:
                              Theme.of(context).primaryColor.withOpacity(0.5),
                        ),
                  ),
                ),
              ),
          ],
        ),
        addVerticalSpacing(5),
        GestureDetector(
          onLongPress: isCurrentUser
              ? () {
                  HapticFeedback.lightImpact();
                  navigateToRoute(
                      context,
                      ProfileInputField(
                        title: "About You",
                        value: user?.bio ?? '',
                        isBio: true,
                        onSave: (newValue) async {
                          await ref
                              .read(appUserProvider.notifier)
                              .updateProfile(bio: newValue);
                        },
                      ));
                }
              : null,
          onTap: () {
            showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                builder: (context) {
                  return TextBottomSheet(
                    title: 'About ${user?.displayName}',
                    content: '${user?.bio}',
                  );
                });
            // navigateToRoute(
            //     context,
            //     ProfileInputField(
            //       title: "Bio",
            //       value: user!.bio ?? '',
            //       isBio: true,
            //       onSave: (newValue) async {
            //         await ref
            //             .read(appUserProvider.notifier)
            //             .updateProfile(bio: newValue);
            //       },
            //     ));
          },
          child: Text(
            user?.bio ?? '',
            style: Theme.of(context).textTheme.displayMedium!,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),
        ),
      ],
    );
  }
}
