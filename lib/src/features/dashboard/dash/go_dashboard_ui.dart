import 'package:flutter_portal/flutter_portal.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:vmodel/src/features/create_posts/controller/create_post_controller.dart';
import 'package:vmodel/src/features/dashboard/dash/controller.dart';
import 'package:vmodel/src/features/dashboard/feed/controller/feed_provider.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/vmodel.dart';

import '../../authentication/register/provider/user_types_controller.dart';
import '../../create_coupons/controller/create_coupon_controller.dart';
import '../../create_posts/controller/cropped_data_controller.dart';
import '../../jobs/job_market/controller/jobs_controller.dart';
import '../../settings/views/booking_settings/controllers/service_packages_controller.dart';
import '../new_profile/controller/user_jobs_controller.dart';
import 'go_tab_bottom_nav_bar.dart';

class GoDashBoardView extends ConsumerWidget {
  const GoDashBoardView({
    super.key,
    required this.navigationShell,
  });

  /// The navigation shell and container for the branch Navigators.
  final StatefulNavigationShell navigationShell;
  static const path = 'godashboard';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //load current user services
    ref.watch(dashTabProvider);
    final watchProvider = ref.watch(dashTabProvider.notifier);
    final fProvider = ref.watch(feedProvider);
    // watchProvider.initFCM(context, ref);

//Low priority

    // Fetch jobs data
    ref.watch(jobsProvider);
    ref.watch(popularJobsProvider);
    ref.watch(popularServicesProvider);

    // Fetch services and coupon data for profile
    ref.watch(userCouponsProvider(null));
    ref.watch(hasServiceProvider(null));
    ref.watch(hasJobsProvider(null));

    ref.watch(accountTypesProvider);

    return Portal(
      child: Scaffold(
        // resizeToAvoidBottomInset: false,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        // body: watchProvider.returnSelected(context),
        body: navigationShell,
        bottomNavigationBar: _showUploadProgress(
          provider: watchProvider,
          nav: Container(
            padding: EdgeInsets.only(bottom: 20),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  // spreadRadius: 0,
                  // blurRadius: 0.5,
                  // color: watchProvider != 2
                  color: watchProvider != 2
                      ? VmodelColors.appBarShadowColor
                      : VmodelColors.black,
                  // offset: const Offset(0, -1), // changes position of shadow
                ),
              ],
              // color: watchProvider.backgroundColor,
              color: fProvider.isFeed
                  ? Theme.of(context).scaffoldBackgroundColor
                  : VmodelColors.blackColor,
            ),
            height: 79,
            // child: Container(
            //   decoration: const BoxDecoration(
            //       color: Colors.amber,
            //       borderRadius: BorderRadius.only(
            //         topRight: Radius.circular(30),
            //         topLeft: Radius.circular(30),
            //       )),
            //   margin: const EdgeInsets.symmetric(
            //     horizontal: 20,
            //     vertical: 5,
            //   ),
            child: GoTabBottomNav(
                navigationShell: navigationShell,
                onFeedTap: () {
                  fProvider.isFeedPage(isFeedOnly: true);
                }),

            //     Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: watchProvider.bottomNavItems(context, () {
            //     fProvider.isFeedPage(isFeedOnly: true);
            //   }),
            // ),
            // ),
          ),
        ),
      ),
    );
  }

  Widget _showUploadProgress(
      {required DashTabProvider provider, required Widget nav}) {
    return Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {
        final uploadPercentage = ref.watch(uploadProgressProvider);
        // final imagesx = ref.watch(croppedImagesToUploadProviderx);
        final images = ref.watch(croppedImagesProvider);

        return PortalTarget(
          // portalCandidateLabels: const [PortalLabel('dashboard')],
          visible: images.isNotEmpty && uploadPercentage > 0.0,
          anchor: const Aligned(
            follower: Alignment.bottomLeft,
            target: Alignment(-1, -11),
            // target: Alignment.topLeft,
            widthFactor: 0.2,
            // backup: Aligned(
            //   follower: Alignment.bottomLeft,
            //   target: Alignment.topLeft,
            //   widthFactor: 5,
            // ),
          ),

          portalFollower: GestureDetector(
            onTap: () {
              // navigateToRoute(
              //     AppNavigatorKeys.instance.navigatorKey.currentContext!,
              // CreatePostPage(images: selectedImages));
              // CreatePostPage(images: [], aspectRatio: UploadAspectRatio.square));
            },
            child: Card(
              color: VmodelColors.white,
              // color: Colors.tealAccent,
              elevation: 5,
              clipBehavior: Clip.hardEdge,
              child: images.isNotEmpty
                  ? Container(
                      // width: 100,
                      decoration: BoxDecoration(
                        color: Colors.black54,
                        image: DecorationImage(
                          colorFilter: ColorFilter.mode(
                              Colors.black.withOpacity(0.2), BlendMode.dstATop),
                          image: MemoryImage(images.first),
                          fit: BoxFit.cover,
                        ),
                      ),
                      height: 100,
                      child: Center(
                        child: SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(
                            value: uploadPercentage >= 1.0
                                ? null
                                : uploadPercentage,
                            strokeWidth: 3,
                            valueColor:
                                AlwaysStoppedAnimation(VmodelColors.white),
                          ),
                        ),
                      ),
                    )
                  : const SizedBox.shrink(),
            ),
          ),
          child: nav,
          // Text('Hello'),
        );
      },
      // child: ,
    );
  }
}
