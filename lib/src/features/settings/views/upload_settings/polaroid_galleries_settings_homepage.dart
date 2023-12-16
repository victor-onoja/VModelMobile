// import 'package:flutter/material.dart';
// import 'package:vmodel/src/core/utils/shared.dart';
// import 'package:vmodel/src/features/settings/views/upload_settings/gallery_functions_widget.dart';
// import 'package:vmodel/src/shared/popup_dialogs/confirmation_popup.dart';
// import 'package:vmodel/src/shared/popup_dialogs/textfield_popup.dart';
// import 'package:vmodel/src/res/res.dart';
// import 'package:vmodel/src/shared/appbar/appbar.dart';

// class PolaroidGalleriesSettingsHomepage extends StatefulWidget {
//   const PolaroidGalleriesSettingsHomepage({super.key});

//   @override
//   State<PolaroidGalleriesSettingsHomepage> createState() =>
//       _PolaroidGalleriesSettingsHomepageState();
// }

// class _PolaroidGalleriesSettingsHomepageState
//     extends State<PolaroidGalleriesSettingsHomepage> {
//   final TextEditingController _controller = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: const VWidgetsAppBar(
//         appbarTitle: "Polaroid Galleries",
//         leadingIcon: VWidgetsBackButton(),
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: SingleChildScrollView(
//               padding: const VWidgetsPagePadding.horizontalSymmetric(16),
//               child: Column(
//                 children: [
//                   addVerticalSpacing(20),
//                   VWidgetsGalleryFunctionsCard(
//                     title: "Polaroid 1",
//                     onTapEdit: () {
//                       showDialog(
//                           context: context,
//                           builder: ((context) => VWidgetsAddAlbumPopUp(
//                                 controller: _controller,
//                                 popupTitle: "Edit Gallery Name",
//                                 buttonTitle: "Done",
//                                 onPressed: () async {},
//                               )));
//                     },
//                     onTapDelete: () {
//                       showDialog(
//                           context: context,
//                           builder: ((context) => VWidgetsConfirmationPopUp(
//                               popupTitle: "Delete Gallery",
//                                 firstButtonText: "Delete",
//                               secondButtonText: "Go Back",
//                               popupDescription:
//                                   "Are you sure want to delete this Gallery ? This action cannot be undone!",
//                               onPressedYes: () {
//                                 showDialog(
//                                     context: context,
//                                     builder: ((context) =>
//                                         VWidgetsAddAlbumPopUp(
//                                           controller: _controller,
//                                           popupTitle: "Delete Gallery",
//                                           buttonTitle: "Delete",
//                                           hintText: "Enter Password",
//                                           onPressed: () async {},
//                                         )));
//                               },
//                               onPressedNo: () {})));
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
