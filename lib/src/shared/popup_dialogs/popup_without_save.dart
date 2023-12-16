import 'package:vmodel/src/vmodel.dart';

class VWidgetsPopUpWithoutSaveButton extends StatelessWidget {
  final Widget? popupTitle;
  final Widget? popupField;
  final String? title;

  const VWidgetsPopUpWithoutSaveButton(
      {this.popupTitle, this.popupField, super.key, this.title});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
      title: Center(
        child: popupTitle ??
            Text(title!,
                style: Theme.of(context).textTheme.displayLarge!.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).primaryColor,
                    )),
      ),
      titleTextStyle: Theme.of(context).textTheme.displayLarge,
      content: popupField == null
          ? null
          : SingleChildScrollView(
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
