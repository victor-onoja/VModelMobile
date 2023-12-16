// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
//
// import '../other_user_profile/other_user_profile.dart';
// import 'new_profile_homepage.dart';
//
// final showOtherUserProfileProvider = StateProvider<String?>((ref) => null);
//
// class ProfileWidget extends ConsumerWidget {
//   const ProfileWidget(
//       {Key? key, this.isCurrentUser = false, required this.username})
//       : super(key: key);
//   final bool isCurrentUser;
//   final String username;
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//    final username = ref.watch(showOtherUserProfileProvider) ;
//     return username == null
//         ? const ProfileBaseScreen(isCurrentUser: true)
//         : OtherUserProfile(username: username);
//   }
// }
