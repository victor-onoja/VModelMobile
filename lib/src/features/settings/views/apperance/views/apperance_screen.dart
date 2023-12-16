import 'package:vmodel/src/features/settings/views/apperance/views/languages.dart';
import 'package:vmodel/src/features/settings/views/apperance/views/themes.dart';
import 'package:vmodel/src/features/settings/widgets/settings_submenu_tile_widget.dart';
import 'package:vmodel/src/shared/appbar/appbar.dart';
import 'package:vmodel/src/vmodel.dart';

import 'default_icon.dart';
import 'haptics_page.dart';

class ApperanceHomepage extends StatefulWidget {
  const ApperanceHomepage({super.key});

  @override
  State<ApperanceHomepage> createState() => _ApperanceHomepageState();
}

class _ApperanceHomepageState extends State<ApperanceHomepage> {
  @override
  Widget build(BuildContext context) {
    List appearanceItems = [
      VWidgetsSettingsSubMenuTileWidget(
          title: "Themes",
          onTap: () {
            navigateToRoute(context, const ThemesPage());
          }),
      VWidgetsSettingsSubMenuTileWidget(
          title: "Default Language",
          onTap: () {
            navigateToRoute(context, const LanguagesPage());
          }),
      VWidgetsSettingsSubMenuTileWidget(
          title: "Default Icon",
          onTap: () {
            navigateToRoute(context, const DefaultIconPage());
          }),
      VWidgetsSettingsSubMenuTileWidget(
          title: "Haptic Feedback",
          onTap: () {
            navigateToRoute(context, const HaptickFeedbackSettings());
          }),
    ];
    return Scaffold(
      appBar: const VWidgetsAppBar(
        leadingIcon: VWidgetsBackButton(),
        appbarTitle: "Appearance",
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 25.0),
        child: Container(
          margin: const EdgeInsets.only(
            left: 18,
            right: 18,
          ),
          child: ListView.separated(
              itemBuilder: ((context, index) => appearanceItems[index]),
              separatorBuilder: (context, index) => const Divider(),
              itemCount: appearanceItems.length),
        ),
      ),
    );
  }
}
