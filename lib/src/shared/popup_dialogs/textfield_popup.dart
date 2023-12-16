import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/shared/buttons/primary_button.dart';
import 'package:vmodel/src/shared/text_fields/primary_text_field.dart';
import 'package:vmodel/src/vmodel.dart';

class VWidgetsAddAlbumPopUp extends StatelessWidget {
  final String? buttonTitle;
  final String? popupTitle;
  final TextEditingController controller;
  final VoidCallback? onPressed;
  final String? textFieldlabel;
  final String? hintText;
  final Widget? customTextField;
  final bool obscureText;
  final ValueNotifier<bool>? showLoading;

  const VWidgetsAddAlbumPopUp({
    this.buttonTitle,
    this.popupTitle,
    required this.onPressed,
    required this.controller,
    super.key,
    this.textFieldlabel,
    this.showLoading,
    this.customTextField,
    this.hintText,
    this.obscureText = false,
  });

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
      titleTextStyle: Theme.of(context).textTheme.displayMedium,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          customTextField == null
              ? VWidgetsPrimaryTextFieldWithTitle(
                  label: textFieldlabel,
                  hintText: hintText ?? "Commercial",
                  obscureText: obscureText,
                  //validator: ValidationsMixin.isNotEmpty(value),
                  controller: controller,
                  //onSaved: (){},
                )
              : customTextField!,
          addVerticalSpacing(20),
          Center(
            child: ValueListenableBuilder(
                valueListenable: showLoading!,
                builder: (context, value, child) {
                  return VWidgetsPrimaryButton(
                    showLoadingIndicator: value,
                    butttonWidth: MediaQuery.of(context).size.width / 2.8,
                    onPressed: onPressed,
                    enableButton: true,
                    buttonTitle: buttonTitle,
                  );
                }),
          ),
        ],
      ),
    );
  }
}
