import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/shared/appbar/appbar.dart';
import 'package:vmodel/src/vmodel.dart';

import '../../../../../shared/switch/primary_switch.dart';

class HaptickFeedbackSettings extends StatefulWidget {
  const HaptickFeedbackSettings({super.key});

  @override
  State<HaptickFeedbackSettings> createState() =>
      _HaptickFeedbackSettingsState();
}

class _HaptickFeedbackSettingsState extends State<HaptickFeedbackSettings> {
  final isSelected = ValueNotifier(true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const VWidgetsAppBar(
        leadingIcon: VWidgetsBackButton(),
        appbarTitle: "Haptic Feedback",
      ),
      body: Padding(
        padding: const VWidgetsPagePadding.horizontalSymmetric(18),
        child: SingleChildScrollView(
          child: Column(
            children: [
              addVerticalSpacing(20),
              //! Currently only one theme is present that's why the isSelected bool is always true
              ValueListenableBuilder(
                  valueListenable: isSelected,
                  builder: (context, value, _) {
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 6),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Haptics Feedback",
                            style: Theme.of(context)
                                .textTheme
                                .displayLarge!
                                .copyWith(
                                  fontWeight: FontWeight.w500,
                                ),
                          ),
                          VWidgetsSwitch(
                              swicthValue: value,
                              onChanged: (newValue) {
                                isSelected.value = newValue;
                              }),
                        ],
                      ),
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
