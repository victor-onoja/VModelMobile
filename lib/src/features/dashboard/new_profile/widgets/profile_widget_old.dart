// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:vmodel/src/core/controller/app_user_controller.dart';
// import 'package:vmodel/src/features/dashboard/new_profile/profile_features/widgets/profile_picture_widget.dart';
// import 'package:vmodel/src/res/icons.dart';
// import 'package:vmodel/src/res/res.dart';
// import 'package:vmodel/src/shared/rend_paint/render_svg.dart';
// import 'package:vmodel/src/shared/text_fields/profile_input_field.dart';
// import 'package:vmodel/src/vmodel.dart';

// class VWidgetsProfileCard extends ConsumerWidget {
//   final String? profileImage;
//   final String? mainBio;
//   final VoidCallback onTapExpandIcon;
//   final VoidCallback onTapProfile;

//   const VWidgetsProfileCard({
//     super.key,
//     required this.profileImage,
//     required this.mainBio,
//     required this.onTapExpandIcon,
//     required this.onTapProfile,
//   });

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final appUser = ref.watch(appUserProvider);
//     final user = appUser.valueOrNull;
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.start,
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         GestureDetector(
//           onTap: onTapProfile,
//           child: ProfilePicture(url: profileImage),
//         ),
//         addHorizontalSpacing(10),
//         Flexible(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.end,
//             children: [
//               addVerticalSpacing(12),
//               Row(
//                 // alignment: Alignment.bottomCenter,
//                 // mainAxisAlignment: MainAxisAlignment.end,
//                 crossAxisAlignment: CrossAxisAlignment.end,
//                 children: [
//                   if (mainBio == null)
//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 15.0),
//                       child: OutlinedButton(
//                         style: OutlinedButton.styleFrom(
//                           foregroundColor: VmodelColors.primaryColor,
//                           side: const BorderSide(
//                               color: VmodelColors.primaryColor, width: 0.5),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(10.0),
//                           ),
//                         ),
//                         child: Text(
//                           "Add Bio",
//                           style: Theme.of(context)
//                               .textTheme
//                               .displaySmall!
//                               .copyWith(
//                                 color: Theme.of(context).primaryColor,
//                               ),
//                         ),
//                         onPressed: () {
//                           navigateToRoute(
//                               context,
//                               ProfileInputField(
//                                 title: "Bio",
//                                 value: user!.bio ?? '',
//                                 isBio: true,
//                                 onSave: (newValue) async {
//                                   await ref
//                                       .read(appUserProvider.notifier)
//                                       .updateProfile(bio: newValue);
//                                 },
//                               ));
//                         },
//                       ),
//                     ),
//                   if (mainBio != null)
//                     Flexible(
//                       child: GestureDetector(
//                         onTap: () {
//                           navigateToRoute(
//                               context,
//                               ProfileInputField(
//                                 title: "Bio",
//                                 value: user!.bio ?? '',
//                                 isBio: true,
//                                 onSave: (newValue) async {
//                                   await ref
//                                       .read(appUserProvider.notifier)
//                                       .updateProfile(bio: newValue);
//                                 },
//                               ));
//                         },
//                         child: Text(
//                           mainBio ?? '',
//                           style: Theme.of(context)
//                               .textTheme
//                               .displayMedium!
//                               .copyWith(
//                                 color: Theme.of(context).primaryColor,
//                               ),
//                           overflow: TextOverflow.ellipsis,
//                           maxLines: 4,
//                         ),
//                       ),
//                     ),
//                 ],
//               ),
//               addVerticalSpacing(2),
//               if (mainBio != null)
//                 GestureDetector(
//                   onTap: onTapExpandIcon,
//                   child: const RenderSvg(
//                     svgPath: VIcons.expandBioIcon,
//                     svgWidth: 18,
//                     svgHeight: 18,
//                   ),
//                 )
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }
