import 'package:vmodel/src/features/dashboard/new_profile/profile_features/widgets/profile_picture_widget.dart';
import 'package:vmodel/src/res/icons.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/shared/rend_paint/render_svg.dart';
import 'package:vmodel/src/vmodel.dart';

import '../../../../../../shared/username_verification.dart';

class VWidgetDiscoverUserTile extends StatelessWidget {
  const VWidgetDiscoverUserTile({
    super.key,
    required this.userName,
    required this.userNickName,
    required this.userImage,
    required this.userImageThumbnail,
    required this.isVerified,
    required this.blueTickVerified,
    this.userType,
    required this.onPressedRemove,
    this.shouldHaveRemoveButton = false,
    required this.onPressedProfile,
  });
  final String? userName;
  final String? userNickName;
  final String? userImage;
  final String? userImageThumbnail;
  final String? userType;
  final VoidCallback? onPressedRemove;
  final VoidCallback? onPressedProfile;
  final bool shouldHaveRemoveButton;
  final bool isVerified;
  final bool blueTickVerified;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: onPressedProfile,
                child: Row(
                  children: [
                    // Container(
                    //   width: 44,
                    //   height: 44,
                    //   decoration: BoxDecoration(
                    //     color: VmodelColors.primaryColor,
                    //     borderRadius: const BorderRadius.all(
                    //       Radius.circular(100),
                    //     ),
                    //     image: DecorationImage(
                    //       image: AssetImage(userImage!),
                    //       fit: BoxFit.cover,
                    //     ),
                    //   ),
                    // ),
                    ProfilePicture(
                      displayName: '$userNickName',
                      url: '$userImage',
                      headshotThumbnail: '$userImageThumbnail',
                      size: 44,
                      showBorder: false,
                    ),
                    addHorizontalSpacing(10),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //     VerifiedUsernameWidget(
                        //   username: '${user?.username}',
                        //   displayName: '${user?.displayName}',
                        //   textStyle: Theme.of(context).textTheme.displayLarge?.copyWith(
                        //         fontWeight: FontWeight.w600,
                        //         fontSize: 18,
                        //         // color: Theme.of(context).primaryColor.withOpacity(1),
                        //       ),
                        //   isVerified: user?.isVerified,
                        //   blueTickVerified: user?.blueTickVerified,
                        // ),

                        VerifiedUsernameWidget(
                          // username: userName,
                          username: '${userName}',
                          displayName: '${userNickName}',
                          textStyle: Theme.of(context)
                              .textTheme
                              .displayMedium!
                              .copyWith(
                                fontWeight: FontWeight.w600,
                                color: Theme.of(context).primaryColor,
                                fontSize: 12.sp,
                              ),
                          isVerified: isVerified,
                          blueTickVerified: blueTickVerified,
                        ),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.center,
                        //   children: [
                        //     Text(
                        //       userNickName!,
                        //       style: Theme.of(context)
                        //           .textTheme
                        //           .displayMedium!
                        //           .copyWith(
                        //               fontWeight: FontWeight.w600,
                        //               color: Theme.of(context).primaryColor,
                        //               fontSize: 12.sp),
                        //     ),
                        //     addHorizontalSpacing(4),
                        //     // getUserVerificationIcon(userName!)
                        //   ],
                        // ),
                        addVerticalSpacing(2),
                        Text(
                          userType ?? userName!,
                          style: Theme.of(context)
                              .textTheme
                              .displayMedium!
                              .copyWith(
                                  fontWeight: FontWeight.w500,
                                  color: Theme.of(context)
                                      .primaryColor
                                      .withOpacity(0.3),
                                  fontSize: 10.sp),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              if (shouldHaveRemoveButton == true)
                IconButton(
                    onPressed: onPressedRemove,
                    icon: const RenderSvg(svgPath: VIcons.cancelTile))
            ],
          ),
          addVerticalSpacing(15),
        ],
      ),
    );
  }
}
