// import 'package:vmodel/src/features/settings/views/booking_settings/views/availability_view.dart';
import 'package:vmodel/src/features/settings/views/booking_settings/views/booking_prices_settings.dart';
import 'package:vmodel/src/features/settings/widgets/settings_submenu_tile_widget.dart';
import 'package:vmodel/src/shared/appbar/appbar.dart';
import 'package:vmodel/src/vmodel.dart';

class BookingSettingsPage extends StatelessWidget {
  const BookingSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    List bookingSettingsItems = [
      VWidgetsSettingsSubMenuTileWidget(title: "Services", onTap: (){
          navigateToRoute(context, const BookingPricesSettingsPage());
      }),
      // VWidgetsSettingsSubMenuTileWidget(title: "Unavailability", onTap: (){
      //      navigateToRoute(context, const AvailabilityView());
      // }),
    ];

    return Scaffold(
      appBar: const VWidgetsAppBar(
        leadingIcon: VWidgetsBackButton(),
        appbarTitle: "Bookings and Services Settings",
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 25.0),
        child: Container(
                    margin: const EdgeInsets.only(
                      left: 18,
                      right: 18,
                      
                    ),
                    child: ListView.separated(
                        itemBuilder: ((context, index) => bookingSettingsItems[index]),
                        separatorBuilder: (context, index) => const Divider(),
                        itemCount: bookingSettingsItems.length),
                  ),
      ),
    );
  }
}


