import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:vmodel/src/res/res.dart';

@Deprecated("Use VWidgetsPrimaryButton instead")
Widget vWidgetsInitialButton(Function()? method, String text) {
  return SafeArea(
    left: false,
    right: false,
    child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: VmodelColors.buttonColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        onPressed: method,
        child: Center(
          child: Text(
            text,
            style: TextStyle(color: VmodelColors.white),
          ).paddingSymmetric(horizontal: 20, vertical: 10),
        )).marginSymmetric(horizontal: 0),
  );
}

Widget appButton(
  String title,
  Widget? icon,
  Function onPressed,
) {
  return SafeArea(
      child: ElevatedButton(
    onPressed: () => onPressed(),
    style: ButtonStyle(
        padding: MaterialStateProperty.all(
            const EdgeInsets.symmetric(vertical: 12))),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (icon != null)
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: icon,
          ),
        Text(
          title,
          style: const TextStyle(
              fontFamily: 'Avenir', fontSize: 14, fontWeight: FontWeight.bold),
        )
      ],
    ),
  ));
}

Widget selectableButton(Function()? method, String text,
    {bool selected = false}) {
  return SafeArea(
    left: false,
    right: false,
    child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor:
              selected ? VmodelColors.buttonColor : VmodelColors.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: BorderSide(color: VmodelColors.buttonColor)),
        ),
        onPressed: method,
        child: Center(
          child: Text(
            text,
            style: TextStyle(
                color:
                    selected ? VmodelColors.white : VmodelColors.buttonColor),
          ).paddingSymmetric(horizontal: 8, vertical: 8),
        )),
  );
}
