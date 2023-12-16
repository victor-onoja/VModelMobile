import 'package:vmodel/src/res/icons.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/shared/rend_paint/render_svg.dart';
import 'package:vmodel/src/vmodel.dart';

import '../../../shared/username_verification.dart';
import '../../dashboard/new_profile/profile_features/widgets/profile_picture_widget.dart';

class VWidgetsNetworkPageCard extends StatelessWidget {
  final String displayName;
  final String subTitle;
  final String? title;
  final String? userImage;
  final String? userImageThumbnail;
  final bool? userImageStatus;
  final bool? isVerified;
  final bool? blueTickVerified;
  final VoidCallback? onPressedAccept;
  final VoidCallback? onPressedRemove;
  final VoidCallback? onPressedProfile;

  const VWidgetsNetworkPageCard(
      {required this.subTitle,
      required this.displayName,
      required this.title,
      required this.userImage,
      required this.userImageThumbnail,
      required this.userImageStatus,
      required this.onPressedRemove,
      required this.onPressedProfile,
      this.isVerified,
      this.blueTickVerified,
      this.onPressedAccept,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: onPressedProfile,
              child: Row(
                children: [
                  ProfilePicture(
                    displayName: "${displayName}",
                    url: userImage,
                    headshotThumbnail: userImageThumbnail,
                    size: 44,
                  ),
                  addHorizontalSpacing(10),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      VerifiedUsernameWidget(
                        username: title ?? '',
                        displayName: title,
                        isVerified: isVerified,
                        blueTickVerified: blueTickVerified,
                        textStyle: Theme.of(context)
                            .textTheme
                            .displayMedium!
                            .copyWith(
                                fontWeight: FontWeight.w600, fontSize: 12.sp),
                      ),
                      // Text(
                      //   userNickName!,
                      //   style: Theme.of(context)
                      //       .textTheme
                      //       .displayMedium!
                      //       .copyWith(
                      //           fontWeight: FontWeight.w600,
                      //           color: Theme.of(context).primaryColor,
                      //           fontSize: 12.sp),
                      // ),
                      addVerticalSpacing(2),
                      Text(
                        subTitle,
                        style: Theme.of(context)
                            .textTheme
                            .displayMedium!
                            .copyWith(
                                fontWeight: FontWeight.w500,
                                color: Theme.of(context)
                                    .primaryColor
                                    .withOpacity(0.6),
                                fontSize: 10.sp),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Row(
              children: [
                if (onPressedAccept != null)
                  GestureDetector(
                    onTap: onPressedAccept,
                    child: RenderSvg(
                      svgPath: VIcons.checkCircle,
                      color: Theme.of(context).iconTheme.color,
                    ),
                  ),
                addHorizontalSpacing(12),
                GestureDetector(
                    onTap: onPressedRemove,
                    child: const RenderSvg(svgPath: VIcons.remove)),
              ],
            )
            // OutlinedButton(
            //     onPressed: onPressedRemove,
            //     style: OutlinedButton.styleFrom(
            //       side: const BorderSide(
            //           color: VmodelColors.primaryColor,
            //           width: 1.5), //<-- SEE HERE
            //     ),
            //     child: Text(
            //       "Remove",
            //       style: Theme.of(context).textTheme.displayMedium!.copyWith(
            //           fontWeight: FontWeight.w500,
            //           color: Theme.of(context).primaryColor,
            //           fontSize: 11.sp),
            //     )),
          ],
        ),
        addVerticalSpacing(15),
      ],
    );
  }
}
