import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/shared/appbar/appbar.dart';
import 'package:vmodel/src/shared/buttons/primary_button.dart';
import 'package:vmodel/src/shared/buttons/text_button.dart';
import 'package:vmodel/src/shared/text_fields/primary_text_field.dart';
import 'package:vmodel/src/vmodel.dart';

class TwoInputFields extends ConsumerStatefulWidget {
  final title;
  var value;
  var purpose;
  var options;
  var pk;
  var bio;
  var dropdownFeetValue;
  var username;
  var firstName;
  var lastName;
  var weight;
  var hair;
  var eyes;
  var chest;
  TwoInputFields(
      {super.key,
      required this.title,
      required this.value,
      required this.purpose,
      required this.pk,
      required this.bio,
      required this.dropdownFeetValue,
      required this.username,
      required this.firstName,
      required this.lastName,
      required this.weight,
      required this.hair,
      required this.eyes,
      required this.chest,
      required this.options});

  @override
  ConsumerState<TwoInputFields> createState() => _TwoInputFieldsState();
}

class _TwoInputFieldsState extends ConsumerState<TwoInputFields> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: VWidgetsAppBar(
        leadingIcon: const VWidgetsBackButton(),
        appbarTitle: "Color",
        trailingIcon: [
          VWidgetsTextButton(
            text: "Done",
            onPressed: () {
              popSheet(context);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const VWidgetsPagePadding.horizontalSymmetric(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            addVerticalSpacing(25),
            Expanded(
                child: SingleChildScrollView(
              child: Column(
                children: [
                  VWidgetsPrimaryTextFieldWithTitle(
                    label: 'Hair Color',
                    hintText: 'Hair Color',
                    controller: widget.hair,
                  ),
                  VWidgetsPrimaryTextFieldWithTitle(
                    label: 'Eye Color',
                    hintText: 'Eye Color',
                    controller: widget.eyes,
                  ),
                ],
              ),
            )),
            addVerticalSpacing(12),
            VWidgetsPrimaryButton(
              buttonTitle: "Done",
              onPressed: () {
                popSheet(context);
              },
              enableButton: true,
            ),
            addVerticalSpacing(40),
          ],
        ),
      ),
    );
  }
}
