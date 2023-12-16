import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:vmodel/src/core/utils/validators_mixins.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/shared/appbar/appbar.dart';
import 'package:vmodel/src/shared/buttons/primary_button.dart';
import 'package:vmodel/src/shared/buttons/text_button.dart';
import 'package:vmodel/src/shared/loader/full_screen_dialog_loader.dart';
import 'package:vmodel/src/shared/text_fields/country_phone_field.dart';
import 'package:vmodel/src/shared/text_fields/primary_text_field.dart';
import 'package:vmodel/src/vmodel.dart';
import '../../core/controller/discard_editing_controller.dart';
import '../../core/models/phone_number_model.dart';
import '../../core/utils/costants.dart';
import '../../core/utils/helper_functions.dart';
import '../../features/settings/views/verification/views/blue-tick/widgets/text_field.dart';
import 'description_text_field.dart';

class ProfileInputField extends ConsumerStatefulWidget {
  final String title;
  final value;
  final bool isBio;
  final Future<void> Function(String) onSave;
  final String? Function(String?)? validator;

  var dropdownInchesValue;
  ProfileInputField({
    super.key,
    required this.title,
    required this.value,
    required this.onSave,
    this.validator,
    this.isBio = false,
  });

  @override
  ConsumerState<ProfileInputField> createState() => _ProfileInputFieldState();
}

class _ProfileInputFieldState extends ConsumerState<ProfileInputField> {
  final TextEditingController textController = TextEditingController();
  bool isEdited = false;
  final showLoading = ValueNotifier<bool>(false);
  // TextEditingController secondvalue = TextEditingController();

  @override
  void initState() {
    // if (widget.purpose != '_username') {
    //   widget.value.text.toString().toLowerCase();
    //   setState(() {});
    // }
    textController.text = widget.value;

    ref.read(discardProvider.notifier).initialState(
        '${widget.title.replaceAll(' ', '-')}',
        initial: widget.value,
        current: widget.value);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(discardProvider);
    return WillPopScope(
      onWillPop: () async {
        return onPopPage(context, ref);
      },
      child: Scaffold(
        appBar: VWidgetsAppBar(
          leadingIcon: VWidgetsBackButton(
            onTap: () {
              onPopPage(context, ref);
            },
          ),
          appbarTitle: widget.title,
          trailingIcon: [
            ValueListenableBuilder<bool>(
                valueListenable: showLoading,
                builder: (context, value, child) {
                  return VWidgetsTextButton(
                    text: "Done",
                    showLoadingIndicator: value,
                    onPressed: () async {
                      dismissKeyboard();
                      // VLoader.changeLoadingState(true);
                      // popSheet(context);
                      // final authNotifier = ref.read(authProvider.notifier);
                      showLoading.value = true;
                      await widget.onSave(textController.text.trim());
                      showLoading.value = false;
                      // VLoader.changeLoadingState(false);
                      // if (!mounted) return;
                      // navigateAndReplaceRoute(context, const ProfileSettingPage());
                      if (context.mounted) goBack(context);
                    },
                  );
                }),
          ],
        ),
        body: Padding(
          padding: const VWidgetsPagePadding.horizontalSymmetric(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              addVerticalSpacing(10),
              Expanded(
                  child: SingleChildScrollView(
                child: Column(
                  children: [
                    // widget.purpose == '_bio'
                    widget.isBio
                        ? VWidgetsDescriptionTextFieldWithTitle(
                            // controller: widget.bio,
                            controller: textController,
                            // label: widget.title,
                            helperText: 'Maximum of 2000 characters',
                            // hintText: widget.title,
                            maxLength: VConstants.maxBioLength,
                            maxLines: 10,
                            textCapitalization: TextCapitalization.sentences,
                            validator: widget.validator,
                            labelStyle: Theme.of(context)
                                .textTheme
                                .displayMedium!
                                .copyWith(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: VmodelColors.mainColor),
                            hintStyle: Theme.of(context)
                                .textTheme
                                .displayMedium!
                                .copyWith(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: VmodelColors.mainColor),
                            onChanged: (val) {
                              ref.read(discardProvider.notifier).updateState(
                                  '${widget.title.replaceAll(' ', '-')}',
                                  newValue: val);
                            },
                            // controller: ,
                          )
                        // : widget.purpose != '_username'
                        :
                        // ? VWidgetsPrimaryTextFieldWithTitle(
                        VWidgetsTextFieldNormal(
                            onChanged: (val) {
                              print('Hellosss $val');

                              ref.read(discardProvider.notifier).updateState(
                                  '${widget.title.replaceAll(' ', '-')}',
                                  newValue: val);
                              // setState(() {
                              //   isEdited = true;
                              // });
                            },
                            // controller: widget.value,
                            textCapitalization: TextCapitalization.sentences,
                            controller: textController,
                            // label: widget.title,
                            hintText: widget.title,
                            validator: widget.validator,
                          )
                    // : VWidgetsPrimaryTextFieldWithTitle(
                    //     onChanged: (val) {
                    //       setState(() {});
                    //     },
                    //     controller: widget.value,
                    //     label: widget.title,
                    //     hintText: widget.title,
                    //   ),
                  ],
                ),
              )),
              addVerticalSpacing(12),
              ValueListenableBuilder<bool>(
                  valueListenable: showLoading,
                  builder: (context, value, child) {
                    return VWidgetsPrimaryButton(
                      buttonTitle: "Done",
                      showLoadingIndicator: value,
                      onPressed: () async {
                        dismissKeyboard();
                        // VLoader.changeLoadingState(true);
                        showLoading.value = true;

                        await widget.onSave(textController.text.trim());
                        showLoading.value = false;
                        // final authNotifier = ref.read(authProvider.notifier);
                        // VLoader.changeLoadingState(false);
                        // navigateAndReplaceRoute(context, const ProfileSettingPage());
                        if (context.mounted) {
                          goBack(context);
                        }
                      },
                      enableButton: true,
                    );
                  }),
              addVerticalSpacing(40),
            ],
          ),
        ),
      ),
    );
  }
}

class PhoneAndEmailInputField extends ConsumerStatefulWidget {
  final String title;
  final value;
  final bool isBio;
  final PhoneNumberModel? phoneData;
  final Future<void> Function(String) onSave;
  final Future<void> Function(PhoneNumberModel)? onPhoneSave;
  final String? Function(String?)? validator;

  var dropdownInchesValue;
  PhoneAndEmailInputField({
    Key? key,
    required this.title,
    required this.value,
    required this.onSave,
    this.onPhoneSave,
    this.validator,
    this.isBio = false,
    this.phoneData,
  }) : super(key: key);

  @override
  ConsumerState<PhoneAndEmailInputField> createState() =>
      _PhoneAndEmailInputFieldState();
}

class _PhoneAndEmailInputFieldState
    extends ConsumerState<PhoneAndEmailInputField> {
  final TextEditingController textController = TextEditingController();
  bool isEdited = false;
  String _countryCode = 'GB';
  String _intlNumber = '';
  final showLoading = ValueNotifier(false);

  @override
  void initState() {
    if (widget.phoneData != null) {
      _countryCode = widget.phoneData!.countryCode.isEmptyOrNull
          ? _countryCode
          : widget.phoneData!.countryCode;
      textController.text = widget.phoneData!.number;
      _intlNumber = widget.phoneData!.e164Number ?? '';
    } else {
      textController.text = widget.value;
    }

    ref.read(discardProvider.notifier).initialState(
          '${widget.title.replaceAll(' ', '-')}',
          initial: textController.text,
          current: textController.text,
        );
    print('AAAAAAA ${widget.phoneData}');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(discardProvider);

    return WillPopScope(
      onWillPop: () async {
        return onPopPage(context, ref);
      },
      child: Scaffold(
        appBar: VWidgetsAppBar(
          leadingIcon: VWidgetsBackButton(
            onTap: () {
              onPopPage(context, ref);
            },
          ),
          appbarTitle: widget.title,
          trailingIcon: [
            ValueListenableBuilder<bool>(
                valueListenable: showLoading,
                builder: (context, value, child) {
                  return VWidgetsTextButton(
                    text: "Done",
                    showLoadingIndicator: value,
                    onPressed: () async {
                      dismissKeyboard();
                      // VLoader.changeLoadingState(true);
                      showLoading.value = true;
                      await widget.onSave(textController.text.trim());
                      showLoading.value = false;
                      // VLoader.changeLoadingState(false);
                      goBack(context);
                    },
                  );
                  // return VWidgetsPrimaryButton(
                  //   buttonTitle: "Done",
                  //   showLoadingIndicator: value,
                  //   onPressed: () async {
                  //     dismissKeyboard();
                  //     // VLoader.changeLoadingState(true);
                  //     showLoading.value = true;

                  //     await widget.onSave(textController.text.trim());
                  //     showLoading.value = false;
                  //     // final authNotifier = ref.read(authProvider.notifier);
                  //     // VLoader.changeLoadingState(false);
                  //     // navigateAndReplaceRoute(context, const ProfileSettingPage());
                  //     if (context.mounted) {
                  //       goBack(context);
                  //     }
                  //   },
                  //   enableButton: true,
                  // );
                }),
          ],
        ),
        body: Padding(
          padding: const VWidgetsPagePadding.horizontalSymmetric(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              addVerticalSpacing(25),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      VWidgetsCountryPhoneFieldWithTitle(
                        //WIP phone number work!!!
                        initialCountryCode: _countryCode,
                        onChanged: (val) {
                          isEdited = true;
                          _intlNumber = val;

                          ref.read(discardProvider.notifier).updateState(
                                '${widget.title.replaceAll(' ', '-')}',
                                newValue: _intlNumber,
                              );
                          setState(() {});
                        },
                        onCountryChanged: (value) {
                          _countryCode = value.code;
                          _intlNumber =
                              '+${value.dialCode}${textController.text.trim()}';

                          ref.read(discardProvider.notifier).updateState(
                                '${widget.title.replaceAll(' ', '-')}',
                                newValue: _intlNumber,
                              );
                          isEdited = true;
                        },
                        controller: textController,
                        label: widget.title,
                        hintText: widget.title,
                        validator: widget.validator,
                      ),
                    ],
                  ),
                ),
              ),
              addVerticalSpacing(12),
              ValueListenableBuilder<bool>(
                  valueListenable: showLoading,
                  builder: (context, value, child) {
                    return VWidgetsPrimaryButton(
                      buttonTitle: isEdited ? "Verify" : "Done",
                      showLoadingIndicator: value,
                      onPressed: () async {
                        dismissKeyboard();
                        // VLoader.changeLoadingState(true);
                        showLoading.value = true;
                        if (widget.onPhoneSave != null) {
                          final temp = PhoneNumberModel(
                              number: textController.text.trim(),
                              countryCode: _countryCode,
                              e164Number: _intlNumber);
                          await widget.onPhoneSave!(temp);
                        } else {
                          await widget.onSave(textController.text.trim());
                        }
                        // VLoader.changeLoadingState(false);
                        showLoading.value = false;
                        !isEdited
                            ? goBack(context)
                            : navigateToRoute(context, const VerifyNewPhone());
                      },
                      enableButton: true,
                    );
                  }),
              addVerticalSpacing(40),
            ],
          ),
        ),
      ),
    );
  }
}

class VerifyNewPhone extends StatefulWidget {
  const VerifyNewPhone({Key? key}) : super(key: key);

  @override
  State<VerifyNewPhone> createState() => _VerifyNewPhoneState();
}

class _VerifyNewPhoneState extends State<VerifyNewPhone> {
  String pinCode = '';
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    bool isCodeValid = pinCode.length == 4;

    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(18),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Verify Phone',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              PinCodeTextField(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                appContext: context,
                keyboardType: TextInputType.number,
                autoFocus: true,
                autoUnfocus: true,
                length: 4,
                pinTheme: PinTheme(
                    // inactiveFillColor: Colors.green,
                    // activeFillColor: const Color.fromRGBO(76, 175, 80, 1),
                    // selectedFillColor: Colors.green,
                    activeColor: Theme.of(context).primaryColor,
                    inactiveColor:
                        Theme.of(context).primaryColor.withOpacity(0.5),
                    selectedColor: Theme.of(context).primaryColor,
                    borderWidth: 2,
                    fieldWidth: 45,
                    // selectedColor: VmodelColors.buttonColor,
                    // activeColor: Colors.transparent,
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(12)),
                onChanged: (v) {
                  // Get.find<OnboardingController>().pin(v);

                  setState(() {
                    pinCode = v;
                  });
                },
              ),
              // PinCodeTextField(
              //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //   appContext: context,
              //   length: 4,
              //   keyboardType: TextInputType.number,
              //   animationCurve: Curves.easeIn,
              //   inputFormatters: [
              //     FilteringTextInputFormatter.digitsOnly,
              //   ],
              //   textStyle: TextStyle(
              //     fontWeight: FontWeight.w600,
              //     color: VmodelColors.primaryColor.withOpacity(1),
              //   ),
              //   pastedTextStyle: TextStyle(
              //     fontWeight: FontWeight.w600,
              //     color: VmodelColors.primaryColor.withOpacity(1),
              //   ),
              //   pinTheme: PinTheme(
              //     activeColor: VmodelColors.primaryColor,
              //     inactiveColor: VmodelColors.primaryColor.withOpacity(0.5),
              //     selectedColor: VmodelColors.primaryColor,
              //   ),
              //   onChanged: (value) {
              //     setState(() {
              //       pinCode = value;
              //     });
              //     //TODO:  Handle the PIN code changes if needed
              //   },
              // ),
              const SizedBox(height: 20),
              VWidgetsPrimaryButton(
                buttonTitle: "Verify",
                onPressed: isCodeValid
                    ? () async {
                        dismissKeyboard();
                        VLoader.changeLoadingState(true);
                        // await widget.onSave(textController.text.trim());
                        // final authNotifier = ref.read(authProvider.notifier);
                        VLoader.changeLoadingState(false);
                        // navigateAndReplaceRoute(context, const ProfileSettingPage());
                        goBack(context);
                      }
                    : null,
                enableButton: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
