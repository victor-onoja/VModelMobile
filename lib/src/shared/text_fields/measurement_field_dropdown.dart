import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vmodel/src/core/models/app_user.dart';
import 'package:vmodel/src/core/models/bust_model.dart';
import 'package:vmodel/src/core/models/chest.dart';
import 'package:vmodel/src/core/models/feet_model.dart';
import 'package:vmodel/src/core/models/height_model.dart';
import 'package:vmodel/src/core/models/waist_model.dart';
import 'package:vmodel/src/core/utils/validators_mixins.dart';
import 'package:vmodel/src/res/icons.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/shared/appbar/appbar.dart';
import 'package:vmodel/src/shared/buttons/primary_button.dart';
import 'package:vmodel/src/shared/buttons/text_button.dart';
import 'package:vmodel/src/shared/rend_paint/render_svg.dart';
import 'package:vmodel/src/shared/text_fields/primary_text_field.dart';
import 'package:vmodel/src/vmodel.dart';

import '../../core/controller/app_user_controller.dart';
import '../../core/utils/costants.dart';
import '../../core/utils/enum/ethnicity_enum.dart';
import '../../core/utils/enum/size_enum.dart';
import '../../features/authentication/register/provider/user_types_controller.dart';
import '../../features/settings/views/verification/views/blue-tick/widgets/text_field.dart';
import 'dropdown_text_field.dart';
import 'dropdown_text_normal.dart';

class SocialMediaInfo {
  String? platform;
  int? followers;
  SocialMediaInfo({this.platform, this.followers});
}

class TwoFieldDropdown extends ConsumerStatefulWidget with VValidatorsMixin {
  final title;
  // String value;
  // var purpose;
  // var options;
  var pk;
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
  TwoFieldDropdown({
    super.key,
    required this.title,
    // required this.value,
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
  });

  @override
  ConsumerState<TwoFieldDropdown> createState() => _TwoFieldDropdownState();
}

class _TwoFieldDropdownState extends ConsumerState<TwoFieldDropdown> {
  // var dropdownIdentifyValue = "";
  // var dropdownIdentifyValue2 = "";
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _waistController = TextEditingController();
  final TextEditingController _feetController = TextEditingController();
  final TextEditingController _bustController = TextEditingController();
  final TextEditingController _hairController = TextEditingController();
  final TextEditingController _eyeController = TextEditingController();
  final TextEditingController _chestController = TextEditingController();
  bool addField = false;
  ModelSize? _modelSize;
  String? _selectedPersonality;
  Ethnicity? _selectedEthnicity;

  var socialMediaList =
      ValueNotifier<List<SocialMediaInfo>>([SocialMediaInfo()]);

  final socialLinksScrollController = ScrollController();
  // String _chest = '';
  // String _height = '';
  // String _weight = '';
  final showLoading = ValueNotifier<bool>(false);

  @override
  void initState() {
    final authState = ref.read(appUserProvider).valueOrNull;
    _heightController.text = authState?.height?.value ?? '';
    _modelSize ??= authState?.modelSize ?? ModelSize.other;
    _eyeController.text = authState?.eyes ?? '';
    _hairController.text = authState?.hair ?? '';
    _eyeController.text = authState?.eyes ?? '';
    _feetController.text = authState?.feet?.value ?? '';
    _bustController.text = authState?.bust?.value ?? '';
    _waistController.text = authState?.bust?.value ?? '';
    _chestController.text = authState?.chest?.value ?? '';
    // _eyeController.text = authState?.eyes ?? '';
    _selectedPersonality = authState?.personality;
    // authState?.personality ?? VConstants.userPersonalities.first;
    if (authState!.socials!.hasSocial) {
      socialMediaList.value.clear();
      addField = true;
      _loadSocial(authState);
    }

    super.initState();
  }

  void _loadSocial(VAppUser? authState) {
    if (authState!.socials!.hasSocial) {
      if (authState.socials!.facebook != null &&
          authState.socials!.facebook?.noOfFollows != 0) {
        print("object1");
        socialMediaList.value.add(SocialMediaInfo(
          platform: authState.socials!.facebook?.username,
          followers: authState.socials!.facebook?.noOfFollows,
        ));
      }
      if (authState.socials!.twitter != null &&
          authState.socials!.twitter?.noOfFollows != 0) {
        print("object2");
        socialMediaList.value.add(SocialMediaInfo(
          platform: authState.socials!.twitter?.username,
          followers: authState.socials!.twitter?.noOfFollows,
        ));
      }
      if (authState.socials!.instagram != null &&
          authState.socials!.instagram?.noOfFollows != 0) {
        print("object3");
        socialMediaList.value.add(SocialMediaInfo(
          platform: authState.socials!.instagram?.username,
          followers: authState.socials!.instagram?.noOfFollows,
        ));
      }
      if (authState.socials!.reddit != null &&
          authState.socials!.reddit?.noOfFollows != 0) {
        print("object4");
        socialMediaList.value.add(SocialMediaInfo(
          platform: authState.socials!.reddit?.username,
          followers: authState.socials!.reddit?.noOfFollows,
        ));
      }

      if (authState.socials!.youtube != null &&
          authState.socials!.youtube?.noOfFollows != 0) {
        print("object5");
        socialMediaList.value.add(SocialMediaInfo(
          platform: authState.socials!.youtube?.username,
          followers: authState.socials!.youtube?.noOfFollows,
        ));
      }

      if (authState.socials!.pinterest != null &&
          authState.socials!.pinterest?.noOfFollows != 0) {
        print("object6");
        socialMediaList.value.add(SocialMediaInfo(
          platform: authState.socials!.pinterest?.username,
          followers: authState.socials!.pinterest?.noOfFollows,
        ));
      }
      if (authState.socials!.linkedin != null &&
          authState.socials!.linkedin?.noOfFollows != 0) {
        print("object7");
        socialMediaList.value.add(SocialMediaInfo(
          platform: authState.socials!.linkedin?.username,
          followers: authState.socials!.linkedin?.noOfFollows,
        ));
      }

      if (authState.socials!.snapchat != null &&
          authState.socials!.snapchat?.noOfFollows != 0) {
        print("object8");
        socialMediaList.value.add(SocialMediaInfo(
          platform: authState.socials!.snapchat?.username,
          followers: authState.socials!.snapchat?.noOfFollows,
        ));
      }

      if (authState.socials!.tiktok != null &&
          authState.socials!.tiktok?.noOfFollows != 0) {
        print("object9");
        socialMediaList.value.add(SocialMediaInfo(
          platform: authState.socials!.tiktok?.username,
          followers: authState.socials!.tiktok?.noOfFollows,
        ));
      }

      if (authState.socials!.patreon != null &&
          authState.socials!.patreon?.noOfFollows != 0) {
        print("object10");
        socialMediaList.value.add(SocialMediaInfo(
          platform: authState.socials!.patreon?.username,
          followers: authState.socials!.patreon?.noOfFollows,
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // final authState = ref.watch(authProvider);
    final formStateKey = GlobalKey<FormState>();
    // _weightController.text = authState?.weight ?? '';
    // _chestController.text = authState?.chest ?? '';
    final appUserState = ref.watch(appUserProvider);
    final userTypes = ref.watch(accountTypesProvider);
    final user = appUserState.valueOrNull;
    _selectedEthnicity = user?.ethnicity;

    List<String> subTalentList = [];
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
                      await update(
                          isFormValid: formStateKey.currentState!.validate());
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
              addVerticalSpacing(25),
              Expanded(
                  child: SingleChildScrollView(
                controller: socialLinksScrollController,
                child: Form(
                  key: formStateKey,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Flexible(
                            child: VWidgetsDropDownTextField(
                              fieldLabel: "Personality",
                              hintText: _selectedPersonality == null
                                  ? 'select ...'
                                  : '',
                              value: _selectedPersonality,
                              isExpanded: true,
                              onChanged: (val) {
                                setState(() {
                                  // dropdownIdentifyValue = val;
                                  _selectedPersonality = val;
                                });
                              },
                              options: VConstants.userPersonalities,
                            ),
                          ),
                          addHorizontalSpacing(20),
                          Flexible(
                            child: VWidgetsDropDownTextField(
                              fieldLabel: "Ethnicity",
                              hintText: _selectedEthnicity == null
                                  ? 'select ...'
                                  : '',
                              value: _selectedEthnicity,
                              isExpanded: true,
                              onChanged: (val) {
                                setState(() {
                                  // dropdownIdentifyValue = val;
                                  _selectedEthnicity = val;
                                });
                              },
                              options: Ethnicity.values,
                            ),
                          ),
                        ],
                      ),
                      Divider(
                        color: Theme.of(context).primaryColor.withOpacity(.4),
                      ),

                      Row(
                        children: [
                          Expanded(
                            child: VWidgetsPrimaryTextFieldWithTitle2(
                              isDense: true,
                              label: "Bust (cm)",
                              controller: _bustController,
                              // initialValue: valueOrNull(authState?.height),
                              // onSaved: (value){
                              //   _height = value ?? '';
                              // },
                              // controller: widget.weight,
                              // hintText: widget.weight.text,
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 7, horizontal: 8),
                              heightForErrorText: 0,
                              hintText:
                                  valueOrNull(_bustController.text) ?? "Ex. 30",
                              // isIncreaseHeightForErrorText: true,
                              validator: (value) =>
                                  VValidatorsMixin.isNotEmpty(value),
                            ),
                          ),
                          addHorizontalSpacing(20),
                          Expanded(
                            child: VWidgetsPrimaryTextFieldWithTitle2(
                              isDense: true,
                              label: "Chest (cm)",
                              controller: _chestController,
                              // initialValue: valueOrNull(authState?.height),
                              // onSaved: (value){
                              //   _height = value ?? '';
                              // },
                              // controller: widget.weight,
                              // hintText: widget.weight.text,
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 7, horizontal: 8),
                              heightForErrorText: 0,
                              hintText: valueOrNull(_chestController.text) ??
                                  "Ex. 30",
                              // isIncreaseHeightForErrorText: true,
                              validator: (value) =>
                                  VValidatorsMixin.isNotEmpty(value),
                            ),
                          ),
                          // addHorizontalSpacing(20),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: VWidgetsPrimaryTextFieldWithTitle2(
                              isDense: true,
                              label: "Feet (cm)",
                              controller: _feetController,
                              // initialValue: valueOrNull(authState?.height),
                              // onSaved: (value){
                              //   _height = value ?? '';
                              // },
                              // controller: widget.weight,
                              // hintText: widget.weight.text,

                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 7, horizontal: 8),
                              heightForErrorText: 0,
                              hintText:
                                  valueOrNull(_feetController.text) ?? "Ex. 30",
                              // isIncreaseHeightForErrorText: true,
                              validator: (value) =>
                                  VValidatorsMixin.isNotEmpty(value),
                            ),
                          ),
                          addHorizontalSpacing(20),
                          Expanded(
                            child: VWidgetsPrimaryTextFieldWithTitle2(
                              isDense: true,
                              label: "Waist (cm)",
                              controller: _waistController,
                              // initialValue: valueOrNull(authState?.height),
                              // onSaved: (value){
                              //   _height = value ?? '';
                              // },
                              // controller: widget.weight,
                              // hintText: widget.weight.text,
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 7, horizontal: 8),
                              heightForErrorText: 0,
                              hintText:
                                  valueOrNull(_bustController.text) ?? "Ex. 30",
                              // isIncreaseHeightForErrorText: true,
                              validator: (value) =>
                                  VValidatorsMixin.isNotEmpty(value),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: VWidgetsPrimaryTextFieldWithTitle2(
                              isDense: true,
                              label: "Hair Colour",
                              controller: _hairController,
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 7, horizontal: 8),
                              heightForErrorText: 0,
                              hintText: valueOrNull(_hairController.text) ??
                                  "Ex. Brown",
                              // isIncreaseHeightForErrorText: true,
                              validator: (value) =>
                                  VValidatorsMixin.isNotEmpty(value),
                            ),
                          ),
                          addHorizontalSpacing(20),
                          Expanded(
                            child: VWidgetsPrimaryTextFieldWithTitle2(
                              minWidth: 42.5.w,
                              isDense: true,
                              label: "Eye Colour",
                              controller: _eyeController,
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 7, horizontal: 8),
                              heightForErrorText: 0,
                              hintText: valueOrNull(_eyeController.text) ??
                                  "Ex. Blue",
                              // isIncreaseHeightForErrorText: true,
                              validator: (value) =>
                                  VValidatorsMixin.isNotEmpty(value),
                            ),
                          ),
                          // Expanded(
                          //   child: VWidgetsPrimaryTextFieldWithTitle2(
                          //     label: "Personality",
                          //     hintText: VConstants.userPersonalities.first,
                          //     shouldReadOnly: true,
                          //     focusNode: null,
                          //     contentPadding: const EdgeInsets.symmetric(
                          //         vertical: 7, horizontal: 8),
                          //     heightForErrorText: 0,
                          //     onTap: () {
                          //       navigateToRoute(
                          //           context,
                          //           ProfileDropdownInput(
                          //             title: "Personality",
                          //             value: VConstants.userPersonalities.first,
                          //             options: VConstants.userPersonalities,
                          //             onSave: (newValue) async {},
                          //           ));
                          //     },
                          //   ),
                          // )
                        ],
                      ),
                      addVerticalSpacing(16),
                      Row(
                        children: [
                          Expanded(
                            child: VWidgetsPrimaryTextFieldWithTitle2(
                              isDense: true,
                              label: "Height (cm)",
                              minWidth: !user!.isBusinessAccount!
                                  ? SizerUtil.width * .42
                                  : null,
                              controller: _heightController,
                              // initialValue: valueOrNull(authState?.height),
                              // onSaved: (value){
                              //   _height = value ?? '';
                              // },
                              // controller: widget.weight,
                              // hintText: widget.weight.text,
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 7, horizontal: 8),
                              heightForErrorText: 0,
                              hintText: valueOrNull(_heightController.text) ??
                                  VMString.hintHeight,
                              // isIncreaseHeightForErrorText: true,
                              validator: VValidatorsMixin.isHeightValid,
                            ),
                          ),
                          if (!user.isBusinessAccount!)
                            addHorizontalSpacing(20),
                          if (!user.isBusinessAccount!)
                            Expanded(
                              child: VWidgetsDropDownTextField(
                                isIncreaseHeightForErrorText: false,
                                fieldLabel: 'Size(UK)',
                                hintText: '',
                                value: _modelSize,
                                onChanged: (val) {
                                  setState(() {
                                    _modelSize = val;
                                  });
                                },
                                // options: widget.options,
                                options: ModelSize.values,
                              ),
                            ),
                        ],
                      ),

                      // addVerticalSpacing(24),
                      // Padding(
                      //   padding: EdgeInsets.only(right: 46.w),
                      //   child: VWidgetsPrimaryTextFieldWithTitle(
                      //     label: "Weight (kg)",
                      //     controller: _weightController,
                      //     hintText: valueOrNull(authState?.weight ) ?? VMstring.hintWeight,
                      //     isIncreaseHeightForErrorText: true,
                      //     validator: VValidatorsMixin.isWeightValid,
                      //   ),
                      // ),

                      // Padding(
                      //   padding: EdgeInsets.only(right: 46.w),
                      //   child: VWidgetsPrimaryTextFieldWithTitle(
                      //     label: "Chest (cm)",
                      //     controller: _chestController,
                      //     hintText: valueOrNull(authState?.chest ) ?? VMstring.hintChest,
                      //     isIncreaseHeightForErrorText: true,
                      //     validator: VValidatorsMixin.isChestValid,
                      //     // onChanged: (value){
                      //     //   _chest = value;
                      //     // },
                      //   ),
                      // ),

                      // Spacer(flex: 2),

                      Divider(
                          color:
                              Theme.of(context).primaryColor.withOpacity(.4)),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Social links',
                              style: Theme.of(context)
                                  .textTheme
                                  .displayMedium!
                                  .copyWith(
                                    fontWeight: FontWeight.w600,
                                  )),
                          Row(
                            children: [
                              IconButton(
                                  onPressed: () {
                                    if (addField) {
                                      socialMediaList.value = [
                                        ...socialMediaList.value,
                                        SocialMediaInfo()
                                      ];
                                      addField = false;
                                      // setState(()=>{});
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content: Text(
                                                  "Please fill out all fields")));
                                    }

                                    socialLinksScrollController.animateTo(
                                        socialLinksScrollController
                                            .position.maxScrollExtent,
                                        duration:
                                            const Duration(milliseconds: 500),
                                        curve: Curves.ease);
                                  },
                                  icon: const Icon(Icons.add))
                            ],
                          ),
                        ],
                      ),

                      ValueListenableBuilder(
                          valueListenable: socialMediaList,
                          builder: (context, value, child) {
                            return ListView.builder(
                                controller: socialLinksScrollController,
                                itemCount: value.length,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 5),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: VWidgetsDropdownNormal(
                                              items: VConstants.platforms,
                                              itemToString: (item) => item,
                                              value: value[index].platform,
                                              validator: (val) {
                                                if (val == null ||
                                                    val.isEmpty) {
                                                  return 'Select a platform';
                                                }
                                                return null;
                                              },
                                              onChanged: (val) {
                                                value[index].platform = val;
                                              }),
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: VWidgetsTextFieldNormal(
                                            inputFormatters: [
                                              FilteringTextInputFormatter
                                                  .digitsOnly,
                                            ],
                                            controller: TextEditingController(
                                                text: value[index].followers !=
                                                        null
                                                    ? value[index]
                                                        .followers
                                                        .toString()
                                                    : null),
                                            onChanged: (val) {
                                              if (value[index].followers != 0) {
                                                addField = true;
                                              }
                                              value[index].followers =
                                                  int.parse(val ?? "0");
                                              //setState(()=>{});
                                            },
                                            hintText: getSocialLinkHint(
                                                value[index].platform),
                                          ),
                                        ),
                                        Container(
                                          width: 50,
                                          child: GestureDetector(
                                            onTap: () {
                                              socialMediaList.value
                                                  .removeLast();
                                              addField = true;
                                              setState(() {});
                                              socialLinksScrollController
                                                  .animateTo(
                                                      socialLinksScrollController
                                                          .position
                                                          .maxScrollExtent,
                                                      duration: const Duration(
                                                          milliseconds: 500),
                                                      curve: Curves.ease);
                                            },
                                            child: RenderSvg(
                                                svgPath: VIcons.remove,
                                                color: Theme.of(context)
                                                    .iconTheme
                                                    .color),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                });
                          }),

                      addVerticalSpacing(10),
                    ],
                  ),
                ),
              )),
              addVerticalSpacing(32),
              ValueListenableBuilder<bool>(
                  valueListenable: showLoading,
                  builder: (context, value, child) {
                    return VWidgetsPrimaryButton(
                      buttonTitle: "Done",
                      showLoadingIndicator: value,
                      onPressed: () async {
                        // VLoader.changeLoadingState(true);
                        showLoading.value = true;

                        await update(
                            isFormValid: formStateKey.currentState!.validate());

                        showLoading.value = false;
                        if (context.mounted) {
                          goBack(context);
                        }
                      },
                    );
                  }),
              addVerticalSpacing(40),
            ],
          ),
        ));
  }

  Future<void> update({required bool isFormValid}) async {
    if (isFormValid) {
      List<Map<String, dynamic>> _socialList = [];
      int? instaFollows;
      int? facebookFollows;
      int? twitterFollows;
      int? pinterestFollows;
      int? youtubeSubs;
      int? tiktokFollows;
      int? linkedinFollows;
      int? redditFollows;
      int? snapchatFollows;
      int? patreonFollows;
      //Todo: show error and return
      if (socialMediaList.value.isNotEmpty) {
        await ref.read(appUserProvider.notifier).updateUserSocials(
              facebook: socialMediaList.value.any((element) {
                var value = element.platform?.toLowerCase() == "facebook";
                facebookFollows = element.followers;
                return value;
              })
                  ? "Facebook"
                  : null,
              facebookFollows: facebookFollows,
              twitter: socialMediaList.value.any((element) {
                var value = element.platform?.toLowerCase() == "twitter";
                twitterFollows = element.followers;
                return value;
              })
                  ? "Twitter"
                  : null,
              twitterFollows: twitterFollows,
              tiktok: socialMediaList.value.any((element) {
                var value = element.platform?.toLowerCase() == "tiktok";
                tiktokFollows = element.followers;
                return value;
              })
                  ? "Tiktok"
                  : null,
              tiktokFollows: tiktokFollows,
              pinterest: socialMediaList.value.any((element) {
                var value = element.platform?.toLowerCase() == "pinterest";
                pinterestFollows = element.followers;
                return value;
              })
                  ? "Pinterest"
                  : null,
              pinterestFollows: pinterestFollows,
              youtube: socialMediaList.value.any((element) {
                var value = element.platform?.toLowerCase() == "youtube";
                youtubeSubs = element.followers;
                return value;
              })
                  ? "Youtube"
                  : null,
              youtubeSubs: youtubeSubs,
              instagram: socialMediaList.value.any((element) {
                var value = element.platform?.toLowerCase() == "instagram";
                instaFollows = element.followers;
                return value;
              })
                  ? "Instagram"
                  : null,
              instaFollows: instaFollows,
              patreon: socialMediaList.value.any((element) {
                var value = element.platform?.toLowerCase() == "patreon";
                patreonFollows = element.followers;
                return value;
              })
                  ? "Patreon"
                  : null,
              patreonFollows: patreonFollows,
              snapchat: socialMediaList.value.any((element) {
                var value = element.platform?.toLowerCase() == "snapchat";
                snapchatFollows = element.followers;
                return value;
              })
                  ? "Snapchat"
                  : null,
              snapchatFollows: snapchatFollows,
              linkedin: socialMediaList.value.any((element) {
                var value = element.platform?.toLowerCase() == "linkedin";
                linkedinFollows = element.followers;
                return value;
              })
                  ? "Linkedin"
                  : null,
              linkedinFollows: linkedinFollows,
              reddit: socialMediaList.value.any((element) {
                var value = element.platform?.toLowerCase() == "reddit";
                redditFollows = element.followers;
                return value;
              })
                  ? "Reddit"
                  : null,
              redditFollows: redditFollows,
            );
      }
    }

    await ref.read(appUserProvider.notifier).updateProfile(
          // authState?.copyWith(
          height: HeightModel(unit: 'cm', value: _heightController.text.trim()),
          waist: WaistModel(unit: 'cm', value: _waistController.text.trim()),
          bust: BustModel(unit: 'cm', value: _bustController.text.trim()),
          chest: ChestModel(unit: 'cm', value: _chestController.text.trim()),
          feet: FeetModel(unit: 'cm', value: _feetController.text.trim()),
          modelSize: _modelSize,
          hair: _hairController.text.trim(),
          eyes: _eyeController.text.trim(),
          personality: _selectedPersonality,
        );
  }

  String getSocialLinkHint(String? platform) {
    final lowerCase = platform?.toLowerCase() ?? "";
    if (lowerCase == "youtube") {
      return 'subscriber count';
    }
    return 'follower count';
  }

  String? valueOrNull(String? text) {
    if (text == null || text.isEmpty) {
      return null;
    } else {
      return text;
    }
  }
}
