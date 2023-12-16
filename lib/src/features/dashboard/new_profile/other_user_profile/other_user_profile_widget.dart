// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:vmodel/src/core/controller/app_user_controller.dart';
// import 'package:vmodel/src/features/dashboard/new_profile/profile_features/widgets/profile_picture_widget.dart';
// import 'package:vmodel/src/res/icons.dart';
// import 'package:vmodel/src/res/res.dart';
// import 'package:vmodel/src/shared/rend_paint/render_svg.dart';
// import 'package:vmodel/src/vmodel.dart';

// class VWidgetsOtherUserProfileCard extends ConsumerWidget {
//   final String? profileImage;
//   final String? mainBio;
//   final VoidCallback onTapExpandIcon;
//   const VWidgetsOtherUserProfileCard({
//     super.key,
//     required this.profileImage,
//     required this.mainBio,
//     required this.onTapExpandIcon,
//   });

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final appUser = ref.watch(appUserProvider);
//     final user = appUser.valueOrNull;
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.start,
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         ProfilePicture(url: profileImage),
//         addHorizontalSpacing(10),
//         Flexible(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.end,
//             children: [
//               Row(
//                 crossAxisAlignment: CrossAxisAlignment.end,
//                 children: [
//                   if (mainBio == null)
//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 15.0),
//                       child: Text(
//                         'No Bio found',
//                         style:
//                             Theme.of(context).textTheme.displayMedium!.copyWith(
//                                   color: Theme.of(context).primaryColor,
//                                 ),
//                         maxLines: 1,
//                       ),
//                     ),
//                   if (mainBio != null)
//                     Flexible(
//                       child: Text(
//                         mainBio ?? '',
//                         style:
//                             Theme.of(context).textTheme.displayMedium!.copyWith(
//                                   color: Theme.of(context).primaryColor,
//                                 ),
//                         overflow: TextOverflow.ellipsis,
//                         maxLines: 4,
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
