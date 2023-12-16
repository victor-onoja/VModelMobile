import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/shared/buttons/primary_button.dart';
import 'package:vmodel/src/vmodel.dart';

class VWidgetsConfirmationPopUp extends StatelessWidget {
  final String? popupTitle;
  final String? popupDescription;
  final VoidCallback? onPressedYes;
  final VoidCallback? onPressedNo;
  final String? firstButtonText;
  final String? secondButtonText;

  const VWidgetsConfirmationPopUp(
      {required this.popupTitle,
      required this.popupDescription,
      required this.onPressedYes,
      required this.onPressedNo,
      this.firstButtonText,
      this.secondButtonText,
      super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
      title: Center(
        child: Text(popupTitle ?? "",
            style: Theme.of(context).textTheme.displayLarge!.copyWith(
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).primaryColor,
                )),
      ),
      titleTextStyle: Theme.of(context).textTheme.headline1,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(popupDescription!,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.displayMedium!.copyWith(
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).primaryColor,
                  )),
          addVerticalSpacing(20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: VWidgetsPrimaryButton(
                  butttonWidth: MediaQuery.of(context).size.width / 1.8,
                  onPressed: onPressedYes,
                  enableButton: true,
                  buttonTitle: firstButtonText ?? "Yes",
                ),
              ),
              addHorizontalSpacing(6),
              Flexible(
                child: VWidgetsPrimaryButton(
                  butttonWidth: MediaQuery.of(context).size.width / 1.8,
                  onPressed: onPressedNo,
                  enableButton: true,
                  buttonTitle: secondButtonText ?? "No",
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
