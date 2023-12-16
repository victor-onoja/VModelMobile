import 'package:flutter/cupertino.dart';
import 'package:vmodel/src/res/ui_constants.dart';

class VWidgetsSwitch extends StatelessWidget {
  final bool swicthValue;
  final Function(bool)? onChanged;
  const VWidgetsSwitch(
      {super.key, required this.swicthValue, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // width: 28,
      // height: 48,
      child: CupertinoSwitch(
        value: swicthValue,
        // activeColor: Theme.of(context).colorScheme.primary,
        activeColor: UIConstants.switchActiveColor(context),
        // backgroundColor:
        //     Theme.of(context).buttonTheme.colorScheme?.secondary,
        onChanged: onChanged,
      ),
    );
  }
}
