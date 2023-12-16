import 'package:vmodel/src/features/settings/other_options/controller/settings_controller.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/shared/text_fields/description_text_field.dart';
import 'package:vmodel/src/shared/text_fields/dropdown_text_field.dart';
import 'package:vmodel/src/shared/text_fields/initial_text_field.dart';
import 'package:vmodel/src/shared/text_fields/primary_text_field.dart';
import 'package:vmodel/src/vmodel.dart';

class ProfileSettings extends StatefulWidget {
  const ProfileSettings({super.key});

  @override
  State<ProfileSettings> createState() => _ProfileSettingsState();
}

class _ProfileSettingsState extends State<ProfileSettings> {
  String dropdownIdentifyValue = "Male";
  String dropdownFeetValue = '4';
  String dropdownInchesValue = '0';
  String dropdownEthnicityValue = "Other";
  String dropdownBodyTypeValue = "Slim";

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<VSettingsController>();

    return Obx(() {
      return Padding(
        padding:
            const EdgeInsets.only(left: 25.0, right: 25, top: 20, bottom: 25),
        child: SingleChildScrollView(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const VWidgetsPrimaryTextFieldWithTitle(
                  label: "nickname",
                  hintText: "Ex. Vmodel",
                ),
                addVerticalSpacing(10),
                VWidgetsDescriptionTextFieldWithTitle(
                  maxLength: 3,
                  label: "Bio",
                  hintText: "Here's my Bio ...",
                  onSaved: (p0) {
                    controller.bio(p0);
                  },
                  onChanged: (p0) => controller.bio(p0),
                ),
                addVerticalSpacing(25),
                Text(
                  'Where are you based?',
                  style: Theme.of(context).textTheme.displayMedium!.copyWith(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
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
                addVerticalSpacing(25),
                Text(
                  'My Birth Gender is:',
                  style: Theme.of(context).textTheme.displayMedium!.copyWith(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                ),
                addVerticalSpacing(8),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  selectableButton(() {
                    controller.gender('male');
                  }, 'Male', selected: controller.gender.value == 'male'),
                  addHorizontalSpacing(25),
                  selectableButton(() {
                    controller.gender('female');
                  }, 'Female', selected: controller.gender.value == 'female'),
                ]),
                addVerticalSpacing(20),
                VWidgetsDropDownTextField(
                  fieldLabel: "I Identify as",
                  hintText: "",
                  value: dropdownIdentifyValue,
                  onChanged: (val) {
                    setState(() {
                      dropdownIdentifyValue = val;
                    });
                  },
                  options: const [
                    'Male',
                    'Female',
                    'I\'m a Pet',
                    'Androgyne',
                    'Bigender',
                    'Butch',
                    'Cisgender',
                    'Gender Expansive',
                    'Gender Fluid',
                    'Gender Outlaw',
                    'Gender Queer',
                    'Masculine of center',
                    'Non-binary',
                    'Omnigender',
                    'Polygender and Pangender',
                    'Transgender',
                    'Trans',
                    'Two Spirit'
                  ],
                ),
                addVerticalSpacing(10),
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
                addVerticalSpacing(20),
                VWidgetsDropDownTextField(
                  fieldLabel: "What's your ethnicity",
                  hintText: "",
                  value: dropdownEthnicityValue,
                  onChanged: (val) {
                    setState(() {
                      dropdownEthnicityValue = val;
                    });
                  },
                  options: const [
                    "White",
                    "Asian",
                    "Black",
                    "Native American"
                        "Hispanic or Latino",
                    "Pacific Islander",
                    "Mixed",
                    "Other"
                  ],
                ),

                addVerticalSpacing(20),
                Row(
                  children: [
                    Flexible(
                      child: VWidgetsDropDownTextField(
                        fieldLabel: "Height in Feet",
                        hintText: "",
                        value: dropdownFeetValue,
                        onChanged: (val) {
                          setState(() {
                            dropdownFeetValue = val;
                          });
                        },
                        options: const ['4', '5', '6', '7', '8'],
                      ),
                    ),
                    addHorizontalSpacing(6),
                    Flexible(
                      child: VWidgetsDropDownTextField(
                        fieldLabel: "Inches",
                        hintText: "",
                        value: dropdownInchesValue,
                        onChanged: (val) {
                          setState(() {
                            dropdownInchesValue = val;
                          });
                        },
                        options: const [
                          '0',
                          '1',
                          '2',
                          '3',
                          '4',
                          '5',
                          '6',
                          '7',
                          '8',
                          '9',
                          '10',
                          '11',
                          '12'
                        ],
                      ),
                    ),
                  ],
                ),
                addVerticalSpacing(40),
                // VWidgetsDropDownTextField(
                //         fieldLabel: "Body Type",
                //         hintText: "",
                //         value: dropdownBodyTypeValue,
                //         onChanged: (val) {
                //           setState(() {
                //             dropdownBodyTypeValue = val;
                //           });
                //         },
                //         options:  controller.gender.value == 'male' ?
                //         ["Slim","Tone","Muscular","Stocky","Large"]
                //         :["Slim","Rectangle","Triangle","Hourglass","Inverted","Round"],
                //       ),
                // addVerticalSpacing(20),
                vWidgetsInitialButton(() {}, 'Done'),
                addVerticalSpacing(25),
              ]),
        ),
      );
    });
  }
}
