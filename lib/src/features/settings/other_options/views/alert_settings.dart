import 'package:flutter/cupertino.dart';
import 'package:vmodel/src/features/settings/other_options/controller/settings_controller.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/shared/buttons/primary_button.dart';

import 'package:vmodel/src/vmodel.dart';

class AlertSettings extends StatelessWidget {
  const AlertSettings({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<VSettingsController>();

    return Obx(() {
      return Padding(
        padding:
            const EdgeInsets.only(left: 18.0, right: 18, top: 20, bottom: 25),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _switchRow(
                'Alert me when I receive a booking',
                controller.alertBooking,
              ),
              addVerticalSpacing(4),
              _switchRow(
                'Alert me when someone features me',
                controller.alertFeature,
              ),
              addVerticalSpacing(4),
              _switchRow('Alert me when someone likes my content',
                  controller.alertLike),
              addVerticalSpacing(4),
              _switchRow('Alert me when a new job matches my settings ',
                  controller.alertJobMatch),
              addVerticalSpacing(4),
              _switchRow(
                'Alert me when I receive an offer ',
                controller.alertOffer,
              ),
              addVerticalSpacing(4),
              _switchRow(
                'Alert me when someone visits my profile',
                controller.alertProfile,
              ),
              const Spacer(),
              VWidgetsPrimaryButton(
                enableButton: true,
                buttonTitle: 'Done',
                onPressed: () {},
              ),
              addVerticalSpacing(24),
            ]),
      );
    });
  }

  _switchRow(
    String text,
    RxBool switchValue,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 4,
          child: Text(
            text,
            style: VModelTypography1.promptTextStyle
                .copyWith(fontWeight: FontWeight.w600, fontSize: 14),
          ),
        ),
        // CupertinoSwitch(value: value, onChanged: onChanged)
        CupertinoSwitch(
          activeColor: VmodelColors.primaryColor,
          value: switchValue.value,
          onChanged: (p0) => switchValue(p0),
        )
      ],
    );
  }
}
