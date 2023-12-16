import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:scroll_date_picker/scroll_date_picker.dart';
import 'package:vmodel/src/core/controller/app_user_controller.dart';
import 'package:vmodel/src/core/utils/helper_functions.dart';
import 'package:vmodel/src/features/onboarding/controller/onboarding_controller.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/shared/buttons/primary_button.dart';
import 'package:vmodel/src/shared/buttons/text_button.dart';
import 'package:vmodel/src/core/utils/validators_mixins.dart';
import 'package:vmodel/src/shared/response_widgets/toast.dart';
import 'package:vmodel/src/vmodel.dart';

import '../../authentication/register/provider/user_types_controller.dart';
import '../../authentication/register/views/location_set_up.dart';

class OnboardingBirthday extends ConsumerStatefulWidget with VValidatorsMixin {
  OnboardingBirthday({
    Key? key,
    this.dob,
    this.isSetup = false,
  }) : super(key: key);

  final bool isSetup;
  final DateTime? dob;

  @override
  ConsumerState<OnboardingBirthday> createState() => _OnboardingBirthdayState();
}

class _OnboardingBirthdayState extends ConsumerState<OnboardingBirthday> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool _showLoader = false;
  Rx<DateTime>? dob = DateTime.now().obs;
  final minAllowedAge = 18;
  initState() {
    Get.put(OnboardingController("ldjjl"));
    dob = widget.dob?.obs;
  }

  @override
  Widget build(BuildContext context) {
    final TextStyle datePickerTextStyle =
        Theme.of(context).textTheme.displayMedium!.copyWith(
              fontWeight: FontWeight.w400,
              fontSize: 25,
            );

    final TextStyle selectedDatePickerTextStyle =
        Theme.of(context).textTheme.displayMedium!.copyWith(
              fontWeight: FontWeight.w500,
              fontSize: 25,
            );

    bool isBusinessAccount = false;
    if (widget.isSetup) {
      isBusinessAccount =
          ref.watch(isAccountTypeBusinessProvider.notifier).state;
    } else {
      isBusinessAccount =
          ref.watch(appUserProvider).valueOrNull?.isBusinessAccount ?? false;
    }

    return Scaffold(
        // backgroundColor: VmodelColors.background,
        appBar: AppBar(
          leading: const VWidgetsBackButton(),
          //   backgroundColor: VmodelColors.background,
          elevation: 0,
          iconTheme: IconThemeData(color: VmodelColors.mainColor),
          actions: [
            Padding(
              padding: EdgeInsets.only(left: screenSize.width * 0.04),
              child: VWidgetsTextButton(
                text: 'Save',
                showLoadingIndicator: _showLoader,
                onPressed: () {
                  // OnboardingInteractor.onBirthdaySubmitted(context);
                  saveDOB();
                },
              ),
            ),
          ],
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            addVerticalSpacing(SizeConfig.screenHeight * 0.22),
            Center(
              child: Text(
                'Please enter your date of birth',
                style: Theme.of(context).textTheme.displayMedium!.copyWith(
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).primaryColor,
                    fontSize: 13.sp),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              //width: MediaQuery.of(context).size.width,
              alignment: Alignment.center,
              margin: const EdgeInsets.symmetric(horizontal: 25),
              child: Form(
                  key: formKey,
                  child: Container(
                    color: Colors.white.withOpacity(0.001),
                    height: SizeConfig.screenHeight * 0.12,
                    child: Obx(() {
                      return ScrollDatePicker(
                        options: DatePickerOptions(
                            isLoop: false,
                            diameterRatio: 3,
                            itemExtent: 30,
                            backgroundColor:
                                Theme.of(context).scaffoldBackgroundColor
                            //itemExtent: 3.0
                            ),
                        scrollViewOptions: DatePickerScrollViewOptions(
                          day: ScrollViewDetailOptions(
                            alignment: Alignment.centerLeft,
                            // textStyle: datePickerTextStyle,
                            textStyle: selectedDatePickerTextStyle,
                            selectedTextStyle: selectedDatePickerTextStyle,
                            margin: const EdgeInsets.all(14.0),
                          ),
                          month: ScrollViewDetailOptions(
                            alignment: Alignment.center,
                            textStyle: datePickerTextStyle,
                            selectedTextStyle: selectedDatePickerTextStyle,
                            margin: const EdgeInsets.only(right: 14),
                          ),
                          year: ScrollViewDetailOptions(
                            alignment: Alignment.centerRight,
                            textStyle: datePickerTextStyle,
                            selectedTextStyle: selectedDatePickerTextStyle,
                            margin: const EdgeInsets.only(right: 14),
                          ),
                        ),
                        selectedDate: dob?.value ??
                            Get.find<OnboardingController>().birthday.value,
                        onDateTimeChanged: (value) {
                          HapticFeedback.lightImpact();
                          Get.find<OnboardingController>().birthday(value);
                        },
                        locale: const Locale('ko'),
                        maximumDate: DateTime(2006, 12, 30),
                        indicator: null,
                      );
                    }),
                  )),
            ),
            addVerticalSpacing(SizeConfig.screenHeight * 0.071),
            Obx(() {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    '${getDay(
                      Get.find<OnboardingController>().birthday.value,
                    ).capitalizeFirst}',
                    style:
                        context.textTheme.displayMedium?.copyWith(fontSize: 12),
                  ),
                  addVerticalSpacing(15),
                  RichText(
                    text: TextSpan(
                      style: promptTextStyle,
                      children: [
                        TextSpan(
                          text: getAge(Get.find<OnboardingController>()
                                  .birthday
                                  .value)
                              .toString(),
                          style: context.textTheme.displayMedium?.copyWith(
                              fontSize: 90, fontWeight: FontWeight.w500),
                        ),
                        const TextSpan(text: '  '),
                        TextSpan(
                          text: 'Years Old',
                          style: context.textTheme.displayMedium?.copyWith(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // vmSized(20),
                  if (!isBusinessAccount)
                    Center(
                        child: getStarSign(
                            Get.find<OnboardingController>().birthday.value))
                ],
              );
            }),
            const Spacer(),
            Padding(
              padding: const VWidgetsPagePadding.horizontalSymmetric(18),
              child: VWidgetsPrimaryButton(
                showLoadingIndicator: _showLoader,
                onPressed: () async {
                  final userAge =
                      getAge(Get.find<OnboardingController>().birthday.value);
                  if (userAge < 18) {
                    VWidgetShowResponse.showToast(ResponseEnum.warning,
                        message:
                            'You must be at least $minAllowedAge to use ${VMString.appName}');
                    return;
                  }
                  saveDOB();
                  if (widget.isSetup) {
                    // return const ;
                    navigateToRoute(context, SignUpLocationViews());
                  }
                },
                enableButton: true,
                buttonTitle: 'Save',
              ),
            ),
            addVerticalSpacing(40),
          ],
        ));
  }

  Future<void> saveDOB() async {
    setState(() {
      // _showLoader = true;
      dob = Get.find<OnboardingController>().birthday;
    });

    final dateOnly =
        Get.find<OnboardingController>().birthday.value.toIso8601DateOnlyString;

    await ref.read(appUserProvider.notifier).updateProfile(dob: dateOnly);
    setState(() => _showLoader = false);
    if (!widget.isSetup && mounted) {
      goBack(context);
    }
  }

  String getDay(DateTime date) {
    return DateFormat('EEEE').format(date);
  }

  Widget getStarSign(DateTime date) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          getZodicaSign(date)["ZodicaSign"],
          style: TextStyle(fontSize: 30),
        ),
        Text(
          getZodicaSign(date)["ZodicaName"],
        )
      ],
    );
  }

  Map<String, dynamic> getZodicaSign(DateTime date) {
    var days = date.day;
    var months = date.month;
    if (months == 1) {
      if (days >= 21) {
        return {
          "ZodicaName": "Aquarius",
          "ZodicaSign": "🌊",
        };
      } else {
        return {
          "ZodicaName": "Capricorn",
          "ZodicaSign": "🐐",
        };
      }
    } else if (months == 2) {
      if (days >= 20) {
        return {
          "ZodicaName": "Pisces",
          "ZodicaSign": "🐟",
        };
      } else {
        return {
          "ZodicaName": "Aquarius",
          "ZodicaSign": "🌊",
        };
      }
    } else if (months == 3) {
      if (days >= 21) {
        return {
          "ZodicaName": "Aries",
          "ZodicaSign": "🔥",
        };
      } else {
        return {
          "ZodicaName": "Pisces",
          "ZodicaSign": "🐟",
        };
      }
    } else if (months == 4) {
      if (days >= 21) {
        return {
          "ZodicaName": "Taurus",
          "ZodicaSign": "🌼",
        };
      } else {
        return {
          "ZodicaName": "Aries",
          "ZodicaSign": "🔥",
        };
      }
    } else if (months == 5) {
      if (days >= 22) {
        return {
          "ZodicaName": "Geminies",
          "ZodicaSign": "🗣️",
        };
      } else {
        return {
          "ZodicaName": "Taurus",
          "ZodicaSign": "🌼",
        };
      }
    } else if (months == 6) {
      if (days >= 22) {
        return {
          "ZodicaName": "Cancer",
          "ZodicaSign": "🦀",
        };
      } else {
        return {
          "ZodicaName": "Geminies",
          "ZodicaSign": "🗣️",
        };
      }
    } else if (months == 7) {
      if (days >= 23) {
        return {
          "ZodicaName": "Leo",
          "ZodicaSign": "🦁",
        };
      } else {
        return {
          "ZodicaName": "Cancer",
          "ZodicaSign": "🦀",
        };
      }
    } else if (months == 8) {
      if (days >= 23) {
        return {
          "ZodicaName": "Virgo",
          "ZodicaSign": "🌾",
        };
      } else {
        return {
          "ZodicaName": "Leo",
          "ZodicaSign": "🦁",
        };
      }
    } else if (months == 9) {
      if (days >= 24) {
        return {
          "ZodicaName": "Libra",
          "ZodicaSign": "⚖️",
        };
      } else {
        return {
          "ZodicaName": "Virgo",
          "ZodicaSign": "🌾",
        };
      }
    } else if (months == 10) {
      if (days >= 24) {
        return {
          "ZodicaName": "Scorpio",
          "ZodicaSign": "🦂",
        };
      } else {
        return {
          "ZodicaName": "Libra",
          "ZodicaSign": "⚖️",
        };
      }
    } else if (months == 11) {
      if (days >= 23) {
        return {
          "ZodicaName": "Sagittarius",
          "ZodicaSign": "🏹",
        };
      } else {
        return {
          "ZodicaName": "Scorpio",
          "ZodicaSign": "🦂",
        };
      }
    } else if (months == 12) {
      if (days >= 22) {
        return {
          "ZodicaName": "Capricorn",
          "ZodicaSign": "🐐",
        };
      } else {
        return {
          "ZodicaName": "Sagittarius",
          "ZodicaSign": "🏹",
        };
      }
    }
    return {};
  }

  int getAge(DateTime date) {
    final today = DateTime.now();
    var age = today.year - date.year;
    final month1 = today.month;
    final month2 = date.month;

    if (month2 > month1) {
      age--;
    } else if (month1 == month2) {
      final day1 = today.day;
      final day2 = date.day;
      if (day2 > day1) {
        age--;
      }
    }
    return age; //.toString();
  }
}
