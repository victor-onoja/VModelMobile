import 'package:vmodel/src/features/settings/other_options/controller/settings_controller.dart';
import 'package:vmodel/src/shared/buttons/initial_button.dart';
import 'package:vmodel/src/shared/text_fields/initial_text_field.dart';
import 'package:vmodel/src/vmodel.dart';

class BioScreen extends StatelessWidget {
  const BioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<VSettingsController>();

    return Obx(() {
      return Column(children: [
        Padding(
          padding:
              const EdgeInsets.only(left: 25.0, right: 25, top: 20, bottom: 25),
          child: VWidgetsTextFieldWithoutTitle(
            // minLines: 5,
            // maxLength: 100,
            hintText: 'Here\'s my Bio ',
            onSaved: (p0) {
              controller.bio(p0);
            },
            onChanged: (p0) => controller.bio(p0),
            onFieldSubmitted: (p0) => controller.bio(p0),
          ),
        ),
        vWidgetsInitialButton(
            controller.bio.value.trim().length < 10 ? null : () {}, 'Done'),
      ]);
    });
  }
}
