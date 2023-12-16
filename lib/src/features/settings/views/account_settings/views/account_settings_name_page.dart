import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/shared/appbar/appbar.dart';
import 'package:vmodel/src/shared/buttons/primary_button.dart';
import 'package:vmodel/src/shared/buttons/text_button.dart';
import 'package:vmodel/src/shared/text_fields/primary_text_field.dart';
import 'package:vmodel/src/vmodel.dart';



class AccountSettingsNamePage extends StatelessWidget {
  const AccountSettingsNamePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: VWidgetsAppBar(
        leadingIcon: const VWidgetsBackButton(),
        appbarTitle: "Name",
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
             const Expanded(child: SingleChildScrollView(
              child: Column(
              children: [
                 VWidgetsPrimaryTextFieldWithTitle(
                label: "First Name",
                hintText: "First Name",
                ),
                 VWidgetsPrimaryTextFieldWithTitle(
                label: "Last Name",
                hintText: "Last Name",
                ),
              ],
              ),
            )),
          
           addVerticalSpacing(12),
           VWidgetsPrimaryButton(
            buttonTitle: "Done",
            onPressed: (){
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