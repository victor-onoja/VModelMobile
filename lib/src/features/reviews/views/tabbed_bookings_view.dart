import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vmodel/src/shared/appbar/appbar.dart';
import 'package:vmodel/src/vmodel.dart';

import 'booking/views/booking_jobs_list.dart';
import 'booking/views/booking_services_list.dart';

class BookingsTabbedView extends ConsumerStatefulWidget {
  const BookingsTabbedView({super.key});

  @override
  ConsumerState<BookingsTabbedView> createState() => _BookingsTabbedViewState();
}

class _BookingsTabbedViewState extends ConsumerState<BookingsTabbedView> {
  // bool _isOrderDate = false;
  // bool _isDeliveryDate = false;
  bool hasBookings = false;
  bool hasPastBookings = false;
  bool sortByRecent = true;

  @override
  Widget build(BuildContext context) {
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
        length: 4,
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
            appbarTitle: "My Bookings",
            trailingIcon: [],
            customBottom: PreferredSize(
              preferredSize: Size.fromHeight(0),
              child: TabBar(
                isScrollable: true,
                indicatorPadding: EdgeInsets.symmetric(horizontal: 16),
                tabs: [
                  Tab(text: 'All (11)'),
                  Tab(text: 'Jobs (58)'),
                  Tab(text: 'Services (43)'),
                  Tab(text: 'Offers (3)'),
                ],
              ),
            ),
          ),
          body: TabBarView(
            children: [
              // Icon(Icons.directions_car),
              BookingJobsList(),
              BookingJobsList(),
              BookingServicesList(),
              BookingServicesList(),
            ],
          ),
        ),
      ),
    );
  }
}
