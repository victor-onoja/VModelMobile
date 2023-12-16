import 'package:vmodel/src/vmodel.dart';

import '../../../../res/res.dart';
import '../../../settings/views/booking_settings/models/service_package_model.dart';
import '../../new_profile/profile_features/services/views/new_service_detail.dart';

class PostServiceBookNowBanner extends StatelessWidget {
  const PostServiceBookNowBanner({super.key, required this.service});

  final ServicePackageModel service;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      width: 100.w,
      // margin: EdgeInsets.symmetric(horizontal: 8),
      // padding: EdgeInsets.symmetric(horizontal: 8),
      // decoration: BoxDecoration(
      //   color: context.theme.colorScheme.primary,
      //   borderRadius: BorderRadius.circular(12),
      // ),
      child: Card(
        elevation: 4,
        color: context.theme.colorScheme.primary,
        margin: EdgeInsets.symmetric(horizontal: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  '${service.title}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.white),
                ),
              ),
              addHorizontalSpacing(16),
              InkWell(
                onTap: () {
                  print('brrrrrrrrrrrrrrrrrrrr');
                  navigateToRoute(
                      context,
                      ServicePackageDetail(
                        service: service,
                        isCurrentUser: false,
                        username: service.user!.username,
                      ));
                },
                borderRadius: BorderRadius.circular(12),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    children: [
                      Text(
                        '${VMString.bullet} Book now',
                        style: TextStyle(color: Colors.white),
                      ),
                      Icon(
                        Icons.chevron_right,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
