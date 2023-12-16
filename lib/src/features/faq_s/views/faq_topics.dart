import 'package:vmodel/src/res/icons.dart';
import 'package:vmodel/src/shared/appbar/appbar.dart';
import 'package:vmodel/src/vmodel.dart';

import '../../settings/widgets/settings_submenu_tile_widget_with_icon.dart';

class FAQsTopics extends StatelessWidget {
  const FAQsTopics({super.key});

  @override
  Widget build(BuildContext context) {
    List fAQsTopics = [
      VWidgetsSettingsSubMenuWithSuffixTileWidget(
          title: "Account Settings",
          svgPath: VIcons.accountHelpIcon,
          onTap: () {}),
      VWidgetsSettingsSubMenuWithSuffixTileWidget(
          title: "Login and Password",
          svgPath: VIcons.loginHelpIcon,
          onTap: () {}),
      VWidgetsSettingsSubMenuWithSuffixTileWidget(
          title: "Privacy and Security",
          svgPath: VIcons.privacyHelpIcon,
          onTap: () {}),
    ];

    return Scaffold(
      appBar: const VWidgetsAppBar(
        appbarTitle: "FAQs Topics",
        leadingIcon: VWidgetsBackButton(),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 25.0),
        child: Container(
          margin: const EdgeInsets.only(
            left: 18,
            right: 18,
          ),
          child: ListView.separated(
              itemBuilder: ((context, index) => fAQsTopics[index]),
              separatorBuilder: (context, index) => const Divider(),
              itemCount: fAQsTopics.length),
        ),
      ),
    );
  }
}
