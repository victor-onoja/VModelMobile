import 'package:vmodel/src/features/settings/other_options/controller/settings_controller.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/shared/text_fields/initial_text_field.dart';
import 'package:vmodel/src/vmodel.dart';

class LocationScreen extends StatelessWidget {
  const LocationScreen({super.key});

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
                'Where are you based?',
                style: VModelTypography1.promptTextStyle
                    .copyWith(fontWeight: FontWeight.w600),
              ),
              addVerticalSpacing(8),
              Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.location_on,
                      size: 18,
                    ),
                    addHorizontalSpacing(4),
                    Text(
                      'Use geoloaction to find my accurate location (city)',
                      style: VModelTypography1.promptTextStyle
                          .copyWith(fontSize: 12),
                    ),
                  ]),
              addVerticalSpacing(20),
              SizedBox(
                height: 42,
                child: VWidgetsTextFieldWithoutTitle(
                  // maxLines: 1,
                  hintText: 'London ',
                  suffix: const Icon(Icons.search),
                  onSaved: (p0) {
                    controller.bio(p0);
                  },
                  onChanged: (p0) => controller.location(p0),
                  onFieldSubmitted: (p0) => controller.location(p0),
                ),
              ),
              addVerticalSpacing(24),
              vWidgetsInitialButton(
                controller.location.value.trim().length < 4 ? null : () {},
                'Done',
              ),
            ]),
      );
    });
  }
}
