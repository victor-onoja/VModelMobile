import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vmodel/src/features/dashboard/new_profile/profile_features/services/views/services_homepage.dart';
import 'package:vmodel/src/shared/appbar/appbar.dart';
import 'package:vmodel/src/vmodel.dart';

import '../../../../../core/controller/app_user_controller.dart';
import '../../../../create_coupons/controller/create_coupon_controller.dart';
import '../../../../settings/views/booking_settings/controllers/service_packages_controller.dart';
import '../../../../suite/views/user_coupons.dart';
import '../../controller/user_jobs_controller.dart';
import '../../profile_features/user_jobs/views/user_jobs_homepage.dart';

class UserOfferingsTabbedView extends ConsumerStatefulWidget {
  const UserOfferingsTabbedView({super.key, required this.username});
  final String? username;

  @override
  ConsumerState<UserOfferingsTabbedView> createState() =>
      _UserOfferingsTabbedViewState();
}

class _UserOfferingsTabbedViewState
    extends ConsumerState<UserOfferingsTabbedView> {
  // bool _isOrderDate = false;
  // bool _isDeliveryDate = false;
  bool hasBookings = false;
  bool hasPastBookings = false;
  bool sortByRecent = true;

  @override
  Widget build(BuildContext context) {
    final isCurrentUser =
        ref.read(appUserProvider.notifier).isCurrentUser(widget.username);
    final requestUsername =
        ref.watch(userNameForApiRequestProvider('${widget.username}'));
    final jobsCount =
        itemsCount(ref.watch(userJobsProvider(requestUsername)).valueOrNull);
    final servicesCount = itemsCount(
        ref.watch(servicePackagesProvider(requestUsername)).valueOrNull);
    final couponCount =
        itemsCount(ref.watch(userCouponsProvider(requestUsername)).valueOrNull);
    return Scaffold(
      // appBar: VWidgetsAppBar(
      //   leadingIcon: const VWidgetsBackButton(),
      //   backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      //   appbarTitle: "My Bookings",
      //   trailingIcon: [],
      //   customBottom: PreferredSize(
      //     preferredSize: Size.fromHeight(40),
      //     child: TabBar(
      //       tabs: [
      //         Tab(icon: Icon(Icons.directions_car)),
      //         Tab(icon: Icon(Icons.directions_transit)),
      //         Tab(icon: Icon(Icons.directions_bike)),
      //       ],
      //     ),
      //   ),
      // ),
      // body: const NoUpcomingBookings()
      // body: const UpcomingBookingsInfo(),
      body: DefaultTabController(
        length: 3,
        child: Scaffold(
          // appBar: AppBar(
          //   bottom: const TabBar(
          //     tabs: [
          //       Tab(icon: Icon(Icons.directions_car)),
          //       Tab(icon: Icon(Icons.directions_transit)),
          //       Tab(icon: Icon(Icons.directions_bike)),
          //     ],
          //   ),
          //   title: const Text('Tabs Demo'),
          // ),
          appBar: VWidgetsAppBar(
            leadingIcon: const VWidgetsBackButton(),
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            appBarHeight: 100,
            appbarTitle: isCurrentUser
                ? "My offerings"
                : "${users(widget.username!)} offerings",
            trailingIcon: [],
            customBottom: PreferredSize(
              preferredSize: Size.fromHeight(0),
              child: TabBar(
                isScrollable: true,
                indicatorPadding: EdgeInsets.symmetric(horizontal: 16),
                tabs: [
                  // Tab(text: 'All (11)'),
                  Tab(text: 'Jobs ($jobsCount)'),
                  Tab(text: 'Services ($servicesCount)'),
                  Tab(text: 'Coupons ($couponCount)'),
                ],
              ),
            ),
          ),
          body: TabBarView(
            children: [
              // Icon(Icons.directions_car),
              // BookingJobsList(),
              UserJobsPage(username: widget.username, showAppBar: false),
              ServicesHomepage(username: widget.username, showAppBar: false),
              // BookingServicesList(),
              // UserCoupons(),
              UserCoupons(username: widget.username, showAppBar: false),
              // BookingServicesList(),
            ],
          ),
        ),
      ),
    );
  }

  int itemsCount(List? items) {
    return items?.length ?? 0;
  }

  String users(String username) {
    if (username.split("").last.toLowerCase() == "s") {
      return "${username}'";
    } else {
      return "${username}'s";
    }
  }
}
