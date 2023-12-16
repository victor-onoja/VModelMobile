import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vmodel/src/features/dashboard/new_profile/other_user_profile/report_account_homepage.dart';
import 'package:vmodel/src/features/dashboard/new_profile/other_user_profile/widgets/report_options_tile_widget.dart';
import 'package:vmodel/src/res/gap.dart';
import 'package:vmodel/src/shared/appbar/appbar.dart';
import 'package:vmodel/src/vmodel.dart';

import '../controller/report_account_controller.dart';

class ReportAccountOptionsPage extends ConsumerStatefulWidget {
  const ReportAccountOptionsPage({
    super.key,
    required this.username,
  });

  final String username;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ReportAccountOptionsPageState();
}

class _ReportAccountOptionsPageState
    extends ConsumerState<ReportAccountOptionsPage> {
  bool isOptionSelected = false;
  final options = <String>[
    "This user has engaged in inappropriate or offensive behaviour towards others",
    "This user has engaged in harassing or abusive behavior towards others on the platform.",
    "The user has violated our community guidelines and terms of service.",
    "The user has posted inappropriate or explicit content.",
    "This user has been involved in fraudulent or deceptive activities.",
    "The user has been consistently unprofessional in their conduct.",
    "The user has been impersonating someone else on the platform.",
    "This user has engaged in harassing or abusive behavior towards others on the platform.",
    "Other",
  ];

  @override
  Widget build(BuildContext context) {
    ref.watch(reportAccountProvider);
    return Scaffold(
      appBar: const VWidgetsAppBar(
        appbarTitle: "Report Account",
        leadingIcon: VWidgetsBackButton(),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            addVerticalSpacing(25),
            ...options.map((e) {
              return VWidgetsReportOptionsTile(
                isOptionSelected: isOptionSelected,
                optionTitle: e,
                onTap: () => _onItemSelected(e),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }

  void _onItemSelected(String option) {
    ref
        .read(reportAccountProvider.notifier)
        .setAccountToReport(username: widget.username);
    navigateToRoute(
        context,
        ReportAccountHomepage(
          selectedOption: option,
          isOptionSelected: true,
        ));
  }
}
