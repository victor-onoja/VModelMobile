import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vmodel/src/res/colors.dart';
import 'package:vmodel/src/shared/appbar/appbar.dart';
import 'package:vmodel/src/shared/buttons/primary_button.dart';

import '../../../core/routing/navigator_1.0.dart';
import '../../../core/utils/shared.dart';
import '../../../res/gap.dart';

class ReferAndEarnPage extends StatefulWidget {
  const ReferAndEarnPage({Key? key}) : super(key: key);

  @override
  State<ReferAndEarnPage> createState() => _ReferAndEarnPageState();
}

class _ReferAndEarnPageState extends State<ReferAndEarnPage> {
  final String inviteLink = 'https://vmodel.app/invite/uL3Rzdwi';
  late TextEditingController _linkController;
  String referralOption = '';

  @override
  void initState() {
    super.initState();
    _linkController = TextEditingController(text: inviteLink);
  }

  @override
  void dispose() {
    _linkController.dispose();
    super.dispose();
  }

  void copyLinkToClipboard() {
    Clipboard.setData(ClipboardData(text: inviteLink));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Link copied to clipboard')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: VmodelColors.primaryColor,
      appBar: VWidgetsAppBar(
          backgroundColor: VmodelColors.primaryColor,
          titleWidget: Text(
            'Refer and earn',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: VmodelColors.appBarShadowColor,
                fontWeight: FontWeight.w600,
                fontSize: 16),
          ),
          leadingIcon: IconButton(
            onPressed: () {
              goBack(context);
            },
            icon: const Icon(Icons.arrow_back_ios_outlined),
            color: VmodelColors.appBarShadowColor,
            iconSize: 16.47,
          )),
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Boost your earnings with VModel's referral program",
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: VmodelColors.appBarShadowColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 20),
                ),
                const SizedBox(height: 15),
                Text(
                  "Refer friends and earn £10 when they successfully complete their first booking!",
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: VmodelColors.appBarShadowColor,
                      fontWeight: FontWeight.w400,
                      fontSize: 16),
                ),
                const SizedBox(height: 30),
                Text(
                  'My unique invite link:',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: VmodelColors.appBarShadowColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 16),
                ),
                const SizedBox(height: 20),
                Center(
                  child: Text(
                    inviteLink,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: VmodelColors.appBarShadowColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 16),
                  ),
                ),
                const SizedBox(height: 15),
                Center(
                  child: GestureDetector(
                    onTap: copyLinkToClipboard,
                    child: Text(
                      'tap to copy link',
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(color: VmodelColors.text4.withOpacity(0.5), fontSize: 12),
                    ),
                  ),
                ),
                addVerticalSpacing(40),
                Center(
                  child: Text(
                    'OR',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: VmodelColors.text4,
                        fontWeight: FontWeight.w600,
                        fontSize: 16),
                  ),
                ),
                addVerticalSpacing(40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Text(
                          'Refer by Email',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(
                                  color: VmodelColors.appBarShadowColor.withOpacity(0.5),
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14),
                        ),
                        Radio(
                          value: 'email',
                          groupValue: referralOption,
                          onChanged: (value) {
                            setState(() {
                              referralOption = value!;
                            });
                          },
                          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          activeColor: VmodelColors.text4,
                          fillColor: MaterialStateProperty.resolveWith<Color>(
                                (Set<MaterialState> states) {
                              if (states.contains(MaterialState.selected)) {
                                return VmodelColors.text4;
                              }
                              return VmodelColors.text4; // Adjust the opacity as per your needs
                            },
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          'Refer by SMS',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(
                                  color: VmodelColors.appBarShadowColor.withOpacity(0.5),
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14),
                        ),
                        Radio(
                          value: 'number',
                          groupValue: referralOption,
                          onChanged: (value) {
                            setState(() {
                              referralOption = value!;
                            });
                          },
                          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          activeColor: VmodelColors.text4,
                          fillColor: MaterialStateProperty.resolveWith<Color>(
                                (Set<MaterialState> states) {
                              if (states.contains(MaterialState.selected)) {
                                return VmodelColors.text4;
                              }
                              return VmodelColors.text4; // Adjust the opacity as per your needs
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                Container(
                  alignment: Alignment.center,
                  height: 45,
                  decoration: const BoxDecoration(
                      color: VmodelColors.appBarShadowColor,
                      borderRadius: BorderRadius.all(Radius.circular(7.5))),
                  child: TextFormField(
                    autocorrect: false,
                    enableSuggestions: false,
                    // controller: TextEditingController.fromValue(referralOption as TextEditingValue?),
                    decoration: InputDecoration(
                      filled: true,
                      hintText: referralOption.isEmpty
                          ? 'Pick option'
                          : referralOption == 'email'
                              ? 'Enter Email Address'
                              : 'Enter Phone number ',
                      //padding for hint/text inside the field
                      contentPadding: const VWidgetsContentPadding.only(),
                      //Changed hintstyle opacity as it is with 0.5 throughout the app
                      hintStyle: Theme.of(context)
                          .textTheme
                          .displayMedium!
                          .copyWith(
                              color: VmodelColors.text3.withOpacity(0.5),
                              fontWeight: FontWeight.w400,
                              fontSize: 14),
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: VmodelColors.appBarShadowColor,
                        ),
                        borderRadius: BorderRadius.circular(7.5),
                      ),
                      //made box height 40 px default as in figma designs all have 40 pc height
                      constraints: const BoxConstraints(maxHeight: 40),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: VmodelColors.appBarShadowColor,
                        ),
                        borderRadius: BorderRadius.circular(7.5),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(7.5),
                        borderSide: BorderSide(
                          color: VmodelColors.buttonColor,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                Center(
                  child: VWidgetsPrimaryButton(
                    butttonWidth: 117,
                    buttonHeight: 40,
                    enableButton: true,
                    onPressed: () {},
                    buttonTitle: 'Send Invite',
                    buttonTitleTextStyle: const TextStyle(
                        color: VmodelColors.primaryColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w600),
                    buttonColor: VmodelColors.appBarShadowColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
