import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vmodel/src/core/utils/validators_mixins.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/shared/appbar/appbar.dart';
import 'package:vmodel/src/shared/buttons/primary_button.dart';
import 'package:vmodel/src/shared/buttons/text_button.dart';
import 'package:vmodel/src/vmodel.dart';

import '../../core/controller/app_user_controller.dart';
import '../../core/network/graphql_service.dart';
import '../../features/settings/views/verification/views/blue-tick/widgets/text_field.dart';
import 'dropdown_text_normal.dart';

class ProfileDropdownInput extends ConsumerStatefulWidget {
  final title;
  var value;
  // var purpose;
  var options;
  // var pk;
  // var bio;
  // var dropdownFeetValue;
  // var username;
  // var firstName;
  // var lastName;
  // var weight;
  // var hair;
  // var eyes;
  // var chest;
  final int? yearsOfExperience;
  final Future<void> Function(dynamic) onSave;

  var dropdownInchesValue;
  ProfileDropdownInput({
    super.key,
    required this.title,
    required this.value,
    // required this.purpose,
    // required this.pk,
    // required this.bio,
    // required this.dropdownFeetValue,
    // required this.username,
    // required this.firstName,
    // required this.lastName,
    // required this.weight,
    // required this.hair,
    // required this.eyes,
    // required this.chest,
    required this.options,
    // required this.dropdownInchesValue,
    required this.onSave,
    this.yearsOfExperience,
  });

  @override
  ConsumerState<ProfileDropdownInput> createState() =>
      _ProfileDropdownInputState();
}

class _ProfileDropdownInputState extends ConsumerState<ProfileDropdownInput> {
  var dropdownIdentifyValue = "";
  final isLoading = ValueNotifier(false);
  final TextEditingController _yearsOfExperienceController =
      TextEditingController();

  @override
  initState() {
    super.initState();
    if (widget.yearsOfExperience != null)
      _yearsOfExperienceController.text = widget.yearsOfExperience.toString();
  }

  @override
  dispose() {
    super.dispose();
    _yearsOfExperienceController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);

    return Scaffold(
      appBar: VWidgetsAppBar(
        leadingIcon: const VWidgetsBackButton(),
        appbarTitle: widget.title,
        trailingIcon: [
          ValueListenableBuilder(
              valueListenable: isLoading,
              builder: (context, value, _) {
                return VWidgetsTextButton(
                  showLoadingIndicator: value,
                  text: "Done",
                  onPressed: () async {
                    // VLoader.changeLoadingState(true);
                    isLoading.value = true;
                    await widget.onSave(widget.value);
                    // VLoader.changeLoadingState(false);
                    isLoading.value = false;
                    if (mounted) goBack(context);
                    // popSheet(context);
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
            addVerticalSpacing(20),
            Expanded(
                child: SingleChildScrollView(
              child: Row(
                children: [
                  Expanded(
                    child: VWidgetsDropdownNormal(
                      fieldLabel: widget.title.toLowerCase() ==
                              "Specialty".toLowerCase()
                          ? "Profile Label"
                          : null,
                      hintText: widget.value == null ? 'select ...' : '',
                      value: widget.value,
                      isExpanded: true,
                      onChanged: (val) {
                        setState(() {
                          // dropdownIdentifyValue = val;
                          widget.value = val;
                        });
                      },
                      validator: (value) => null,
                      items: widget.options,
                      itemToString: (value) => value.toString(),
                    ),
                  ),
                  addHorizontalSpacing(20),
                  if (widget.title.toLowerCase() == "Specialty".toLowerCase())
                    Expanded(
                      child: VWidgetsTextFieldNormal(
                        // isDense: true,
                        labelText: "Experience (Years)",
                        controller: _yearsOfExperienceController,
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 7, horizontal: 8),
                        // heightForErrorText: 0,
                        maxLength: 2,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        hintText:
                            valueOrNull(_yearsOfExperienceController.text) ??
                                "Ex. 2",
                        // isIncreaseHeightForErrorText: true,
                        validator: (value) =>
                            VValidatorsMixin.isNotEmpty(value),
                      ),
                    )
                ],
              ),
            )),
            addVerticalSpacing(12),
            ValueListenableBuilder(
                valueListenable: isLoading,
                builder: (context, value, _) {
                  return VWidgetsPrimaryButton(
                    showLoadingIndicator: value,
                    buttonTitle: "Done",
                    onPressed: () async {
                      // final authNotifier = ref.read(authProvider.notifier);
                      // VLoader.changeLoadingState(true);
                      isLoading.value = true;
                      if (widget.title.toLowerCase() ==
                          "Specialty".toLowerCase()) {
                        updateYearsOfExperience(
                            _yearsOfExperienceController.text);
                      }

                      await widget.onSave(widget.value);
                      // VLoader.changeLoadingState(false);
                      isLoading.value = false;
                      if (mounted) goBack(context);
                      // navigateAndReplaceRoute(context, const ProfileSettingPage());
                    },
                    enableButton: true,
                  );
                }),
            addVerticalSpacing(40),
          ],
        ),
      ),
    );
  }

  Future<void> updateYearsOfExperience(String value) async {
    final years = int.tryParse(value);
    if (years == null) {
      return;
    }
    await ref
        .read(appUserProvider.notifier)
        .updateProfile(yearsOfExperience: years);
  }

  String? valueOrNull(String? text) {
    if (text == null || text.isEmpty) {
      return null;
    } else {
      return text;
    }
  }
}
