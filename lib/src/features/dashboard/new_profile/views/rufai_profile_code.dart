


// import 'dart:async';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:rxdart/rxdart.dart' as rx;
// import 'package:vmodel/src/app_locator.dart';
// import 'package:vmodel/src/core/cache/local_storage.dart';
// import 'package:vmodel/src/core/network/graphql_service.dart';
// import 'package:vmodel/src/core/utils/enum/profile_types.dart';
// import 'package:vmodel/src/features/authentication/login/views/sign_in.dart';
// import 'package:vmodel/src/features/dashboard/profile/view/general_profile_specifics.dart';
// import 'package:vmodel/src/res/assets/app_asset.dart';
// import 'package:vmodel/src/res/icons.dart';
// import 'package:vmodel/src/res/res.dart';
// import 'package:vmodel/src/shared/appbar/appbar.dart';
// import 'package:vmodel/src/shared/empty_page/empty_page.dart';
// import 'package:vmodel/src/shared/popup_dialogs/confirmation_popup.dart';
// import 'package:vmodel/src/shared/rend_paint/render_svg.dart';
// import 'package:vmodel/src/vmodel.dart';
// import '../../../../core/utils/helper_functions.dart';
// import '../../../../shared/shimmer/profileShimmerPage.dart';


// class ProfileMainGeneralView extends ConsumerStatefulWidget {
//   final ProfileTypeEnum profileTypeEnumConstructor;
//   final bool shouldHaveBackButton;

//   const ProfileMainGeneralView(
//       {Key? key,
//       this.shouldHaveBackButton = true,
//       required this.profileTypeEnumConstructor})
//       : super(key: key);

//   @override
//   ConsumerState<ProfileMainGeneralView> createState() =>
//       _ProfileMainViewState();
// }

// class _ProfileMainViewState extends ConsumerState<ProfileMainGeneralView>
//     with SingleTickerProviderStateMixin {
//   late TabController tabBarController;

// //
//   DraggableScrollableController scrollController =
//       DraggableScrollableController();
// //
//   @override
//   void initState() {
//     tabBarController =
//         TabController(length: mockCategories.length, vsync: this);
//     changeDragrableHeight();
//     super.initState();
//   }

//   Future<void> onRefresh() async {
//     print("calling this block");
//   }

//   double? d;

//   changeDragrableHeight() {
//     if (d == null) {
//       setState(() {
//         if (scrollController.isAttached) {
//           d = scrollController.size;
//         }
//       });
//     }
//     print("Drag height");
//   }

//   @override
//   Widget build(BuildContext context) {
//     final authNotifier = ref.watch(authProvider.notifier);
//     final authNot = authNotifier.state;
//     return RefreshIndicator(
//       onRefresh: () {
//         return onRefresh();
//       },
//       child: StreamBuilder(
//         stream: rx.Rx.combineLatest2(
//           authNotifier.getUser(globalUsername!),
//           authNotifier.getPosts(authNot.username ?? ""),
//           (user, posts) => {'user': user, 'posts': posts},
//         ),
//         // loadData()
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return ProfileShimmerPage(
//               onTap: () {
//                 logOutFunction();
//               },
//             );
//           } else if (snapshot.hasError) {
//             return ProfileShimmerPage(
//               onTap: () {
//                 logOutFunction();
//               },
//             );
//           } else if (snapshot.data == null) {
//             return ProfileShimmerPage(
//               onTap: () {
//                 logOutFunction();
//               },
//             );
//           } else {
//             //Todo posts need to be re-integrated commented out below code
//             // to prevent null exceptions
//             // print('data == ${snapshot.data!['posts']['posts']['data']}');
//             final List<dynamic> albums = [];
//                 // snapshot.data!['posts']["posts"]["data"];
//             // final albumss = snapshot.data![1]["posts"]["data"]["album"];
//             print('album == ${albums.length}');
//             return Scaffold(
//               appBar: VWidgetsAppBar(
//                 leadingIcon: (widget.shouldHaveBackButton == true)
//                     ? Padding(
//                         padding: const EdgeInsets.only(top: 12),
//                         child: VWidgetsBackButton(
//                           onTap: () {
//                             logOutFunction();
//                           },
//                         ),
//                       )
//                     : const Text(""),
//                 appbarTitle: "",
//                 titleWidget: Row(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Flexible(
//                       child: GestureDetector(
//                         onTap: () {
//                           ref
//                               .watch(authProvider.notifier)
//                               .getPosts(authNot.username ?? "");
//                         },
//                         child: Text(
//                           // authProvider.notifier.
//                           authNot.username?.toLowerCase() ?? "",
//                           // widget.profileTypeEnumConstructor ==
//                           //         ProfileTypeEnum.business
//                           //     ? "Afrogarm"
//                           //     : 'Samantha',
//                           maxLines: 1,
//                           overflow: TextOverflow.ellipsis,
//                           style: context.textTheme.displayLarge?.copyWith(
//                             color: VmodelColors.primaryColor,
//                             fontWeight: FontWeight.w600,
//                           ),
//                         ),
//                       ),
//                     ),
//                     addHorizontalSpacing(5),
//                     if (authNot.isVerified == true) verifiedBadge
//                   ],
//                 ),
//                 trailingIcon: [
//                   Padding(
//                     padding: const EdgeInsets.only(top: 12),
//                     child: SizedBox(
//                       height: 30,
//                       width: 80,
//                       child: Row(
//                         children: [
//                           Flexible(
//                             child: IconButton(
//                               padding: const EdgeInsets.all(0),
//                               onPressed: () {
//                                 openVModelMenu(context);
//                               },
//                               icon: const NormalRenderSvg(
//                                 svgPath: VIcons.circleIcon,
//                               ),
//                             ),
//                           ),
//                           addHorizontalSpacing(5),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               body: Column(
//                 children: [
//                   //bio section first

//                   returnBasedOnUser(
//                     widget.profileTypeEnumConstructor,
//                     0,
//                   ),
//                   //
//                   Expanded(
//                     child: DraggableScrollableSheet(
//                         expand: true,
//                         controller: scrollController,
//                         builder: (context, controller) {
//                           return Column(
//                             children: [
//                               Container(
//                                 height: 60,
//                                 color: VmodelColors.white,
//                                 child: albums.isEmpty
//                                     ? TabBar(
//                                         controller: tabBarController,
//                                         labelStyle: context
//                                             .textTheme.displayMedium
//                                             ?.copyWith(
//                                                 fontWeight: FontWeight.w600),
//                                         labelColor: VmodelColors.primaryColor,
//                                         unselectedLabelColor:
//                                             VmodelColors.unselectedText,
//                                         unselectedLabelStyle: context
//                                             .textTheme.displayMedium
//                                             ?.copyWith(
//                                                 fontWeight: FontWeight.w500),
//                                         indicatorColor: VmodelColors.mainColor,
//                                         isScrollable: true,
//                                         tabs: mockCategories
//                                             .map((e) => Tab(
//                                                   text: e,
//                                                 ))
//                                             .toList(),
//                                       )
//                                     : TabBar(
//                                         controller: tabBarController,
//                                         labelStyle: context
//                                             .textTheme.displayMedium
//                                             ?.copyWith(
//                                                 fontWeight: FontWeight.w600),
//                                         labelColor: VmodelColors.primaryColor,
//                                         unselectedLabelColor:
//                                             VmodelColors.unselectedText,
//                                         unselectedLabelStyle: context
//                                             .textTheme.displayMedium
//                                             ?.copyWith(
//                                                 fontWeight: FontWeight.w500),
//                                         indicatorColor: VmodelColors.mainColor,
//                                         isScrollable: true,
//                                         tabs: albums.map((post) {
//                                           String albumName =
//                                               post['album']['name'];
//                                           return Tab(
//                                             text: albumName,
//                                           );
//                                         }).toList(),
//                                       ),
//                               ),
//                               Container(
//                                 color: VmodelColors.white,
//                                 child: albums.isEmpty
//                                     ? const SizedBox(
//                                         child: EmptyPage(
//                                           shouldCenter: false,
//                                           title: 'No Posts Yet',
//                                           subtitle:
//                                               'Upload your content to get access to bookings!',
//                                         ),
//                                       )
//                                     : Expanded(
//                                         child: SingleChildScrollView(
//                                           controller: controller,
//                                           child: TabBarView(
//                                             children: albums.map((post) {
//                                               List photos =
//                                                   post['photos']['data'];
//                                               return Container(
//                                                 margin: const EdgeInsets.only(
//                                                     top: 105),
//                                                 child: GridView.count(
//                                                   crossAxisCount: 3,
//                                                   crossAxisSpacing: 1,
//                                                   mainAxisSpacing: 1,
//                                                   childAspectRatio: 123 / 200,
//                                                   children: photos.map((photo) {
//                                                     String imageUrl =
//                                                         photo['itemLink'];
//                                                     String image =
//                                                         VMString.pictureCall +
//                                                             imageUrl;
//                                                     return GestureDetector(
//                                                         child: Image.network(
//                                                       image,
//                                                       fit: BoxFit.cover,
//                                                     ));
//                                                   }).toList(),
//                                                 ),
//                                               );
//                                             }).toList(),
//                                           ),
//                                         ),
//                                       ),
//                               ),
//                             ],
//                           );
//                         }),
//                   )
//                 ],
//               ),
//             );
//           }
//         },
//       ),
//     );
//   }


//   logOutFunction() {
//     closeAnySnack();

//     showDialog(
//         context: context,
//         builder: ((context) => VWidgetsConfirmationPopUp(
//               popupTitle: "Logout Confirmation",
//               popupDescription:
//                   "Are you sure you want to logout from your account",
//               onPressedYes: () async {
//                 Navigator.pop(context);
//                 await VModelSharedPrefStorage().clearObject('token');
//                 await VModelSharedPrefStorage().clearObject('pk');
//                 if (!mounted) return;
//                 navigateAndRemoveUntilRoute(context, LoginPage());
//               },
//               onPressedNo: () {
//                 Navigator.pop(context);
//               },
//             )));
//   }
// }

// const mockCategories = [
//   'Favourites',
//   'Commercial',
//   'Editorial',
//   'Underwear',
//   'Features',
// ];

// Widget returnBasedOnUser(
//     ProfileTypeEnum profileTypeEnumSelection, double maxHeight) {
//   if (profileTypeEnumSelection == ProfileTypeEnum.business) {
//     return GeneralProfileSpecifics(
//       imgLink: 'assets/images/business/business_profile_picture.png',
//       profileTypeEnum: ProfileTypeEnum.business,
//       maxHeight: maxHeight,
//       isMainPortfolio: true,
//     );
//   } else if (profileTypeEnumSelection == ProfileTypeEnum.photographer) {
//     return GeneralProfileSpecifics(
//       imgLink: 'assets/images/models/model_11.png',
//       isMainPortfolio: true,
//       maxHeight: maxHeight,
//       profileTypeEnum: ProfileTypeEnum.photographer,
//     );
//   } else {
//     return GeneralProfileSpecifics(
//       imgLink: 'assets/images/models/model_11.png',
//       maxHeight: maxHeight,
//       isMainPortfolio: true,
//       profileTypeEnum: ProfileTypeEnum.personal,
//     );
//   }
// }
