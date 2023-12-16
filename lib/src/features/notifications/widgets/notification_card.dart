import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/vmodel.dart';

import '../../dashboard/new_profile/profile_features/widgets/profile_picture_widget.dart';

class VWidgetsNotificationCard extends StatelessWidget {
  final String? profileImageUrl;
  final String? notificationText;
  final String displayName;
  final String? date;
  final bool checkProfilePicture;
  final VoidCallback onUserTapped;

  const VWidgetsNotificationCard({
    required this.profileImageUrl,
    required this.notificationText,
    required this.checkProfilePicture,
    required this.displayName,
    required this.date,
    required this.onUserTapped,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    print('[ososos $displayName $profileImageUrl');
    return Row(
      children: [
        Flexible(
          child: Container(
            padding: const EdgeInsets.only(right: 8),
            color: Colors.transparent,
            child: Row(
              children: [
                GestureDetector(
                  onTap: onUserTapped,
                  child: Padding(
                    padding: const VWidgetsPagePadding.verticalSymmetric(8),
                    child: ProfilePicture(
                      url: profileImageUrl,
                      headshotThumbnail: profileImageUrl,
                      displayName: displayName,
                      size: 50,
                      showBorder: false,
                    ),

                    // Container(
                    //   decoration: VModelBoxDecoration.avatarDecoration.copyWith(
                    //       color: VmodelColors.appBarBackgroundColor,
                    //       border: Border.all(width: 0, color: Colors.transparent),
                    //       image: checkProfilePicture == true ? DecorationImage(
                    //         image: NetworkImage(
                    //           profileImagePath!,
                    //           //e.picPath,
                    //         ),
                    //         fit: BoxFit.cover,
                    //       ) : DecorationImage(
                    //             image: AssetImage(profileImagePath!),
                    //             fit: BoxFit.cover,
                    //           )),
                    //   width: 50,
                    //   height: 50,
                    // ),
                  ),
                ),
                addHorizontalSpacing(12),
                Flexible(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: onUserTapped,
                              child: Text(
                                notificationText!.split(" ").first,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 11.sp,
                                    ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Flexible(
                              child: Text(
                                notificationText!.replaceAll(
                                    notificationText!.split(" ").first, ""),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                      // fontWeight: FontWeight.w400,
                                      fontSize: 11.sp,
                                    ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                      addHorizontalSpacing(5),
                      Text(
                        date!,
                        style: VModelTypography1.normalTextStyle.copyWith(
                          color:
                              Theme.of(context).primaryColor.withOpacity(0.4),
                          fontWeight: FontWeight.w500,
                          fontSize: 9.sp,
                        ),
                        maxLines: 1,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
