import 'package:flutter/material.dart';
import 'package:vmodel/src/core/utils/shared.dart';
import 'package:vmodel/src/features/create_posts/widgets/dropdown_texfield_with_trailing_icon.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/shared/appbar/appbar.dart';
import 'package:vmodel/src/shared/buttons/primary_button.dart';
import 'package:vmodel/src/shared/buttons/text_button.dart';
import 'package:vmodel/src/shared/popup_dialogs/confirmation_popup.dart';
import 'package:vmodel/src/shared/response_widgets/toast.dart';
import 'package:vmodel/src/shared/slider/slider.dart';
import 'package:vmodel/src/shared/switch/primary_switch.dart';
import 'package:vmodel/src/shared/text_fields/dropdown_text_field.dart';
import 'package:vmodel/src/shared/text_fields/primary_text_field.dart';

class ComponentRevampHomepage extends StatefulWidget {
  const ComponentRevampHomepage({super.key});

  @override
  State<ComponentRevampHomepage> createState() =>
      _ComponentRevampHomepageState();
}

class _ComponentRevampHomepageState extends State<ComponentRevampHomepage> {
  String dropDownValue = "temp";
  double slideValue = 20.00;
  bool swicthValue = false;
  List<String> deliveryOptions = ["1", "2", "3"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const VWidgetsAppBar(
        appbarTitle: "Components Revamp",
        leadingIcon: VWidgetsBackButton(),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            addVerticalSpacing(25),
            const VWidgetsPrimaryTextFieldWithTitle(
              label: "Primary text field",
            ),
            const VWidgetsPrimaryTextFieldWithTitle(
              label: "Primary text field",
              trailingWidget: Icon(Icons.add),
            ),
            VWidgetsDropDownTextField(
              fieldLabel: "Primary dropdown field",
              hintText: "",
              options: const ["temp", "temp2", "temp3"],
              value: dropDownValue,
              onChanged: (val) {
                setState(() {
                  dropDownValue = val;
                });
              },
            ),
            VWidgetsDropDownTextFieldWithTrailingIcon<String>(
              fieldLabel: "Delivery",
              hintText: "",
              options: deliveryOptions,
              getLabel: (String value) => value,
              value: deliveryOptions[0],
              onChanged: (val) {
                setState(() {});
              },
              trailingIcon: const Icon(Icons.add),
              onPressedIcon: () {},
            ),
            VWidgetsPrimaryButton(
              onPressed: () {},
              enableButton: true,
              buttonTitle: "Primary Button",
            ),
            const VWidgetsTextButton(text: "Primary Text Button"),
            VWidgetsSlider<double>(
              startLabel: "18",
              endLabel: "32",
              sliderValue: slideValue,
              sliderMinValue: 18,
              sliderMaxValue: 32,
              onChanged: (value) {
                setState(() {
                  slideValue = value;
                });
              },
            ),
            VWidgetsSwitch(
              swicthValue: swicthValue,
              onChanged: (p0) {
                setState(() {
                  swicthValue = !swicthValue;
                });
              },
            ),
            VWidgetsPrimaryButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: ((context) => VWidgetsConfirmationPopUp(
                        popupTitle: "Logout Confirmation",
                        popupDescription:
                            "Are you sure you want to logout from your account?",
                        onPressedYes: () async {},
                        onPressedNo: () {
                          Navigator.pop(context);
                        },
                      )),
                );
              },
              enableButton: true,
              buttonTitle: "Pop UP Fields",
            ),
            VWidgetsPrimaryButton(
              onPressed: () {
                VWidgetShowResponse.showToast(ResponseEnum.warning,
                    message: "Please fill all the fields");
              },
              enableButton: true,
              buttonTitle: "Toast",
            ),
          ],
        ),
      ),
    );
  }
}
