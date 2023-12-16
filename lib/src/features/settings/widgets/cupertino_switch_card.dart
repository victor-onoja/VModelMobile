import 'package:vmodel/src/vmodel.dart';

import '../../../shared/switch/primary_switch.dart';

class VWidgetsCupertinoSwitchWithText extends StatelessWidget {
  final String? titleText;
  final bool? value;
  final Function(bool)? onChanged;

  const VWidgetsCupertinoSwitchWithText(
      {super.key,
      required this.titleText,
      required this.onChanged,
      required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 4,
          child: Text(
            titleText!,
            style: Theme.of(context).textTheme.displayMedium!.copyWith(
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).primaryColor,
                ),
          ),
        ),
        // CupertinoSwitch(value: value, onChanged: onChanged)

        VWidgetsSwitch(swicthValue: value!, onChanged: onChanged),
        // CupertinoSwitch(
        //   activeColor: VmodelColors.primaryColor,
        //   value: value!,
        //   onChanged: onChanged,
        // )
      ],
    );
  }
}
