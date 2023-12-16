import 'package:flutter/material.dart';

class SocialAccountsPopUpWidget extends StatelessWidget {
  final Widget? popupField;

  const SocialAccountsPopUpWidget({
    super.key,
    required this.popupField,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            popupField!,
          ],
        ),
      ),
    );
  }
}
