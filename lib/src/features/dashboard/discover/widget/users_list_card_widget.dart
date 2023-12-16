import 'package:vmodel/src/features/dashboard/new_profile/profile_features/widgets/profile_picture_widget.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/vmodel.dart';

import '../../../../shared/username_verification.dart';

class VWidgetsUsersListTile extends StatelessWidget {
  final String displayName;
  final String title;
  final String? profileImage;
  final String? profileImageThumbnail;
  final String subTitle;
  final VoidCallback? onPressedDelete;
  final String? trailingButtonText;
  final Widget? trailingIcon;
  final bool showTrailingIcon;
  final VoidCallback? onTap;
  final bool? isVerified;
  final bool? blueTickVerified;

  const VWidgetsUsersListTile({
    super.key,
    required this.displayName,
    required this.title,
    required this.profileImage,
    required this.profileImageThumbnail,
    required this.subTitle,
    required this.onPressedDelete,
    required this.isVerified,
    required this.blueTickVerified,
    this.trailingButtonText,
    this.trailingIcon,
    this.showTrailingIcon = true,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
                padding: const EdgeInsets.all(3.0),
                child: ProfilePicture(
                  showBorder: false,
                  displayName: displayName,
                  url: profileImage,
                  headshotThumbnail: profileImageThumbnail,
                  size: 45,
                )),
            addHorizontalSpacing(10),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  VerifiedUsernameWidget(
                    username: title,
                    // displayName: profileFullName,
                    isVerified: isVerified,

                    blueTickVerified: blueTickVerified,
                    rowMainAxisAlignment: MainAxisAlignment.start,
                    textStyle: Theme.of(context)
                        .textTheme
                        .displayMedium!
                        .copyWith(fontWeight: FontWeight.w600),
                  ),

                  addVerticalSpacing(4),
                  //second row
                  Text(
                    subTitle,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: Theme.of(context)
                        .textTheme
                        .displaySmall!
                        .copyWith(
                          color: Theme.of(context)
                              .primaryColor
                              .withOpacity(0.5),
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
