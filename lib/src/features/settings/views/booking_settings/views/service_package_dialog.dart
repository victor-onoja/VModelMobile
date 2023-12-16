// import 'package:flutter/services.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:vmodel/src/core/controller/app_user_controller.dart';
// import 'package:vmodel/src/core/utils/validators_mixins.dart';
// import 'package:vmodel/src/features/settings/views/booking_settings/controllers/services.dart';

// import '../../../../../core/utils/enum/service_pricing_enum.dart';
// import '../../../../../res/res.dart';
// import '../../../../../shared/buttons/primary_button.dart';
// import '../../../../../shared/popup_dialogs/input_popup.dart';
// import '../../../../../shared/text_fields/description_text_field.dart';
// import '../../../../../shared/text_fields/dropdown_text_field.dart';
// import '../../../../../shared/text_fields/primary_text_field.dart';
// import '../../../../../vmodel.dart';
// import '../controllers/service_packages_controller.dart';
// import '../models/service_package_model.dart';

// class NewServicePackageDialog extends ConsumerStatefulWidget {
//   const NewServicePackageDialog({Key? key, this.package}) : super(key: key);
//   final ServicePackageModel? package;

//   @override
//   ConsumerState<NewServicePackageDialog> createState() =>
//       _NewServicePackageDialogState();
// }

// class _NewServicePackageDialogState
//     extends ConsumerState<NewServicePackageDialog> {
//   final priceController = TextEditingController();
//   final titleController = TextEditingController();
//   final descriptionController = TextEditingController();
//   late String _selectedDelivery = '';
//   late String _selectedUsageType = '';
//   late String _selectedUsageLength = '';
//   ServicePeriod _selectedPricingOption = ServicePeriod.hour;
//   final _formKey = GlobalKey<FormState>();
//   String deliveryTitle = 'Delivery';
//   String usageTypeTitle = 'Usage type';
//   String usageLengthTitle = 'Usage length';
//   final usageTypes = [
//     'Private',
//     'Commercial',
//     'Social media',
//     'Other (please type)',
//   ];

//   final deliveryOptions = [
//     '1 day',
//     '2 days',
//     '3 days',
//     '4 days',
//     '5 days',
//     '6 days',
//     '1 week',
//     '2 weeks',
//     '3 weeks',
//     '1 month',
//     '2 months',
//     '3 months',
//     '4 months',
//     '5 months',
//     '6 months',
//     'Other (please specify)',
//   ];

//   final usageLengthOptions = [
//     '1 week',
//     '2 weeks',
//     '3 weeks',
//     '1 month',
//     '2 months',
//     '3 months',
//     '4 months',
//     '5 months',
//     '6 months',
//     '1 year',
//     '2 years',
//     '3 years',
//     '4 years',
//     '5 years',
//     'Other (please specify)',
//   ];

//   @override
//   void initState() {
//     super.initState();
//     if (widget.package == null) {
//       _selectedDelivery = deliveryOptions.first;
//       _selectedUsageType = usageTypes.first;
//       _selectedUsageLength = usageLengthOptions.first;
//     } else {
//       _selectedDelivery = widget.package!.delivery;
//       _selectedUsageType = widget.package!.usageType;
//       _selectedUsageLength = widget.package!.usageLength;
//       _selectedPricingOption = widget.package!.servicePricing;
//       priceController.text = widget.package!.price.toInt().toString();
//       titleController.text = widget.package!.title.toString();
//       descriptionController.text = widget.package!.description.toString();

//       addToListIfNotExist(deliveryOptions, _selectedDelivery);
//       addToListIfNotExist(usageTypes, _selectedUsageType);
//       addToListIfNotExist(usageLengthOptions, _selectedUsageLength);
//     }
//   }

//   void addToListIfNotExist(List<String> options, String value) {
//     if (!options.contains(value)) {
//       options.insert(options.length - 1, value);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final userState = ref.watch(appUserProvider);
//     final user = userState.valueOrNull;
//     final services = ref.watch(userServices(user!.username));
//     return Dialog(
//       insetPadding: const EdgeInsets.all(24),
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(16),
//       ),
//       child: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               // const Text('New Package'),
//               Padding(
//                 padding:
//                     const EdgeInsets.symmetric(vertical: 16, horizontal: 8.0),
//                 child: Text(
//                   'Create a new service',
//                   style: VModelTypography1.promptTextStyle
//                       .copyWith(fontWeight: FontWeight.w700, fontSize: 14.sp),
//                 ),
//               ),
//               addVerticalSpacing(8),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   Text(
//                     'Price per',
//                     style: VModelTypography1.promptTextStyle
//                         .copyWith(fontWeight: FontWeight.w600, fontSize: 14.sp),
//                   ),
//                 ],
//               ),
//               addVerticalSpacing(8),
//               Row(
//                 children: [
//                   Expanded(
//                     child: Row(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         Radio(
//                           value: ServicePeriod.hour,
//                           groupValue: _selectedPricingOption,
//                           visualDensity: VisualDensity.compact,
//                           onChanged: (value) {
//                             _selectedPricingOption = ServicePeriod.hour;
//                             if (mounted) setState(() {});
//                           },
//                         ),
//                         Text(ServicePeriod.hour.simpleName),
//                       ],
//                     ),
//                   ),
//                   Expanded(
//                     child: Row(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         Radio(
//                           value: ServicePeriod.service,
//                           groupValue: _selectedPricingOption,
//                           visualDensity: VisualDensity.compact,
//                           onChanged: (value) {
//                             _selectedPricingOption = ServicePeriod.service;
//                             if (mounted) setState(() {});
//                           },
//                           // child: Text('Wow'),
//                         ),
//                         Text(ServicePeriod.service.simpleName),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//               addVerticalSpacing(16),
//               VWidgetsPrimaryTextFieldWithTitle2(
//                 isDense: true,
//                 contentPadding:
//                     const EdgeInsets.symmetric(vertical: 7, horizontal: 8),
//                 onChanged: (val) {
//                   setState(() {});
//                 },
//                 controller: titleController,
//                 isIncreaseHeightForErrorText: true,
//                 heightForErrorText: 40,
//                 label: 'Service Name',
//                 hintText: 'Ex. Gold',
//                 validator: (value) =>
//                     VValidatorsMixin.isNotEmpty(value, field: "Service name"),
//               ),
//               addVerticalSpacing(16),
//               VWidgetsDescriptionTextFieldWithTitle(
//                 maxLines: 5,
//                 minLines: 1,
//                 controller: descriptionController,
//                 label: 'Service Description',
//                 hintText:
//                     'Explain what you are offering in simple and understandable detail',
//                 validator: (value) => VValidatorsMixin.isMinimumLengthValid(
//                     value, 100,
//                     field: 'Service description'),
//                 labelStyle: Theme.of(context).textTheme.displayMedium!.copyWith(
//                     fontSize: 14,
//                     fontWeight: FontWeight.w600,
//                     color: VmodelColors.mainColor),
//                 hintStyle: Theme.of(context).textTheme.displayMedium!.copyWith(
//                     fontSize: 14,
//                     fontWeight: FontWeight.w500,
//                     color: VmodelColors.mainColor),
//                 // controller: ,
//               ),
//               addVerticalSpacing(16),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Expanded(
//                     child: VWidgetsPrimaryTextFieldWithTitle2(
//                       isDense: true,
//                       controller: priceController,
//                       label: 'Price',
//                       hintText: 'Ex. 500',
//                       keyboardType: TextInputType.number,
//                       formatters: [FilteringTextInputFormatter.digitsOnly],
//                       contentPadding: const EdgeInsets.symmetric(
//                           vertical: 7, horizontal: 8),
//                       validator: (value) =>
//                           VValidatorsMixin.isValidServicePrice(value,
//                               field: "Price"),
//                     ),
//                   ),
//                   addHorizontalSpacing(10),
//                   Expanded(
//                     child: VWidgetsDropDownTextField(
//                       isExpanded: true,
//                       isOneLineEllipsize: true,
//                       fieldLabel: deliveryTitle,
//                       // hintText: 'I identify as',
//                       hintText: '',
//                       value: _selectedDelivery,
//                       onChanged: (val) async {
//                         if (val.isNotEmpty && val.contains("Other")) {
//                           final specifiedValue =
//                               await showInputPopup(deliveryTitle);
//                           if (specifiedValue != null &&
//                               specifiedValue.isNotEmpty) {
//                             addToListIfNotExist(
//                                 deliveryOptions, specifiedValue);
//                             _selectedDelivery = specifiedValue;
//                           }
//                         } else {
//                           _selectedDelivery = val;
//                         }

//                         if (mounted) {
//                           setState(() {});
//                         }
//                       },
//                       // options: widget.options,
//                       options: deliveryOptions,
//                     ),
//                   ),
//                   // Expanded(
//                   //   child: VWidgetsDropDownTextFieldWithTrailingIcon<String>(
//                   //     fieldLabel: "Delivery",
//                   //     hintText: "",
//                   //     isExpanded: true,
//                   //     options: deliveryOptions,
//                   //     getLabel: (String value) => value,
//                   //     value: deliveryOptions[0],
//                   //     onChanged: (val) {
//                   //       setState(() {
//                   //         // dropdownIdentifyValue = val;
//                   //         // selectedAlbum = val;
//                   //       });
//                   //     },
//                   //     trailingIcon: Icon(Icons.add),
//                   //     onPressedIcon: () {
//                   //       showDialog(
//                   //           context: context,
//                   //           builder: ((context) => VWidgetsAddAlbumPopUp(
//                   //                 controller: TextEditingController(),
//                   //                 popupTitle: "Create a new album",
//                   //                 buttonTitle: "Continue",
//                   //                 onPressed: () async {
//                   //                   // await ref
//                   //                   //     .read(createPostProvider.notifier)
//                   //                   //     .createAlbum(
//                   //                   //         _controller.text.capitalizeFirst!
//                   //                   //             .trim(),
//                   //                   //         userIDPk!)
//                   //                   //     .then((value) =>
//                   //                   //         ref.refresh(myStreamProvider));
//                   //                 },
//                   //               )));
//                   //       Navigator.pop(context);
//                   //     },
//                   //   ),
//                   // ),
//                 ],
//               ),
//               addVerticalSpacing(24),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Expanded(
//                     child: VWidgetsDropDownTextField(
//                       isExpanded: true,
//                       isOneLineEllipsize: true,
//                       fieldLabel: usageTypeTitle,
//                       // hintText: 'I identify as',
//                       hintText: '',
//                       value: _selectedUsageType,
//                       onChanged: (val) async {
//                         if (val.isNotEmpty && val.contains("Other")) {
//                           final specifiedValue =
//                               await showInputPopup(usageTypeTitle);
//                           if (specifiedValue != null &&
//                               specifiedValue.isNotEmpty) {
//                             addToListIfNotExist(usageTypes, specifiedValue);
//                             _selectedUsageType = specifiedValue;
//                           }
//                         } else {
//                           _selectedUsageType = val;
//                         }
//                         if (mounted) {
//                           setState(() {});
//                         }
//                       },
//                       // options: widget.options,
//                       options: usageTypes,
//                     ),
//                   ),
//                   addHorizontalSpacing(10),
//                   Expanded(
//                     child: VWidgetsDropDownTextField(
//                       isExpanded: true,
//                       isOneLineEllipsize: true,
//                       fieldLabel: usageLengthTitle,
//                       // hintText: 'I identify as',
//                       hintText: '',
//                       value: _selectedUsageLength,
//                       onChanged: (val) async {
//                         if (val.isNotEmpty && val.contains("Other")) {
//                           final specifiedValue =
//                               await showInputPopup(usageLengthTitle);
//                           if (specifiedValue != null &&
//                               specifiedValue.isNotEmpty) {
//                             addToListIfNotExist(
//                                 usageLengthOptions, specifiedValue);
//                             _selectedUsageLength = specifiedValue;
//                           }
//                         } else {
//                           _selectedUsageLength = val;
//                         }
//                         if (mounted) {
//                           setState(() {});
//                         }
//                       },
//                       // options: widget.options,
//                       options: usageLengthOptions,
//                     ),
//                   ),
//                   // Expanded(
//                   //   child: VWidgetsDropDownTextFieldWithTrailingIcon<String>(
//                   //     fieldLabel: "Delivery",
//                   //     hintText: "",
//                   //     options: deliveryOptions,
//                   //     getLabel: (String value) => value,
//                   //     value: '2 Weeks',
//                   //     onChanged: (val) {
//                   //       setState(() {
//                   //         // dropdownIdentifyValue = val;
//                   //         // selectedAlbum = val;
//                   //       });
//                   //     },
//                   //     trailingIcon: Icon(Icons.add),
//                   //     onPressedIcon: () {
//                   //       showDialog(
//                   //           context: context,
//                   //           builder: ((context) => VWidgetsAddAlbumPopUp(
//                   //                 controller: TextEditingController(),
//                   //                 popupTitle: "Create a new album",
//                   //                 buttonTitle: "Continue",
//                   //                 onPressed: () async {
//                   //                   // await ref
//                   //                   //     .read(createPostProvider.notifier)
//                   //                   //     .createAlbum(
//                   //                   //         _controller.text.capitalizeFirst!
//                   //                   //             .trim(),
//                   //                   //         userIDPk!)
//                   //                   //     .then((value) =>
//                   //                   //         ref.refresh(myStreamProvider));
//                   //                 },
//                   //               )));
//                   //       Navigator.pop(context);
//                   //     },
//                   //   ),
//                   // ),
//                 ],
//               ),
//               addVerticalSpacing(32),
//               Container(
//                 padding: const EdgeInsets.symmetric(horizontal: 64.0),
//                 child: VWidgetsPrimaryButton(
//                   buttonTitle: 'Save',
//                   enableButton: true,
//                   onPressed: () {
//                     final price = double.tryParse(priceController.text) ?? 0.0;
//                     if (!_formKey.currentState!.validate()) {
//                       return;
//                     }

//                     // final package = ServicePackageModel(
//                     //   id: widget.package!.id.toString(),
//                     //   price: price,
//                     //   title: titleController.text.trim(),
//                     //   description: descriptionController.text.trim(),
//                     //   delivery: _selectedDelivery,
//                     //   usageType: _selectedUsageType,
//                     //   usageLength: _selectedUsageLength,
//                     //   servicePricing: _selectedPricingOption,
//                     // );
//                     if (services.valueOrNull == null) {
//                       ref.read(serviceProvider).createService(
//                           _selectedDelivery,
//                           descriptionController.text.trim(),
//                           _selectedPricingOption.toString(),
//                           price,
//                           titleController.text.trim(),
//                           _selectedUsageLength,
//                           _selectedUsageType);
//                     } else {
//                       ref.read(serviceProvider).updateService(
//                           _selectedDelivery,
//                           descriptionController.text.trim(),
//                           _selectedPricingOption.toString(),
//                           price,
//                           titleController.text.trim(),
//                           _selectedUsageLength,
//                           _selectedUsageType);
//                     }
//                     goBack(context);
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Future<String?> showInputPopup(String title) async {
//     final controller = TextEditingController();
//     final result = await showDialog<String>(
//         context: context,
//         builder: ((context) => VWidgetsInputPopUp(
//               popupTitle: title,
//               popupField: TextFormField(
//                 decoration: const InputDecoration(hintText: 'Please specify'),
//                 controller: controller,
//                 // decoration: (InputDecoration(hintText: '')),
//               ),
//               onPressedYes: () async {
//                 Navigator.pop(context, controller.text.trim());
//               },
//             )));
//     print('ljsfajfslafsffffffffffff $result');
//     return result;
//   }
// }
