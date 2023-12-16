import 'package:vmodel/src/features/settings/widgets/settings_submenu_tile_widget.dart';
import 'package:vmodel/src/shared/appbar/appbar.dart';
import 'package:vmodel/src/vmodel.dart';

import 'business_opening_times_form.dart';

class BusinessOpeningHours extends StatelessWidget {
  const BusinessOpeningHours({super.key});

  @override
  Widget build(BuildContext context) {
    List fAQsItems = [
      // VWidgetsSettingsSubMenuTileWidget(
      //     title: "Bottom sheet",
      //     onTap: () {
      //       // navigateToRoute(context, const BusinessPopularOpeningHours());

      //       showModalBottomSheet(
      //           context: context,
      //           isScrollControlled: true,
      //           backgroundColor: Colors.transparent,
      //           builder: (context) {
      //             return OpeningHoursBottomSheet(
      //               username: 'lll',
      //               displayName: "Test Business Name",
      //               label: "Test Restaurent",
      //             );
      //           });
      //     }),
      VWidgetsSettingsSubMenuTileWidget(
          title: "Opening times",
          onTap: () {
            navigateToRoute(context, const OpeningTimesHomepage());
          }),
    ];

    return Scaffold(
      appBar: const VWidgetsAppBar(
        appbarTitle: "Opening Hours",
        leadingIcon: VWidgetsBackButton(),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 25.0),
        child: Container(
          margin: const EdgeInsets.only(
            left: 18,
            right: 18,
          ),
          child: ListView.separated(
              itemBuilder: ((context, index) => fAQsItems[index]),
              separatorBuilder: (context, index) => const Divider(),
              itemCount: fAQsItems.length),
        ),
      ),
    );
  }
}
