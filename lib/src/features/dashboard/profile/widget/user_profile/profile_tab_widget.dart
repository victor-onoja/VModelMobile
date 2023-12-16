// import 'package:flutter/material.dart';
// import 'package:vmodel/src/core/routing/navigator_1.0.dart';
// import 'package:vmodel/src/features/dashboard/profile/view/profile_feed_screen.dart';

// class ProfileTabWidget extends StatelessWidget {
//   final String name;
//   final List images;
//   final bool isSaved;
//   const ProfileTabWidget({Key? key, required this.name, required this.isSaved, required this.images})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return CustomScrollView(
//       key: PageStorageKey<String>(name),
//       slivers: [
//         SliverOverlapInjector(
//             handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context)),
//         SliverPadding(
//           padding: const EdgeInsets.only(top: 0, bottom: 8),
//           sliver: SliverGrid(
//             gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//               crossAxisCount: 3,
//               crossAxisSpacing: 1,
//               mainAxisSpacing: 1,
//               childAspectRatio: 123 / 200,
//             ),
//             delegate:
//                 SliverChildBuilderDelegate((BuildContext context, int index) {
//               return GestureDetector(
//                   onTap: () {
//                     navigateToRoute(
//                         context,
//                         ProfileFeedView(
//                           isSaved: isSaved,
//                           images: images,
//                         ));
//                   },
//                   child: GestureDetector(
//                       child: Image.asset(images[index], fit: BoxFit.cover)));
//             }, childCount: images.length),
//           ),
//         )
//       ],
//     );
//   }
// }
