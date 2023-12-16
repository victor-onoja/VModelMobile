// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:sizer/sizer.dart';
// import 'package:vmodel/src/core/routing/navigator_1.0.dart';
// import 'package:vmodel/src/core/utils/browser_laucher.dart';
// import 'package:vmodel/src/core/utils/enum/profile_types.dart';
// import 'package:vmodel/src/core/utils/shared.dart';
// import 'package:vmodel/src/features/booking/views/create_booking/views/create_booking_view.dart';
// import 'package:vmodel/src/features/create_contract/views/create_contract_view.dart';
// import 'package:vmodel/src/features/dashboard/dash/controller.dart';
// import 'package:vmodel/src/features/dashboard/dash/dashboard_ui.dart';
// import 'package:vmodel/src/features/dashboard/profile/data/measurement_mock.dart';
// import 'package:vmodel/src/features/dashboard/profile/view/my_network_page.dart';
// import 'package:vmodel/src/features/dashboard/profile/view/profile_polaroid_screen.dart';
// import 'package:vmodel/src/features/dashboard/new_profile/profile_features/widgets/measurement_tile.dart';
// import 'package:vmodel/src/features/dashboard/new_profile/widgets/profile_buttons_widget.dart';
// import 'package:vmodel/src/features/dashboard/profile/widget/user_profile/profile_sub_info_widget.dart';
// import 'package:vmodel/src/features/messages/views/messages_chat_screen.dart';
// import 'package:vmodel/src/features/messages/views/messages_homepage.dart';
// import 'package:vmodel/src/features/dashboard/new_profile/profile_features/services/views/services_homepage.dart';
// import 'package:vmodel/src/res/icons.dart';
// import 'package:vmodel/src/res/res.dart';
// import 'package:vmodel/src/shared/rend_paint/render_svg.dart';

// import '../../../../core/cache/local_storage.dart';
// import '../../../../shared/popup_dialogs/input_popup.dart';

// class BusinessProfileSpecifics extends StatefulWidget {
//   final ProfileTypeEnum profileTypeEnum;
//   const BusinessProfileSpecifics(
//       {Key? key,
//       required this.imgLink,
//       required this.isMainPortfolio,
//       required this.profileTypeEnum})
//       : super(key: key);
//   final String imgLink;
//   final bool isMainPortfolio;

//   @override
//   State<BusinessProfileSpecifics> createState() =>
//       _BusinessProfileSpecificsState();
// }

// class _BusinessProfileSpecificsState extends State<BusinessProfileSpecifics> {
//   double _animatedHeight = 600.0;
//   bool isDefaultBio = true;
//   bool isConnected = false;
//   bool isUserPrivate = false;
//   TextEditingController instagramController = TextEditingController();
//   userConnectionState() {
//     setState(() {});
//   }

//   privateUserBookingState() {
//     setState(() {
//       isUserPrivate = !isUserPrivate;
//     });
//   }

//   changeConnectionState() {
//     setState(() {
//       isConnected = !isConnected;
//     });
//   }

// //
//   String get mainBio => widget.profileTypeEnum == ProfileTypeEnum.business
//       ? "At Afrogarm, we are focused on building a platform that changes the narrative of presentation in Black and African brands world.."
//       : "Hi, I’m a model with ABC Model Agency in San Francisco, CA who is interested in building a good portfolio for my model work";

//   //
//   bool shouldShowUSerMeasurement = false;

//   changeMeasurementState() {
//     setState(() {
//       shouldShowUSerMeasurement = !shouldShowUSerMeasurement;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     TextTheme theme = Theme.of(context).textTheme;

//     return SafeArea(
//       child: Container(
//         margin: const EdgeInsets.only(top: 52),
//         decoration: BoxDecoration(
//             border: Border(
//                 top: BorderSide(width: 1, color: VmodelColors.borderColor),
//                 bottom: BorderSide(width: 1, color: VmodelColors.borderColor))),
//         child: Stack(
//           alignment: Alignment.center,
//           children: [
//             Visibility(
//               visible: isDefaultBio,
//               child: Stack(
//                 children: [
//                   Container(
//                     height: SizeConfig.screenHeight * 0.52,
//                     width: SizeConfig.screenWidth,
//                     alignment: Alignment.centerLeft,
//                     padding: const EdgeInsets.symmetric(horizontal: 18),
//                     margin: const EdgeInsets.only(bottom: 52),
//                     child: Column(
//                       // physics: const NeverScrollableScrollPhysics(),
//                       children: [
//                         addVerticalSpacing(18),

//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: [
//                             Container(
//                               height: 80,
//                               width: 80,
//                               decoration: BoxDecoration(
//                                 shape: BoxShape.circle,
//                                 border: Border.all(
//                                     width: 3, color: VmodelColors.primaryColor),
//                               ),
//                               child: Padding(
//                                 padding: const EdgeInsets.all(2.0),
//                                 child: Container(
//                                   height: 80,
//                                   width: 80,
//                                   decoration: BoxDecoration(
//                                       shape: BoxShape.circle,
//                                       border: Border.all(
//                                           width: 1,
//                                           color: VmodelColors.primaryColor),
//                                       image: DecorationImage(
//                                           image: AssetImage(widget.imgLink),
//                                           fit: BoxFit.cover)),
//                                 ),
//                               ),
//                             ),
//                             addHorizontalSpacing(12),
//                             Flexible(
//                               child: Row(
//                                 // alignment: Alignment.bottomCenter,
//                                 crossAxisAlignment: CrossAxisAlignment.end,
//                                 children: [
//                                   Flexible(
//                                     child: Text(
//                                       mainBio,
//                                       style: theme.displayMedium!.copyWith(
//                                         fontSize: 11.sp,
//                                         color: Theme.of(context).primaryColor,
//                                         fontWeight: FontWeight.w500,
//                                       ),
//                                       overflow: TextOverflow.ellipsis,
//                                       maxLines: 4,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                         addVerticalSpacing(15),

//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             /// profile type name here
//                             Text(
//                               returnLabelBasedOnUser(widget.profileTypeEnum),
//                               style: Theme.of(context)
//                                   .textTheme
//                                   .displayMedium!
//                                   .copyWith(
//                                     color: Theme.of(context)
//                                         .primaryColor
//                                         .withOpacity(0.4),
//                                   ),
//                             ),

//                             ///Expand bio icon logic
//                             Align(
//                               alignment: Alignment.bottomRight,
//                               child: Padding(
//                                 padding: const EdgeInsets.symmetric(
//                                     horizontal: 8, vertical: 2),
//                                 child: GestureDetector(
//                                     onTap: (() {
//                                       setState(() {
//                                         isDefaultBio = false;
//                                         _animatedHeight != 0.0
//                                             ? _animatedHeight = 0.0
//                                             : _animatedHeight = 600.0;
//                                       });
//                                     }),
//                                     child: const NormalRenderSvgWithColor(
//                                       svgPath: VIcons.expandBioIcon,
//                                     )),
//                               ),
//                             ),
//                           ],
//                         ),
//                         addVerticalSpacing(10),

//                         /// For Sub info of profile
//                         VWidgetsProfileSubInfoDetails(
//                           userName: "Samantha Colins",
//                           stars: "4.9",
//                           profileTypeEnum: widget.profileTypeEnum,
//                           // category: "Commercial, Glamour, Beauty, Outdoors",
//                           address: "Los Angeles, USA",
//                           companyUrl: "www.afrogarm.com",
//                           budget: "450",
//                           onPressedCompanyURL: () {
//                             VUtilsBrowserLaucher.lauchWebBrowserWithUrl(
//                                 "www.afrogarm.com");
//                           },
//                         ),

//                         addVerticalSpacing(15),
//                         VWidgetsProfileButtons(
//                           largeButtonTitle:
//                               isUserPrivate ? "Book Now" : "Bookings",
//                           connectTitle: isConnected ? "Remove" : "Network",
//                           connected: isConnected,
//                           connectOnPressed: () {
//                             //! Temporary change do not delete
//                             // changeConnectionState();

//                             ///?popup dialog for remove button if you view photographers profile
//                             //   if(isConnected){
//                             //  showDialog(
//                             //  context: context,
//                             //  builder: ((context) => VWidgetsConfirmationPopUp(
//                             // popupTitle: "Remove Connection",
//                             // popupDescription:
//                             //     "Are you sure you want to remove this connection?",
//                             // onPressedYes: () {},
//                             // onPressedNo: () {
//                             //   Navigator.pop(context);
//                             // })
//                             // )
//                             // );
//                             // }
//                             //?
//                             navigateToRoute(context, const NetworkPage());
//                           },
//                           smallButtonOneTitle: (widget.profileTypeEnum ==
//                                       ProfileTypeEnum.business ||
//                                   widget.profileTypeEnum ==
//                                       ProfileTypeEnum.photographer)
//                               ? "Top Picks"
//                               : widget.isMainPortfolio
//                                   ? 'Polaroid'
//                                   : 'Portfolio',
//                           smallButtonTwoTitle: (widget.profileTypeEnum ==
//                                       ProfileTypeEnum.business ||
//                                   widget.profileTypeEnum ==
//                                       ProfileTypeEnum.photographer)
//                               ? "Message"
//                               : "Messages",
//                           polaroidOrTopPicksOnPressed: () {
//                             if (widget.profileTypeEnum ==
//                                     ProfileTypeEnum.business ||
//                                 widget.profileTypeEnum ==
//                                     ProfileTypeEnum.photographer) {
//                             } else {
//                               widget.isMainPortfolio
//                                   ? navigateToRoute(
//                                       context, const PolaroidPortfolioView())
//                                   : navigateAndReplaceRoute(
//                                       context, const DashBoardView());
//                             }
//                           },
//                           messagesOnPressed: () {
//                             if (widget.profileTypeEnum ==
//                                     ProfileTypeEnum.business ||
//                                 widget.profileTypeEnum ==
//                                     ProfileTypeEnum.photographer) {
//                               navigateToRoute(
//                                   context, const MessagesChatScreen());
//                             } else {
//                               navigateToRoute(
//                                   context, const MessagingHomePage());
//                             }
//                           },
//                           instagramOnPressed: () async {
//                             final instagramUsername =
//                                 await VModelSharedPrefStorage()
//                                     .getString('instagram_username');
//                             VUtilsBrowserLaucher.lauchWebBrowserWithUrl(widget
//                                         .profileTypeEnum ==
//                                     ProfileTypeEnum.business
//                                 ? "www.afrogarm.com"
//                                 : instagramUsername != null
//                                     ? "www.instagram.com/$instagramUsername/"
//                                     : "www.instagram.com");
//                           },
//                           instagramLongPress: () {
//                             showDialog(
//                                 context: context,
//                                 builder: ((context) => VWidgetsInputPopUp(
//                                       popupTitle: "Instaram Profile",
//                                       popupField: TextFormField(
//                                         decoration: const InputDecoration(
//                                             hintText: 'Instagram username'),
//                                         controller: instagramController,
//                                         // decoration: (InputDecoration(hintText: '')),
//                                       ),
//                                       onPressedYes: () async {
//                                         if (instagramController.text != "") {
//                                           await VModelSharedPrefStorage()
//                                               .putString('instagram_username',
//                                                   instagramController.text);
//                                           Navigator.pop(context);
//                                         } else {
//                                           Fluttertoast.showToast(
//                                               msg:
//                                                   "Please fill the instagram username",
//                                               gravity: ToastGravity.TOP,
//                                               timeInSecForIosWeb: 1,
//                                               backgroundColor: VmodelColors
//                                                   .error
//                                                   .withOpacity(0.6),
//                                               textColor: Colors.white,
//                                               fontSize: 16.0);
//                                         }
//                                       },
//                                     )));
//                           },
//                           instaLineOnPressed: () {
//                             //? new functionality
//                             navigateToRoute(context, const ServicesHomepage());

//                             // changeMeasurementState();
//                             // ScaffoldMessenger.of(context)
//                             //     .showSnackBar(measurementSnackbar());
//                             // popSheet(context);
//                           },
//                           bookNowOnPressed: () {
//                             // navigateToRoute(context, const BookingsView());
//                             //! Temporary change do not delete
//                             privateUserBookingState();
//                             bookNowFunction(context);
//                           },
//                         ),
//                         addVerticalSpacing(15),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             if (shouldShowUSerMeasurement == true)
//               Align(
//                 alignment: Alignment.topLeft,
//                 child: SizedBox(
//                     height: 90,
//                     child: Container(
//                       decoration:
//                           BoxDecoration(color: VmodelColors.white, boxShadow: [
//                         BoxShadow(
//                           color: VmodelColors.blackColor.withOpacity(0.1),
//                           spreadRadius: 0,
//                           blurRadius: 9,
//                           offset: const Offset(0, 3),
//                         )
//                       ]),
//                       child: Row(
//                         children: [
//                           for (int i = 0;
//                               i < measurementModelList().length;
//                               i++)
//                             Expanded(
//                               child: MeasusementTile(
//                                 title: measurementModelList()[i].title,
//                                 label: measurementModelList()[i].label,
//                               ),
//                             )
//                         ],
//                       ),
//                     )),
//               ),
//           ],
//         ),
//       ),
//     );
//   }

//   bookNowFunction(BuildContext context) {
//     showCupertinoModalPopup(
//       context: context,
//       builder: (BuildContext context) => Container(
//         margin: const EdgeInsets.only(
//           bottom: 40,
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.end,
//           children: [
//             ...createBookingOptions(context).map((e) {
//               return Container(
//                 decoration: BoxDecoration(
//                   color: VmodelColors.white,
//                   borderRadius: const BorderRadius.all(
//                     Radius.circular(10),
//                   ),
//                 ),
//                 width: double.infinity,
//                 margin: const EdgeInsets.only(left: 12, right: 12, bottom: 4),
//                 height: 50,
//                 child: MaterialButton(
//                   shape: const RoundedRectangleBorder(
//                     borderRadius: BorderRadius.all(
//                       Radius.circular(10),
//                     ),
//                   ),
//                   onPressed: e.onTap,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text(
//                         e.label.toString(),
//                         style: e.label == 'Cancel'
//                             ? Theme.of(context)
//                                 .textTheme
//                                 .displayMedium!
//                                 .copyWith(color: VmodelColors.primaryColor)
//                             : Theme.of(context).textTheme.displayMedium,
//                       ),
//                     ],
//                   ),
//                 ),
//               );
//             }),
//           ],
//         ),
//       ),
//     );
//   }

//   List<UploadOptions> createBookingOptions(BuildContext context) {
//     return [
//       UploadOptions(
//           label: "Create a booking",
//           onTap: () {
//             navigateToRoute(context, const BookingView());
//           }),
//       UploadOptions(
//           label: "Create a smart contract",
//           onTap: () {
//             navigateToRoute(context, const CreateContractView());
//           }),
//       UploadOptions(
//           label: "Cancel",
//           onTap: () {
//             Navigator.pop(context);
//           }),
//     ];
//   }
// }

// String returnLabelBasedOnUser(ProfileTypeEnum profileTypeEnum) {
//   if (profileTypeEnum == ProfileTypeEnum.business) {
//     return "BUSINESS";
//   } else if (profileTypeEnum == ProfileTypeEnum.photographer) {
//     return "PHOTOGRAPHER";
//   } else {
//     return "MODEL";
//   }
// }
