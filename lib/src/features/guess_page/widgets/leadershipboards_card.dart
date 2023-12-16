import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/vmodel.dart';

import '../../dashboard/new_profile/profile_features/widgets/profile_picture_widget.dart';

class VWidgetsLeadershipboards extends StatelessWidget {
  final String? profileImageUrl;

  final String displayName;
  final String points;

  final VoidCallback onUserTapped;

  const VWidgetsLeadershipboards({
    required this.points,
    required this.profileImageUrl,
    required this.displayName,
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
                      displayName: displayName,
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
                              child: Text(
                                displayName,
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
                          ],
                        ),
                      ),
                      Flexible(
                        child: Text(
                          points,
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    fontWeight: FontWeight.w700,
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
