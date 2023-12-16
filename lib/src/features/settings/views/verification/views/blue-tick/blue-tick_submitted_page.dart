import 'package:vmodel/src/features/settings/views/verification/views/blue-tick/blue-tick_verified_page.dart';
import 'package:vmodel/src/shared/buttons/primary_button.dart';

import '../../../../../../shared/appbar/appbar.dart';
import '../../../../../../vmodel.dart';

class BusinessTickSubmittedPage extends StatelessWidget {
  const BusinessTickSubmittedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () {
          return Future.value(false);
        },
        child: Scaffold(
            persistentFooterButtons: [
              VWidgetsPrimaryButton(
                buttonTitle: 'Done',
                onPressed: () =>
                    {navigateToRoute(context, const BlueTickVerifiedPage())},
              )
            ],
            appBar: const VWidgetsAppBar(
              appbarTitle: "Verification",
              elevation: 1,
            ),
            body: SafeArea(
                child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Center(
                  child: Text(
                      "Thank You for Your Submission! We'll Review It Within 7 Business Days and Notify You of Our Decision.",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.displayMedium)),
            ))));
  }
}
