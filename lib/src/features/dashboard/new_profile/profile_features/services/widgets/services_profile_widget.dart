import 'package:vmodel/src/features/dashboard/new_profile/profile_features/widgets/profile_picture_widget.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/vmodel.dart';

class VWidgetsServicesProfileWidget extends StatelessWidget {
  final String? profileImage;
  final String? profileImageThumbnail;
  final String? userName;
  final String? userType;
  final String? location;

  const VWidgetsServicesProfileWidget({
    super.key,
    required this.profileImage,
    required this.profileImageThumbnail,
    required this.userName,
    required this.userType,
    required this.location,
  });

  @override
  Widget build(BuildContext context) {
    print('widget location $location');
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ProfilePicture(
          url: profileImage,
          headshotThumbnail: profileImageThumbnail,
          size: 100,
          showBorder: false,
        ),
        addHorizontalSpacing(18),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            addVerticalSpacing(2),
            Text(
              userName!,
              style: Theme.of(context).textTheme.displayLarge!.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).primaryColor,
                  ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
            addVerticalSpacing(6),
            Text(
              userType!,
              style: Theme.of(context).textTheme.displayMedium!,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
            addVerticalSpacing(6),
            Text(
              location!,
              style: Theme.of(context).textTheme.displayLarge!.copyWith(
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).primaryColor),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ],
        )
      ],
    );
  }
}
