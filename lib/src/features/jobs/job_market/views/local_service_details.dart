// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:intl/intl.dart';
// import 'package:vmodel/src/core/utils/costants.dart';
// import 'package:vmodel/src/core/utils/helper_functions.dart';
// import 'package:vmodel/src/core/utils/validators_mixins.dart';
// import 'package:vmodel/src/features/jobs/job_market/model/local_services_model.dart';
// import 'package:vmodel/src/features/settings/views/booking_settings/models/service_package_model.dart';
// import 'package:vmodel/src/res/colors.dart';
// import 'package:vmodel/src/res/gap.dart';
// import 'package:vmodel/src/shared/appbar/appbar.dart';
// import 'package:vmodel/src/shared/bottom_sheets/tile.dart';
// import 'package:vmodel/src/shared/job_service_section_container.dart';
// import 'package:vmodel/src/shared/loader/full_screen_dialog_loader.dart';
// import 'package:vmodel/src/shared/picture_styles/rounded_square_avatar.dart';
// import 'package:vmodel/src/vmodel.dart';

// import '../../../../res/icons.dart';
// import '../../../../shared/bottom_sheets/confirmation_bottom_sheet.dart';
// import '../../../../shared/buttons/brand_outlined_button.dart';
// import '../../../../shared/buttons/primary_button.dart';
// import '../../../../shared/rend_paint/render_svg.dart';
// import '../../../dashboard/feed/widgets/send.dart';
// import '../../../dashboard/feed/widgets/share.dart';
// import '../../../dashboard/new_profile/profile_features/services/widgets/service_detail_icon_stat.dart';
// import '../../../settings/views/booking_settings/views/new_add_services_homepage.dart';
// import '../widget/job_detail_bottom_sheet.dart';

// class ServicePackageDetail extends ConsumerStatefulWidget {
//   const ServicePackageDetail({
//     Key? key,
//     required this.service,
//     required this.isCurrentUser,
//     required this.username,
//   }) : super(key: key);

//   final LocalServicesModel service;
//   final bool isCurrentUser;
//   final String username;

//   @override
//   ConsumerState<ServicePackageDetail> createState() =>
//       _ServicePackageDetailState();
// }

// class _ServicePackageDetailState extends ConsumerState<ServicePackageDetail> {
//   bool isSaved = false;
//   bool? liked = false;
//   final _currencyFormatter = NumberFormat.simpleCurrency(locale: "en_GB");
//   final Duration _maxDuration = Duration.zero;
//   late LocalServicesModel serviceData;

//   @override
//   void initState() {
//     super.initState();
//     serviceData = widget.service;
//     // ref
//     //     .read(allServicesProvider(widget.username).notifier)
//     //     .getService(serviceId: serviceData.id);

//     // for (var item in widget.service.jobDelivery) {
//     //   _maxDuration += item.dateDuration;
//     // }
//     print("serviceData ${serviceData.id}");
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: VWidgetsAppBar(
//           elevation: 0,
//           backgroundColor: VmodelColors.white,
//           appbarTitle: 'Service Details',
//           leadingIcon: const VWidgetsBackButton(),
//           trailingIcon: [
//             if (widget.isCurrentUser)
//               IconButton(
//                   onPressed: () {
//                     showModalBottomSheet(
//                         context: context,
//                         backgroundColor: Colors.transparent,
//                         builder: (context) {
//                           return Container(
//                               padding:
//                                   const EdgeInsets.only(left: 16, right: 16),
//                               decoration: BoxDecoration(
//                                 // color: VmodelColors.appBarBackgroundColor,
//                                 color: Theme.of(context).colorScheme.surface,
//                                 borderRadius: BorderRadius.only(
//                                   topLeft: Radius.circular(13),
//                                   topRight: Radius.circular(13),
//                                 ),
//                               ),
//                               child: VWidgetsConfirmationBottomSheet(
//                                 actions: [
//                                   VWidgetsBottomSheetTile(
//                                       onTap: () {
//                                         navigateToRoute(
//                                             context,
//                                             AddNewServicesHomepage(
//                                               servicePackage: serviceData,
//                                               onUpdateSuccess: (value) {
//                                                 serviceData = value;
//                                                 setState(() {});
//                                               },
//                                             ));
//                                       },
//                                       message: 'Edit'),
//                                   const Divider(thickness: 0.5),
//                                   VWidgetsBottomSheetTile(
//                                       onTap: () {}, message: 'Duplicate'),
//                                   const Divider(thickness: 0.5),
//                                   VWidgetsBottomSheetTile(
//                                       onTap: () {}, message: 'Pause'),
//                                   const Divider(thickness: 0.5),
//                                   VWidgetsBottomSheetTile(
//                                     onTap: () async {
//                                       VLoader.changeLoadingState(true);
//                                       // await ref
//                                       //     .read(allServicesProvider(null)
//                                       //         .notifier)
//                                       //     .deleteService(widget.service.id);
//                                       VLoader.changeLoadingState(false);
//                                       if (mounted) {
//                                         // goBack(context);
//                                         Navigator.of(context)
//                                           ..pop()
//                                           ..pop();
//                                       }
//                                     },
//                                     message: 'Delete',
//                                     showWarning: true,
//                                   )
//                                 ],
//                               ));
//                         });
//                   },
//                   icon: const RenderSvg(svgPath: VIcons.galleryEdit)),
//           ],
//         ),
//         body: SingleChildScrollView(
//           padding: const VWidgetsPagePadding.all(16),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               SectionContainer(
//                 // height: 100,
//                 // padding: const EdgeInsets.all(16),
//                 topRadius: 16,
//                 bottomRadius: 0,
//                 child: Text(
//                   serviceData.title!,
//                   textAlign: TextAlign.center,
//                   style: Theme.of(context).textTheme.displayLarge!.copyWith(
//                         fontSize: 19,
//                         fontWeight: FontWeight.w600,
//                         // color: VmodelColors.primaryColor,
//                       ),
//                 ),
//               ),
//               if (serviceData.bannerUrl.isEmptyOrNull) addVerticalSpacing(2),
//               SectionContainer(
//                 // padding: const EdgeInsets.all(16),
//                 topRadius: 0,
//                 bottomRadius: 16,
//                 child: Column(
//                   children: [
//                     if (!serviceData.bannerUrl.isEmptyOrNull)
//                       RoundedSquareAvatar(
//                         url: serviceData.bannerUrl,
//                         size: Size(SizerUtil.width * 0.8, 350),
//                       ),
//                     addVerticalSpacing(32),
//                     SingleChildScrollView(
//                       scrollDirection: Axis.horizontal,
//                       child: Row(
//                         // mainAxisAlignment: MainAxisAlignment.start,
//                         children: [
//                           VWidgetsOutlinedButton(
//                             buttonText: 'Read description',
//                             onPressed: () {
//                               _showBottomSheet(context,
//                                   title: 'Description',
//                                   content: serviceData.description);
//                             },
//                           ),
//                           // addHorizontalSpacing(16),
//                           // VWidgetsOutlinedButton(
//                           //   buttonText: 'Read brief',
//                           //   onPressed: () {
//                           //     _showBottomSheet(context,
//                           //         title: 'Creative Brief',
//                           //         content: serviceData.brief ?? '',
//                           //         briefLink: serviceData.briefLink);
//                           //   },
//                           // ),
//                         ],
//                       ),
//                     ),
//                     addVerticalSpacing(32),
//                     _jobPersonRow(context,
//                         field: 'Pricing',
//                         value: serviceData.servicePricing.tileDisplayName),
//                     _jobPersonRow(context,
//                         field: 'Location',
//                         value: serviceData.serviceType.simpleName),
//                     _jobPersonRow(context,
//                         field: 'Delivery', value: serviceData.delivery),
//                     if (serviceData.initialDeposit != null &&
//                         serviceData.initialDeposit! > 0)
//                       _jobPersonRow(context, field: 'Deposit', value: '''
//                           ${VConstants.noDecimalCurrencyFormatterGB.format(serviceData.initialDeposit?.toInt().round())}
//                           '''),
//                     // _jobPersonRow(context,
//                     //     field: 'Date',
//                     //     value: VConstants.simpleDateFormatter
//                     //         .format(serviceData.jobDelivery.first.date)),
//                   ],
//                 ),
//               ),
//               addVerticalSpacing(16),
//               _headingText(context, title: 'Price'),
//               addVerticalSpacing(16),
//               SectionContainer(
//                 padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
//                 topRadius: 16,
//                 bottomRadius: 16,
//                 child: _priceDetails(context),
//               ),
//               addVerticalSpacing(32),
//               if (serviceData.isDigitalContentCreator)
//                 _headingText(context, title: 'Addtional details and delivery'),
//               if (serviceData.isDigitalContentCreator) addVerticalSpacing(16),
//               if (serviceData.isDigitalContentCreator)
//                 SectionContainer(
//                   // padding: const EdgeInsets.all(16),
//                   topRadius: 16,
//                   bottomRadius: 16,
//                   child: Column(
//                     children: [
//                       _jobPersonRow(context,
//                           field: 'Content license',
//                           value:
//                               serviceData.usageType?.capitalizeFirstVExt ?? ''),
//                       _jobPersonRow(context,
//                           field: 'Content license length',
//                           value: serviceData.usageLength?.capitalizeFirstVExt ??
//                               ''),
//                     ],
//                   ),
//                 ),
//               addVerticalSpacing(32),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   StatItem(
//                     outlineIcon: VIcons.favorite,
//                     filledIcon: VIcons.likedIcon,
//                     text: '105',
//                     iconWidth: 18,
//                     iconHeight: 18,
//                     onIconTapped: () async {
//                       // await ref
//                       //     .read(allServicesProvider(null).notifier)
//                       //     .likeService(widget.service.id);
//                     },
//                   ),
//                   addHorizontalSpacing(7),
//                   const StatItem(
//                     outlineIcon: VIcons.bookmark,
//                     filledIcon: VIcons.savedPostIcon,
//                     text: '150',
//                     iconWidth: 18,
//                     iconHeight: 18,
//                   ),
//                   addHorizontalSpacing(7),

//                   StatItem(
//                     outlineIcon: VIcons.sendWitoutNot,
//                     text: '27',
//                     iconWidth: 22,
//                     iconHeight: 22,
//                     onIconTapped: () {
//                       showModalBottomSheet(
//                         isScrollControlled: true,
//                         isDismissible: true,
//                         useRootNavigator: true,
//                         backgroundColor: Colors.transparent,
//                         context: context,
//                         builder: (context) => const SendWidget(),
//                       );
//                     },
//                   ),
//                   addHorizontalSpacing(7),
//                   StatItem(
//                     outlineIcon: VIcons.shareIcon,
//                     text: '84',
//                     iconWidth: 18,
//                     iconHeight: 18,
//                     onIconTapped: () {
//                       showModalBottomSheet(
//                         isScrollControlled: true,
//                         isDismissible: true,
//                         useRootNavigator: true,
//                         backgroundColor: Colors.transparent,
//                         context: context,
//                         builder: (context) => ShareWidget(
//                           shareLabel: 'Share service',
//                           shareTitle: widget.service.title,
//                           isWebPicture: true,
//                           shareImage:
//                               '${widget.service.user?.profilePictureUrl}',
//                           shareURL:
//                               'app.vmodel.social/service/${widget.service.id}',
//                         ),
//                       );
//                     },
//                   ), ],
//               ),
//               addVerticalSpacing(32),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Container(
//                       width: 5,
//                       height: 5,
//                       decoration: BoxDecoration(
//                         color: Theme.of(context).primaryColor.withOpacity(0.3),
//                         borderRadius: BorderRadius.circular(5),
//                       )),
//                   addHorizontalSpacing(4),
//                   Flexible(
//                     child: Text(
//                       '${serviceData.views?.pluralize('person', pluralString: 'people')}'
//                       ' viewed this service in'
//                       ' the last ${serviceData.updatedAt.getSimpleDate(suffix: "")}',
//                       style: Theme.of(context).textTheme.bodyMedium?.copyWith(
//                             fontWeight: FontWeight.w500,
//                             fontSize: 12,
//                             color: // VmodelColors.primaryColor.withOpacity(0.3),
//                                 Theme.of(context)
//                                     .textTheme
//                                     .bodyMedium
//                                     ?.color
//                                     ?.withOpacity(0.3),
//                           ),
//                     ),
//                   ),
//                 ],
//               ),
//               if (!widget.isCurrentUser) addVerticalSpacing(32),
//               if (!widget.isCurrentUser)
//                 VWidgetsPrimaryButton(
//                   onPressed: () {},
//                   buttonTitle: 'Book Now',
//                   enableButton: true,
//                 ),
//               addVerticalSpacing(32),
//             ],
//           ),
//         ));
//   }

//   // GestureDetector(
//   //   onTap: () {
//   //     widget.like();
//   //   },
//   //   child: RenderSvg(
//   //     svgPath:
//   //         widget.likedBool! ? VIcons.likedIcon : VIcons.feedLikeIcon,
//   //     svgHeight: 22,
//   //     svgWidth: 22,
//   //   ),
//   // ),

//   Future<dynamic> _showBottomSheet(BuildContext context,
//       {required String title, required String content, String? briefLink}) {
//     return showModalBottomSheet(
//         context: context,
//         isScrollControlled: true,
//         backgroundColor: Colors.transparent,
//         builder: (context) {
//           return DetailBottomSheet(
//             title: title,
//             content: content,
//             briefLink: briefLink,
//           );
//         });
//   }

//   Text _headingText(BuildContext context, {required String title}) {
//     return Text(
//       title,
//       style: Theme.of(context).textTheme.displayLarge!.copyWith(
//             fontWeight: FontWeight.w600,
//             // color: VmodelColors.primaryColor,
//           ),
//     );
//   }

//   Column _priceDetails(BuildContext context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.start,
//       children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           crossAxisAlignment: CrossAxisAlignment.end,
//           children: [
//             Flexible(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     VConstants.noDecimalCurrencyFormatterGB
//                         .format(serviceData.price),
//                     style: Theme.of(context).textTheme.displayLarge!.copyWith(
//                           fontWeight: FontWeight.w600,
//                           decoration:
//                               isValidDiscount(serviceData.percentDiscount)
//                                   ? TextDecoration.lineThrough
//                                   : null,
//                           decorationColor:
//                               Theme.of(context).primaryColor.withOpacity(0.3),
//                           color:
//                               //  VmodelColors.primaryColor.withOpacity(0.3),
//                               Theme.of(context)
//                                   .textTheme
//                                   .displayLarge
//                                   ?.color
//                                   ?.withOpacity(0.3),
//                         ),
//                   ),
//                   Text(
//                     serviceData.servicePricing.tileDisplayName,
//                     style: Theme.of(context).textTheme.displayLarge!.copyWith(
//                           fontWeight: FontWeight.w500,
//                           color: // VmodelColors.primaryColor.withOpacity(0.3),

//                               Theme.of(context)
//                                   .textTheme
//                                   .displayLarge
//                                   ?.color
//                                   ?.withOpacity(0.3),
//                         ),
//                   )
//                 ],
//               ),
//             ),
//             addHorizontalSpacing(4),
//             Flexible(
//               flex: 2,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.end,
//                 children: [
//                   Text(
//                     // '8 x 300',
//                     isValidDiscount(serviceData.percentDiscount)
//                         ? '${serviceData.percentDiscount}% Discount'
//                         : '',

//                     style: Theme.of(context).textTheme.displayLarge!.copyWith(
//                           fontWeight: FontWeight.w500,
//                           color: // VmodelColors.primaryColor.withOpacity(0.3),

//                               Theme.of(context)
//                                   .textTheme
//                                   .displayLarge
//                                   ?.color
//                                   ?.withOpacity(0.3),
//                         ),
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     crossAxisAlignment: CrossAxisAlignment.baseline,
//                     textBaseline: TextBaseline.alphabetic,
//                     children: [
//                       Text(
//                         'Total',
//                         textAlign: TextAlign.end,
//                         style:
//                             Theme.of(context).textTheme.displayLarge!.copyWith(
//                                   fontWeight: FontWeight.w500,
//                                   color: //VmodelColors.primaryColor.withOpacity(0.3),

//                                       Theme.of(context)
//                                           .textTheme
//                                           .displayLarge
//                                           ?.color
//                                           ?.withOpacity(0.3),
//                                 ),
//                       ),
//                       addHorizontalSpacing(8),
//                       Flexible(
//                         child: Text(
//                           // '2,400',
//                           VConstants.noDecimalCurrencyFormatterGB.format(
//                               calculateDiscountedAmount(
//                                       price: serviceData.price,
//                                       discount: serviceData.percentDiscount)
//                                   .round()),
//                           textAlign: TextAlign.end,
//                           style: Theme.of(context)
//                               .textTheme
//                               .displayLarge!
//                               .copyWith(
//                                 fontWeight: FontWeight.w600,
//                                 fontSize: 24,
//                                 // color: VmodelColors.primaryColor,
//                               ),
//                         ),
//                       )
//                     ],
//                   ),
//                 ],
//               ),
//             )
//           ],
//         )
//       ],
//     );
//   }

//   Widget _jobPersonRow(BuildContext context,
//       {required String field, required String value}) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             field,
//             style: Theme.of(context).textTheme.displayMedium!.copyWith(
//                   fontWeight: FontWeight.w600,
//                   height: 1.7,
//                   // color: VmodelColors.primaryColor,
//                   // fontSize: 12,
//                 ),
//           ),
//           addHorizontalSpacing(32),
//           Flexible(
//             child: Text(
//               value,
//               textAlign: TextAlign.end,
//               style: Theme.of(context).textTheme.displayMedium!.copyWith(
//                     fontWeight: FontWeight.w500,
//                     height: 1.7,
//                     // color: VmodelColors.primaryColor,
//                     // fontSize: 12,
//                   ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget iconText({required String assetIcon, required String text}) {
//     return Row(
//       children: [
//         RenderSvg(svgPath: assetIcon, svgHeight: 16, svgWidth: 16),
//         addHorizontalSpacing(8),
//         Text(
//           text,
//           style: Theme.of(context).textTheme.displayMedium!.copyWith(
//                 fontWeight: FontWeight.w600,
//                 height: 1.7,
//                 // color: VmodelColors.primaryColor,
//                 // fontSize: 12,
//               ),
//         ),
//       ],
//     );
//   }
// }
