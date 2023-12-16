import 'package:flutter_portal/flutter_portal.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/shared/appbar/appbar.dart';
import 'package:vmodel/src/shared/buttons/primary_button.dart';
import 'package:vmodel/src/shared/response_widgets/toast.dart';
import 'package:vmodel/src/shared/text_fields/dropdown_text_field.dart';
import 'package:vmodel/src/shared/text_fields/primary_text_field.dart';
import 'package:vmodel/src/vmodel.dart';

import '../../../../core/utils/costants.dart';
import '../../../../core/utils/enum/ethnicity_enum.dart';
import '../../../../core/utils/enum/size_enum.dart';
import '../../../../core/utils/validators_mixins.dart';
import '../../../../res/icons.dart';
import '../../../../shared/rend_paint/render_svg.dart';
import '../../../../shared/switch/primary_switch.dart';
import '../../../../shared/text_fields/description_text_field.dart';
import '../../../jobs/create_jobs/controller/create_job_controller.dart';

final dates = StateProvider.autoDispose<List>((ref) => []);

class CreateBookingSecondPage extends ConsumerStatefulWidget {
  // final String isPricePerService;
  const CreateBookingSecondPage({super.key, required this.jobType
      //  required this.isPricePerService
      });
  final String jobType;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CreateBookingSecondPageState();
}

class _CreateBookingSecondPageState
    extends ConsumerState<CreateBookingSecondPage> {
  double slideValue = 18;
  double amountSlide = 0;

  String jobType = "On-site";
  String duration = "Full-Day";
  String arrivalTime = "Morning";
  String gender = "Male";
  Ethnicity ethinicity = Ethnicity.values.first;
  String budget = "Per Day";
  String identifiedGender = "Indentified Gender";
  String heightInches = "1";
  String heightFeet = "5";
  ModelSize size = ModelSize.values.first; //= "XL";
  String complexion = "Dark/Melanin";
  bool isDigitalContent = true;
  String usageType = VConstants.kUsageTypes.first; //"Usage type";
  String usageLength = VConstants.kUsageLengthOptions.first; //"Usage Length";
  List<String> _usageLengthOptions = [];
  final RangeValues _ageRangeValues = const RangeValues(18, 30);
  final String _selectedLocation = "";

  TextEditingController dateTime = TextEditingController();
  // final _locationController = TextEditingController();
  final _deliverablesController = TextEditingController();
  final _heightController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool creativeBriefSwitchValue = false;
  String talentType = "Model";
  String height = "5'11";
  String weight = "XL";
  String deliveryDateType = "Range";

  String preferredGender = "Male";

  // @override
  // bool get wantKeepAlive => true;

  final _briefTextController = TextEditingController();
  final _briefLinkController = TextEditingController();

  @override
  void initState() {
    super.initState();
    //Taking out the last option from the usage length options
    _usageLengthOptions = VConstants.kUsageLengthOptions
        .sublist(0, VConstants.kUsageLengthOptions.length - 1);
  }

  @override
  Widget build(BuildContext context) {
    final tempJobData = ref.watch(jobDataProvider);

    return Portal(
      child: Scaffold(
        appBar: VWidgetsAppBar(
          backgroundColor: VmodelColors.white,
          appBarHeight: 50,
          leadingIcon: const VWidgetsBackButton(),

          appbarTitle: "Create a job",
          // trailingIcon: [
          //   Padding(
          //     padding: const EdgeInsets.only(top: 12),
          //     child: VWidgetsTextButton(
          //       text: 'Create',
          //       //Implement the logic here
          //       onPressed: () {},
          //     ),
          //   ),
          // ],
        ),
        body: SingleChildScrollView(
          padding: const VWidgetsPagePadding.horizontalSymmetric(18),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                addVerticalSpacing(15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "I have a creative brief",
                      style:
                          Theme.of(context).textTheme.displayMedium!.copyWith(
                              // color: VmodelColors.primaryColor,
                              fontWeight: FontWeight.w600),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 12.0),
                      child: VWidgetsSwitch(
                        swicthValue: creativeBriefSwitchValue,
                        onChanged: (p0) {
                          setState(() {
                            creativeBriefSwitchValue =
                                !creativeBriefSwitchValue;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                addVerticalSpacing(15),
                if (creativeBriefSwitchValue)
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      VWidgetsDescriptionTextFieldWithTitle(
                        controller: _briefTextController,
                        label: "Create your brief (Optional)",
                        hintText: "Write in detail what work needs to be done",
                        minLines: 4,
                      ),
                      addVerticalSpacing(25),
                      Text(
                        "Attach brief (optional)",
                        style:
                            Theme.of(context).textTheme.displayMedium!.copyWith(
                                  // color: VmodelColors.primaryColor,
                                  fontWeight: FontWeight.w600,
                                ),
                      ),
                      addVerticalSpacing(5),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Flexible(
                            child: VWidgetsPrimaryButton(
                              onPressed: () {},
                              buttonTitle: "Upload",
                              enableButton: true,
                            ),
                          ),
                          addHorizontalSpacing(10),
                          Flexible(
                              child: Container(
                            height: 40,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurface),
                                borderRadius: BorderRadius.circular(8)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Flexible(
                                    child: Text("",
                                        overflow: TextOverflow.ellipsis,
                                        style: Theme.of(context)
                                            .textTheme
                                            .displayMedium),
                                  ),
                                ],
                              ),
                            ),
                          )),
                          addHorizontalSpacing(10),
                          GestureDetector(
                            onTap: () {},
                            child: const RenderSvg(svgPath: VIcons.remove),
                          )
                        ],
                      ),

                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   crossAxisAlignment: CrossAxisAlignment.center,
                      //   children: [
                      //     Flexible(
                      //       child: VWidgetsPrimaryButton(
                      //         onPressed: () {},
                      //         buttonTitle: "Upload",
                      //         enableButton: true,
                      //       ),
                      //     ),
                      //     addHorizontalSpacing(10),
                      //     Flexible(
                      //         child: Container(
                      //       height: 40,
                      //       decoration: BoxDecoration(
                      //           border: Border.all(
                      //             // color: VmodelColors.primaryColor,
                      //             color:
                      //                 Theme.of(context).colorScheme.onSurface,
                      //           ),
                      //           borderRadius: BorderRadius.circular(8)),
                      //       child: Padding(
                      //         padding: const EdgeInsets.all(8.0),
                      //         child: Row(
                      //           children: [
                      //             Flexible(
                      //               child: Text("File Name.extension",
                      //                   overflow: TextOverflow.ellipsis,
                      //                   style: Theme.of(context)
                      //                       .textTheme
                      //                       .displayMedium),
                      //             ),
                      //             GestureDetector(
                      //               onTap: () {},
                      //               child: const RenderSvg(
                      //                   svgPath: VIcons.galleryDelete),
                      //             )
                      //           ],
                      //         ),
                      //       ),
                      //     ))
                      //   ],
                      // ),
                      addVerticalSpacing(25),
                      VWidgetsPrimaryTextFieldWithTitle(
                        label: "Link to brief (Optional)",
                        hintText: "https://vmodel.app/brief-document.html",
                        controller: _briefLinkController,
                        //validator: ValidationsMixin.isNotEmpty(value),
                        //keyboardType: TextInputType.emailAddress,
                        //onSaved: (){},
                      ),
                      addVerticalSpacing(10),
                    ],
                  ),
                addVerticalSpacing(10),
                VWidgetsPrimaryTextFieldWithTitle(
                  controller: _deliverablesController,
                  label: "Deliverables type (Required)",
                  hintText: "Eg. What do you expect to receive?",
                  validator: VValidatorsMixin.isNotEmpty,
                  isIncreaseHeightForErrorText: true,
                  //keyboardType: TextInputType.emailAddress,
                  //onSaved: (){},
                ),
                addVerticalSpacing(8),
                VWidgetsDropDownTextField<bool>(
                  fieldLabel: "Are you receiving any digital content?",
                  hintText: "",
                  onChanged: (val) {
                    setState(() {
                      isDigitalContent = val;
                    });
                  },
                  value: isDigitalContent,
                  // options: const ["Yes", "No"],
                  options: const [false, true],
                  // getLabel: (String value) => value,
                  customDisplay: (value) => value ? "Yes" : "No",
                ),
                if (isDigitalContent)
                  Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Flexible(
                            child: VWidgetsDropDownTextField(
                              fieldLabel: "License",
                              hintText: "",
                              onChanged: (val) {
                                setState(() {
                                  usageType = val;
                                });
                              },
                              value: usageType,
                              // options: const ["Usage type", "Usage type 2"],
                              options: VConstants.kUsageTypes,
                              getLabel: (String value) => value,
                            ),
                          ),
                          addHorizontalSpacing(10),
                          Flexible(
                            child: VWidgetsDropDownTextField(
                              fieldLabel: "",
                              hintText: "",
                              onChanged: (val) {
                                setState(() {
                                  usageLength = val;
                                });
                              },
                              value: usageLength,
                              // options: const ["Usage Length", "Usage Length 2"],
                              options: _usageLengthOptions,
                              getLabel: (String value) => value,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                addVerticalSpacing(25),
                VWidgetsPrimaryButton(
                  enableButton: true,
                  onPressed: () async {
                    if (!_formKey.currentState!.validate()) {
                      VWidgetShowResponse.showToast(ResponseEnum.warning,
                          message: "Please fill all required fields");
                      return;
                    }

                    final temp = ref
                        .read(jobDataProvider.notifier)
                        .state
                        ?.copyWith(
                          location: {
                            "latitude": "0",
                            "longitude": "0",
                            "locationName": _selectedLocation,
                          },
                          deliverablesType: _deliverablesController.text.trim(),
                          isDigitalContent: isDigitalContent,
                          usageType: usageType,
                          usageLength: usageLength,
                          ethnicity: ethinicity,
                          minAge: _ageRangeValues.start.round(),
                          maxAge: _ageRangeValues.end.round(),
                          height: {
                            "value": int.parse(_heightController.text),
                            "unit": "cm"
                          },
                          size: size,
                          complexion: complexion,
                        );
                    ref.read(jobDataProvider.notifier).state = temp;

                    // VLoader.changeLoadingState(true);
                    // final success = await ref
                    //     .read(selectedDateTimeAndDurationProvider.notifier)

                    // if (success) {
                    //   ref.invalidate(selectedDateTimeAndDurationProvider);
                    //   ref.invalidate(jobsProvider);
                    //   if (mounted) {
                    //     goBack(context);
                    //     goBack(context);
                    //   }
                    // }

                    // VLoader.changeLoadingState(false);
                    // print('GGGGGGGGGBBBBBBBBB $temp');
                  },
                  buttonTitle: "Continue to payment",
                ),
                addVerticalSpacing(50)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
