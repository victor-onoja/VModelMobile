import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/shared/buttons/primary_button.dart';
import 'package:vmodel/src/vmodel.dart';

class VWidgetsInputPopUp extends StatelessWidget {
  final String? popupTitle;
  final Widget? popupField;
  final VoidCallback? onPressedYes;

  const VWidgetsInputPopUp(
      {required this.popupTitle,
      required this.popupField,
      required this.onPressedYes,
      super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
      title: Center(
        child: Text(popupTitle ?? "",
            style: Theme.of(context).textTheme.displayLarge!.copyWith(
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).primaryColor,
                )),
      ),
      titleTextStyle: Theme.of(context).textTheme.displayLarge,
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            popupField!,
            addVerticalSpacing(20),
            
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: VWidgetsPrimaryButton(
                    butttonWidth: MediaQuery.of(context).size.width / 2.8,
                    onPressed: onPressedYes,
                    enableButton: true,
                    buttonTitle: "Save",
                  ),
                ),
              ],
            ),
            
          ],
        ),
      ),
    );
  }
}
