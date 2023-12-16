import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/routes/default_transitions.dart';
import 'package:vmodel/src/features/dashboard/dash/dashboard_ui.dart';
import 'package:vmodel/src/features/dashboard/menu_settings/menu_sheet.dart';
import 'package:vmodel/src/vmodel.dart';

import '../utils/helper_functions.dart';

class AppNavigatorKeys {
  AppNavigatorKeys._privateContructor();

  static AppNavigatorKeys instance = AppNavigatorKeys._privateContructor();

  GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  GlobalKey<ScaffoldMessengerState> scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();
}

void dismissKeyboard() {
  FocusManager.instance.primaryFocus?.unfocus();
}

void popSheet(BuildContext context) {
  Navigator.of(context).pop();
}

void closeDialog(BuildContext context) {
  Navigator.of(context, rootNavigator: true).pop();
}

displayBottomSheet(context, Widget bottomSheet) {
  return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      // elevation: 0,
      // barrierColor: Colors.black.withAlpha(1),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.0), topRight: Radius.circular(30.0))),
      builder: (context) => Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: GestureDetector(onTap: dismissKeyboard, child: bottomSheet)));
}

navigateToRoute(BuildContext context, dynamic routeClass,
    {bool useMaterial = true}) {
  Navigator.push(
      context,
      useMaterial || Platform.isAndroid
          ? MaterialPageRoute(builder: (context) => routeClass)
          // ? _createRoute(context, routeClass)
          : CupertinoPageRoute(builder: (context) => routeClass));
}

// PageTransitionsTheme pageTransitionsTheme = PageTransitionsTheme(builders: {
//   TargetPlatform.android: ZoomPageTransitionsBuilder(),
//   TargetPlatform.iOS: ZoomPageTransitionsBuilder()
// });

Route _createRoute(BuildContext context, dynamic routeClass) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => routeClass,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0);
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}

void navigateAndReplaceRoute(BuildContext? context, dynamic routeClass) {
  Navigator.pushReplacement(
      context!,
      Platform.isAndroid
          ? MaterialPageRoute(builder: (context) => routeClass)
          : CupertinoPageRoute(builder: (context) => routeClass));
}

void navigateAndRemoveUntilRoute(BuildContext? context, dynamic routeClass) {
  Navigator.pushAndRemoveUntil(
      context!,
      Platform.isAndroid
          ? MaterialPageRoute(builder: (context) => routeClass)
          : CupertinoPageRoute(builder: (context) => routeClass),
      (route) => false);
}

goBackHome(BuildContext context) {
  Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
      Platform.isAndroid
          ? MaterialPageRoute(builder: (context) => const DashBoardView())
          : CupertinoPageRoute(builder: (context) => const DashBoardView()),
      (route) => false);
}

goBack(BuildContext context) {
  Navigator.of(context).pop();
}

moveAppToBackGround() {
  // MoveToBackground.moveTaskToBack();
  SystemNavigator.pop();
}

openVModelMenu(BuildContext context, {bool isNotTabScreen = false}) {
  closeAnySnack();

  HapticFeedback.lightImpact();
  showModalBottomSheet(
    backgroundColor: Colors.transparent,
    useRootNavigator: true,
    context: context,
    isScrollControlled: true,
    enableDrag: true,
    anchorPoint: const Offset(0, 200),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(16),
        topRight: Radius.circular(16),
      ),
    ),
    builder: ((context) => MenuSheet(
          isNotTabSreen: isNotTabScreen,
        )),
  );
}
