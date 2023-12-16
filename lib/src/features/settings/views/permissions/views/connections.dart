import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vmodel/src/core/controller/app_user_controller.dart';
import 'package:vmodel/src/features/settings/widgets/cupertino_switch_card.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/shared/appbar/appbar.dart';
import 'package:vmodel/src/vmodel.dart';

class ConnectionsSettingsPage extends ConsumerStatefulWidget {
  const ConnectionsSettingsPage({super.key});

  @override
  ConsumerState<ConnectionsSettingsPage> createState() =>
      _ConnectionsSettingsPageState();
}

class _ConnectionsSettingsPageState
    extends ConsumerState<ConnectionsSettingsPage> {
  bool alertReceiveBooking = false;
  bool alertFeatureMe = true;
  bool alertLikesContent = false;
  bool alertNewJobMatches = false;
  bool alertReceiveOffer = false;
  bool alertProfileVisit = false;
  bool alertSilenceAllMessages = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const VWidgetsAppBar(
        appbarTitle: "Connections Settings",
        leadingIcon: VWidgetsBackButton(),
      ),
      body: Padding(
        padding: const VWidgetsPagePadding.horizontalSymmetric(18),
        child: Column(children: [
          addVerticalSpacing(15),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  VWidgetsCupertinoSwitchWithText(
                    titleText: "Allow connections to message me",
                    value: alertReceiveBooking,
                    onChanged: ((p0) {
                      setState(() {
                        alertReceiveBooking = !alertReceiveBooking;
                      });
                    }),
                  ),
                  addVerticalSpacing(3),
                  const Divider(
                    thickness: 0.5,
                  ),
                  addVerticalSpacing(3),
                  VWidgetsCupertinoSwitchWithText(
                    titleText: "Allow connections to view my network",
                    value: alertFeatureMe,
                    onChanged: ((p0) {
                      ref
                          .read(appUserProvider.notifier)
                          .updateProfile(allowConnectionView: false);
                      setState(() {
                        alertFeatureMe = !alertFeatureMe;
                      });
                    }),
                  ),
                  addVerticalSpacing(6),
                  const Divider(
                    thickness: 0.5,
                  ),
                  // addVerticalSpacing(6),
                  // VWidgetsCupertinoSwitchWithText(
                  //   titleText: "Alert me when someone likes my content",
                  //   value: alertLikesContent,
                  //   onChanged: ((p0) {
                  //     setState(() {
                  //       alertLikesContent = !alertLikesContent;
                  //     });
                  //   }),
                  // ),
                  // addVerticalSpacing(6),
                  // VWidgetsCupertinoSwitchWithText(
                  //   titleText: "Alert me when a new job matches my settings",
                  //   value: alertNewJobMatches,
                  //   onChanged: ((p0) {
                  //     setState(() {
                  //       alertNewJobMatches = !alertNewJobMatches;
                  //     });
                  //     return alertNewJobMatches;
                  //   }),
                  // ),
                  // addVerticalSpacing(6),
                  // VWidgetsCupertinoSwitchWithText(
                  //   titleText: "Alert me when I receive an offer",
                  //   value: alertReceiveOffer,
                  //   onChanged: ((p0) {
                  //     setState(() {
                  //       alertReceiveOffer = !alertReceiveOffer;
                  //     });
                  //   }),
                  // ),
                  // addVerticalSpacing(6),
                  // VWidgetsCupertinoSwitchWithText(
                  //   titleText: "Alert me when someone visits my profile",
                  //   value: alertProfileVisit,
                  //   onChanged: ((p0) {
                  //     setState(() {
                  //       alertProfileVisit = !alertProfileVisit;
                  //     });
                  //   }),
                  // ),
                  // addVerticalSpacing(6),
                  // VWidgetsCupertinoSwitchWithText(
                  //   titleText: "Silence all messages on dates I'm unavailabe",
                  //   value: alertSilenceAllMessages,
                  //   onChanged: ((p0) {
                  //     setState(() {
                  //       alertSilenceAllMessages = !alertSilenceAllMessages;
                  //     });
                  //     return alertSilenceAllMessages;
                  //   }),
                  // ),
                ],
              ),
            ),
          ),
          addVerticalSpacing(40),
        ]),
      ),
    );
  }
}
