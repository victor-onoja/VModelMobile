import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vmodel/src/features/dashboard/new_profile/other_user_profile/widgets/report_options_tile_widget.dart';
import 'package:vmodel/src/res/gap.dart';
import 'package:vmodel/src/shared/appbar/appbar.dart';
import 'package:vmodel/src/shared/buttons/primary_button.dart';
import 'package:vmodel/src/shared/text_fields/description_text_field.dart';
import 'package:vmodel/src/vmodel.dart';
import 'package:vmodel/src/core/utils/validators_mixins.dart';

import '../../../../shared/popup_dialogs/response_dialogue.dart';
import '../controller/report_account_controller.dart';

class ReportAccountHomepage extends ConsumerStatefulWidget {
  final String selectedOption;
  final bool isOptionSelected;
  const ReportAccountHomepage({
    required this.selectedOption,
    required this.isOptionSelected,
    super.key,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ReportAccountHomepageState();
}

class _ReportAccountHomepageState extends ConsumerState<ReportAccountHomepage> {
  // String _details = '';
  final textController = TextEditingController();
  final showLoading = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const VWidgetsAppBar(
        appbarTitle: "Report Account",
        leadingIcon: VWidgetsBackButton(),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  addVerticalSpacing(25),
                  VWidgetsReportOptionsTile(
                      isOptionSelected: widget.isOptionSelected,
                      optionTitle: widget.selectedOption,
                      onTap: () {}),
                  VWidgetsDescriptionTextFieldWithTitle(
                    controller: textController,
                    hintText: "Share as much details as possible...",
                    onChanged: (value) {
                      // _details = value;
                    },
                  )
                ],
              ),
            ),
          ),
          ValueListenableBuilder(
              valueListenable: showLoading,
              builder: (context, value, _) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 40),
                  child: VWidgetsPrimaryButton(
                    showLoadingIndicator: value,
                    buttonTitle: "Send Report",
                    onPressed: () async {
                      showLoading.value = true;
                      final response = await ref
                          .read(reportAccountProvider.notifier)
                          .reportAccount(
                              reason: widget.selectedOption,
                              content: textController.text);
                      showLoading.value = false;
                      if (!response.isEmptyOrNull) {
                        textController.clear();
                        Navigator.of(context)
                          ..pop()
                          ..pop();
                        responseDialog(context, response);
                      }
                    },
                  ),
                );
              })
        ],
      ),
    );
  }
}
