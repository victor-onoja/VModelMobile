import 'package:flutter/material.dart';

import '../../res/gap.dart';
import '../modal_pill_widget.dart';

class VWidgetsConfirmationBottomSheet extends StatelessWidget {
  const VWidgetsConfirmationBottomSheet(
      {this.title, this.dialogMessage, this.actions, super.key});

  final String? title;
  final String? dialogMessage;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        addVerticalSpacing(15),
        const Align(alignment: Alignment.center, child: VWidgetsModalPill()),
        if (title != null) addVerticalSpacing(25),
        if (title != null)
          Text('$title',
              textAlign: TextAlign.center,
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
        ...?actions,
        addVerticalSpacing(30),
      ],
    );
  }
}
