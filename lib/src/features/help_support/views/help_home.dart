import 'package:vmodel/src/core/utils/browser_laucher.dart';
import 'package:vmodel/src/features/help_support/views/report_a_bug_page.dart';
import 'package:vmodel/src/features/help_support/views/report_illegal_page.dart';
import 'package:vmodel/src/features/help_support/views/reportsPage.dart';
import 'package:vmodel/src/features/settings/widgets/settings_submenu_tile_widget.dart';
import 'package:vmodel/src/shared/appbar/appbar.dart';
import 'package:vmodel/src/vmodel.dart';

import '../../beta_dashboard/views/beta_dashboard_browser.dart';
import 'report_abuse_or_spam_page.dart';

class HelpAndSupportMainView extends StatelessWidget {
  const HelpAndSupportMainView({super.key});
  static const routeName = 'helpAndSupport';

  @override
  Widget build(BuildContext context) {
    List helpAndSupportMenuItems = [
      VWidgetsSettingsSubMenuTileWidget(
          title: "Report a bug",
          onTap: () {
            navigateToRoute(context, const ReportABugHomePage());
          }),
      VWidgetsSettingsSubMenuTileWidget(
          title: "Report abuse or spam",
          onTap: () {
            navigateToRoute(context, const ReportAbuseSpamPage());
          }),
      VWidgetsSettingsSubMenuTileWidget(
          title: "Report something illegal",
          onTap: () {
            navigateToRoute(context, const ReportIllegalPage());
          }),
      VWidgetsSettingsSubMenuTileWidget(
          title: "Reports",
          onTap: () {
            navigateToRoute(context, const ReportsPage());
          }),
      VWidgetsSettingsSubMenuTileWidget(
          title: "Size Guide",
          onTap: () {
            VUtilsBrowserLaucher.lauchWebBrowserWithUrl(
                "afrogarm.com/size-guide");
          }),
      VWidgetsSettingsSubMenuTileWidget(
          title: "Terms & Conditions",
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (builder) => const BetaDashBoardWeb(
                    title: 'Terms & Conditions', url: 'https://vmodel.app/')));
          }),
    ];

    return Scaffold(
      appBar: const VWidgetsAppBar(
        leadingIcon: VWidgetsBackButton(),
        appBarHeight: 50,
        appbarTitle: "Help and support",
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 25.0),
        child: Container(
          margin: const EdgeInsets.only(
            left: 18,
            right: 18,
          ),
          child: ListView.separated(
              itemBuilder: ((context, index) => helpAndSupportMenuItems[index]),
              separatorBuilder: (context, index) => const Divider(),
              itemCount: helpAndSupportMenuItems.length),
        ),
      ),
    );
  }
}
