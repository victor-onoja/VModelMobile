import 'package:vmodel/src/core/utils/validators_mixins.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/shared/appbar/appbar.dart';
import 'package:vmodel/src/shared/text_fields/help_support_text_field.dart';
import 'package:vmodel/src/vmodel.dart';

import '../../../shared/buttons/primary_button.dart';

class HelpDetailsView extends StatelessWidget with VValidatorsMixin {
  final TextEditingController _details = TextEditingController();
  final TextEditingController _userName = TextEditingController();
  final String helpDetailsTitle;
  final bool isReportingBug;
  HelpDetailsView(
      {super.key,
      this.helpDetailsTitle = "Account settings",
      this.isReportingBug = false});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: VWidgetsAppBar(
        leadingIcon: const VWidgetsBackButton(),
        appbarTitle: helpDetailsTitle.toString(),
        appBarHeight: 50,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const VWidgetsPagePadding.horizontalSymmetric(17),
          padding: const VWidgetsPagePadding.verticalSymmetric(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              !isReportingBug
                  ? VWidgetsHelpAndSupportTextField(
                      hintText: "Type in a name or nickname...",
                      controller: _userName,
                      maxLines: 1,
                      onChanged: (val) {},
                      validator: (String? val) =>
                          VValidatorsMixin.isNotEmpty(val, field: "UserName"),
                      suffix: Icon(
                        Icons.search,
                        color: Theme.of(context).primaryColor,
                      ),
                    )
                  : const SizedBox.shrink(),
              addVerticalSpacing(13),
              VWidgetsHelpAndSupportTextField(
                hintText: "Share as much detail as possible...",
                controller: _details,
                onChanged: (val) {},
                validator: (String? val) =>
                    VValidatorsMixin.isNotEmpty(val, field: "Details"),
              ),
              addVerticalSpacing(13),
              VWidgetsPrimaryButton(
                  onPressed: () {},
                  buttonTitle: 'Submit',
                  enableButton: true,
                  buttonColor: VmodelColors.primaryColor,
                  buttonTitleTextStyle: const TextStyle(
                      color: VmodelColors.appBarBackgroundColor))
            ],
          ),
        ),
      ),
    );
  }
}
