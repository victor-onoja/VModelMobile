// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:vmodel/src/core/utils/debounce.dart';
// import 'package:vmodel/src/core/utils/validators_mixins.dart';
// import 'package:vmodel/src/features/dashboard/discover/widget/discover_search_field.dart';
// import 'package:vmodel/src/features/jobs/job_market/views/coupon_end_widget.dart';
// import 'package:vmodel/src/features/jobs/job_market/widget/coupons_widget.dart';
// import 'package:vmodel/src/res/gap.dart';
// import 'package:vmodel/src/shared/response_widgets/error_dialogue.dart';
// import 'package:vmodel/src/vmodel.dart';
// import '../../../../../core/controller/app_user_controller.dart';
// import '../../../../../core/models/app_user.dart';
// import '../../../../../shared/shimmer/jobShimmerPage.dart';
// import '../../../../create_coupons/controller/create_coupon_controller.dart';
// import '../../../profile/controller/profile_controller.dart';
// // import '../../../../shared/shimmer/jobShimmerPage.dart';
// // import '../controller/coupons_controller.dart';

// class UserCoupons extends ConsumerStatefulWidget {
//   const UserCoupons({
//     super.key,
//     required this.username,
//     this.showAppBar = true,
//   });
//   static const routeName = 'allCoupons';
//   final String? username;
//   final bool showAppBar;

//   @override
//   ConsumerState<UserCoupons> createState() => _UserCouponsState();
// }

// class _UserCouponsState extends ConsumerState<UserCoupons> {
//   final TextEditingController _searchController = TextEditingController();
//   late final Debounce _debounce;
//   ScrollController _scrollController = ScrollController();
//   bool isCurrentUser = false;

//   @override
//   void initState() {
//     _debounce = Debounce(delay: Duration(milliseconds: 300));
//     _scrollController.addListener(() {
//       final maxScroll = _scrollController.position.maxScrollExtent;
//       final currentScroll = _scrollController.position.pixels;
//       final delta = SizerUtil.height * 0.2;
//       if (maxScroll - currentScroll <= delta) {
//         _debounce(() {
//           // ref.read(userCouponsProvider(widget.username).notifier).fetchMoreData();
//         });
//       }
//     });
//     isCurrentUser =
//         ref.read(appUserProvider.notifier).isCurrentUser(widget.username);
//     super.initState();
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     _scrollController.dispose();
//     _debounce.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     VAppUser? user;
//     if (isCurrentUser) {
//       final appUser = ref.watch(appUserProvider);
//       user = appUser.valueOrNull;
//     } else {
//       final appUser = ref.watch(profileProvider(widget.username));
//       user = appUser.valueOrNull;
//     }
//     final requestUsername =
//         ref.watch(userNameForApiRequestProvider('${widget.username}'));
//     final allCoupons = ref.watch(userCouponsProvider(requestUsername));
//     final userCoupons = ref.watch(userCouponsProvider(requestUsername));
//     return allCoupons.when(data: (data) {
//       if (data.isNotEmpty)
//         return Scaffold(
//           body: SafeArea(
//             top: false,
//             child: RefreshIndicator.adaptive(
//               onRefresh: () async {
//                 await ref.refresh(userCouponsProvider(null).future);
//               },
//               child: CustomScrollView(
//                 // physics: const BouncingScrollPhysics(),
//                 physics: const AlwaysScrollableScrollPhysics(
//                     parent: BouncingScrollPhysics()),
//                 controller: _scrollController,
//                 slivers: [
//                   // SliverAppBar(
//                   //   expandedHeight: 120.0,
//                   //   elevation: 0,
//                   //   backgroundColor: Theme.of(context).scaffoldBackgroundColor,
//                   //   leading: const VWidgetsBackButton(),
//                   //   flexibleSpace: FlexibleSpaceBar(background: _titleSearch()),
//                   //   floating: true,
//                   //   pinned: true,
//                   // ),
//                   SliverList.builder(
//                     itemCount: data.length,
//                     itemBuilder: (context, index) {
//                       return Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 8),
//                         child: Column(
//                           children: [
//                             addVerticalSpacing(5),
//                             CouponsWidget(
//                               // date: data[index].dateCreated,
//                               date: DateTime.now(),
//                               username: user?.username ?? '',
//                               thumbnail: user?.profilePictureUrl ?? '',
//                               couponTitle: data[index].title,
//                               couponCode: data[index].code,
//                             ),
//                           ],
//                         ),
//                       );
//                     },
//                   ),

//                   // if (ref.watch(allCouponsSearchProvider).isEmptyOrNull)
//                   CouponsEndWidget(),
//                 ],
//               ),
//             ),
//           ),
//         );
//       return CustomErrorDialogWithScaffold(
//           onTryAgain: () => ref.refresh(userCouponsProvider(widget.username)),
//           title: "Coupons");
//     }, loading: () {
//       return const JobShimmerPage(showTrailing: false);
//     }, error: (error, stackTrace) {
//       return CustomErrorDialogWithScaffold(
//           onTryAgain: () => ref.refresh(userCouponsProvider(widget.username)),
//           title: "Coupons");
//     });
//   }
// }
