// import 'dart:convert';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:image_cropper/image_cropper.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:vmodel/src/app_locator.dart';
// import 'package:vmodel/src/core/utils/browser_laucher.dart';
// import 'package:vmodel/src/core/utils/enum/profile_types.dart';
// import 'package:vmodel/src/core/utils/helper_functions.dart';
// import 'package:vmodel/src/core/utils/logs.dart';
// import 'package:vmodel/src/features/booking/views/booking_list/booking_list.dart';
// import 'package:vmodel/src/features/booking/views/create_booking/views/create_booking_view.dart';
// import 'package:vmodel/src/features/create_contract/views/create_contract_view.dart';
// import 'package:vmodel/src/features/dashboard/dash/controller.dart';
// import 'package:vmodel/src/features/dashboard/dash/dashboard_ui.dart';
// import 'package:vmodel/src/features/dashboard/profile/data/measurement_mock.dart';
// import 'package:vmodel/src/features/dashboard/new_profile/profile_features/expanded_bio/expanded_bio_homepage.dart.dart';
// import 'package:vmodel/src/features/dashboard/new_profile/profile_features/widgets/book_now/book_now_service.dart';
// import 'package:vmodel/src/features/dashboard/profile/view/my_network_page.dart';
// import 'package:vmodel/src/features/dashboard/profile/view/profile_polaroid_screen.dart';
// import 'package:vmodel/src/features/dashboard/new_profile/widgets/profile_buttons_widget.dart';
// import 'package:vmodel/src/features/dashboard/profile/widget/user_profile/profile_sub_info_widget.dart';
// import 'package:vmodel/src/features/messages/views/messages_chat_screen.dart';
// import 'package:vmodel/src/features/messages/views/messages_homepage.dart';
// import 'package:vmodel/src/features/dashboard/new_profile/profile_features/services/views/services_homepage.dart';
// import 'package:vmodel/src/features/dashboard/new_profile/profile_features/widgets/profile_picture_widget.dart';
// import 'package:vmodel/src/features/reviews/views/bookings_view.dart';
// import 'package:vmodel/src/res/icons.dart';
// import 'package:vmodel/src/res/res.dart';
// import 'package:vmodel/src/shared/popup_dialogs/customisable_popup.dart';
// import 'package:vmodel/src/shared/rend_paint/render_svg.dart';
// import 'package:vmodel/src/vmodel.dart';
// import '../../../../core/cache/local_storage.dart';
// import '../../../../core/controller/app_user_controller.dart';
// import '../../../../core/network/graphql_service.dart';
// import '../../../../shared/loader/full_screen_dialog_loader.dart';
// import '../../../../shared/popup_dialogs/confirmation_popup.dart';
// import '../../../../shared/popup_dialogs/input_popup.dart';
// import 'webview_page.dart';

// class GeneralProfileSpecifics extends ConsumerStatefulWidget {
//   final ProfileTypeEnum profileTypeEnum;
//   double maxHeight;
//   GeneralProfileSpecifics(
//       {Key? key,
//       required this.imgLink,
//       required this.maxHeight,
//       required this.isMainPortfolio,
//       required this.profileTypeEnum})
//       : super(key: key);
//   final String imgLink;
//   final bool isMainPortfolio;

//   @override
//   ConsumerState<GeneralProfileSpecifics> createState() =>
//       _GeneralProfileSpecificsState();
// }

// class _GeneralProfileSpecificsState
//     extends ConsumerState<GeneralProfileSpecifics> {
//   bool isDefaultBio = false;
//   bool isConnected = false;
//   bool isUserPrivate = false;
//   bool longPressProfile = false;
//   bool isBioVisible = true;
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

//   changeMeasurementState({String from = 'onPressed', bool? isClosed}) {
//     setState(() {
//       shouldShowUSerMeasurement =
//           isClosed != null ? !isClosed : !shouldShowUSerMeasurement;
//     });
//     print('==========($from) Change called flag is $shouldShowUSerMeasurement');
//   }

// //
//   final ScrollController _scrollController = ScrollController();
//   //on refresh
//   Future<void> onRefresh() async {
//     print("calling this block");
//     ref.watch(authProvider);
//     final authNotifier = ref.watch(authProvider.notifier);
//     //Todo (Ernest) undo getUser
//     authNotifier.getUser(globalUsername!);
//   }

//   // This is the image picker
//   final _picker = ImagePicker();
//   // Implementing the image picker
//   Future<String> _openImagePicker() async {
//     final XFile? pickedImage =
//         await _picker.pickImage(source: ImageSource.gallery);
//     if (pickedImage != null) {
//       return pickedImage.path;
//     }
//     return "";
//   }

// //biologic
//   bool shouldShowBioExpandButton = true;
//   final logger = AppLogger('MyApp');
//   String checkBioExpandButton(String bioWatch) {
//     if (bioWatch.length > 150) {
//       setState(() {
//         shouldShowBioExpandButton = true;
//       });
//     } else {
//       setState(() {
//         shouldShowBioExpandButton = false;
//       });
//     }

//     return bioWatch;
//   }

//   // Future<CroppedFile?> cropImage(String filePath) async {
//   //   return await ImageCropper().cropImage(
//   //     sourcePath: filePath,
//   //     aspectRatioPresets: [
//   //       CropAspectRatioPreset.square,
//   //       CropAspectRatioPreset.ratio3x2,
//   //       CropAspectRatioPreset.original,
//   //       CropAspectRatioPreset.ratio4x3,
//   //       CropAspectRatioPreset.ratio16x9
//   //     ],
//   //     uiSettings: [
//   //       AndroidUiSettings(
//   //         initAspectRatio: CropAspectRatioPreset.original,
//   //         lockAspectRatio: false,
//   //       ),
//   //     ],
//   //   );
//   // }

//   @override
//   void dispose() {
//     closeAnySnack();
//     super.dispose();
//   }

//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final authNotifier = ref.watch(authProvider.notifier);
//     final authNot = authNotifier.state;
//     final appUser= ref.watch(appUserProvider);
//     final user =appUser.valueOrNull;

//     TextTheme theme = context.textTheme;
//     List<MeasurementObjectModel> measurementModelList() {
//       if (authNot.height == null &&
//           authNot.chest == null &&
//           authNot.weight == null &&
//           authNot.hair == null &&
//           authNot.eyes == null) {
//         return [];
//       } else {
//         return [
//           MeasurementObjectModel(title: authNot.height ?? "", label: "Height"),
//           MeasurementObjectModel(title: authNot.chest ?? "", label: "Chest"),
//           MeasurementObjectModel(
//               title: authNot.modelSize?.simpleName ?? "", label: "Size"),
//           MeasurementObjectModel(title: authNot.hair ?? "", label: "Hair"),
//           MeasurementObjectModel(title: authNot.eyes ?? "", label: "Eyes")
//         ];
//       }
//     }

//     return Wrap(
//       children: [
//         Container(
//           alignment: Alignment.centerLeft,
//           padding: const EdgeInsets.symmetric(horizontal: 18),
//           margin: const EdgeInsets.only(bottom: 0, top: 70),
//           child: Column(
//             children: [
//               addVerticalSpacing(18),

//               Row(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   SizedBox(
//                     height: 100,
//                     width: 100,
//                     child: Padding(
//                       padding: const EdgeInsets.all(2.0),
//                       child: GestureDetector(
//                           onTap: () {
//                             closeAnySnack();
//                             showDialog(
//                                 context: context,
//                                 builder: ((context) =>
//                                     VWidgetsCustomisablePopUp(
//                                       option1: "Change",
//                                       option2: "Delete",
//                                       popupTitle: "Edit Headshot",
//                                       popupDescription: "",
//                                       onPressed1: () async {

//                                         selectPicture().then((value) async {
//                                           print(value);
//                                           if(value!=null && value!="") {
//                                             ref.read(appUserProvider.notifier).uploadProfilePicture(
//                                                 value, onProgress: (sent, total) {
//                                               final percentUploaded = (sent / total);
//                                               print(
//                                                   '########## ${value}\n [${percentUploaded}%]  sent: $sent ---- total: $total');

//                                             });
//                                           }
//                                         });
//                                         // UpdateProfilePicture()
//                                         //     .updateProfilePicture()
//                                         //     .then((value) async {
//                                         //   print('value is $value');
//                                         //   if (value != null) {
//                                         //     VLoader.changeLoadingState(true);
//                                         //     final image =
//                                         //         await UpdateProfilePicture()
//                                         //             .cropImage(value);
//                                         //     final bytes =
//                                         //         await image!.readAsBytes();
//                                         //     String base64Image =
//                                         //         base64Encode(bytes);
//                                         //     await authNotifier.pictureUpdate(
//                                         //       userIDPk!,
//                                         //       base64Image,
//                                         //       "${authNot.username}_${value.split('/').last}",
//                                         //     );
//                                         //     VLoader.changeLoadingState(false);
//                                         //   } else {
//                                         //     print('value is null');
//                                         //   }
//                                         // });
//                                       },
//                                       onPressed2: () {
//                                         Navigator.pop(context);
//                                         showDialog(
//                                             context: context,
//                                             builder: ((context) =>
//                                                 VWidgetsConfirmationPopUp(
//                                                   popupTitle:
//                                                       "Delete Confirmation",
//                                                   popupDescription:
//                                                       "Are you sure you want to delete your profile photo?",
//                                                   onPressedYes: () async {
//                                                     Navigator.pop(context);
//                                                   },
//                                                   onPressedNo: () {
//                                                     Navigator.pop(context);
//                                                   },
//                                                 )));
//                                       },
//                                     )));
//                           },
//                           child:  ProfilePicture(
//                             //VMString.pictureCall + authNot.profilePicture!,
//                             url :'${user?.profilePictureUrl}',
                   
//                           )),
//                     ),
//                   ),
//                   addHorizontalSpacing(19),
//                   Visibility(
//                     visible: isBioVisible,
//                     child: Flexible(
//                       child: Row(
//                         crossAxisAlignment: CrossAxisAlignment.end,
//                         children: [
//                           Flexible(
//                             child: Text(
//                               checkBioExpandButton(
//                                   authNot.bio ?? "No bio found"),
//                               style: theme.displayMedium!.copyWith(
//                                 fontSize: 11.sp,
//                                 color: Theme.of(context).primaryColor,
//                                 fontWeight: FontWeight.w500,
//                               ),
//                               overflow: TextOverflow.ellipsis,
//                               maxLines: 4,
//                             ),
//                           ),
//                           if (shouldShowBioExpandButton == true)
//                             GestureDetector(
//                               onTap: () {
//                                 navigateToRoute(
//                                     context, const ExpandedBioHomepage());
//                               },
//                               child: const RenderSvg(
//                                 svgPath: VIcons.bioIcon,
//                                 svgHeight: 19,
//                                 svgWidth: 19,
//                               ),
//                             )
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               addVerticalSpacing(35),

//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   /// profile type name here
//                   Text(
//                     // returnLabelBasedOnUser(widget.profileTypeEnum),
//                     authNot.accountType?.toUpperCase() ?? 'OTHER',
//                     style: context.textTheme.displayMedium!.copyWith(
//                       color: Theme.of(context).primaryColor.withOpacity(0.4),
//                     ),
//                   ),
//                 ],
//               ),
//               addVerticalSpacing(10),

//               /// For Sub info of profile
//               VWidgetsProfileSubInfoDetails(
//                 stars: "No ratings yet",
//                 profileTypeEnum: widget.profileTypeEnum,
//                 address: authNot.locationName,
//                 companyUrl: "www.afrogarm.com",
//                 budget: authNot.price == null
//                     ? ""
//                     : authNot.price!.floor().toString(),
//                 onPressedCompanyURL: () {
//                   VUtilsBrowserLaucher.lauchWebBrowserWithUrl(
//                       "www.afrogarm.com");
//                 },
//                 userName: '${authNot.firstName} '
//                     ' ${authNot.lastName}',
//               ),

//               addVerticalSpacing(15),
//               VWidgetsProfileButtons(
//                 largeButtonTitle:
//                     widget.profileTypeEnum == ProfileTypeEnum.personal
//                         ? "Bookings"
//                         : "Book Now",
//                 connectTitle: widget.profileTypeEnum == ProfileTypeEnum.personal
//                     ? "Network"
//                     : isConnected
//                         ? "Remove"
//                         : "Connect",
//                 connected: widget.profileTypeEnum == ProfileTypeEnum.personal
//                     ? true
//                     : isConnected,
//                 connectOnPressed: () {
//                   //! Temporary change do not delete
//                   closeAnySnack();
//                   widget.profileTypeEnum == ProfileTypeEnum.personal
//                       ? navigateToRoute(context, const NetworkPage())
//                       : changeConnectionState();
//                 },
//                 smallButtonOneTitle: (widget.profileTypeEnum ==
//                             ProfileTypeEnum.business ||
//                         widget.profileTypeEnum == ProfileTypeEnum.photographer)
//                     ? "Top Picks"
//                     : widget.isMainPortfolio
//                         ? 'Polaroid'
//                         : 'Portfolio',
//                 smallButtonTwoTitle: (widget.profileTypeEnum ==
//                             ProfileTypeEnum.business ||
//                         widget.profileTypeEnum == ProfileTypeEnum.photographer)
//                     ? "Messages"
//                     : "Messages",
//                 polaroidOrTopPicksOnPressed: () {
//                   closeAnySnack();
//                   if (widget.profileTypeEnum == ProfileTypeEnum.business ||
//                       widget.profileTypeEnum == ProfileTypeEnum.photographer) {
//                   } else {
//                     widget.isMainPortfolio
//                         ? navigateToRoute(
//                             context, const PolaroidPortfolioView())
//                         : navigateAndReplaceRoute(
//                             context, const DashBoardView());
//                   }
//                 },
//                 messagesOnPressed: () {
//                   closeAnySnack();
//                   if (widget.profileTypeEnum == ProfileTypeEnum.business ||
//                       widget.profileTypeEnum == ProfileTypeEnum.photographer) {
//                     navigateToRoute(context, const MessagesChatScreen());
//                   } else {
//                     navigateToRoute(context, const MessagingHomePage());
//                   }
//                 },
//                 instagramOnPressed: () async {
//                   closeAnySnack();
//                   final instagramUsername = await VModelSharedPrefStorage()
//                       .getString('instagram_username');

//                   final url = widget.profileTypeEnum == ProfileTypeEnum.business
//                       ? "https://www.afrogarm.com"
//                       : instagramUsername != null
//                           ? "https://www.instagram.com/$instagramUsername/"
//                           : "https://www.instagram.com";

//                   navigateToRoute(context, WebViewPage(url: url));
//                 },
//                 instagramLongPress: () {
//                   closeAnySnack();
//                   showDialog(
//                       context: context,
//                       builder: ((context) => VWidgetsInputPopUp(
//                             popupTitle: "Instagram Profile",
//                             popupField: TextFormField(
//                               decoration: const InputDecoration(
//                                   hintText: 'Instagram username'),
//                               controller: instagramController,
//                               // decoration: (InputDecoration(hintText: '')),
//                             ),
//                             onPressedYes: () async {
//                               if (instagramController.text != "") {
//                                 await VModelSharedPrefStorage().putString(
//                                     'instagram_username',
//                                     instagramController.text);
//                                 Navigator.pop(context);
//                               } else {
//                                 Fluttertoast.showToast(
//                                     msg: "Please fill the instagram username",
//                                     gravity: ToastGravity.TOP,
//                                     timeInSecForIosWeb: 1,
//                                     backgroundColor:
//                                         VmodelColors.error.withOpacity(0.6),
//                                     textColor: Colors.white,
//                                     fontSize: 16.0);
//                               }
//                             },
//                           )));
//                 },
//                 instaLineOnPressed: () {
//                   navigateToRoute(context, const ServicesHomepage());
//                 },
//                 bookNowOnPressed: () {
//                   closeAnySnack();

//                   // navigateToRoute(context, const BookingsView());
//                   //! Temporary change do not delete
//                   if (widget.profileTypeEnum == ProfileTypeEnum.personal) {
//                     navigateToRoute(context, const BookingsMenuView());
//                     // navigateToRoute(context,
//                     //     const BookingList());
//                     // Old Page: BookingsMenuView()
//                   } else {
//                     privateUserBookingState();
//                     bookNowFunction(context);
//                   }
//                 },
//               ),
//               addVerticalSpacing(15),
//             ],
//           ),
//         ),
//       ],
//     );
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
