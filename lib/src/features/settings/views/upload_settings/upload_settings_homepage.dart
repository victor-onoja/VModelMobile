// import 'package:flutter/material.dart';
// import 'package:vmodel/src/core/routing/navigator_1.0.dart';
// import 'package:vmodel/src/core/utils/shared.dart';
// import 'package:vmodel/src/features/settings/views/upload_settings/gallery_settings_homepage.dart';
// import 'package:vmodel/src/features/settings/widgets/settings_submenu_tile_widget.dart';
// import 'package:vmodel/src/shared/appbar/appbar.dart';

// class UploadSettingsHomepage extends StatefulWidget {
//   const UploadSettingsHomepage({super.key});

//   @override
//   State<UploadSettingsHomepage> createState() => _UploadSettingsHomepageState();
// }

// class _UploadSettingsHomepageState extends State<UploadSettingsHomepage> {
//   @override
//   Widget build(BuildContext context) {
//     List uploadSettingsItems = [
//       VWidgetsSettingsSubMenuTileWidget(
//           title: "Galleries",
//           onTap: () {
//             navigateToRoute(context, const GallerySettingsHomepage());
//           }),
//     ];

//     return Scaffold(
//       appBar: const VWidgetsAppBar(
//         appbarTitle: "Upload Settings",
//         leadingIcon: VWidgetsBackButton(),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(vertical: 25.0),
//         child: Container(
//                     margin: const EdgeInsets.only(
//                       left: 18,
//                       right: 18,
                      
//                     ),
//                     child: ListView.separated(
//                         itemBuilder: ((context, index) => uploadSettingsItems[index]),
//                         separatorBuilder: (context, index) => const Divider(),
//                         itemCount: uploadSettingsItems.length),
//                   ),
//       ),
//     );
//   }
// }
