import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vmodel/src/core/controller/app_user_controller.dart';
import 'package:vmodel/src/core/models/app_user.dart';
import 'package:vmodel/src/features/settings/widgets/cupertino_switch_card.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/shared/appbar/appbar.dart';
import 'package:vmodel/src/vmodel.dart';

class AlertSettingsPage extends ConsumerStatefulWidget {
  const AlertSettingsPage({super.key, required this.user});
  final VAppUser? user;

  @override
  ConsumerState<AlertSettingsPage> createState() => _AlertSettingsPageState();
}

class _AlertSettingsPageState extends ConsumerState<AlertSettingsPage> {
  bool alertReceiveBooking = false;
  bool alertFeatureMe = false;
  bool alertLikesContent = false;
  bool alertNewJobMatches = false;
  bool alertReceiveOffer = false;
  bool alertProfileVisit = false;
  bool alertSilenceAllMessages = false;
  bool alertPrintPolaroid = false;

  @override
  void initState() {
    alertProfileVisit = widget.user!.alertOnProfileVisit;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const VWidgetsAppBar(
        appbarTitle: "Notifications Settings",
        leadingIcon: VWidgetsBackButton(),
      ),
      body: Padding(
        padding: const VWidgetsPagePadding.horizontalSymmetric(18),
        child: Column(children: [
          addVerticalSpacing(25),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  VWidgetsCupertinoSwitchWithText(
                    titleText: "Alert me when someone visits my profile",
                    value: alertProfileVisit,
                    onChanged: ((p0) async {
                      await ref
                          .read(appUserProvider.notifier)
                          .updateNotification(alertProfileVisit: p0);
                      setState(() {
                        alertProfileVisit = !alertProfileVisit;
                      });
                    }),
                  ),
                  addVerticalSpacing(5),
                  Divider(thickness: 0.5),
                  addVerticalSpacing(5),
                  VWidgetsCupertinoSwitchWithText(
                    titleText: "Silence all messages on dates I'm unavailabe",
                    value: alertSilenceAllMessages,
                    onChanged: ((p0) {
                      setState(() {
                        alertSilenceAllMessages = !alertSilenceAllMessages;
                      });
                      return alertSilenceAllMessages;
                    }),
                  ),
                  addVerticalSpacing(5),
                  Divider(thickness: 0.5),
                  addVerticalSpacing(5),
                  VWidgetsCupertinoSwitchWithText(
                    titleText:
                        "Alert me when somebody prints my Portfolio or Polaroid",
                    value: alertPrintPolaroid,
                    onChanged: ((p0) {
                      setState(() {
                        alertPrintPolaroid = !alertPrintPolaroid;
                      });
                      return alertPrintPolaroid;
                    }),
                  ),
                ],
              ),
            ),
          ),
          addVerticalSpacing(12),
        ]),
      ),
    );
  }
}
