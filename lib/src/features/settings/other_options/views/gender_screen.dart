import 'package:vmodel/src/features/settings/other_options/controller/settings_controller.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/vmodel.dart';

class GenderScreen extends StatelessWidget {
  const GenderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<VSettingsController>();

    return Obx(() {
      return Padding(
        padding:
            const EdgeInsets.only(left: 25.0, right: 25, top: 20, bottom: 25),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              addVerticalSpacing(15),
              Text(
                'My Birth Gender is:',
                style: VModelTypography1.promptTextStyle
                  ..copyWith(fontWeight: FontWeight.w600),
              ),
              addVerticalSpacing(8),
              Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    selectableButton(() {
                      controller.gender('male');
                    }, 'Male', selected: controller.gender.value == 'male'),
                    addHorizontalSpacing(8),
                    selectableButton(() {
                      controller.gender('female');
                    }, 'Female', selected: controller.gender.value == 'female'),
                  ]),
              addVerticalSpacing(30),
              Text(
                'I identify as a',
                style: VModelTypography1.promptTextStyle
                  ..copyWith(fontSize: 14, fontWeight: FontWeight.w600),
              ),
              addVerticalSpacing(8),
              SizedBox(
                height: 42,
                child: Container(
                  padding: const EdgeInsets.only(left: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: VmodelColors.borderColor,
                    ),
                  ),
                  child: DropdownButton(
                    value: controller.identifyAs.value,
                    underline: Container(),

                    borderRadius: BorderRadius.circular(8),
                    isExpanded: true,
                    items: VSettingsController.indentifyTypes
                        .map(
                          (e) => DropdownMenuItem(
                            value: e,
                            child: Text(e),
                          ),
                        )
                        .toList(),
                    //   DropdownMenuItem(
                    //     value: 'non-binary',
                    //     child: Text('Non-Binary'),
                    //   ),
                    //   DropdownMenuItem(
                    //     value: 'male',
                    //     child: Text('Male'),
                    //   ),
                    //   DropdownMenuItem(
                    //     value: 'female',
                    //     child: Text('Female'),
                    //   ),
                    // ],
                    onChanged: (v) {
                      controller.identifyAs(v);
                      FocusNode().unfocus();
                    },
                  ),
                ),
              ),
              addVerticalSpacing(24),
              Row(
                children: [
                  Checkbox(
                    checkColor: Colors.white,
                    activeColor: VmodelColors.buttonColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4)),
                    value: controller.representingAPet.value,
                    onChanged: (v) => controller.representingAPet(v),
                  ),
                  Text(
                    'I\'m representing a pet',
                    style: VModelTypography1.promptTextStyle
                      ..copyWith(fontSize: 14),
                  ),
                ],
              ),
              addVerticalSpacing(24),
              vWidgetsInitialButton(() {}, 'Done'),
            ]),
      );
    });
  }
}
