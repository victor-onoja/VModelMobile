import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/shared/appbar/appbar.dart';
import 'package:vmodel/src/vmodel.dart';

import '../../../../../res/icons.dart';
import '../widgets/default_icon_tile.dart';

class DefaultIconPage extends StatefulWidget {
  const DefaultIconPage({super.key});

  @override
  State<DefaultIconPage> createState() => _DefaultIconPageState();
}

class _DefaultIconPageState extends State<DefaultIconPage> {
  bool isSelected = true;
  int _currentlySelectedIndex = 0;

  String dropDownCurrencyTypeValue = "Classic (White, brown)";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const VWidgetsAppBar(
        leadingIcon: VWidgetsBackButton(),
        appbarTitle: "Default Icon",
      ),
      body: Padding(
        padding: const VWidgetsPagePadding.horizontalSymmetric(18),
        child: SingleChildScrollView(
          child: Column(
            children: [
              addVerticalSpacing(20),
              //! Currently only one theme is present that's why the isSelected bool is always true
              VWidgetsAppearanceDefaultIconTile(
                title: "Brown",
                isSelected: _currentlySelectedIndex == 0,
                svgIconAsset: VIcons.defaultIconBrown,
                onTap: () {
                  setState(() {
                    _currentlySelectedIndex = 0;
                  });
                },
              ),
              VWidgetsAppearanceDefaultIconTile(
                title: "Butter",
                isSelected: _currentlySelectedIndex == 1,
                svgIconAsset: VIcons.defaultIconButter,
                onTap: () {
                  setState(() {
                    _currentlySelectedIndex = 1;
                  });
                },
              ),
              VWidgetsAppearanceDefaultIconTile(
                title: "CyberPunk",
                isSelected: _currentlySelectedIndex == 2,
                svgIconAsset: VIcons.defaultIconCyberpunk,
                onTap: () {
                  setState(() {
                    _currentlySelectedIndex = 2;
                  });
                },
              ),
              //  const VWidgetsThemes(title: "Modern (White-Brown)"),
            ],
          ),
        ),
      ),
    );
  }
}
