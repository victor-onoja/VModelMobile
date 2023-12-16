
import 'package:vmodel/src/res/assets/app_asset.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/vmodel.dart';

class VWidgetsCountingTextField extends StatelessWidget {
  final String? hintText;
  final VoidCallback? onTapMinus;
  final VoidCallback? onTapPlus;
  final double? boxWidth;

  const VWidgetsCountingTextField(
      {required this.hintText,
      required this.onTapMinus,
      required this.onTapPlus,
      required this.boxWidth,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.max,
      children: [
        GestureDetector(
          onTap: onTapMinus,
          child: lessButton,
        ),
        addHorizontalSpacing(10),
        SizedBox(
          width: boxWidth ?? 40.w,
          height: 40,
          child: TextField(
            cursorHeight: 0,
            cursorWidth: 0,
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            decoration: InputDecoration(
                contentPadding: const EdgeInsets.fromLTRB(14.5, 8.5, 14.5, 8.5),
                hintText: hintText,
                hintStyle: const TextStyle(
                    fontSize: 14.0, fontWeight: FontWeight.w600),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme.of(context).primaryColor.withOpacity(1),
                        width: 1.5),
                    borderRadius: const BorderRadius.all(Radius.circular(8))),
                disabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme.of(context).primaryColor.withOpacity(0.4),
                        width: 1.5),
                    borderRadius: const BorderRadius.all(Radius.circular(7.5))),
                border: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme.of(context).primaryColor.withOpacity(0.4),
                        width: 1.5),
                    borderRadius: const BorderRadius.all(Radius.circular(7.5))),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme.of(context).primaryColor.withOpacity(0.4),
                        width: 1.5),
                    borderRadius: const BorderRadius.all(Radius.circular(7.5))),
                focusedErrorBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                        color: VmodelColors.bottomNavIndicatiorColor,
                        width: 1.0),
                    borderRadius: BorderRadius.all(Radius.circular(7.5))),
                errorBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: VmodelColors.bottomNavIndicatiorColor, width: 1.0),
                    borderRadius: BorderRadius.all(Radius.circular(7.5)))),
          ),
        ),
        addHorizontalSpacing(10),
        GestureDetector(
          onTap: onTapPlus,
          child: plusButton,
        ),
      ],
    );
  }
}
