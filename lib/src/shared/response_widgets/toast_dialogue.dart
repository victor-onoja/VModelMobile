import 'package:flutter/material.dart';
import 'package:vmodel/src/core/routing/navigator_1.0.dart';
import 'package:vmodel/src/shared/response_widgets/vm_toast.dart';

Future<void> toastDialoge({
  required String text,
  Duration? toastLength,
  required BuildContext context,
}) async {
  showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return VMToastDialog(title: text);
      });
  await Future.delayed(toastLength ?? Duration(milliseconds: 800));
  if (context.mounted) goBack(context);
}
