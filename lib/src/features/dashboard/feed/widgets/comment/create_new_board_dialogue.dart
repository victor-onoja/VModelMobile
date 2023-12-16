import 'package:flutter/material.dart';
import 'package:vmodel/src/core/utils/validators_mixins.dart';
import 'package:vmodel/src/features/settings/views/verification/views/blue-tick/widgets/text_field.dart';
import 'package:vmodel/src/res/gap.dart';
import 'package:vmodel/src/shared/buttons/primary_button.dart';

class CreateNewBoardDialog extends StatefulWidget {
  final String buttonText;
  final String? title;
  final TextEditingController controller;
  final Future<void> Function(String)? onSave;

  const CreateNewBoardDialog({
    super.key,
    required this.controller,
    this.buttonText = "Create & add",
    this.title,
    this.onSave,
  });

  @override
  State<CreateNewBoardDialog> createState() => _CreateNewBoardDialogState();
}

class _CreateNewBoardDialogState extends State<CreateNewBoardDialog> {
  final ValueNotifier<bool> showLoading = ValueNotifier(false);
  final sss = GlobalKey<FormFieldState>(debugLabel: 'create_board_field_state');

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
      title: Center(
        child: Text(
          widget.title ?? "Create board",
          style: Theme.of(context).textTheme.displayLarge!.copyWith(
                fontWeight: FontWeight.w600,
                color: Theme.of(context).primaryColor,
              ),
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          VWidgetsTextFieldNormal(
            textFieldKey: sss,
            labelText: "Board title",
            hintText: "Title",
            obscureText: false,
            controller: widget.controller,
            validator: (value) {
              return value.isEmptyOrNull ? '' : null;
            },
          ),
          addVerticalSpacing(20),
          Center(
            child: ValueListenableBuilder(
                valueListenable: showLoading,
                builder: (context, value, child) {
                  return VWidgetsPrimaryButton(
                    showLoadingIndicator: value,
                    butttonWidth: MediaQuery.of(context).size.width / 2.8,
                    onPressed: () async {
                      final title = widget.controller.text.trim();
                      if (!sss.currentState!.validate()) {
                        // responseDialog(context, "Title");
                        print('o22c no title');
                        return;
                      }
                      showLoading.value = true;
                      await widget.onSave?.call(title);
                      showLoading.value = false;
                    },
                    enableButton: true,
                    buttonTitle: widget.buttonText,
                  );
                }),
          ),
        ],
      ),
    );
  }
}
