// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:vmodel/src/core/controller/app_user_controller.dart';
// import 'package:vmodel/src/core/utils/enum/upload_ratio_enum.dart';
// import 'package:vmodel/src/features/dashboard/feed/controller/feed_controller.dart';
// import 'package:vmodel/src/features/dashboard/feed/data/field_mock_data.dart';
// import 'package:vmodel/src/features/dashboard/feed/widgets/user_post.dart';
// import 'package:vmodel/src/features/dashboard/feed/widgets/user_tag_widget.dart';
// import 'package:vmodel/src/res/icons.dart';
// import 'package:vmodel/src/shared/appbar/appbar.dart';
// import 'package:vmodel/src/shared/rend_paint/render_svg.dart';
// import 'package:vmodel/src/vmodel.dart';

// import '../../../../shared/response_widgets/toast.dart';
// import '../../../notifications/views/notifications_ui.dart';

// class ProfileFeedView extends ConsumerWidget {
//   final homeCtrl = Get.put<HomeController>(HomeController());
//   final List images;
//   final bool isSaved;
//   ProfileFeedView({
//     required this.images,
//     required this.isSaved,
//     Key? key,
//   }) : super(key: key);

//   Future<void> reloadData() async {}

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final currentUser = ref.watch(appUserProvider).valueOrNull;
//     return Scaffold(
//       appBar: VWidgetsAppBar(
//         appbarTitle: "Feed",
//         appBarHeight: 50,
//         leadingIcon: const VWidgetsBackButton(),
//         trailingIcon: [
//           SizedBox(
//             // height: 30,
//             width: 80,
//             child: IconButton(
//               onPressed: () {
//                 navigateToRoute(context, const NotificationsView());
//               },
//               icon: const RenderSvg(
//                 svgPath: VIcons.notification,
//               ),
//             ),
//           ),

//           // Padding(
//           //   padding: const EdgeInsets.only(top: 12, right: 8),
//           //   child: Row(
//           //     mainAxisAlignment: MainAxisAlignment.end,
//           //     children: [
//           //       Padding(
//           //         padding: const EdgeInsets.only(top: 12, right: 0),
//           //         child: SizedBox(
//           //           height: 30,
//           //           width: 60,
//           //           child: IconButton(
//           //             padding: const EdgeInsets.all(0),
//           //             onPressed: () {
//           //               navigateToRoute(context,  NotificationsView());
//           //             },
//           //             icon: const RenderSvg(
//           //               svgPath: VIcons.notification,
//           //             ),
//           //           ),
//           //         ),
//           //       ),
//           //       // Flexible(
//           //       //   child: IconButton(
//           //       //     padding: const EdgeInsets.all(0),
//           //       //     onPressed: () {},
//           //       //     icon: const RenderSvg(
//           //       //       svgPath: VIcons.unsavedPostsIcon,
//           //       //     ),
//           //       //   ),
//           //       // ),
//           //       // Flexible(
//           //       //   child: IconButton(
//           //       //     padding: const EdgeInsets.only(top: 2),
//           //       //     onPressed: () {},
//           //       //     icon: notiBadge.Badge(
//           //       //       alignment: Alignment.topRight,
//           //       //       badgeColor: VmodelColors.bottomNavIndicatiorColor,
//           //       //       elevation: 0,
//           //       //       toAnimate: true,
//           //       //       showBadge: true,
//           //       //       badgeContent: Text(
//           //       //         '3',
//           //       //         style: Theme.of(context)
//           //       //             .textTheme
//           //       //             .displaySmall!
//           //       //             .copyWith(color: VmodelColors.white),
//           //       //       ),
//           //       //       child: SvgPicture.asset(
//           //       //         VIcons.sendWitoutNot,
//           //       //         width: 230,
//           //       //         height: 23,
//           //       //       ),
//           //       //     ),
//           //       //   ),
//           //       // ),
//           //       addHorizontalSpacing(5),
//           //     ],
//           //   ),
//           // ),
//         ],
//       ),
//       body: SafeArea(
//         child: RefreshIndicator(
//           onRefresh: () {
//             return reloadData();
//           },
//           child: Column(children: [
//             Expanded(
//               child: ListView.separated(
//                   padding: const EdgeInsets.only(bottom: 20),
//                   physics: const BouncingScrollPhysics(),
//                   itemBuilder: (context, index) => UserPost(
//                         isOwnPost: currentUser?.username == feedNames[index],
//                         isSaved: isSaved,
//                         username: feedNames[index],
//                         homeCtrl: homeCtrl,
//                         postTime: 'Date',
//                         aspectRatio: UploadAspectRatio
//                             .square, // Todo: Fix this hardcoded value
//                         imageList: [images[index]],
//                         //! Dummy userTagList
//                         userTagList: [],
//                         onTaggedUserTap: (value) {
//                           VWidgetShowResponse.showToast(
//                             ResponseEnum.sucesss,
//                             message: '#6Tagged user $value tapped',
//                           );
//                         },
//                         // userTagList: [
//                         //   VWidgetsUserTag(
//                         //       profilePictureUrl:
//                         //           "https://images.unsplash.com/photo-1604514628550-37477afdf4e3?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=3327&q=80",
//                         //       onTapProfile: () {}),
//                         //   VWidgetsUserTag(
//                         //       profilePictureUrl:
//                         //           "https://images.unsplash.com/photo-1556347961-f9521a88cb8a?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1287&q=80",
//                         //       onTapProfile: () {}),
//                         //   VWidgetsUserTag(
//                         //       profilePictureUrl:
//                         //           "https://images.unsplash.com/photo-1529626455594-4ff0802cfb7e?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1287&q=80",
//                         //       onTapProfile: () {}),
//                         //   VWidgetsUserTag(
//                         //       profilePictureUrl:
//                         //           "https://images.unsplash.com/photo-1536924430914-91f9e2041b83?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1288&q=80",
//                         //       onTapProfile: () {}),
//                         //   VWidgetsUserTag(
//                         //       profilePictureUrl:
//                         //           "https://images.unsplash.com/photo-1524504388940-b1c1722653e1?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1287&q=80",
//                         //       onTapProfile: () {}),
//                         // ],
//                         smallImageAsset: images[index],
//                         onLike: () async {
//                           return false;
//                         },
//                         onSave: () async {
//                           return false;
//                         },
//                         onUsernameTap: () {},
//                       ),
//                   separatorBuilder: (context, index) => const SizedBox(
//                         height: 24,
//                       ),
//                   itemCount: images.length),
//             ),
//           ]),
//         ),
//       ),
//     );
//   }
// }
