import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vmodel/src/core/controller/app_user_controller.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/shared/appbar/appbar.dart';
import 'package:vmodel/src/shared/buttons/primary_button.dart';
import 'package:vmodel/src/shared/buttons/text_button.dart';
import 'package:vmodel/src/vmodel.dart';

import '../../core/network/graphql_service.dart';
import '../../core/utils/enum/gender_enum.dart';
import 'dropdown_text_field.dart';

class GenderFieldDropdown extends ConsumerStatefulWidget {
  final String title;
  Gender value;
  // var purpose;
  // var options;
  final int pk;
  // var bio;
  // var dropdownFeetValue;
  // var username;
  // var firstName;
  // var lastName;
  // var weight;
  // var hair;
  // var eyes;
  // var chest;

  // var dropdownInchesValue;

  var dropdownIdentifyValue;
  GenderFieldDropdown({
    super.key,
    required this.title,
    required this.value,
    // required this.purpose,
    required this.pk,
    // required this.bio,
    // required this.dropdownFeetValue,
    // required this.username,
    // required this.firstName,
    // required this.lastName,
    // required this.weight,
    // required this.hair,
    // required this.eyes,
    // required this.chest,
    // required this.options,
    // required this.dropdownInchesValue,
    required this.dropdownIdentifyValue,
  });

  @override
  ConsumerState<GenderFieldDropdown> createState() =>
      _GenderFieldDropdownState();
}

class _GenderFieldDropdownState extends ConsumerState<GenderFieldDropdown> {
  var dropdownIdentifyValue = "";
  var dropdownIdentifyValue2 = "";
  final showLoading = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);
    return Scaffold(
        appBar: VWidgetsAppBar(
          leadingIcon: const VWidgetsBackButton(),
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
                      await ref
                          .read(appUserProvider.notifier)
                          .updateProfile(gender: widget.value);
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
              addVerticalSpacing(0),
              Expanded(
                  child: SingleChildScrollView(
                child: Column(
                  children: [
                    VWidgetsDropDownTextField(
                      // fieldLabel: 'Gender',
                      // hintText: 'Gender',
                      hintText: '',
                      value: widget.value,
                      onChanged: (val) {
                        setState(() {
                          // dropdownIdentifyValue = val;
                          // widget.value = val;
                          widget.value = val;
                        });
                      },
                      // options: widget.options,
                      options: Gender.values,
                    ),
                    // addVerticalSpacing(15),
                    // VWidgetsDropDownTextField(
                    //   fieldLabel: 'I identify as',
                    //   // hintText: 'I identify as',
                    //   hintText: '',
                    //   value: widget.dropdownIdentifyValue,
                    //   onChanged: <String>(val) {
                    //     setState(() {
                    //       dropdownIdentifyValue2 = val;
                    //       widget.dropdownIdentifyValue = val;
                    //     });
                    //   },
                    //   // options: widget.options,
                    //   options: Gender.values,
                    // ),
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
                        // VLoader.changeLoadingState(true);
                        showLoading.value = true;

                        await ref
                            .read(appUserProvider.notifier)
                            .updateProfile(gender: widget.value);
                        showLoading.value = false;
                        // final authNotifier = ref.read(authProvider.notifier);
                        // VLoader.changeLoadingState(false);
                        // navigateAndReplaceRoute(context, const ProfileSettingPage());
                        if (context.mounted) {
                          goBack(context);
                        }
                      },
                      // enableButton: true,
                    );
                  }),
              addVerticalSpacing(40),
            ],
          ),
        ));
  }
}
