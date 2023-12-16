// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:vmodel/src/core/utils/enum/profile_types.dart';
// import 'package:vmodel/src/features/dashboard/polaroid/data/polarid_mock_data.dart';
// import 'package:vmodel/src/features/dashboard/profile/view/business_profile_specifics.dart';
// import 'package:vmodel/src/features/dashboard/profile/view/general_profile_specifics.dart';
// import 'package:vmodel/src/features/dashboard/profile/widget/user_profile/profile_tab_widget.dart';
// import 'package:vmodel/src/features/notifications/views/notifications_ui.dart';
// import 'package:vmodel/src/res/assets/app_asset.dart';
// import 'package:vmodel/src/res/icons.dart';
// import 'package:vmodel/src/res/res.dart';
// import 'package:vmodel/src/shared/rend_paint/render_svg.dart';
// import 'package:vmodel/src/vmodel.dart';

// import '../../../../core/network/graphql_service.dart';
// import '../../dash/controller.dart';
// import '../../feed/controller/feed_provider.dart';

// class PolaroidPortfolioView extends ConsumerStatefulWidget {
//   final ProfileTypeEnum profileTypeEnumConstructor;
//   final bool shouldHaveBackButton;

//   const PolaroidPortfolioView(
//       {Key? key,
//       this.shouldHaveBackButton = true,
//       this.profileTypeEnumConstructor = ProfileTypeEnum.personal})
//       : super(key: key);

//   @override
//   ConsumerState<PolaroidPortfolioView> createState() =>
//       _PolaroidPortfolioViewState();
// }

// class _PolaroidPortfolioViewState extends ConsumerState<PolaroidPortfolioView>
//     with SingleTickerProviderStateMixin {
//   late TabController tabBarController;

//   final double _animatedHeight = 600.0;
//   bool isDefaultBio = true;

//   @override
//   void initState() {
//     tabBarController =
//         TabController(length: mockCategories.length, vsync: this);
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final authNotifier = ref.read(authProvider.notifier);
//     final autNot = authNotifier.state;
//     TextTheme theme = Theme.of(context).textTheme;
//     ref.watch(dashTabProvider);
//     final watchProvider = ref.watch(dashTabProvider.notifier);
//     ref.watch(feedProvider);
//     final fProvider = ref.watch(feedProvider.notifier);
//     return DefaultTabController(
//       length: mockCategories.length,
//       child: Scaffold(
//         body: NestedScrollView(
//           headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
//             return <Widget>[
//               SliverOverlapAbsorber(
//                 handle:
//                     NestedScrollView.sliverOverlapAbsorberHandleFor(context),
//                 sliver: SliverAppBar(
//                     automaticallyImplyLeading: widget.shouldHaveBackButton,
//                     leading: (widget.shouldHaveBackButton == true)
//                         ? const Padding(
//                             padding: EdgeInsets.only(top: 12),
//                             child: VWidgetsBackButton(),
//                           )
//                         : const Text(""),
//                     titleTextStyle: theme.displayLarge?.copyWith(
//                         color: VmodelColors.textColor,
//                         fontWeight: FontWeight.w600),
//                     title: Padding(
//                       padding: const EdgeInsets.only(top: 18),
//                       child: Row(
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           Text(autNot.username!.toLowerCase()),
//                           addHorizontalSpacing(5),
//                           if (autNot.isVerified == true) verifiedBadge
//                         ],
//                       ),
//                     ),
//                     centerTitle: true,
//                     shadowColor: Colors.grey[350],
//                     backgroundColor: Colors.white,
//                     flexibleSpace: Container(
//                       child: SingleChildScrollView(
//                         child: LayoutBuilder(builder: (context, constraint) {
//                           return returnBasedOnUser(
//                               widget.profileTypeEnumConstructor,
//                               constraint.maxHeight);
//                         }),
//                       ),
//                     ),
//                     forceElevated: innerBoxIsScrolled,
//                     actions: [
//                       Padding(
//                         padding: const EdgeInsets.only(top: 12),
//                         child: SizedBox(
//                           height: 30,
//                           width: 80,
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.end,
//                             children: [
//                               // Flexible(
//                               //   child: IconButton(
//                               //     padding: const EdgeInsets.all(0),
//                               //     onPressed: () {
//                               //       navigateToRoute(
//                               //           context, const MessagingHomePage());
//                               //     },
//                               //     icon: const RenderSvg(
//                               //       svgPath: VIcons.sendWitoutNot,
//                               //       svgHeight: 24,
//                               //       svgWidth: 24,
//                               //     ),
//                               //   ),
//                               // ),
//                               // Flexible(
//                               //   child: IconButton(
//                               //     padding: const EdgeInsets.all(0),
//                               //     onPressed: () {
//                               //       navigateToRoute(
//                               //           context, NotificationsView());
//                               //     },
//                               //     icon: const RenderSvg(
//                               //       svgPath: VIcons.notificationIcon,
//                               //       svgHeight: 24,
//                               //       svgWidth: 24,
//                               //     ),
//                               //   ),
//                               // ),
//                               Flexible(
//                                 child: IconButton(
//                                   padding: const EdgeInsets.all(0),
//                                   onPressed: () {
//                                     openVModelMenu(context,
//                                         isNotTabScreen: true);
//                                   },
//                                   icon: const RenderSvgWithoutColor(
//                                     svgPath: VIcons.circleMenu,
//                                     svgHeight: 24,
//                                     svgWidth: 24,
//                                   ),
//                                 ),
//                               ),
//                               addHorizontalSpacing(5),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ],
//                     expandedHeight: 62.h,
//                     pinned: true,
//                     floating: false,
//                     elevation: 3,
//                     bottom: PreferredSize(
//                         preferredSize: const Size(double.infinity, 50),
//                         child: Container(
//                           color: VmodelColors.white,
//                           child: TabBar(
//                             labelStyle: theme.displayMedium?.copyWith(
//                                 letterSpacing: 0.5,
//                                 fontWeight: FontWeight.w600),
//                             labelColor: VmodelColors.mainColor,
//                             unselectedLabelColor: VmodelColors.unselectedText,
//                             unselectedLabelStyle: theme.displayMedium
//                                 ?.copyWith(fontWeight: FontWeight.w500),
//                             indicatorColor: VmodelColors.mainColor,
//                             // isScrollable: true,
//                             tabs: mockCategories
//                                 .map((e) => Tab(
//                                       text: e,
//                                     ))
//                                 .toList(),
//                           ),
//                         ))),
//               )
//             ];
//           },
//           // body: TabBarView(
//           //     children:
//           //         mockCategories.map((e) => Polaroid1(name: e)).toList()
//           // ),

//           body: const TabBarView(children: [
//             ProfileTabWidget(
//               name: "Polaroid 1",
//               images: polaroid1MockData,
//             ),
//             ProfileTabWidget(
//               name: "Polaroid 2",
//               images: polaroid2MockData,
//             ),
//           ]),
//         ),
//         bottomNavigationBar: Container(
//           decoration: BoxDecoration(
//             boxShadow: [
//               BoxShadow(
//                 // spreadRadius: 0,
//                 // blurRadius: 0.5,
//                 color: watchProvider.getPageIndex != 2
//                     ? VmodelColors.appBarShadowColor
//                     : VmodelColors.black,
//                 // offset: const Offset(0, -1), // changes position of shadow
//               ),
//             ],
//             color: watchProvider.backgroundColor,
//           ),
//           height: 79,
//           child: Container(
//             decoration: const BoxDecoration(
//                 borderRadius: BorderRadius.only(
//               topRight: Radius.circular(30),
//               topLeft: Radius.circular(30),
//             )),
//             margin: const EdgeInsets.symmetric(
//               horizontal: 20,
//               vertical: 5,
//             ),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: watchProvider.bottomNavItems(
//                   context, () => fProvider.isFeedPage(isFeedOnly: false),
//                   doesItNeedPopUp: true),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// Widget returnBasedOnUser(
//     ProfileTypeEnum profileTypeEnumSelection, double maxHeight) {
//   if (profileTypeEnumSelection == ProfileTypeEnum.business) {
//     return const BusinessProfileSpecifics(
//       imgLink: 'assets/images/business/business_profile_picture.png',
//       profileTypeEnum: ProfileTypeEnum.business,
//       isMainPortfolio: false,
//     );
//   } else if (profileTypeEnumSelection == ProfileTypeEnum.photographer) {
//     return GeneralProfileSpecifics(
//       imgLink: 'assets/images/models/model_11.png',
//       isMainPortfolio: false,
//       maxHeight: maxHeight,
//       profileTypeEnum: ProfileTypeEnum.photographer,
//     );
//   } else {
//     return GeneralProfileSpecifics(
//       imgLink: 'assets/images/models/model_11.png',
//       maxHeight: maxHeight,
//       isMainPortfolio: false,
//       profileTypeEnum: ProfileTypeEnum.personal,
//     );
//   }
// }


// const mockCategories = [
//   'Polaroid 1',
//   'Polaroid 2',
//   // 'Polaroid 3',
//   // 'Polaroid 4',
//   // 'Polaroid 5',
// ];
