import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/shared/buttons/primary_button.dart';
import 'package:vmodel/src/vmodel.dart';

class VWidgetsCustomisablePopUp extends StatelessWidget {
  final String? popupTitle;
  final String? popupDescription;
  final String? option1;
  final String? option2;
  final VoidCallback? onPressed1;
  final VoidCallback? onPressed2;

  const VWidgetsCustomisablePopUp(
      {required this.popupTitle,
      required this.popupDescription,
      required this.onPressed1,
      required this.onPressed2,
      required this.option1,
      required this.option2,
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
      titleTextStyle: Theme.of(context).textTheme.headline1,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          (popupDescription != "")
              ? Text(popupDescription!,
                  // textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.displayMedium!.copyWith(
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).primaryColor,
                      ))
              : Container(),
          (popupDescription != "") ? addVerticalSpacing(20) : Container(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: VWidgetsPrimaryButton(
                  butttonWidth: MediaQuery.of(context).size.width / 1.8,
                  onPressed: onPressed1,
                  enableButton: true,
                  buttonTitle: option1,
                ),
              ),
              addHorizontalSpacing(6),
              Flexible(
                child: VWidgetsPrimaryButton(
                  butttonWidth: MediaQuery.of(context).size.width / 1.8,
                  onPressed: onPressed2,
                  enableButton: true,
                  buttonTitle: option2,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
