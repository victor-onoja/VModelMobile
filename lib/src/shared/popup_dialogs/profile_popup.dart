import 'dart:io';

import 'package:vmodel/src/core/models/height_model.dart';
import 'package:vmodel/src/features/dashboard/new_profile/profile_features/widgets/profile_picture_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:vmodel/src/res/icons.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/shared/response_widgets/toast.dart';
import 'package:vmodel/src/vmodel.dart';

import 'package:badges/badges.dart' as notiBadge;

import '../../core/controller/app_user_controller.dart';
import '../../core/utils/costants.dart';
import '../../core/utils/enum/ethnicity_enum.dart';
import '../../core/utils/enum/gender_enum.dart';
import '../../core/utils/enum/size_enum.dart';
import '../../core/utils/helper_functions.dart';
import '../../core/utils/validators_mixins.dart';
import '../../features/dashboard/discover/widget/category_button.dart';
import '../../features/dashboard/profile/controller/profile_controller.dart';
import '../buttons/primary_button.dart';
import '../loader/circle_profile_indicator.dart';
import '../loader/full_screen_dialog_loader.dart';
import '../text_fields/description_text_field.dart';
import '../text_fields/dropdown_text_field.dart';
import '../text_fields/primary_text_field.dart';

//Todo update this to true to show complete profile popup
final popUpEnabledProvider = StateProvider((ref) => false);
final percentProvider = StateProvider.autoDispose((ref) => 0);

class PopupWrapper extends ConsumerWidget {
  final Widget child;
  final Widget popup;

  const PopupWrapper({
    super.key,
    required this.child,
    required this.popup,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final enablePopuUp = ref.watch(popUpEnabledProvider);
    return Stack(
      children: [
        child,
        if (enablePopuUp)
          GestureDetector(
            onTap: () => ref.read(popUpEnabledProvider.notifier).state = false,
            child: Container(
              color: Colors.black54,
              alignment: Alignment.center,
              child: popup,
            ),
          ),
      ],
    );
  }
}

class MyPopup extends ConsumerStatefulWidget with VValidatorsMixin {
  late int value;
  @override
  ConsumerState<MyPopup> createState() => _MyPopupState();
  MyPopup({Key? key, this.value = 10}) : super(key: key);
}

class _MyPopupState extends ConsumerState<MyPopup>
    with SingleTickerProviderStateMixin {
  late AnimationController _progressController;
  // Animation<double>? animation;
  bool isDefaultBio = true;
  bool isConnected = false;
  bool isUserPrivate = false;
  bool longPressProfile = false;

  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _hairController = TextEditingController();
  final TextEditingController _eyeController = TextEditingController();
  final TextEditingController _locationNameController = TextEditingController();
  Gender _updatedGender = Gender.any;
  Ethnicity? _updatedEthnicity;
  ModelSize _updatedModelSize = ModelSize.other;
  bool updateFields = true;

  final _heightFieldState = GlobalKey<FormFieldState>();
  final _phoneNumberFieldState = GlobalKey<FormFieldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  // late final List<TextEditingController> _fieldControllers;

  File? _image;
  @override
  void initState() {
    super.initState();
    _progressController = AnimationController(
      vsync: this,
      lowerBound: 0,
      upperBound: 100,
      reverseDuration: const Duration(milliseconds: 3000),
      duration: const Duration(milliseconds: 3000),
    )..addListener(() {
        if (!mounted) return;
        setState(() {});
      });

    // animation = Tween<double>(begin: 0, end: 100).animate(progressController!)
    //   ..addListener(() {
    //     setState(() {});
    //   });
  }

  @override
  void dispose() {
    _progressController.dispose();
    _bioController.dispose();
    _phoneController.dispose();
    _heightController.dispose();
    _hairController.dispose();
    _eyeController.dispose();
    _locationNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //Todo finalize this
    ref.watch(profileProvider(null));
    // final authNotifier = ref.watch(authProvider);
    final userState = ref.watch(appUserProvider);
    final authNotifier = userState.valueOrNull;
    final percentState = ref.watch(percentProvider);
    // final appUser = ref.watch(appUserProvider);
    // final user = appUser.valueOrNull;
    // final authNotif = ref.watch(authProvider.notifier);
    // final authNot = authNotif.state;
    ref.listen(percentProvider, (prev, next) {
      final start = prev!.toDouble();
      final end = next.toDouble();

      if (start < end) {
        _progressController.animateTo(end, curve: Curves.easeIn);
      } else {
        _progressController.animateBack(end, curve: Curves.easeIn);
      }
    });

    //Update fields only if auth state has not been retrieved
    if (updateFields) {
      _bioController.text = authNotifier?.bio ?? '';
      _phoneController.text = authNotifier?.phone?.number ?? '';
      _heightController.text = authNotifier?.height?.value ?? '';
      _hairController.text = authNotifier?.hair ?? '';
      _eyeController.text = authNotifier?.eyes ?? '';
      _locationNameController.text = authNotifier?.location?.locationName ?? '';
      _updatedGender = authNotifier?.gender ?? Gender.any;
      _updatedEthnicity = authNotifier?.ethnicity;
      _updatedModelSize = authNotifier?.modelSize ?? ModelSize.other;

      //If pk is not null then state information has been loaded
      // thus skip assignment on next widget rebuild.
      // updateFields = authNotifier?.pk == null;
      updateFields = authNotifier?.id == null;

      _calculatePercentageComplete();
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.red,
        title: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Icon(
            Icons.warning_amber_rounded,
            color: Colors.white,
            size: 18,
          ),
          addHorizontalSpacing(10),
          Text(
            'Complete your profile',
            style: Theme.of(context).textTheme.displayMedium!.copyWith(
                  fontSize: 13.sp,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
          )
        ]),
      ),
      backgroundColor: Colors.transparent,
      body: AlertDialog(
        insetPadding: const EdgeInsets.all(20),
        contentPadding: EdgeInsets.zero,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        content: Container(
          width: MediaQuery.of(context).size.width / 0.2,
          padding: const EdgeInsets.fromLTRB(10, 30, 10, 5),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Flexible(
                          child: Stack(children: [
                            CustomPaint(
                              child: Container(
                                // width: 200,
                                // height: 200,
                                child: GestureDetector(
                                    onDoubleTap: () {},
                                    child: _profilePicture(
                                      authNotifier?.profilePictureUrl ?? "",
                                      VIcons.emptyProfileIconLightMode,
                                    )),
                              ),
                            ),
                            Positioned(
                              bottom: MediaQuery.of(context).size.height / 35.2,
                              left: 0.0,
                              right: MediaQuery.of(context).size.width / 13,
                              child: notiBadge.Badge(
                                  alignment: Alignment.bottomLeft,
                                  badgeColor: VmodelColors.white,
                                  elevation: 0,
                                  toAnimate: false,
                                  showBadge: true,
                                  badgeContent: Text(
                                    // '${animation!.value.toInt()}%',
                                    '$percentState%',
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayLarge!
                                        .copyWith(
                                            color: VmodelColors.primaryColor,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 15.sp),
                                  ),
                                  child: Container()),
                            ),
                          ]),
                        ),
                        Flexible(
                          // fit: FlexFit.tight,
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        authNotifier?.fullName ?? '',
                                        style: Theme.of(context)
                                            .textTheme
                                            .displayMedium!
                                            .copyWith(
                                              fontSize: 15.sp,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              fontWeight: FontWeight.w600,
                                            ),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 4,
                                      ),
                                      addHorizontalSpacing(10),
                                    ]),
                                // addVerticalSpacing(10),
                                // Row(
                                //     mainAxisAlignment: MainAxisAlignment.start,
                                //     children: [
                                //       Row(
                                //         children: List.generate(5, (index) {
                                //           return Icon(
                                //             index < widget.value
                                //                 ? Icons.star_sharp
                                //                 : Icons.star_border,
                                //             color: VmodelColors
                                //                 .vModelprimarySwatch,
                                //             size: 18,
                                //           );
                                //         }),
                                //       ),
                                //       addHorizontalSpacing(10),
                                //       Flexible(
                                //         child: Text(
                                //           '4.2',
                                //           style: Theme.of(context)
                                //               .textTheme
                                //               .displayMedium!
                                //               .copyWith(
                                //                 fontSize: 12.sp,
                                //                 color: Theme.of(context)
                                //                     .primaryColor,
                                //                 fontWeight: FontWeight.w600,
                                //               ),
                                //           overflow: TextOverflow.ellipsis,
                                //           maxLines: 3,
                                //         ),
                                //       ),
                                //     ]),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    CategoryButton(
                                      isSelected: false,
                                      text: 'Edit Photo',
                                      onPressed: () async {
                                        // UpdateProfilePicture()
                                        //     .updateProfilePicture()
                                        //     .then((value) async {
                                        //   if (value != null) {
                                        //     VLoader.changeLoadingState(true);
                                        //     final image =
                                        //         await UpdateProfilePicture()
                                        //             .cropImage(value);
                                        //     final bytes =
                                        //         await image!.readAsBytes();
                                        //     String base64Image =
                                        //         base64Encode(bytes);
                                        //     await authNotif.pictureUpdate(
                                        //       userIDPk!,
                                        //       base64Image,
                                        //       "${authNot.username}_${value.split('/').last}",
                                        //     );
                                        //     VLoader.changeLoadingState(false);
                                        //   } else {}
                                        // });

                                        selectAndCropImage()
                                            .then((value) async {
                                          print(value);
                                          if (value != null && value != "") {
                                            ref
                                                .read(appUserProvider.notifier)
                                                .uploadProfilePicture(value,
                                                    onProgress: (sent, total) {
                                              final percentUploaded =
                                                  (sent / total);
                                              print(
                                                  '########## $value\n [$percentUploaded%]  sent: $sent ---- total: $total');
                                            });
                                          }
                                        });
                                        // UpdateProfilePicture()
                                        //     .updateProfilePicture()
                                        //     .then((value) async {
                                        //   if (value != null) {
                                        //     VLoader.changeLoadingState(true);
                                        //     final image =
                                        //         await UpdateProfilePicture()
                                        //             .cropImage(value);
                                        //     final bytes =
                                        //         await image!.readAsBytes();
                                        //     String base64Image =
                                        //         base64Encode(bytes);
                                        //     await authNotif.pictureUpdate(
                                        //       userIDPk!,
                                        //       base64Image,
                                        //       "${authNot.username}_${value.split('/').last}",
                                        //     );
                                        //     VLoader.changeLoadingState(false);
                                        //   } else {}
                                        // });

                                        // String? imagePath = await _openImagePicker();
                                        //
                                        // if (imagePath != "") {
                                        //
                                        // final image = await cropImage(imagePath);
                                        //
                                        // if (image != null) {
                                        //   print('profile popup IMAGEA update');
                                        //   print(userIDPk);
                                        // VLoader.changeLoadingState(true);
                                        // final bytes = await image.readAsBytes();
                                        // String base64Image = base64Encode(bytes);
                                        // await ref.read(authProvider.notifier).pictureUpdate(
                                        // userIDPk!,
                                        // base64Image,
                                        // "${authNotifier.username}_${imagePath.split('/').last}");
                                        //
                                        // VLoader.changeLoadingState(false);
                                        // }
                                        // }

                                        // await _openImagePicker();
                                        // final bytes =
                                        //     await _image!.readAsBytes();
                                        // String base64Image =
                                        //     base64Encode(bytes);
                                        // await ref
                                        //     .read(authProvider.notifier)
                                        //     .pictureUpdate(userIDPk!,
                                        //         base64Image, 'profilePicture');
                                        setState(() {});
                                      },
                                    )
                                  ],
                                )
                              ]),
                        ),
                      ],
                    ),
                    addVerticalSpacing(10),
                    Row(
                      children: [
                        const Icon(Icons.info_outline_rounded),
                        addHorizontalSpacing(10),
                        Flexible(
                            child: RichText(
                          text: TextSpan(
                            text: 'You must complete at least',
                            style: Theme.of(context)
                                .textTheme
                                .displayMedium!
                                .copyWith(
                                  fontSize: 10.sp,
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.w400,
                                ),
                            children: <TextSpan>[
                              TextSpan(
                                text: ' 70% ',
                                style: Theme.of(context)
                                    .textTheme
                                    .displayMedium!
                                    .copyWith(
                                      fontSize: 11.sp,
                                      color: Theme.of(context).primaryColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                              ),
                              TextSpan(
                                text:
                                    'of your profile to get access to bookings.',
                                style: Theme.of(context)
                                    .textTheme
                                    .displayMedium!
                                    .copyWith(
                                      fontSize: 10.sp,
                                      color: Theme.of(context).primaryColor,
                                      fontWeight: FontWeight.w400,
                                    ),
                              ),
                            ],
                          ),
                        ))
                      ],
                    ),
                    addVerticalSpacing(20),
                    // VWidgetsPrimaryTextFieldWithTitle(
                    //   onChanged: (val) {
                    //     widget.value = 10;
                    //     setState(() {});
                    //   },
                    //   label: "Username",
                    //   hintText: "Ex. vmodel",
                    //   controller: _fieldControllers[0],
                    //   labelStyle: Theme.of(context)
                    //       .textTheme
                    //       .displayMedium!
                    //       .copyWith(
                    //           fontSize: 14,
                    //           fontWeight: FontWeight.w600,
                    //           color: VmodelColors.mainColor),
                    //   hintStyle: Theme.of(context)
                    //       .textTheme
                    //       .displayMedium!
                    //       .copyWith(
                    //           fontSize: 14,
                    //           fontWeight: FontWeight.w500,
                    //           color: VmodelColors.mainColor),
                    // ),
                    // addVerticalSpacing(10),
                    // VWidgetsPrimaryTextFieldWithTitle(
                    //   label: "Full name",
                    //   controller: _fieldControllers[1],
                    //   hintText: "Ex. Jane Cooper",
                    //   labelStyle: Theme.of(context)
                    //       .textTheme
                    //       .displayMedium!
                    //       .copyWith(
                    //           fontSize: 14,
                    //           fontWeight: FontWeight.w600,
                    //           color: VmodelColors.mainColor),
                    //   hintStyle: Theme.of(context)
                    //       .textTheme
                    //       .displayMedium!
                    //       .copyWith(
                    //           fontSize: 14,
                    //           fontWeight: FontWeight.w500,
                    //           color: VmodelColors.mainColor),
                    // ),
                    addVerticalSpacing(10),
                    VWidgetsDescriptionTextFieldWithTitle(
                      label: "Bio",
                      hintText: VMString.hintBio,
                      controller: _bioController,
                      maxLines: 8,
                      maxLength: VConstants.maxBioLength,
                      validator: (newValue) =>
                          VValidatorsMixin.isNotEmpty(newValue, field: 'Bio'),
                      onChanged: (value) {
                        _calculatePercentageComplete();
                      },
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
                      // controller: ,
                    ),
                    addVerticalSpacing(30),
                    VWidgetsPrimaryTextFieldWithTitle(
                      key: _phoneNumberFieldState,
                      label: "Mobile",
                      isIncreaseHeightForErrorText: true,
                      heightForErrorText: 8.h,
                      keyboardType: TextInputType.phone,
                      hintText: VMString.hintPhone,
                      controller: _phoneController,
                      onChanged: (value) {
                        _calculatePercentageComplete();
                      },
                      validator: VValidatorsMixin.isPhoneValid,
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
                    ),
                    addVerticalSpacing(5),
                    VWidgetsDropDownTextField(
                      isIncreaseHeightForErrorText: true,
                      heightForErrorText: 8.h,
                      fieldLabel: "Gender",
                      hintText: '',
                      value: _updatedGender,
                      options: Gender.values,
                      // getLabel: (String value) => value,
                      onChanged: (value) {
                        setState(() {
                          _updatedGender = value;
                        });
                        _calculatePercentageComplete();
                        // ref
                        //     .read(authProvider.notifier)
                        //     .updateState(authState.copyWith(gender: value));
                      },
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
                    ),
                    // addVerticalSpacing(5),
                    VWidgetsDropDownTextField<Ethnicity>(
                      isIncreaseHeightForErrorText: true,
                      heightForErrorText: 8.h,
                      fieldLabel: "Ethnicity",
                      hintText: _updatedEthnicity == null ? 'select ...' : '',
                      options: Ethnicity.values,
                      // getLabel: (Ethnicity value) => value.name,
                      value: _updatedEthnicity,
                      onChanged: (value) {
                        setState(() {
                          _updatedEthnicity = value;
                        });
                        _calculatePercentageComplete();
                      },
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
                    ),
                    // addVerticalSpacing(5),
                    VWidgetsDropDownTextField<ModelSize>(
                      isIncreaseHeightForErrorText: true,
                      heightForErrorText: 8.h,
                      fieldLabel: "Size",
                      hintText: '',
                      options: ModelSize.values,
                      // getLabel: (ModelSize value) => value.name,
                      value: _updatedModelSize,
                      onChanged: (value) {
                        setState(() {
                          _updatedModelSize = value;
                        });
                        // progressController!.forward();
                        _calculatePercentageComplete();
                      },
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
                    ),
                    // addVerticalSpacing(5),
                    VWidgetsPrimaryTextFieldWithTitle(
                      key: _heightFieldState,
                      isIncreaseHeightForErrorText: true,
                      heightForErrorText: 8.h,
                      onChanged: (val) {
                        // progressController!.forward();
                        final isValid =
                            _heightFieldState.currentState?.validate();
                        // if (isValid) {
                        _calculatePercentageComplete();
                        // }
                      },
                      keyboardType: TextInputType.number,
                      validator: (value) => VValidatorsMixin.isHeightValid(
                          value,
                          isRequired: true),
                      label: "Height (cm)",
                      hintText: VMString.hintHeight,
                      controller: _heightController,
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
                    ),
                    addVerticalSpacing(12),
                    VWidgetsPrimaryTextFieldWithTitle(
                      onChanged: (val) {
                        _calculatePercentageComplete();
                      },
                      label: "Hair Colour",
                      isIncreaseHeightForErrorText: true,
                      heightForErrorText: 8.h,
                      validator: (value) => VValidatorsMixin.isNotEmpty(value,
                          field: 'Hair colour'),
                      controller: _hairController,
                      hintText: VMString.hintHairColor,
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
                    ),
                    addVerticalSpacing(12),
                    VWidgetsPrimaryTextFieldWithTitle(
                      onChanged: (val) {
                        _calculatePercentageComplete();
                      },
                      label: "Eye Colour",
                      isIncreaseHeightForErrorText: true,
                      heightForErrorText: 8.h,
                      validator: (value) => VValidatorsMixin.isNotEmpty(value,
                          field: 'Eye colour'),
                      hintText: VMString.hintEyeColor,
                      controller: _eyeController,
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
                    ),
                    addVerticalSpacing(12),
                    // VWidgetsPrimaryTextFieldWithTitle(
                    //   onChanged: (val) {
                    //     _calculatePercentageComplete();
                    //   },
                    //   label: "City(Location)",
                    //   hintText: VMstring.hintLocation,
                    //   controller: _locationNameController,
                    //   labelStyle: Theme.of(context)
                    //       .textTheme
                    //       .displayMedium!
                    //       .copyWith(
                    //           fontSize: 14,
                    //           fontWeight: FontWeight.w600,
                    //           color: VmodelColors.mainColor),
                    //   hintStyle: Theme.of(context)
                    //       .textTheme
                    //       .displayMedium!
                    //       .copyWith(
                    //           fontSize: 14,
                    //           fontWeight: FontWeight.w500,
                    //           color: VmodelColors.mainColor),
                    // ),
                    addVerticalSpacing(10),
                    VWidgetsPrimaryButton(
                        buttonTitle: "Complete",
                        enableButton: true,
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            //Set bio to null when it is empty so that in profile default text
                            // will be displayed
                            String? trimmedBio = _bioController.text.trim();
                            if (trimmedBio.isEmpty) trimmedBio = null;
                            VLoader.changeLoadingState(true);
                            await ref
                                .read(appUserProvider.notifier)
                                .updateProfile(
                                  bio: trimmedBio,
                                  // phone: _phoneController.text.trim(), //Todo fix to allow update from popup
                                  height: HeightModel(
                                      value: _heightController.text.trim(),
                                      unit: 'cm'),
                                  hair: _hairController.text.trim(),
                                  eyes: _eyeController.text.trim(),
                                  // location: _locationNameController.text.trim(),
                                  gender: _updatedGender,
                                  ethnicity: _updatedEthnicity,
                                  modelSize: _updatedModelSize,
                                );
                            // await ref.read(authProvider.notifier).userUpdate(
                            //       // authNotifier.copyWith(
                            //       bio: trimmedBio,
                            //       phone: _phoneController.text.trim(),
                            //       height: _heightController.text.trim(),
                            //       hair: _hairController.text.trim(),
                            //       eyes: _eyeController.text.trim(),
                            //       locationName:
                            //           _locationNameController.text.trim(),
                            //       gender: _updatedGender,
                            //       ethnicity: _updatedEthnicity,
                            //       modelSize: _updatedModelSize,
                            //       // ),
                            //     );
                            VLoader.changeLoadingState(false);
                            ref.read(popUpEnabledProvider.notifier).state =
                                false;
                            // navigateToRoute(context, DashBoardView());
                          } else {
                            VWidgetShowResponse.showToast(
                              ResponseEnum.failed,
                              message:
                                  'Please provide valid input for all fields',
                            );
                          }
                        }),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _calculatePercentageComplete() {
    double total = 9.0;
    int completed = 0;
    double percentage = 0.0;

    completed += _bioController.text.isEmpty ? 0 : 1;
    completed += _heightController.text.isEmpty ? 0 : 1;
    completed += _phoneController.text.isEmpty ? 0 : 1;
    completed += _hairController.text.isEmpty ? 0 : 1;
    completed += _eyeController.text.isEmpty ? 0 : 1;
    completed += _locationNameController.text.isEmpty ? 0 : 1;
    completed += _updatedGender == Gender.any ? 0 : 1;
    completed += _updatedEthnicity == null ? 0 : 1;
    completed += _updatedModelSize == ModelSize.other ? 0 : 1;

    percentage = completed / total;

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(percentProvider.notifier).state = (percentage * 100).round();
    });
  }

  Widget _profilePicture(String? url, String errorIconPath) {
    final appUser = ref.watch(appUserProvider);
    final user = appUser.valueOrNull;
    return Row(children: [
      Flexible(
        child: CustomPaint(
          foregroundPainter: CircleProgress(_progressController.value),
          child: Container(
            height: 80,
            width: 80,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(width: 1, color: Colors.transparent),
            ),
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: SizedBox(
                height: 80,
                width: 50,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: ProfilePicture(
                    showBorder: false,
                    displayName: '${user?.displayName}',
                    //VMString.pictureCall + authNot.profilePicture!,
                    url: '${user?.profilePictureUrl}',
                    headshotThumbnail: '${user?.thumbnailUrl}',
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    ]);
  }
}
// class PopUpBanner extends StatefulWidget {
//   const PopUpBanner({Key? key}) : super(key: key);

//   @override
//   State<PopUpBanner> createState() => _PopUpBannerState();
// }

// class _PopUpBannerState extends State<PopUpBanner> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.transparent,
//       appBar: PreferredSize(
//         preferredSize:
//             const Size.fromHeight(150), // change height of ads as you like
//         child: Container(
//           color: Colors.red,
//           child: Row(children: [
//             const Flexible(child: Icon(Icons.warning_outlined)),
//             addHorizontalSpacing(10),
//             Flexible(
//               child: Row(children: [
//                 Flexible(
//                   child: RichText(
//                     textAlign: TextAlign.start,
//                     text: TextSpan(
//                         text: 'Complete your profile',
//                         style:
//                             Theme.of(context).textTheme.displayMedium!.copyWith(
//                                   // fontSize: 12.sp,
//                                   color: Theme.of(context).primaryColor,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                         children: const <TextSpan>[
//                           // TextSpan(
//                           //   text: 'Update',
//                           //   style: Theme.of(context)
//                           //       .textTheme
//                           //       .displayMedium!
//                           //       .copyWith(
//                           //         fontSize: 15.sp,
//                           //         color: Theme.of(context).primaryColor,
//                           //         fontWeight: FontWeight.w500,
//                           //       ),
//                           // ),
//                         ]),
//                     maxLines: 1,
//                   ),
//                 ),
//               ]),
//             ),
//           ]),
//         ),
//       ),
//       body: GestureDetector(
//         onTap: () {
//           navigateToRoute(context, MyPopup());
//         },
//         child: Dialog(
//           child: Container(
//             width: double.infinity,
//             height: MediaQuery.of(context).size.height / 1.5,
//             padding: const EdgeInsets.fromLTRB(0, 30, 0, 5),
//             child: Form(
//               child: SingleChildScrollView(
//                 child: Padding(
//                   padding: const EdgeInsets.all(5),
//                   child: Padding(
//                     padding: const EdgeInsets.all(10),
//                     child: Column(
//                       mainAxisSize: MainAxisSize.max,
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             RichText(
//                               text: TextSpan(
//                                   text: '30% ',
//                                   style: Theme.of(context)
//                                       .textTheme
//                                       .displayMedium!
//                                       .copyWith(
//                                         fontSize: 15.sp,
//                                         color: Theme.of(context).primaryColor,
//                                         fontWeight: FontWeight.w800,
//                                       ),
//                                   children: <TextSpan>[
//                                     TextSpan(
//                                       text: 'Profile complete',
//                                       style: Theme.of(context)
//                                           .textTheme
//                                           .displayMedium!
//                                           .copyWith(
//                                             fontSize: 15.sp,
//                                             color:
//                                                 Theme.of(context).primaryColor,
//                                             fontWeight: FontWeight.w500,
//                                           ),
//                                     ),
//                                   ]),
//                             ),
//                           ],
//                         ),
//                         addVerticalSpacing(20),
//                         Row(
//                           children: [
//                             Flexible(
//                               child: SizedBox(
//                                 width: MediaQuery.of(context).size.width,
//                                 child: const LinearProgressIndicator(
//                                   valueColor: AlwaysStoppedAnimation<Color>(
//                                       VmodelColors.vModelprimarySwatch),
//                                   backgroundColor: Colors.grey,
//                                   minHeight: 3,
//                                   color: Colors.grey,
//                                   value: 0.3,
//                                 ),
//                               ),
//                             )
//                           ],
//                         ),
//                         addVerticalSpacing(20),
//                         Row(
//                           children: [
//                             const Icon(Icons.info_outline_rounded),
//                             addHorizontalSpacing(10),
//                             const Flexible(
//                               child: Text(
//                                   'You must complete at least 95% of your profile to get access to bookings.'),
//                             )
//                           ],
//                         )
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
