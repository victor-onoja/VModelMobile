import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:vmodel/src/features/onboarding/views/birthday_view.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/shared/appbar/appbar.dart';
import 'package:vmodel/src/vmodel.dart';

import '../../../../../core/controller/app_user_controller.dart';
import '../../../../../core/utils/enum/gender_enum.dart';
import '../../../../../shared/response_widgets/toast.dart';
import '../../../../../shared/text_fields/profile_input_field.dart';
import '../../../../authentication/register/views/location_set_up.dart';
import '../../account_settings/widgets/account_settings_card.dart';

class ProfileSettingPage extends ConsumerStatefulWidget {
  const ProfileSettingPage({super.key});

  @override
  ConsumerState<ProfileSettingPage> createState() => _ProfileSettingPageState();
}

class _ProfileSettingPageState extends ConsumerState<ProfileSettingPage>
    with SingleTickerProviderStateMixin {
  late TabController pageController = TabController(length: 3, vsync: this);
  final Gender? dropdownIdentifyValue = Gender.any;
  String _dateOfBirth = "12 Jul, 1990";
  DateFormat formatter = DateFormat('d MMMM yyyy');
  final tabTitles = [
    'Personal information',
    'Profile settings',
    'Pet details',
  ];
  final mockCategories = [
    'Favourites',
    'Commercial',
    'Editorial',
    'Underwear',
    'Features',
  ];
  String dropdownIdentifyAsPetValue = '';
  String dropdownBodyTypeValue = "Slim";
  String dropdownPetValue = "Dog";
  List<String> mockPets = const [
    "Add my own",
    "Dog",
    "Cat",
    "Hamster",
    "Fish",
    "Bird",
    "Reptile",
    "Rabbit",
    "Poultry",
    "Ferret",
    "Guinea Pig",
  ];
  String dropdownDogBreedValue = "Siberian Husky";
  List<String> mockBreed = const [
    "Siberian Husky",
    "Golden retriever",
    "Labrador retriever",
    "French bulldog",
    "Beagle",
    "German shepherd dog",
    "Poodle",
    "Bulldog"
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final authState = ref.watch(authProvider);
    // final _userPK = authState.pk ?? 0;

    final appUserState = ref.watch(appUserProvider);
    final user = appUserState.valueOrNull;

    return Scaffold(
      appBar: const VWidgetsAppBar(
        leadingIcon: VWidgetsBackButton(),
        appbarTitle: "Account Settings",
        trailingIcon: [],
      ),
      body: user == null
          ? const Text('User state is null')
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  addVerticalSpacing(10),
                  _headingText('Personal Information'),
                  addVerticalSpacing(10),
                  VWidgetsAccountSettingsCard(
                    title: "First Name",
                    subtitle: user.firstName ?? '',
                    onTap: () {
                      navigateToRoute(
                          context,
                          ProfileInputField(
                            title: "First Name",
                            // value: _firstName,
                            value: user.firstName,
                            onSave: (newValue) async {
                              // await ref
                              //     .read(authProvider.notifier)
                              //     .userUpdate(firstName: newValue);
                              await ref
                                  .read(appUserProvider.notifier)
                                  .updateProfile(firstName: newValue);
                            },
                          ));
                    },
                  ),
                  VWidgetsAccountSettingsCard(
                    title: "Last Name",
                    // subtitle: _lastName.text,
                    subtitle: user.lastName ?? '',
                    onTap: () {
                      navigateToRoute(
                          context,
                          ProfileInputField(
                            title: "Last Name",
                            value: user.lastName,
                            onSave: (newValue) async {
                              // await ref
                              //     .read(authProvider.notifier)
                              //     .userUpdate(lastName: newValue);
                              await ref
                                  .read(appUserProvider.notifier)
                                  .updateProfile(lastName: newValue);
                            },
                          ));
                    },
                  ),
                  VWidgetsAccountSettingsCard(
                    title: "Date of birth",
                    // subtitle: _lastName.text,
                    subtitle: user.dob != null
                        ? formatter.format(user.dob!)
                        : _dateOfBirth,
                    onTap: () async {
                      navigateToRoute(
                          context, OnboardingBirthday(dob: user.dob ?? null));

                      // DateTime? selectedDate = await showDatePicker(
                      //   context: context,
                      //   initialDate: DateTime.now(),
                      //   firstDate: DateTime.now(),
                      //   lastDate: DateTime(DateTime.now().year + 10),
                      //   builder: (context, child) {
                      //     return Theme(
                      //       data: ThemeData.light().copyWith(
                      //         useMaterial3: true,
                      //         colorScheme: const ColorScheme.light(
                      //             primary: VmodelColors.primaryColor),
                      //       ),
                      //       child: child!,
                      //     );
                      //   },
                      // );
                      // if (selectedDate != null) {
                      //   _dateOfBirth = formatter.format(DateTime.parse(
                      //       selectedDate.toIso8601String().split("T")[0]));
                      //   setState(() {});
                      // }
                      // navigateToRoute(
                      //     context,
                      //     ProfileInputField(
                      //       title: "Date of birth",
                      //       value: "12 Jul, 1990",
                      //       onSave: (newValue) async {
                      //         await ref
                      //             .read(appUserProvider.notifier)
                      //             .updateProfile(lastName: newValue);
                      //       },
                      //     ));
                    },
                  ),
                  VWidgetsAccountSettingsCard(
                    title: "Email",
                    // subtitle: _lastName.text,
                    subtitle: user.email ?? '',
                    onTap: () {
                      navigateToRoute(
                          context,
                          ProfileInputField(
                            title: "Email",
                            value: user.email,
                            onSave: (newValue) async {
                              VWidgetShowResponse.showToast(
                                  ResponseEnum.warning,
                                  message: "Cannot change email now");
                              // await ref
                              //     .read(appUserProvider.notifier)
                              //     .updateProfile(email: newValue);
                            },
                          ));
                    },
                  ),
                  addVerticalSpacing(10),
                  VWidgetsAccountSettingsCard(
                    title: "Phone number",
                    // subtitle: _username.text.toLowerCase(),
                    subtitle: user.phone?.number ?? '',
                    onTap: () {
                      navigateToRoute(
                          context,
                          // ProfileInputField(
                          //   title: "Phone number",
                          //   // value: _username,
                          //   value: user.phone ?? '',
                          //   onSave: (newValue) async {
                          //     await ref
                          //         .read(appUserProvider.notifier)
                          //         .updateProfile(phone: newValue);
                          //   },
                          //   // purpose: '_username',
                          // )

                          PhoneAndEmailInputField(
                            title: 'Phone number',
                            value: user.phone?.number ?? "",
                            phoneData: user.phone,
                            onSave: (value) async {},
                            onPhoneSave: (newVal) async {
                              await ref
                                  .read(appUserProvider.notifier)
                                  .updateProfile(phone: newVal);
                            },
                          ));
                    },
                  ),
                  VWidgetsAccountSettingsCard(
                    title: "Location",
                    // subtitle: _username.text.toLowerCase(),
                    subtitle: user.location?.locationName ?? '',
                    onTap: () {
                      navigateToRoute(
                          context,
                          SignUpLocationViews(
                            initialValue: user.location?.locationName,
                            isLocationUpdate: true,
                          ));
                      // navigateToRoute(
                      //     context,
                      //     ProfileInputField(
                      //       title: "Location",
                      //       value: authState.locationName?.toLowerCase(),
                      //       onSave: (newValue) async {
                      //         await ref
                      //             .read(authProvider.notifier)
                      //             .userUpdate(locationName: newValue);
                      //       },
                      //       // purpose: '_username',
                      //     ));
                    },
                  ),
                  addVerticalSpacing(24),

                  // _headingText('Pet details'),
                  // addVerticalSpacing(10),
                  // VWidgetsAccountSettingsCard(
                  //   title: "Select Pet Type",
                  //   subtitle: dropdownPetValue,
                  //   onTap: () {
                  //     navigateToRoute(
                  //         context,
                  //         ProfileDropdownInput(
                  //           title: "Select Pet Type",
                  //           value: dropdownPetValue,
                  //           options: mockPets,
                  //           onSave: (newValue) async {
                  //             // ref.read(authProvider.notifier).updateState(
                  //             //     authState.copyWith(: newValue));
                  //           },
                  //         ));
                  //   },
                  // ),
                  // if (dropdownPetValue == "Dog" &&
                  //     dropdownIdentifyValue == "I'm representing a Pet")
                  // VWidgetsDropDownTextField(
                  //   fieldLabel: "Select Breed",
                  //   hintText: "",
                  //   value: dropdownDogBreedValue,
                  //   onChanged: (val) {
                  //     setState(() {
                  //       dropdownDogBreedValue = val;
                  //     });
                  //   },
                  //   options: const [
                  //     "Siberian Husky",
                  //     "Golden retriever",
                  //     "Labrador retriever",
                  //     "French bulldog",
                  //     "Beagle",
                  //     "German shepherd dog",
                  //     "Poodle",
                  //     "Bulldog"
                  //   ],
                  // ),
                  // VWidgetsAccountSettingsCard(
                  //   title: "Select Breed",
                  //   subtitle: dropdownDogBreedValue,
                  //   onTap: () {
                  //     navigateToRoute(
                  //         context,
                  //         ProfileDropdownInput(
                  //           title: "Select Breed",
                  //           value: dropdownDogBreedValue,
                  //           options: mockBreed,
                  //           onSave: (newValue) async {
                  //             // ref.read(authProvider.notifier).updateState(
                  //             //     authState.copyWith(ethnicity: newValue));
                  //           },
                  //         ));
                  //   },
                  // ),
                  // VWidgetsAccountSettingsCard(
                  //   title: "Age",
                  //   subtitle: '2',
                  //   onTap: () {
                  //     navigateToRoute(
                  //         context,
                  //         ProfileInputField(
                  //           title: "Age",
                  //           value: '',
                  //           onSave: (newValue) async {},
                  //         ));
                  //   },
                  // ),
                  // if (dropdownPetValue == "Add my own" &&
                  //     dropdownIdentifyAsPetValue == "I'm representing a Pet")
                  //   Column(
                  //     children: [
                  //       addVerticalSpacing(10),
                  //       const VWidgetsTextFieldWithoutTitle(
                  //           hintText: "Pet Type"),
                  //       addVerticalSpacing(10),
                  //       const VWidgetsTextFieldWithoutTitle(
                  //           hintText: "Pet Breed"),
                  //       addVerticalSpacing(10)
                  //     ],
                  //   ),
                  // addVerticalSpacing(40),
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
                  // addVerticalSpacing(10),
                  // VWidgetsPrimaryButton(
                  //   buttonTitle: "Apply",
                  //   onPressed: () async {
                  //     final authNotifier = ref.read(authProvider.notifier);
                  //     await authNotifier.userUpdate(
                  //         _pk != 0 ? _pk : authNotifier.state.pk!.toInt(),
                  //         _bio.text,
                  //         dropdownFeetValue!,
                  //         _username.text.capitalizeFirst!.trim(),
                  //         _firstName.text.capitalizeFirst!.trim(),
                  //         _lastName.text.capitalizeFirst!.trim(),
                  //         _weight.text.trim(),
                  //         _hair.text.capitalizeFirst!.trim(),
                  //         _eyes.text.capitalizeFirst!.trim(),
                  //         _chest.text.trim());
                  //     await authNotifier.getUser(_pk != 0
                  //         ? _pk
                  //         : ref.read(authProvider.notifier).state.pk!.toInt());
                  //     popSheet(context);
                  //     navigateAndRemoveUntilRoute(context, const DashBoardView());
                  //   },
                  //   enableButton: true,
                  // ),
                  addVerticalSpacing(40),

                  // TabBar(
                  //     controller: pageController,
                  //     labelPadding: const EdgeInsets.symmetric(horizontal: 16),
                  //     labelStyle: context.textTheme.displayMedium
                  //         ?.copyWith(fontWeight: FontWeight.w600),
                  //     labelColor: VmodelColors.primaryColor,
                  //     unselectedLabelColor: VmodelColors.unselectedText,
                  //     unselectedLabelStyle: context.textTheme.displayMedium
                  //         ?.copyWith(fontWeight: FontWeight.w500),
                  //     indicatorColor: VmodelColors.mainColor,
                  //     isScrollable: true,
                  //     tabs: List.generate(
                  //       tabTitles.length,
                  //       (index) => Tab(text: tabTitles[index]),
                  //     ),
                  //     onTap: (_) {}),
                  // Expanded(
                  //   child: Padding(
                  //     padding: const EdgeInsets.all(16.0),
                  //     child: TabBarView(
                  //       controller: pageController,
                  //       children: const [
                  //         PersonalInformationWidget(),
                  //         MyProfileSettings(),
                  //         PetDetailsSettings(),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
    );
  }

  Widget _headingText(String title) {
    return Text(
      title,
      style: context.textTheme.displayMedium?.copyWith(
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
