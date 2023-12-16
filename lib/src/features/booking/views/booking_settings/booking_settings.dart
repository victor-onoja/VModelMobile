import 'package:flutter/material.dart';
import 'package:vmodel/src/core/routing/navigator_1.0.dart';
import 'package:vmodel/src/features/booking/views/booking_settings/booking_settings_option.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/shared/appbar/appbar_title_text.dart';
import 'package:vmodel/src/shared/buttons/text_button.dart';
import 'package:vmodel/src/core/utils/shared.dart';

class BookingSettings extends StatelessWidget {
  const BookingSettings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const VWidgetsAppBarTitleText(
          titleText: "Booking Setting",
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        leading: const VWidgetsBackButton(),
        actions: [
           VWidgetsTextButton(
              text: 'Next',
              onPressed: () {},
            ),      
        ],
      ),
      body: ListView(
        children: [
          Column(
            children: [
              //Text("Price")
              ListTile(
                  onTap: () {
                    navigateToRoute(context, const BookingSettingsOptions());
                  },
                  leading: Text(
                    "Price",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 17,
                      color: VmodelColors.buttonColor,
                    ),
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios_outlined)),
              ListTile(
                  onTap: () {},
                  leading: Text(
                    "Availability",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 17,
                      color: VmodelColors.buttonColor,
                    ),
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios_outlined)),
              ListTile(
                  leading: Text(
                    "Calls",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 17,
                      color: VmodelColors.buttonColor,
                    ),
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios_outlined))
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: vWidgetsInitialButton(() {}, "Done"),
          )
        ],
      ),
    );
  }
}
