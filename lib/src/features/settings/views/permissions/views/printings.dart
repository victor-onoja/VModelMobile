import 'package:vmodel/src/features/settings/widgets/cupertino_switch_card.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/shared/appbar/appbar.dart';
import 'package:vmodel/src/vmodel.dart';

class PrintingSettingsPage extends StatefulWidget {
  const PrintingSettingsPage({super.key});

  @override
  State<PrintingSettingsPage> createState() => _PrintingSettingsPageState();
}

class _PrintingSettingsPageState extends State<PrintingSettingsPage> {
  bool alertReceiveBooking = false;
  bool alertFeatureMe = false;
  bool alertLikesContent = false;
  bool alertNewJobMatches = false;
  bool alertReceiveOffer = false;
  bool alertProfileVisit = false;
  bool alertSilenceAllMessages = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const VWidgetsAppBar(
        appbarTitle: "Print Settings",
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
                    titleText:
                        "Allow businesses & bookers to print my polaroid",
                    value: alertReceiveBooking,
                    onChanged: ((p0) {
                      setState(() {
                        alertReceiveBooking = !alertReceiveBooking;
                      });
                    }),
                  ),
                  addVerticalSpacing(6),
                  const Divider(
                    thickness: 0.5,
                  ),
                  addVerticalSpacing(6),
                  VWidgetsCupertinoSwitchWithText(
                    titleText:
                        "Allow businesses & bookers to print my portfolio",
                    value: alertFeatureMe,
                    onChanged: ((p0) {
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
