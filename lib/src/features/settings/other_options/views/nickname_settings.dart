import 'package:vmodel/src/features/settings/other_options/controller/settings_controller.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/shared/text_fields/initial_text_field.dart';
import 'package:vmodel/src/vmodel.dart';

class NickNameSettings extends StatelessWidget {
  const NickNameSettings({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<VSettingsController>();

    return Obx(() {
      return Container(
        padding:
            const EdgeInsets.only(left: 25.0, right: 25, top: 20, bottom: 25),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          addVerticalSpacing(15),
          Text(
            'Nickname',
            style: VModelTypography1.promptTextStyle
                .copyWith(fontWeight: FontWeight.w600),
          ),
          addVerticalSpacing(8),
          SizedBox(
            height: 44,
            child: VWidgetsTextFieldWithoutTitle(
              hintText: 'Flowers',
              onSaved: (p0) {
                controller.bio(p0);
              },
              onChanged: (p0) => controller.bio(p0),
              onFieldSubmitted: (p0) => controller.bio(p0),
            ),
          ),
          addVerticalSpacing(19),
          vWidgetsInitialButton(
            controller.bio.value.trim().length < 4 ? null : () {},
            'Done',
          ),
        ]),
      );
    });
  }
}
