import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vmodel/src/core/utils/enum/service_pricing_enum.dart';
import 'package:vmodel/src/core/utils/helper_functions.dart';
import 'package:vmodel/src/core/utils/validators_mixins.dart';
import 'package:vmodel/src/features/settings/views/booking_settings/controllers/service_packages_controller.dart';
import 'package:vmodel/src/features/settings/views/booking_settings/models/service_package_model.dart';
import 'package:vmodel/src/features/settings/views/booking_settings/widgets/category_modal.dart';
import 'package:vmodel/src/features/settings/views/verification/views/blue-tick/widgets/text_field.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/shared/appbar/appbar.dart';
import 'package:vmodel/src/shared/buttons/primary_button.dart';
import 'package:vmodel/src/shared/popup_dialogs/input_popup.dart';
import 'package:vmodel/src/shared/response_widgets/toast.dart';
import 'package:vmodel/src/shared/text_fields/description_text_field.dart';
import 'package:vmodel/src/shared/text_fields/dropdown_text_field.dart';
import 'package:vmodel/src/shared/text_fields/primary_text_field.dart';
import 'package:vmodel/src/vmodel.dart';

import '../../../../../core/controller/discard_editing_controller.dart';
import '../../../../../core/utils/costants.dart';
import '../../../../../core/utils/enum/work_location.dart';
import '../../../../../shared/dialogs/discard_dialog.dart';
import '../../../../../shared/popup_dialogs/popup_without_save.dart';
import '../../../../../shared/response_widgets/vm_toast.dart';
import '../../../../../shared/switch/primary_switch.dart';
import '../controllers/service_images_controller.dart';
import '../widgets/service_image_listview.dart';
import '../widgets/service_length_dropdowns.dart';

class AddNewServicesHomepage extends ConsumerStatefulWidget {
  const AddNewServicesHomepage({
    Key? key,
    this.servicePackage,
    this.onUpdateSuccess,
  }) : super(key: key);
  final ServicePackageModel? servicePackage;
  final ValueChanged<ServicePackageModel>? onUpdateSuccess;

  @override
  ConsumerState<AddNewServicesHomepage> createState() =>
      _AddNewServicesHomepageState();
}

class _AddNewServicesHomepageState
    extends ConsumerState<AddNewServicesHomepage> {
  List<String> selectedCategoryList = [];

  final priceController = TextEditingController();
  final depositController = TextEditingController();
  final discountController = TextEditingController();
  final titleController = TextEditingController();

  final descriptionController = TextEditingController();

  late String _selectedDelivery = '';
  String? _selectedUsageType = '';
  String? _selectedUsageLength = '';
  WorkLocation _serviceType = WorkLocation.onSite;
  var _selectedPricingOption = ServicePeriod.hour;
  final _formKey = GlobalKey<FormState>();
  String deliveryTitle = 'Delivery';
  String usageTypeTitle = 'License type';
  String usageLengthTitle = 'License length';
  bool isvaluevalid = true;
  bool _isDigitalContent = false;
  bool _isAddtionalOfferingServices = false;
  bool _isfaq = false;
  bool _isDiscounted = true;
  bool _showButtonLoader = false;
  // int _percentDiscount = 0;
  bool _isPopupClosed = false;

  String imageName = "";
  String? _serviceBannerUrl;
  XFile? image;
  List<XFile> serviceImages = [];
  List<Map> categoryList = [];

  List<Widget> faqTextFields = [];
  List<TextEditingController> anserControllers = [TextEditingController()];
  List<TextEditingController> questionControllers = [TextEditingController()];
  final _scrollController = ScrollController();
  String lastValidInput = '';

  @override
  void initState() {
    super.initState();
    for (var data in VConstants.tempCategories) {
      categoryList.add({"item": data, "selected": false});
    }
    if (widget.servicePackage == null) {
      _selectedDelivery = VConstants.kDeliveryOptions.first;
      _selectedUsageType = VConstants.kUsageTypes.first;
      _selectedUsageLength = VConstants.kUsageLengthOptions.first;
      _serviceType = WorkLocation.values.first;
      faqTextFields.add(FAQTextField(
        questionNumber: 1,
        answerController: anserControllers[0],
        questionController: questionControllers[0],
      ));
    } else {
      if (widget.servicePackage!.faq != null) {
        if (widget.servicePackage!.faq!.isNotEmpty) {
          anserControllers.clear();
          questionControllers.clear();
          for (int index = 0;
              index < widget.servicePackage!.faq!.length;
              index++) {
            anserControllers.add(TextEditingController(
                text: widget.servicePackage!.faq![index].answer));
            questionControllers.add(TextEditingController(
                text: widget.servicePackage!.faq![index].question));
          }
          for (var i = 0; i < questionControllers.length; i++) {
            faqTextFields.add(
              FAQTextField(
                questionNumber: i + 1,
                answerController: anserControllers[i],
                questionController: questionControllers[i],
              ),
            );
          }
          _isfaq = true;
          setState(() {});
        } else {
          if (faqTextFields.isEmpty)
            faqTextFields.add(FAQTextField(
              questionNumber: 1,
              answerController: anserControllers[0],
              questionController: questionControllers[0],
            ));
        }
      } else {
        if (faqTextFields.isEmpty)
          faqTextFields.add(FAQTextField(
            questionNumber: 1,
            answerController: anserControllers[0],
            questionController: questionControllers[0],
          ));
      }

      _selectedDelivery = widget.servicePackage!.delivery;
      _selectedUsageType = _getOptionFromApiString(
          VConstants.kUsageTypes, widget.servicePackage?.usageType);
      _selectedUsageLength = widget.servicePackage?.usageLength;
      _selectedPricingOption = ServicePeriod.hour;
      // _selectedPricingOption = widget.servicePackage!.servicePricing;
      priceController.text = widget.servicePackage!.price.toInt().toString();
      // depositController.text = widget.servicePackage!.price.toInt().toString();
      titleController.text = widget.servicePackage!.title.toString();
      // _serviceBannerUrl = widget.servicePackage!.bannerUrl;
      descriptionController.text =
          widget.servicePackage!.description.toString();
      _serviceType = widget.servicePackage!.serviceType;
      _isAddtionalOfferingServices = widget.servicePackage!.hasAdditional;
      _isDigitalContent = widget.servicePackage!.isDigitalContentCreator;
      discountController.text = widget.servicePackage?.percentDiscount != null
          ? widget.servicePackage!.percentDiscount.toString()
          : '';
      depositController.text = widget.servicePackage?.percentDiscount != null
          ? widget.servicePackage!.initialDeposit.toString()
          : '';
      selectedCategoryList = widget.servicePackage!.category!;
    }

    titleController.addListener(() {
      print("is text ${isText(titleController.text)}");
      if (titleController.text.isNotEmpty) {
        if (!containsEmoji(titleController.text)) {
          print("is imojie");
          titleController.clear();
        } else {
          print("Is text");
        }
      } else {
        lastValidInput = titleController.text;
      }
      setState(() {});
    });
    initDiscardProvider();
  }

  bool isText(String input) {
    final alphanumericPattern = RegExp(r'^[A-Za-z0-9]+$');
    return alphanumericPattern.hasMatch(input);
  }

  bool containsEmoji(String text) {
    // Define a regular expression pattern to match emojis
    final RegExp regexEmoji = RegExp(
        r'(\\u00a9|\\u00ae|[\\u2000-\\u3300]|\\ud83c[\\ud000-\\udfff]|\\ud83d[\\ud000-\\udfff]|\\ud83e[\\ud000-\\udfff])');
    return regexEmoji.hasMatch(text);
  }

  initDiscardProvider() {
    print('[discard******] init discard again');
    ref.read(discardProvider.notifier).initialState('delivery',
        initial: _selectedDelivery, current: _selectedDelivery);
    ref.read(discardProvider.notifier).initialState('usageType',
        initial: _selectedUsageType, current: _selectedUsageType);
    ref.read(discardProvider.notifier).initialState('usageLength',
        initial: _selectedUsageLength, current: _selectedUsageLength);
    ref.read(discardProvider.notifier).initialState('pricingOption',
        initial: _selectedPricingOption, current: _selectedPricingOption);
    ref.read(discardProvider.notifier).initialState('price',
        initial: priceController.text, current: priceController.text);
    ref.read(discardProvider.notifier).initialState('title',
        initial: titleController.text, current: titleController.text);
    ref.read(discardProvider.notifier).initialState('description',
        initial: descriptionController.text,
        current: descriptionController.text);
    ref.read(discardProvider.notifier).initialState('serviceType',
        initial: _serviceType, current: _serviceType);
    ref.read(discardProvider.notifier).initialState('discount',
        initial: discountController.text, current: discountController.text);
    ref.read(discardProvider.notifier).initialState('isDiscount',
        initial: _isDiscounted, current: _isDiscounted);
    // ref.read(discardProvider.notifier).initialState('deposit',
    //     initial: depositController.text, current: depositController.text);
    ref.read(discardProvider.notifier).initialState('category',
        initial: [...selectedCategoryList], current: selectedCategoryList);
    ref.read(discardProvider.notifier).initialState('banners',
        initial: [...ref.read(serviceImagesProvider)],
        current: [...ref.read(serviceImagesProvider)]);
    ref
        .read(discardProvider.notifier)
        .initialState('isFaq', initial: _isfaq, current: _isfaq);
  }

  @override
  dispose() {
    _scrollController.dispose();

    titleController.dispose();
    // if (context.mounted) {
    //   ref.invalidate(discardProvider);
    //   ref.invalidate(serviceImagesProvider);
    // }
    super.dispose();
  }

  void _toggleButtonLoader() {
    _showButtonLoader = !_showButtonLoader;
    setState(() {});
  }

  void addToListIfNotExist(List<String> options, String value) {}

  String _getOptionFromApiString(List<String> options, String? value) {
    if (value == null) return options.first;
    return options
        .firstWhere((element) => element.toLowerCase() == value.toLowerCase());
  }

  @override
  Widget build(BuildContext context) {
    // final userState = ref.watch(appUserProvider);
    // final user = userState.valueOrNull;
    // final services = ref.watch(userServices(user!.username));
    // final myServices = ref.watch(servicePackagesProvider(null));
    final images = ref.watch(serviceImagesProvider);
    ref.watch(discardProvider);

    return WillPopScope(
      onWillPop: () async {
        return onPopPage(context, ref, onDiscard: () {
          ref.invalidate(serviceImagesProvider);
          ref.invalidate(discardProvider);
          if (context.mounted) {
            Navigator.of(context)
              ..pop()
              ..pop();
          }
        });
      },
      child: Scaffold(
        appBar: VWidgetsAppBar(
          leadingIcon: VWidgetsBackButton(
            onTap: () {
              onPopPage(context, ref, onDiscard: () {
                ref.invalidate(serviceImagesProvider);
                ref.invalidate(discardProvider);
                if (context.mounted) {
                  Navigator.of(context)
                    ..pop()
                    ..pop();
                }
              });
            },
          ),
          appbarTitle: widget.servicePackage == null
              ? "Create a new service"
              : "Update service",
        ),
        body: SingleChildScrollView(
          controller: _scrollController,
          padding: const VWidgetsPagePadding.horizontalSymmetric(16),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                addVerticalSpacing(20),
                // addVerticalSpacing(16),
                if (images.isNotEmpty)
                  Row(
                    children: [
                      Text("Sample Images",
                          style: Theme.of(context)
                              .textTheme
                              .displayMedium!
                              .copyWith(
                                fontWeight: FontWeight.w600,
                                color: Theme.of(context)
                                    .primaryColor
                                    .withOpacity(1),
                              )),
                    ],
                  ),
                if (images.isNotEmpty) addVerticalSpacing(8),
                if (images.isNotEmpty)
                  Row(
                    children: [
                      Flexible(
                          child: ServiceImageListView(
                        fileImages: images,
                        addMoreImages: () {
                          ref.read(serviceImagesProvider.notifier).pickImages();
                        },
                      )),
                    ],
                  ),
                if (images.isEmpty)
                  Row(
                    children: [
                      Text("Service banner(s)",
                          style: Theme.of(context)
                              .textTheme
                              .displayMedium!
                              .copyWith(
                                fontWeight: FontWeight.w600,
                                color: Theme.of(context)
                                    .primaryColor
                                    .withOpacity(1),
                              )),
                    ],
                  ),
                if (images.isEmpty) addVerticalSpacing(8),
                if (images.isEmpty)
                  Flexible(
                    child: Container(
                      width: SizerUtil.width,
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                          color: Theme.of(context)
                              .buttonTheme
                              .colorScheme!
                              .secondary,
                          borderRadius: BorderRadius.circular(10)),
                      child: Container(
                        height: 90,
                        width: 90,
                        // margin: const EdgeInsets.symmetric(horizontal: 6),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Theme.of(context).scaffoldBackgroundColor),
                        child: TextButton(
                          onPressed: () => ref
                              .read(serviceImagesProvider.notifier)
                              .pickImages(),
                          style: TextButton.styleFrom(
                            backgroundColor: Theme.of(context)
                                .buttonTheme
                                .colorScheme!
                                .secondary,
                            shape: const CircleBorder(),
                            maximumSize: const Size(64, 36),
                          ),
                          child: Icon(Icons.add, color: VmodelColors.white),
                        ),
                      ),
                    ),
                  ),

                addVerticalSpacing(16),
                VWidgetsTextFieldNormal(
                  // minLines: 1,
                  // maxLines: 3,
                  // isDense: true,
                  // contentPadding:
                  //     const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                  onChanged: (val) {
                    ref
                        .read(discardProvider.notifier)
                        .updateState('title', newValue: val);
                    setState(() {
                      // if (val.length >= 60) {
                      //   setState(() {
                      //     titleController.clear();
                      //   });
                      // }
                    });
                  },
                  inputFormatters: [
                    UppercaseLimitTextInputFormatter(),
                  ],
                  textCapitalization: TextCapitalization.sentences,
                  controller: titleController,
                  // isIncreaseHeightForErrorText: true,
                  // heightForErrorText: 80,
                  labelText: 'Title',
                  hintText: 'Glamour Shoot',
                  validator: (value) =>
                      VValidatorsMixin.isNotEmpty(value, field: "Service name"),
                ),
                addVerticalSpacing(16),

                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      child: VWidgetsDropDownTextField<WorkLocation>(
                        prefixText: "",
                        hintText: "",
                        options:
                            WorkLocation.values, // VConstants.kDeliveryType,
                        fieldLabel: "Type",
                        onChanged: (val) {
                          _serviceType = val;
                          ref.read(discardProvider.notifier).updateState(
                              'serviceType',
                              newValue: _serviceType);
                          setState(() {});
                        },
                        value: _serviceType,
                        getLabel: (WorkLocation value) => value.simpleName,
                        // heightForErrorText: 0,
                      ),
                    ),
                    addHorizontalSpacing(10),
                    Expanded(
                      child: VWidgetsDropDownTextField(
                        isExpanded: true,
                        isOneLineEllipsize: true,
                        fieldLabel: deliveryTitle,
                        // hintText: 'I identify as',
                        hintText: '',
                        isDisabled: _serviceType == WorkLocation.onSite,
                        value: _selectedDelivery,
                        onChanged: (String val) async {
                          if (val.isNotEmpty && val.contains("Other")) {
                            final specifiedValue =
                                await showInputPopup(deliveryTitle);
                            if (specifiedValue != null &&
                                specifiedValue.isNotEmpty) {
                              addToListIfNotExist(
                                  VConstants.kDeliveryOptions, specifiedValue);
                              _selectedDelivery = specifiedValue;
                            }
                          } else {
                            _selectedDelivery = val;
                          }
                          if (mounted) {
                            setState(() {});
                          }
                          ref.read(discardProvider.notifier).updateState(
                              'delivery',
                              newValue: _selectedDelivery);
                        },
                        // options: widget.options,
                        options: VConstants.kDeliveryOptions,
                      ),
                    ),
                  ],
                ),
                // addVerticalSpacing(16),
                VWidgetsServiceLength(),
                addVerticalSpacing(20),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      child: VWidgetsDropDownTextField<ServicePeriod>(
                        hintText: "",
                        options: ServicePeriod
                            .values, //const ["Per service", "Per hour"],
                        fieldLabel: "Pricing",
                        onChanged: (val) {
                          _selectedPricingOption = val;
                          ref.read(discardProvider.notifier).updateState(
                              'pricingOption',
                              newValue: _selectedPricingOption);
                          setState(() {});
                        },
                        value: _selectedPricingOption,
                        // getLabel: (String value) => value,
                        customDisplay: (value) => value.tileDisplayName,
                      ),
                    ),
                    addHorizontalSpacing(10),
                    Flexible(
                      child: VWidgetsPrimaryTextFieldWithTitle2(
                        minLines: 1,
                        // maxLines: 2,
                        isDense: true,
                        controller: priceController,
                        label: 'Price (\u00A3)',
                        hintText: '${VMString.poundSymbol} 500',
                        keyboardType: TextInputType.number,
                        formatters: [FilteringTextInputFormatter.digitsOnly],
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 7, horizontal: 8),
                        heightForErrorText: 0,
                        onChanged: (val) {
                          ref
                              .read(discardProvider.notifier)
                              .updateState('price', newValue: val);
                        },
                        validator: (value) =>
                            VValidatorsMixin.isValidServicePrice(value,
                                field: "Price"),
                      ),
                    ),
                  ],
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Select categories",
                            style: Theme.of(context)
                                .textTheme
                                .displayMedium!
                                .copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: Theme.of(context)
                                      .primaryColor
                                      .withOpacity(1),
                                ),
                          ),
                          addVerticalSpacing(10),
                          GestureDetector(
                            onTap: () => showModalBottomSheet(
                                context: context,
                                isDismissible: true,
                                isScrollControlled: true,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(10))),
                                builder: (context) {
                                  return Container(
                                    child: CategoryModal(
                                      categoryList: categoryList,
                                      selectedCategoryList:
                                          selectedCategoryList,
                                      onTap: () {
                                        selectedCategoryList.clear();
                                        for (var data in categoryList) {
                                          if (data['selected']) {
                                            selectedCategoryList
                                                .add(data['item']);
                                          }
                                        }
                                        print(
                                            '[discard******] updating category list');

                                        ref
                                            .read(discardProvider.notifier)
                                            .updateState('category',
                                                newValue: selectedCategoryList);
                                        setState(() {});
                                      },
                                    ),
                                  );
                                }),
                            child: Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Theme.of(context)
                                    .buttonTheme
                                    .colorScheme!
                                    .secondary,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Select"),
                                  Icon(Icons.arrow_drop_down)
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                addVerticalSpacing(10),
                if (selectedCategoryList.isNotEmpty)
                  Container(
                    height: 40,
                    // padding: EdgeInsets.symmetric(horizontal: 16),
                    child: ListView.builder(
                      itemCount: selectedCategoryList.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.only(right: 10),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 5, vertical: 5),
                          decoration: BoxDecoration(
                            color: Theme.of(context)
                                .buttonTheme
                                .colorScheme!
                                .secondary,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                selectedCategoryList[index],
                              ),
                              GestureDetector(
                                onTap: () {
                                  for (var data in categoryList) {
                                    if (data['item'] ==
                                        selectedCategoryList[index]) {
                                      data['selected'] = false;
                                    }
                                  }
                                  selectedCategoryList.removeAt(index);
                                  setState(() {});
                                },
                                child: Icon(
                                  Icons.cancel,
                                  size: 20,
                                  color: Theme.of(context).iconTheme.color,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 4,
                      child: Text(
                        "I'm creating digital content",
                        style: VModelTypography1.promptTextStyle.copyWith(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            color: Theme.of(context).primaryColor),
                      ),
                    ),
                    // CupertinoSwitch(value: value, onChanged: onChanged)
                    VWidgetsSwitch(
                      swicthValue: _isDigitalContent,
                      onChanged: (value) {
                        _isDigitalContent = value;
                        setState(() {});
                        WidgetsBinding.instance
                            .addPostFrameCallback((timeStamp) {
                          _scrollController.animateTo(
                              _scrollController.position.maxScrollExtent,
                              duration: const Duration(milliseconds: 200),
                              curve: Curves.fastEaseInToSlowEaseOut);
                        });
                      },
                    )
                  ],
                ),
                addVerticalSpacing(24),
                _isDigitalContent
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: VWidgetsDropDownTextField(
                              isExpanded: true,
                              isOneLineEllipsize: true,
                              fieldLabel: usageTypeTitle,
                              // hintText: 'I identify as',
                              hintText: '',
                              value: _selectedUsageType,
                              onChanged: (val) async {
                                if (val.isNotEmpty && val.contains("Other")) {
                                  final specifiedValue =
                                      await showInputPopup(usageTypeTitle);
                                  if (specifiedValue != null &&
                                      specifiedValue.isNotEmpty) {
                                    addToListIfNotExist(
                                        VConstants.kUsageTypes, specifiedValue);
                                    _selectedUsageType = specifiedValue;
                                  }
                                } else {
                                  _selectedUsageType = val;
                                }

                                ref.read(discardProvider.notifier).updateState(
                                    'usageType',
                                    newValue: _selectedUsageType);
                                if (mounted) {
                                  setState(() {});
                                }
                              },
                              // options: widget.options,
                              options: VConstants.kUsageTypes,
                            ),
                          ),
                          addHorizontalSpacing(10),
                          Expanded(
                            child: VWidgetsDropDownTextField(
                              isExpanded: true,
                              isOneLineEllipsize: true,
                              fieldLabel: usageLengthTitle,
                              // hintText: 'I identify as',
                              hintText: '',
                              value: _selectedUsageLength,
                              onChanged: (val) async {
                                // if (val.isNotEmpty && val.contains("Other")) {
                                //   final specifiedValue =
                                //       await showInputPopup(usageLengthTitle);
                                //   if (specifiedValue != null &&
                                //       specifiedValue.isNotEmpty) {
                                //     addToListIfNotExist(
                                //         VConstants.kUsageLengthOptions,
                                //         specifiedValue);
                                //     _selectedUsageLength = specifiedValue;
                                //   }
                                // } else {
                                _selectedUsageLength = val;

                                ref.read(discardProvider.notifier).updateState(
                                    'usageLength',
                                    newValue: _selectedUsageLength);
                                // }
                                if (mounted) {
                                  setState(() {});
                                }
                              },
                              // options: widget.options,
                              options: VConstants.kUsageLengthOptions,
                            ),
                          ),
                        ],
                      )
                    : const SizedBox.shrink(),
                VWidgetsDescriptionTextFieldWithTitle(
                  maxLines: 5,
                  minLines: 1,
                  controller: descriptionController,
                  label: ' Description',
                  hintText:
                      'Provide a clear and detailed description of the service you are offering.',
                  validator: (value) => VValidatorsMixin.isMinimumLengthValid(
                      value, 100,
                      field: 'Service description'),
                  labelStyle: Theme.of(context)
                      .textTheme
                      .displayMedium!
                      .copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: VmodelColors.mainColor),
                  onChanged: (val) {
                    ref.read(discardProvider.notifier).updateState(
                          'description',
                          newValue: val,
                        );
                  },
                  // hintStyle: Theme.of(context)
                  //     .textTheme
                  //     .displayMedium!
                  //     .copyWith(
                  //         fontSize: 14,
                  //         fontWeight: FontWeight.w500,
                  //         color: VmodelColors.mainColor),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 4,
                      child: Text(
                        "I'm offering additional services",
                        style: VModelTypography1.promptTextStyle.copyWith(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            color: Theme.of(context).primaryColor),
                      ),
                    ),
                    VWidgetsSwitch(
                      swicthValue: _isAddtionalOfferingServices,
                      onChanged: (value) {
                        _isAddtionalOfferingServices = value;
                        setState(() {});
                        WidgetsBinding.instance
                            .addPostFrameCallback((timeStamp) {
                          _scrollController.animateTo(
                              _scrollController.position.maxScrollExtent,
                              duration: const Duration(milliseconds: 200),
                              curve: Curves.fastEaseInToSlowEaseOut);
                        });
                      },
                    )
                  ],
                ),

                addVerticalSpacing(24),
                _isAddtionalOfferingServices
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Flexible(
                            child: VWidgetsDropDownTextField(
                              isExpanded: true,
                              isOneLineEllipsize: true,
                              fieldLabel: 'Discounted service',
                              // hintText: 'I identify as',
                              hintText: '',
                              value: _isDiscounted,
                              onChanged: (val) async {
                                _isDiscounted = val;

                                ref
                                    .read(discardProvider.notifier)
                                    .updateState('isDiscount', newValue: val);
                                if (mounted) {
                                  setState(() {});
                                }
                              },
                              // options: widget.options,
                              options: const [true, false],
                              customDisplay: (value) => value ? "Yes" : "No",
                            ),
                          ),
                          addHorizontalSpacing(10),
                          Flexible(
                            // flex: 2,
                            child: VWidgetsPrimaryTextFieldWithTitle2(
                              enabled: _isDiscounted,
                              minLines: 1,
                              // maxLines: 2,
                              // isIncreaseHeightForErrorText: true,
                              // maxLength: 2,
                              isDense: true,
                              controller: discountController,
                              label: '% discounted',
                              hintText: 'Ex. 50',
                              keyboardType: TextInputType.number,
                              formatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                LengthLimitingTextInputFormatter(2)
                              ],
                              // contentPadding: const EdgeInsets.symmetric(
                              //     vertical: 7, horizontal: 8),
                              heightForErrorText: 0,
                              validator: (value) =>
                                  VValidatorsMixin.isValidDiscount(value,
                                      field: "Discount"),
                              onChanged: (val) {
                                ref
                                    .read(discardProvider.notifier)
                                    .updateState('discount', newValue: val);
                              },
                            ),
                          ),
                        ],
                      )
                    : const SizedBox.shrink(),
                if (!_isfaq)
                  GestureDetector(
                    onTap: () {
                      _isfaq = true;
                      ref
                          .read(discardProvider.notifier)
                          .updateState('isFaq', newValue: _isfaq);
                      setState(() {});
                    },
                    child: Container(
                      // margin: EdgeInsets.symmetric(horizontal: 16),
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Theme.of(context)
                            .buttonTheme
                            .colorScheme!
                            .secondary,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                "Add FAQ",
                                style:
                                    context.textTheme.displayMedium!.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          addVerticalSpacing(10),
                          Text(
                            "${VMString.bullet} Introducing Service FAQ: In-depth Qs and As",
                            style: context.textTheme.displaySmall!
                                .copyWith(fontSize: 11.sp),
                            maxLines: 2,
                          ),
                          addVerticalSpacing(5),
                          Text(
                            "${VMString.bullet} Enhance Service Clarity: Custom FAQ Section",
                            style: context.textTheme.displaySmall!
                                .copyWith(fontSize: 11.sp),
                            maxLines: 2,
                          ),
                        ],
                      ),
                    ),
                  ),
                if (_isfaq)
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 4,
                            child: Text(
                              "FAQ",
                              style: VModelTypography1.promptTextStyle.copyWith(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                  color: Theme.of(context).primaryColor),
                            ),
                          ),
                          VWidgetsSwitch(
                            swicthValue: _isfaq,
                            onChanged: (value) {
                              _isfaq = value;

                              ref
                                  .read(discardProvider.notifier)
                                  .updateState('isFaq', newValue: _isfaq);
                              setState(() {});
                              WidgetsBinding.instance
                                  .addPostFrameCallback((timeStamp) {
                                _scrollController.animateTo(
                                    _scrollController.position.maxScrollExtent,
                                    duration: const Duration(milliseconds: 200),
                                    curve: Curves.fastEaseInToSlowEaseOut);
                              });
                            },
                          )
                        ],
                      ),
                      if (_isfaq)
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ListView.builder(
                              shrinkWrap: true,
                              padding: EdgeInsets.only(bottom: 5),
                              itemCount: faqTextFields.length,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 20),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text("Question ${index + 1}",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .displayMedium!
                                                  .copyWith(
                                                    fontWeight: FontWeight.w600,
                                                    color: Theme.of(context)
                                                        .primaryColor
                                                        .withOpacity(1),
                                                  )),
                                          faqTextFields[index],
                                        ],
                                      ),
                                    ),
                                    if (index > 0)
                                      VWidgetsPrimaryButton(
                                        onPressed: () {
                                          faqTextFields.removeAt(index);
                                          setState(() {});
                                        },
                                        buttonTitle: "Remove",
                                        buttonTitleTextStyle: Theme.of(context)
                                            .textTheme
                                            .displayLarge!
                                            .copyWith(
                                              color: Theme.of(context)
                                                  .iconTheme
                                                  .color,
                                              fontWeight: FontWeight.w600,
                                              // fontSize: 12.sp,
                                            ),
                                        buttonColor: Theme.of(context)
                                            .buttonTheme
                                            .colorScheme!
                                            .secondary,
                                      ),
                                  ],
                                );
                              },
                            ),
                            VWidgetsPrimaryButton(
                              onPressed: () {
                                var anserController = TextEditingController();
                                var questionController =
                                    TextEditingController();
                                anserControllers.add(anserController);
                                questionControllers.add(questionController);
                                faqTextFields.add(FAQTextField(
                                  questionNumber: faqTextFields.length + 1,
                                  answerController: anserController,
                                  questionController: questionController,
                                ));
                                setState(() {});
                              },
                              buttonTitle: "Add New",
                              buttonTitleTextStyle: Theme.of(context)
                                  .textTheme
                                  .displayLarge!
                                  .copyWith(
                                    color: Theme.of(context).iconTheme.color,
                                    fontWeight: FontWeight.w600,
                                    // fontSize: 12.sp,
                                  ),
                              buttonColor: Theme.of(context)
                                  .buttonTheme
                                  .colorScheme!
                                  .secondary,
                            ),
                          ],
                        ),
                    ],
                  ),

                addVerticalSpacing(24),
                VWidgetsPrimaryButton(
                  // butttonWidth: double.infinity,
                  showLoadingIndicator: _showButtonLoader,
                  buttonTitle:
                      widget.servicePackage == null ? 'Create' : 'Update',
                  enableButton: true,
                  onPressed: () async {
                    List<Map<String, dynamic>> faqs = [];
                    if (faqTextFields.isNotEmpty)
                      for (int index = 0;
                          index < questionControllers.length;
                          index++) {
                        if (questionControllers[index].text.isNotEmpty) {
                          faqs.add({
                            "answer": anserControllers[index].text,
                            "question": questionControllers[index].text,
                          });
                        }
                      }

                    final price = double.tryParse(priceController.text) ?? 0.0;
                    if (!_formKey.currentState!.validate()) {
                      VWidgetShowResponse.showToast(ResponseEnum.warning,
                          message: "Please fill all required fields");
                      return;
                    }
                    if (image == null) {
                      if (images.isEmpty) {
                        toastContainer(text: "Service image(s) is required");
                        return;
                      }
                    }
                    // VLoader.changeLoadingState(true);
                    _toggleButtonLoader();
                    bool successful = false;
                    if (widget.servicePackage == null) {
                      if (selectedCategoryList.isNotEmpty) {
                        successful = await ref
                            .read(servicePackagesProvider(null).notifier)
                            .addPackage(
                              deliveryTimeline: _selectedDelivery,
                              serviceType: _serviceType.apiValue,
                              description: descriptionController.text.trim(),
                              period: _selectedPricingOption.simpleName,
                              price: price,
                              title: titleController.text.trim(),
                              usageLength: _selectedUsageLength,
                              usageType: _selectedUsageType?.toLowerCase(),
                              isDigitalContent: _isDigitalContent,
                              hasAddtionalSerices: _isAddtionalOfferingServices,
                              percentDiscount:
                                  int.tryParse(discountController.text.trim()),
                              image: image,
                              deposit: double.tryParse(
                                  depositController.text.trim()),
                              category: selectedCategoryList,
                              faqs: faqs,
                            );
                      } else {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return VMToastDialog(
                              title: 'Select at least one category',
                            );
                          },
                        );
                        await Future.delayed(Duration(seconds: 2));
                        goBack(context);
                      }
                    } else {
                      print('Updating a service package View');
                      if (!_isDigitalContent) {
                        _selectedUsageLength =
                            VConstants.kUsageLengthOptions.first;
                        _selectedUsageType = VConstants.kUsageTypes.first;
                      }

                      successful = await ref
                          .read(servicePackagesProvider(null).notifier)
                          .updatePackage(
                            widget.servicePackage!.copyWith(
                              delivery: _selectedDelivery,
                              description: descriptionController.text.trim(),
                              serviceType: _serviceType,
                              servicePricing: _selectedPricingOption,
                              price: price,
                              faq: faqs
                                  .map((e) => FAQModel(
                                      question: e['question'],
                                      answer: e['answer']))
                                  .toList(),
                              title: titleController.text.trim(),
                              usageLength: _selectedUsageLength,
                              usageType: _selectedUsageType?.toLowerCase(),
                              isDigitalContentCreator: _isDigitalContent,
                              hasAdditional: _isAddtionalOfferingServices,
                              category: selectedCategoryList,
                              percentDiscount: _isAddtionalOfferingServices
                                  ? int.tryParse(discountController.text.trim())
                                  : 0,
                              initialDeposit:
                                  int.tryParse(depositController.text.trim()),
                            ),
                            onSuccessCallback: widget.onUpdateSuccess,
                            image: image,
                          );
                    }
                    _toggleButtonLoader();
                    if (context.mounted) {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return VMToastDialog(
                            title: successful
                                ? widget.servicePackage == null
                                    ? "Service created successfully"
                                    : 'Service updated successfully'
                                : widget.servicePackage == null
                                    ? "Failed to create service"
                                    : 'Failed to update service',
                          );
                        },
                      );
                      await Future.delayed(Duration(seconds: 2));
                      goBack(context);
                      if (successful) goBack(context);
                    }
                  },
                ),
                addVerticalSpacing(40),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // _isDigitalContent() {}

  Future<String?> showInputPopup(String title) async {
    final controller = TextEditingController();
    final result = await showDialog<String>(
        context: context,
        builder: ((context) => VWidgetsInputPopUp(
              popupTitle: title,
              popupField: TextFormField(
                decoration: const InputDecoration(hintText: 'Please specify'),
                controller: controller,
                // decoration: (InputDecoration(hintText: '')),
              ),
              onPressedYes: () async {
                Navigator.pop(context, controller.text.trim());
              },
            )));

    return result;
  }

  depositDialog(BuildContext context) {
    _isPopupClosed = false;
    Future.delayed(const Duration(seconds: 3), () {
      if (!_isPopupClosed) goBack(context);
    });

    return showDialog(
      context: context,
      builder: (context) => VWidgetsPopUpWithoutSaveButton(
        popupTitle: Text(
          'Adding a deposit means your clients must pay this'
          ' deposit to book your service',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w400,
                fontSize: 12,
              ),
        ),
      ),
    ).then((value) => _isPopupClosed = true);
  }

  void _removeImage() {
    if (image != null || _serviceBannerUrl != null) {
      try {
        // Delete the picked file
        _serviceBannerUrl = '';
        image = null;
        print('Image removed successfully');
      } catch (e) {
        print('Error removing image: $e');
      }
      if (mounted) setState(() {});
    }
  }
}

class FAQTextField extends StatefulWidget {
  const FAQTextField({
    super.key,
    required this.questionNumber,
    required this.questionController,
    required this.answerController,
  });
  final int questionNumber;
  final TextEditingController questionController;
  final TextEditingController answerController;

  @override
  State<FAQTextField> createState() => _FAQTextFieldState();
}

class _FAQTextFieldState extends State<FAQTextField> {
  final faqTitleController = TextEditingController();
  final faqDescriptionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        addVerticalSpacing(10),
        VWidgetsTextFieldNormal(
          onChanged: (p0) {},
          textCapitalization: TextCapitalization.sentences,
          controller: widget.questionController,
          hintText: 'Question',
          validator: (value) =>
              VValidatorsMixin.isNotEmpty(value, field: "FAQ"),
        ),
        VWidgetsDescriptionTextFieldWithTitle(
          maxLines: 5,
          minLines: 1,
          controller: widget.answerController,
          label: 'Answer',
          hintText: 'Provide a clear and detailed of your answer.',
          validator: (value) => VValidatorsMixin.isNotEmpty(value),
          labelStyle: Theme.of(context).textTheme.displayMedium!.copyWith(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: VmodelColors.mainColor,
              ),
        ),
      ],
    );
  }
}
