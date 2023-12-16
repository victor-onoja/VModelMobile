import 'package:flutter/material.dart';
import 'package:vmodel/src/features/settings/views/verification/views/blue-tick/widgets/text_field.dart';

import '../../res/gap.dart';
import '../modal_pill_widget.dart';

class VWidgetsInputBottomSheet extends StatelessWidget {
  const VWidgetsInputBottomSheet({
    super.key,
    required this.controller,
    this.title,
    this.dialogMessage,
    this.hintText,
    this.actions,
    this.obscureText = false,
  });

  final bool obscureText;
  final String? title;
  final String? dialogMessage;
  final String? hintText;
  final List<Widget>? actions;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          addVerticalSpacing(15),
          const Align(alignment: Alignment.center, child: VWidgetsModalPill()),
          addVerticalSpacing(6),
          if (title != null) addVerticalSpacing(10),
          if (title != null)
            Text('$title',
                style: Theme.of(context).textTheme.displayMedium!.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).primaryColor,
                    )),
          addVerticalSpacing(25),
          if (dialogMessage != null)
            Center(
              child: Text(dialogMessage!,
                  style: Theme.of(context).textTheme.displaySmall!.copyWith(
                        color: Theme.of(context).primaryColor,
                      )),
            ),
          if (dialogMessage != null) addVerticalSpacing(10),
          if (dialogMessage != null) const Divider(thickness: 0.5),
          if (dialogMessage != null) addVerticalSpacing(15),
          VWidgetsTextFieldNormal(
            // label: "Add Caption",
            hintText: hintText ?? "",
            controller: controller,
            obscureText: obscureText,
          ),
          ...?actions,
          addVerticalSpacing(30),
        ],
      ),
    );
  }
}
