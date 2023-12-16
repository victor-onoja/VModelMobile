import 'package:fluttertoast/fluttertoast.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/vmodel.dart';

enum ResponseEnum {
  sucesss,
  failed,
  warning,
}

class VWidgetShowResponse {
  static showToast(ResponseEnum responseEnum, {String? message}) {
    Fluttertoast.showToast(
      msg: returnStringBasedOnResponse(responseEnum, customMessage: message),
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: returnColorBasedOnResponse(responseEnum),
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  void toastContainer({
    @required String? text,
    Toast toastLength = Toast.LENGTH_LONG,
    Color? backgroundColor,
  }) {
    Fluttertoast.showToast(
      msg: text!,
      toastLength: toastLength,
      // gravity: ToastGravity.SNACKBAR,
      timeInSecForIosWeb: 1,
      backgroundColor: backgroundColor,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  static String returnStringBasedOnResponse(ResponseEnum responseEnum,
      {String? customMessage}) {
    switch (responseEnum) {
      case ResponseEnum.sucesss:
        return customMessage ?? "Success";
      case ResponseEnum.failed:
        return customMessage ?? "Oops! an error occured, Please try again";
      case ResponseEnum.warning:
        return customMessage ?? "Please Try again!";
      default:
        return "Oops! Something went wrong";
    }
  }

  static Color returnColorBasedOnResponse(ResponseEnum responseEnum) {
    switch (responseEnum) {
      case ResponseEnum.sucesss:
        return VmodelColors.primaryColor;
      case ResponseEnum.failed:
        return VmodelColors.error.withOpacity(0.3);
      case ResponseEnum.warning:
        return VmodelColors.primaryColor.withOpacity(0.3);
      default:
        return VmodelColors.primaryColor;
    }
  }
}

void toastContainer({
  @required String? text,
  Toast toastLength = Toast.LENGTH_LONG,
  Color? backgroundColor = VmodelColors.primaryColor,
}) {
  Fluttertoast.showToast(
    msg: text!,
    toastLength: toastLength,
    // gravity: ToastGravity.SNACKBAR,
    timeInSecForIosWeb: 1,
    backgroundColor: backgroundColor,
    textColor: Colors.white,
    fontSize: 16.0,
  );
}
