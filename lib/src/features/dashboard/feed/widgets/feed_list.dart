// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:vmodel/src/core/controller/app_user_controller.dart';
// import 'package:vmodel/src/features/dashboard/feed/widgets/user_tag_widget.dart';

// import '../../../../shared/response_widgets/toast.dart';
// import '../../../../vmodel.dart';
// import '../../new_profile/controller/gallery_controller.dart';
// import '../controller/feed_controller.dart';
// import 'user_post.dart';

// class CurrentUserFeedListview extends ConsumerStatefulWidget {
//   const CurrentUserFeedListview({
//     Key? key,
//     required this.galleryId,
//     required this.username,
//     required this.postTime,
//     required this.profilePictureUrl,
//     required this.isSaved,
//     this.isCurrentUser = false,
//   }) : super(key: key);
//   // final List items;
//   final bool isCurrentUser;
//   final String galleryId;
//   final String postTime;
//   final String username;
//   final bool isSaved;
//   final String profilePictureUrl;

//   @override
//   ConsumerState<CurrentUserFeedListview> createState() =>
//       _CurrentUserFeedListviewState();
// }

// class _CurrentUserFeedListviewState
//     extends ConsumerState<CurrentUserFeedListview> {
//   final homeCtrl = Get.put<HomeController>(HomeController());
//   late final String? galleryUsername;

//   @override
//   void initState() {
//     galleryUsername = widget.isCurrentUser ? null : widget.username;
//   }

//   @override
//   Widget build(BuildContext context) {
//     final galleries = ref.watch(filteredGalleryListProvider(galleryUsername));
//     final currentUser = ref.watch(appUserProvider).valueOrNull;
//     return Scaffold(
//       body: galleries.maybeWhen(
//         data: (data) {
//           final value =
//               data.firstWhere((element) => element.id == widget.galleryId);
//           return SafeArea(
//             child: ListView.separated(
//               padding: const EdgeInsets.only(bottom: 20),
//               physics: const BouncingScrollPhysics(),
//               itemCount: value.postSets.length,
//               itemBuilder: (context, index) {
//                 return Container(
//                   // height: 650,
//                   child: UserPost(
//                     isOwnPost: currentUser?.username == widget.username,
//                     isSaved: widget.isSaved,
//                     username: widget.username,
//                     homeCtrl: homeCtrl,
//                     postTime: widget.postTime,
//                     aspectRatio: value.postSets[index].aspectRatio,
//                     imageList: value.postSets[index].photos,
//                     //! Dummy userTagList

//                     userTagList: [],
//                     // userTagList: [
//                     //   VWidgetsUserTag(
//                     //       profilePictureUrl:
//                     //           "https://images.unsplash.com/photo-1483519396903-1ef292f4974a?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=3270&q=80",
//                     //       onTapProfile: () {}),
//                     //   VWidgetsUserTag(
//                     //       profilePictureUrl:
//                     //           "https://images.unsplash.com/photo-1483519396903-1ef292f4974a?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=3270&q=80",
//                     //       onTapProfile: () {}),
//                     //   VWidgetsUserTag(
//                     //       profilePictureUrl:
//                     //           "https://images.unsplash.com/photo-1483519396903-1ef292f4974a?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=3270&q=80",
//                     //       onTapProfile: () {}),
//                     //   VWidgetsUserTag(
//                     //       profilePictureUrl:
//                     //           "https://images.unsplash.com/photo-1483519396903-1ef292f4974a?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=3270&q=80",
//                     //       onTapProfile: () {}),
//                     //   VWidgetsUserTag(
//                     //       profilePictureUrl:
//                     //           "https://images.unsplash.com/photo-1483519396903-1ef292f4974a?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=3270&q=80",
//                     //       onTapProfile: () {}),
//                     // ],
//                     smallImageAsset: widget.profilePictureUrl,
//                     onLike: () async {
//                       return false;
//                     },
//                     onSave: () async {
//                       return false;
//                     },
//                     onUsernameTap: () {},
//                     onTaggedUserTap: (value) {
//                       VWidgetShowResponse.showToast(
//                         ResponseEnum.sucesss,
//                         message: '#5Tagged user $value tapped',
//                       );
//                     },
//                   ),
//                 );
//               },
//               separatorBuilder: (context, index) {
//                 return const SizedBox.shrink();
//               },
//             ),
//           );
//         },
//         orElse: () => const Center(
//           child: CircularProgressIndicator(),
//         ),
//       ),
//     );
//   }
// }
