import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_portal/flutter_portal.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vmodel/src/features/dashboard/new_profile/controller/user_jobs_controller.dart';
import 'package:vmodel/src/features/jobs/job_market/controller/jobs_controller.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/shared/appbar/appbar.dart';
import 'package:vmodel/src/shared/buttons/primary_button.dart';
import 'package:vmodel/src/shared/loader/loader_progress.dart';
import 'package:vmodel/src/shared/response_widgets/toast.dart';
import 'package:vmodel/src/shared/text_fields/dropdown_text_field.dart';
import 'package:vmodel/src/shared/text_fields/primary_text_field.dart';
import 'package:vmodel/src/vmodel.dart';

import '../../../../core/utils/costants.dart';
import '../../../../core/utils/enum/ethnicity_enum.dart';
import '../../../../core/utils/enum/license_type.dart';
import '../../../../core/utils/enum/size_enum.dart';
import '../../../../core/utils/validators_mixins.dart';
import '../../../../shared/slider/range_slider.dart';
import '../../../../shared/text_fields/description_text_field.dart';
import '../../../../shared/text_fields/places_autocomplete_field.dart';
import '../../job_market/model/job_post_model.dart';
import '../controller/create_job_controller.dart';

final dates = StateProvider.autoDispose<List>((ref) => []);

class CreateJobSecondPage extends ConsumerStatefulWidget {
  // final String isPricePerService;
  const CreateJobSecondPage({
    super.key,
    this.isEdit = false,
    required this.jobType,
    this.job,
    //  required this.isPricePerService
  });
  final String jobType;
  final JobPostModel? job;
  final bool isEdit;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CreateJobSecondPageState();
}

class _CreateJobSecondPageState extends ConsumerState<CreateJobSecondPage> {
  double slideValue = 18;
  double amountSlide = 0;
  bool done = false;
  String jobType = "On-site";
  String duration = "Full-Day";
  String arrivalTime = "Morning";
  String gender = "Male";
  Ethnicity ethnicity = Ethnicity.values.first;
  String budget = "Per Day";
  String identifiedGender = "Indentified Gender";
  String heightInches = "1";
  String heightFeet = "5";
  ModelSize size = ModelSize.values.first; //= "XL";
  // String complexion = "Dark/Melanin";
  bool isDigitalContent = true;
  bool hasAdvancedRequirements = false;
  // String usageType = VConstants.kUsageTypes.first; //"Usage type";
  LicenseType usageType = LicenseType.values.first; //"Usage type";
  String usageLength = VConstants.kUsageLengthOptions.first; //"Usage Length";
  List<String> _usageLengthOptions = [];
  RangeValues _ageRangeValues = const RangeValues(18, 30);
  String _selectedLocation = "";

  TextEditingController dateTime = TextEditingController();
  // final _locationController = TextEditingController();
  final _deliverablesController = TextEditingController();
  final _heightController = TextEditingController();
  bool _showButtonLoader = false;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    //Taking out the last option from the usage length options
    _usageLengthOptions = VConstants.kUsageLengthOptions
        .sublist(0, VConstants.kUsageLengthOptions.length - 1);

    if (widget.job != null) {
      initWithExistingJobData();
    }
  }

  void initWithExistingJobData() {
    print('[aa] == ${widget.job!.usageType}');
    _selectedLocation = widget.job!.jobLocation.locationName;

    //   ref.read(jobDataProvider.notifier).state.copyWith(
    // location: {
    //   "latitude": "0",
    //   "longitude": "0",
    //   "locationName": _selectedLocation,
    // },
    _deliverablesController.text = widget.job!.deliverablesType;
    isDigitalContent = widget.job!.isDigitalContent;
    usageType =
        LicenseType.licenseTypeByApiValue(widget.job!.usageType?.name ?? '');
    usageLength =
        widget.job!.usageLength?.name ?? VConstants.kUsageLengthOptions.first;
    hasAdvancedRequirements = widget.job!.hasAdvancedRequirements;
    ethnicity = widget.job!.ethnicity ?? Ethnicity.values.first;
    if (widget.job!.minAge > 0 && widget.job!.maxAge > 0) {
      _ageRangeValues = RangeValues(
          widget.job!.minAge.toDouble(), widget.job!.maxAge.toDouble());
    }
    _heightController.text = widget.job!.talentHeight?['value'] ?? '';
    size = widget.job!.size ?? ModelSize.values.first;
  }

  @override
  Widget build(BuildContext context) {
    final tempJobData = ref.watch(jobDataProvider);

    return Portal(
      child: Stack(
        children: [
          Scaffold(
            appBar: VWidgetsAppBar(
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
                    Visibility(
                      visible: widget.jobType == 'Remote' ? false : true,
                      child: Column(
                        children: [
                          addVerticalSpacing(25),
                          PlacesAutocompletionField(
                            label: "Address",
                            hintText: "Start typing address...",
                            initialValue: _selectedLocation,
                            isFollowerTop: false,
                            onItemSelected: (value) {
                              if (!mounted) return;
                              _selectedLocation = value;
                            },
                            postOnChanged: (String value) {},
                          ),
                          addVerticalSpacing(8),
                          const Divider(thickness: 1),
                        ],
                      ),
                    ),
                    addVerticalSpacing(25),
                    VWidgetsDescriptionTextFieldWithTitle(
                      controller: _deliverablesController,
                      label: "Deliverables type (Required)",
                      hintText: "Eg. What do you expect to receive?",
                      validator: VValidatorsMixin.isNotEmpty,
                      // isIncreaseHeightForErrorText: true,
                      minLines: 4,
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
                                child: VWidgetsDropDownTextField<LicenseType>(
                                  fieldLabel: "License",
                                  hintText: "",
                                  onChanged: (val) {
                                    setState(() {
                                      usageType = val;
                                    });
                                  },
                                  value: usageType,
                                  // options: const ["Usage type", "Usage type 2"],
                                  options: LicenseType.values,
                                  getLabel: (LicenseType value) =>
                                      value.simpleName,
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
                    ExpansionTile(
                      initiallyExpanded: hasAdvancedRequirements,
                      expandedCrossAxisAlignment: CrossAxisAlignment.start,
                      childrenPadding: EdgeInsets.zero,
                      onExpansionChanged: (value) {
                        print('@@@@@@@@@@@@@@@ is it expanded $value');
                        hasAdvancedRequirements = value;
                        setState(() {});
                      },
                      trailing: Icon(
                        hasAdvancedRequirements
                            ? Icons.arrow_drop_up_rounded
                            : Icons.arrow_drop_down_rounded,
                        color: Theme.of(context).colorScheme.onSurface,
                        size: 32,
                      ),
                      // iconColor: VmodelColors.primaryColor,
                      title: Text("Advanced Requirements",
                          style: Theme.of(context)
                              .textTheme
                              .displayMedium!
                              .copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: Theme.of(context).primaryColor)),
                      children: [
                        addVerticalSpacing(25),
                        VWidgetsDropDownTextField<Ethnicity>(
                          fieldLabel: "Ethnicity",
                          hintText: "",
                          options: Ethnicity
                              .values, //const ["Black/African", "Asian"],
                          onChanged: (val) {
                            setState(() {
                              ethnicity = val;
                            });
                          },
                          value: ethnicity,
                          getLabel: (Ethnicity value) => value.simpleName,
                        ),
                        addVerticalSpacing(0),
                        // Text(
                        //   "Age Range",
                        //   style: Theme.of(context).textTheme.displayMedium!.copyWith(
                        //       fontWeight: FontWeight.w600,
                        //       color: Theme.of(context).primaryColor),
                        // ),
                        // addVerticalSpacing(20),
                        // VWidgetsSlider<double>(
                        //   startLabel: "18",
                        //   endLabel: "32",
                        //   sliderValue: slideValue,
                        //   sliderMinValue: 18,
                        //   sliderMaxValue: 32,
                        //   onChanged: (value) {
                        //     setState(() {
                        //       slideValue = value;
                        //     });
                        //   },
                        // ),
                        VWidgetsRangeSlider(
                          title: "Age Range",
                          sliderValue: _ageRangeValues,
                          sliderMinValue: 1,
                          sliderMaxValue: 100,
                          onChanged: (RangeValues value) {
                            setState(() {
                              _ageRangeValues = value;
                            });
                          },
                        ),
                        addVerticalSpacing(25),

                        Row(
                          children: [
                            Flexible(
                              child: VWidgetsPrimaryTextFieldWithTitle(
                                label: "Height (cm)",
                                hintText: "Ex. 190",
                                minLines: 1,
                                // maxLength: 3,
                                controller: _heightController,
                                // validator: VValidatorsMixin.isNotEmpty,
                                isIncreaseHeightForErrorText: true,
                                formatters: [
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                keyboardType: TextInputType.number,
                                onChanged: (val) {
                                  // setState(() {});
                                },
                                //onSaved: (){},
                              ),
                            ),
                            //         SizedBox(
                            //           width: 75,
                            //           child: VWidgetsDropDownTextField(
                            //             fieldLabel: "Height",
                            //             hintText: "",
                            //             value: heightFeet,
                            //             onChanged: (val) {
                            //               setState(() {
                            //                 heightFeet = val;
                            //               });
                            //             },
                            //             options: const ["3", "4", "5", "6", "7", "8", "9"],
                            //             getLabel: (String value) => value,
                            //           ),
                            //         ),
                            //         addHorizontalSpacing(5),
                            //         SizedBox(
                            //           width: 75,
                            //           child: VWidgetsDropDownTextField(
                            //             fieldLabel: "",
                            //             hintText: "",
                            //             value: heightInches,
                            //             onChanged: (val) {
                            //               setState(() {
                            //                 heightInches = val;
                            //               });
                            //             },
                            //             options: const [
                            //               "1",
                            //               "2",
                            //               "3",
                            //               "4",
                            //               "5",
                            //               "6",
                            //               "7",
                            //               "8",
                            //               "9",
                            //               "10",
                            //               "11",
                            //               "12"
                            //             ],
                            //             getLabel: (String value) => value,
                            //           ),
                            //         ),
                            addHorizontalSpacing(40),
                            Flexible(
                              child: VWidgetsDropDownTextField<ModelSize>(
                                fieldLabel: "Size",
                                hintText: "",
                                onChanged: (val) {
                                  setState(() {
                                    size = val;
                                  });
                                },
                                value: size,
                                // options: const ["S", "M", "L", "XL", "XXL"],
                                options: ModelSize.values,
                                getLabel: (ModelSize value) => value.simpleName,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    addVerticalSpacing(25),
                    VWidgetsPrimaryButton(
                      enableButton: true,
                      showLoadingIndicator: _showButtonLoader,
                      onPressed: () async {
                        if (!_formKey.currentState!.validate()) {
                          VWidgetShowResponse.showToast(ResponseEnum.warning,
                              message: "Please fill all required fields");
                          return;
                        }

                        final temp =
                            ref.read(jobDataProvider.notifier).state?.copyWith(
                          location: {
                            "latitude": "0",
                            "longitude": "0",
                            "locationName": _selectedLocation,
                          },
                          deliverablesType: _deliverablesController.text.trim(),
                          isDigitalContent: isDigitalContent,
                          usageType:
                              isDigitalContent ? usageType.apiValue : null,
                          usageLength: isDigitalContent ? usageLength : null,
                          ethnicity: hasAdvancedRequirements ? ethnicity : null,
                          minAge: hasAdvancedRequirements
                              ? _ageRangeValues.start.round()
                              : 0,
                          maxAge: hasAdvancedRequirements
                              ? _ageRangeValues.end.round()
                              : 0,
                          height: _getHeight,
                          size: hasAdvancedRequirements ? size : null,
                          // complexion: complexion,
                        );
                        // ref.read(jobDataProvider.notifier).state = temp;

                        // VLoader.changeLoadingState(true);

                        _toggleButtonLoader();

                        if (widget.job == null) {
                          showDialog(
                            barrierColor: Colors.black54,
                            context: context,
                            builder: (context) => LoaderProgress(
                              done: false,
                              loading: true,
                            ),
                          );

                          final success = await ref
                              .read(
                                  selectedDateTimeAndDurationProvider.notifier)
                              .createJob(isAdvanced: hasAdvancedRequirements);

                          if (success) {
                            ref.invalidate(selectedDateTimeAndDurationProvider);
                            //invalidate main jobs page
                            ref.invalidate(jobsProvider);
                            //invalidate user jobs
                            ref.invalidate(userJobsProvider(null));
                            _toggleButtonLoader();
                            showDialog(
                              context: context,
                              builder: (context) => LoaderProgress(
                                done: true,
                                loading: false,
                              ),
                            );
                            await Future.delayed(
                                Duration(seconds: 2), () async {});
                            if (mounted) {
                              goBack(context);
                              goBack(context);
                              goBack(context);
                              goBack(context);
                            }
                          }
                        } else {
                          showDialog(
                            barrierColor: Colors.black54,
                            context: context,
                            builder: (context) => LoaderProgress(
                              done: false,
                              loading: true,
                            ),
                          );
                          final success = await ref
                              .read(
                                  selectedDateTimeAndDurationProvider.notifier)
                              .updateJob(
                                  jobId: widget.job!.id,
                                  isAdvanced: hasAdvancedRequirements);

                          if (success) {
                            ref.invalidate(selectedDateTimeAndDurationProvider);
                            //invalidate main jobs page
                            ref.invalidate(jobsProvider);
                            //invalidate user jobs
                            ref.invalidate(userJobsProvider(null));

                            showDialog(
                              context: context,
                              builder: (context) => LoaderProgress(
                                done: true,
                                loading: false,
                              ),
                            );
                            await Future.delayed(
                                Duration(seconds: 2), () async {});
                            if (mounted) {
                              Navigator.of(context)
                                ..pop()
                                ..pop()
                                ..pop()
                                ..pop()
                                ..pop();
                              // goBack(context);
                              // goBack(context);
                            }
                          }
                        }

                        _toggleButtonLoader();
                      },
                      buttonTitle: widget.isEdit ? "Update" : "Create",
                    ),
                    addVerticalSpacing(50)
                  ],
                ),
              ),
            ),
          ),
          // if (_isLoading) LoaderProgress(done: done, loading: _isLoadingState)
        ],
      ),
    );
  }

//if (_isLoading) LoaderProgress(animation: _animation, done: _done)
  void _toggleButtonLoader() {
    _showButtonLoader = !_showButtonLoader;
    setState(() {});
  }

  Map<String, dynamic>? get _getHeight {
    if (_heightController.text.isNotEmpty) {
      return {"value": int.parse(_heightController.text), "unit": "cm"};
    }
    return null;
    // return {"value": 150, "unit": "cm"};
  }
}
