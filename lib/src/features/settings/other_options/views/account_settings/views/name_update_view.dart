import 'package:vmodel/src/features/settings/other_options/controller/account_settings_controller.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/shared/text_fields/initial_text_field.dart';
import 'package:vmodel/src/vmodel.dart';

class NameUpdateView extends StatelessWidget {
  const NameUpdateView({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<AccountSettignsController>();

    return Obx(() {
      return Padding(
        padding:
            const EdgeInsets.only(left: 25.0, right: 25, top: 20, bottom: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'First Name',
              style: VModelTypography1.promptTextStyle
                  .copyWith(fontWeight: FontWeight.w600),
            ),
            addVerticalSpacing(8),
            VWidgetsTextFieldWithoutTitle(
              hintText: 'First Name',
              onSaved: (p0) {
                controller.firstName(p0);
              },
              onChanged: (p0) => controller.firstName(p0),
              onFieldSubmitted: (p0) => controller.firstName(p0),
            ),
            addVerticalSpacing(16),
            Text(
              'Last Name',
              style: VModelTypography1.promptTextStyle
                  .copyWith(fontWeight: FontWeight.w600),
            ),
            addVerticalSpacing(8),
            VWidgetsTextFieldWithoutTitle(
              hintText: 'Last Name',
              onSaved: (p0) {
                controller.lastName(p0);
              },
              onChanged: (p0) => controller.lastName(p0),
              onFieldSubmitted: (p0) => controller.lastName(p0),
            ),
            const Spacer(),
            vWidgetsInitialButton(
              controller.firstName.value.trim().length < 4 ? null : () {},
              'Done',
            ),
            addVerticalSpacing(24)
          ],
        ),
      );
    });
  }
}
