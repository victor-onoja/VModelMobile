import 'package:vmodel/src/features/settings/views/apperance/widgets/themes_radio_tile_widget.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/shared/appbar/appbar.dart';
import 'package:vmodel/src/vmodel.dart';

class LanguagesPage extends StatefulWidget {
  const LanguagesPage({super.key});

  @override
  State<LanguagesPage> createState() => _LanguagesPageState();
}

class _LanguagesPageState extends State<LanguagesPage> {
  bool isSelected = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const VWidgetsAppBar(
        leadingIcon: VWidgetsBackButton(),
        appbarTitle: "Languages",
      ),
      body: Padding(
        padding: const VWidgetsPagePadding.horizontalSymmetric(18),
        child: SingleChildScrollView(
          child: Column(
            children: [
              addVerticalSpacing(20),
              //! Currently only one Language is present that's why the isSelected bool is always true
              VWidgetsAppearanceOptionTile(
                title: "English",
                isSelected: isSelected,
                onTap: () {
                  setState(() {
                    isSelected = true;
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
