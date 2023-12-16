import 'package:vmodel/src/features/settings/other_options/controller/settings_controller.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/vmodel.dart';

class InteractionSettings extends StatelessWidget {
  const InteractionSettings({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<VSettingsController>();

    return Obx(() {
      print(VSettingsController.whoCanPolaroid);
      print(controller.whoCanPolaroidSee.value);
      return Padding(
        padding:
            const EdgeInsets.only(left: 25.0, right: 25, top: 20, bottom: 25),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              addVerticalSpacing(15),
              Text(
                'Who can book me?',
                style: VModelTypography1.promptTextStyle
                    .copyWith(fontWeight: FontWeight.w600),
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
                  child: DropdownButton<String>(
                    value: controller.whoCanBookMe.value,
                    underline: Container(),
                    borderRadius: BorderRadius.circular(8),
                    isExpanded: true,
                    items: VSettingsController.whoCanType
                        .map((e) => DropdownMenuItem(
                              value: e,
                              child: Text(e),
                            ))
                        .toList(),
                    onChanged: (v) {
                      controller.whoCanBookMe(v);
                      FocusNode().unfocus();
                    },
                  ),
                ),
              ),
              addVerticalSpacing(24),
              Text(
                'Who can message me?',
                style: VModelTypography1.promptTextStyle
                    .copyWith(fontWeight: FontWeight.w600),
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
                  child: DropdownButton<String>(
                    value: controller.whoCanMessageMe.value,
                    underline: Container(),
                    borderRadius: BorderRadius.circular(8),
                    isExpanded: true,
                    items: VSettingsController.whoCanType
                        .map((e) => DropdownMenuItem(
                              value: e,
                              child: Text(e),
                            ))
                        .toList(),
                    onChanged: (v) {
                      controller.whoCanMessageMe(v);
                      FocusNode().unfocus();
                    },
                  ),
                ),
              ),
              addVerticalSpacing(24),
              Text(
                'Who can feature me?',
                style: VModelTypography1.promptTextStyle
                    .copyWith(fontWeight: FontWeight.w600),
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
                  child: DropdownButton<String>(
                    value: controller.whoCanFeatureMe.value,
                    underline: Container(),
                    borderRadius: BorderRadius.circular(8),
                    isExpanded: true,
                    items: VSettingsController.whoCanType
                        .map((e) => DropdownMenuItem(
                              value: e,
                              child: Text(e),
                            ))
                        .toList(),
                    onChanged: (v) {
                      controller.whoCanFeatureMe(v);
                      FocusNode().unfocus();
                    },
                  ),
                ),
              ),
              addVerticalSpacing(24),
              Text(
                'Who can view my polaroid?',
                style: VModelTypography1.promptTextStyle
                  ..copyWith(fontWeight: FontWeight.w600),
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
                  child: DropdownButton<String>(
                    value: controller.whoCanPolaroidSee.value,
                    underline: Container(),
                    borderRadius: BorderRadius.circular(8),
                    isExpanded: true,
                    items: VSettingsController.whoCanPolaroid
                        .map((e) => DropdownMenuItem(
                              value: e,
                              child: Text(e),
                            ))
                        .toList(),
                    onChanged: (v) {
                      controller.whoCanPolaroidSee(v);
                      FocusNode().unfocus();
                    },
                  ),
                ),
              ),
              const Spacer(),
              vWidgetsInitialButton(() {}, 'Done'),
              addVerticalSpacing(24),
            ]),
      );
    });
  }
}
