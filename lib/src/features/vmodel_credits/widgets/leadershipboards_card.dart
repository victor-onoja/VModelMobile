import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/vmodel.dart';

import '../../dashboard/new_profile/profile_features/widgets/profile_picture_widget.dart';

class VMCLeaderboardsCard extends StatelessWidget {
  final String? profileImageUrl;

  final String userType;
  final String username;
  final String points;

  final VoidCallback onUserTapped;

  const VMCLeaderboardsCard({
    required this.points,
    required this.profileImageUrl,
    required this.userType,
    required this.username,
    required this.onUserTapped,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
                      displayName: username.toUpperCase(),
                      size: 50,
                      showBorder: false,
                    ),
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
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    username,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 11.sp,
                                        ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    userType,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 11.sp,
                                            color: Theme.of(context)
                                                .primaryColor
                                                .withOpacity(.6)),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Flexible(
                        child: Text(
                          points,
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 11.sp,
                                  ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      )
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
