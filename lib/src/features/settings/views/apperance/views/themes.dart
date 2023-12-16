import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vmodel/src/features/settings/views/apperance/widgets/themes_radio_tile_widget.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/shared/appbar/appbar.dart';
import 'package:vmodel/src/vmodel.dart';

import '../../../../../core/controller/user_prefs_controller.dart';
import '../../../../../core/models/user_prefs_config.dart';

class ThemesPage extends ConsumerStatefulWidget {
  const ThemesPage({super.key});

  @override
  ConsumerState<ThemesPage> createState() => _ThemesPageState();
}

class _ThemesPageState extends ConsumerState<ThemesPage> {
  bool isSelected = true;
  late ThemeMode _selectedThemeMode;
  // ThemeMode _selectedThemeMode;

  String dropDownCurrencyTypeValue = "Classic (White, brown)";

  // final themes = ['System', 'Classic (White-Brown)', 'Dark Theme']

  @override
  void initState() {
    super.initState();
    final userPrefsConfig = ref.read(userPrefsProvider);
    _selectedThemeMode = userPrefsConfig.value!.themeMode;
    // _preferredTheme = userPrefsConfig.value!.preferredLightTheme;
    // _selectedThemeMode = ThemeMode.system;
  }

  @override
  Widget build(BuildContext context) {
    final userPrefsConfig = ref.watch(userPrefsProvider);
    return Scaffold(
      appBar: const VWidgetsAppBar(
        leadingIcon: VWidgetsBackButton(),
        appbarTitle: "Themes",
      ),
      body: Padding(
        padding: const VWidgetsPagePadding.horizontalSymmetric(18),
        child: SingleChildScrollView(
          child: userPrefsConfig.when(data: (items) {
            return Column(
              children: [
                addVerticalSpacing(20),
                //! Currently only one theme is present that's why the isSelected bool is always true
                // ...List.generate(VModelAppThemes.values, (index) {
                //   return VWidgetsAppearanceOptionTile(
                //     title: "System (Automatic)",
                //     isSelected: _selectedThemeMode == ThemeMode.system,
                //     onTap: () {
                //       _update(items, ThemeMode.system, VModelTheme);
                //     },
                //   );
                // }),

                VWidgetsAppearanceOptionTile(
                  title: "System (Automatic)",
                  isSelected: _selectedThemeMode == ThemeMode.system,
                  onTap: () {
                    _update(items, ThemeMode.system);
                  },
                ),
                // VWidgetsAppearanceOptionTile(
                //   title: "Bambi (White-Pink)",
                //   isSelected: _selectedThemeMode == ThemeMode.light,
                //   onTap: () {
                //     _update(items, ThemeMode.light);
                //   },
                // ),
                VWidgetsAppearanceOptionTile(
                  title: "Classic (White-Brown)",
                  isSelected: _selectedThemeMode == ThemeMode.light,
                  onTap: () {
                    _update(items, ThemeMode.light);
                  },
                ),
                VWidgetsAppearanceOptionTile(
                  title: "Dark Theme",
                  // isSelected: false,
                  isSelected: _selectedThemeMode == ThemeMode.dark,
                  onTap: () {
                    _update(items, ThemeMode.dark);
                  },
                ),
                //  const VWidgetsThemes(title: "Modern (White-Brown)"),
              ],
            );
          }, error: ((error, stackTrace) {
            return Center(child: Text('Error occured'));
          }), loading: () {
            return Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }),
        ),
      ),
    );
  }

  _update(UserPrefsConfig items, ThemeMode mode) {
    setState(() {
      _selectedThemeMode = mode;
    });
    // print('[mm] selected theme mode: $_selectedThemeMode');
    ref.read(userPrefsProvider.notifier).addOrUpdatePrefsEntry(items.copyWith(
          themeMode: _selectedThemeMode,
          // preferredLightTheme: _preferredTheme,
        ));
  }
}
