import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vmodel/src/core/utils/debounce.dart';
import 'package:vmodel/src/core/utils/validators_mixins.dart';
import 'package:vmodel/src/features/jobs/job_market/views/coupon_end_widget.dart';
import 'package:vmodel/src/features/jobs/job_market/widget/coupons_widget.dart';
import 'package:vmodel/src/res/gap.dart';
import 'package:vmodel/src/shared/response_widgets/error_dialogue.dart';
import 'package:vmodel/src/vmodel.dart';
import '../../../../shared/shimmer/jobShimmerPage.dart';
import '../controller/coupons_controller.dart';

class Coupons extends ConsumerStatefulWidget {
  const Coupons({super.key});
  static const routeName = 'allCoupons';

  @override
  ConsumerState<Coupons> createState() => _CouponsState();
}

class _CouponsState extends ConsumerState<Coupons> {
  final TextEditingController _searchController = TextEditingController();
  late final Debounce _debounce;
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    _debounce = Debounce(delay: Duration(milliseconds: 300));
    _scrollController.addListener(() {
      final maxScroll = _scrollController.position.maxScrollExtent;
      final currentScroll = _scrollController.position.pixels;
      final delta = SizerUtil.height * 0.2;
      if (maxScroll - currentScroll <= delta) {
        _debounce(() {
          ref.read(allCouponsProvider.notifier).fetchMoreData();
        });
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
    _debounce.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final allCoupons = ref.watch(allCouponsProvider);
    return allCoupons.when(data: (data) {
      if (data.isNotEmpty)
        return Scaffold(
          body: SafeArea(
            top: false,
            child: RefreshIndicator.adaptive(
              onRefresh: () async {
                HapticFeedback.lightImpact();
                await ref.refresh(allCouponsProvider.future);
              },
              child: CustomScrollView(
                // physics: const BouncingScrollPhysics(),
                physics: const AlwaysScrollableScrollPhysics(
                    parent: BouncingScrollPhysics()),
                controller: _scrollController,
                slivers: [
                  // SliverAppBar(
                  //   expandedHeight: 120.0,
                  //   elevation: 0,
                  //   backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  //   leading: const VWidgetsBackButton(),
                  //   flexibleSpace: FlexibleSpaceBar(background: _titleSearch()),
                  //   floating: true,
                  //   pinned: true,
                  // ),
                  SliverList.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Column(
                          children: [
                            addVerticalSpacing(5),
                            CouponsWidget(
                              date: data[index].dateCreated,
                              username: data[index].owner!.username!,
                              thumbnail: data[index].owner!.profilePictureUrl!,
                              couponId: data[index].id!,
                              couponTitle: data[index].title!,
                              couponCode: data[index].code!,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  if (ref.watch(allCouponsSearchProvider).isEmptyOrNull)
                    CouponsEndWidget(),
                ],
              ),
            ),
          ),
        );
      return CustomErrorDialogWithScaffold(
          onTryAgain: () => ref.refresh(allCouponsProvider), title: "Coupons");
    }, loading: () {
      return const JobShimmerPage(showTrailing: false);
    }, error: (error, stackTrace) {
      return CustomErrorDialogWithScaffold(
          onTryAgain: () => ref.refresh(allCouponsProvider), title: "Coupons");
    });
  }

  // Widget _titleSearch() {
  //   return SafeArea(
  //     child: Column(
  //       children: [
  //         addVerticalSpacing(60),
  //         Padding(
  //           padding: const EdgeInsets.symmetric(horizontal: 13),
  //           child: Row(
  //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //             children: [
  //               Text(
  //                 "Coupons",
  //                 style: Theme.of(context).textTheme.displayLarge!.copyWith(
  //                       fontWeight: FontWeight.w600,
  //                       color: Theme.of(context).primaryColor,
  //                       fontSize: 16.sp,
  //                     ),
  //               ),
  //             ],
  //           ),
  //         ),
  //         Flexible(
  //           child: Container(
  //             //padding: const VWidgetsPagePadding.horizontalSymmetric(18),
  //             margin: const EdgeInsets.symmetric(horizontal: 15),
  //             // padding: const EdgeInsets.only(top: 22),
  //             decoration: BoxDecoration(
  //               border: Border(
  //                 bottom: BorderSide(
  //                     color: Theme.of(context).primaryColor, width: 2),
  //               ),
  //             ),
  //             child: Row(
  //               children: [
  //                 Expanded(
  //                   flex: 3,
  //                   child: SearchTextFieldWidget(
  //                     showInputBorder: false,
  //                     hintText: "Eg: Last minute stylists needed ASAP",
  //                     controller: _searchController,
  //                     enabledBorder: InputBorder.none,
  //                     onTap: () {
  //                       if (_searchController.text.isNotEmpty) {
  //                         // ref.read(
  //                         //     allCouponsProvider(_searchController.text.trim())
  //                         //         .notifier);
  //                       }
  //                     },
  //                     onChanged: (val) {
  //                       // ref.read(allCouponsProvider(val).notifier);
  //                       _debounce(
  //                         () {
  //                           ref.read(allCouponsSearchProvider.notifier).state =
  //                               val;
  //                         },
  //                       );

  //                       setState(() {});
  //                     },
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ),
  //         // addVerticalSpacing(0)
  //       ],
  //     ),
  //   );
  // }
}
