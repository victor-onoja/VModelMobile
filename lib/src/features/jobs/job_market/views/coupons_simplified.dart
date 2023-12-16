import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vmodel/src/core/utils/debounce.dart';
import 'package:vmodel/src/core/utils/validators_mixins.dart';
import 'package:vmodel/src/features/jobs/job_market/views/coupon_end_widget.dart';
import 'package:vmodel/src/res/gap.dart';
import 'package:vmodel/src/shared/response_widgets/error_dialogue.dart';
import 'package:vmodel/src/shared/shimmer/search_shimmer.dart';
import 'package:vmodel/src/vmodel.dart';
import '../controller/coupons_controller.dart';
import '../widget/coupons_widget_simple.dart';
import '../widget/hottest_coupon_tile.dart';

class CouponsSimple extends ConsumerStatefulWidget {
  const CouponsSimple({super.key});
  static const routeName = 'allCouponsSimple';

  @override
  ConsumerState<CouponsSimple> createState() => _CouponsSimpleState();
}

class _CouponsSimpleState extends ConsumerState<CouponsSimple> {
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
    final allCouponsSimple = ref.watch(allCouponsProvider);
    final hottestCouponsSimple = ref.watch(hottestCouponsProvider);
    return allCouponsSimple.when(data: (data) {
      if (data.isNotEmpty)
        return Scaffold(
          body: SafeArea(
            top: false,
            child: RefreshIndicator.adaptive(
              onRefresh: () async {
                HapticFeedback.lightImpact();
                await ref.refresh(allCouponsProvider.future);
                await ref.refresh(hottestCouponsProvider.future);
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
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Hottest coupons',
                            style: context.textTheme.displayMedium!.copyWith(
                              fontWeight: FontWeight.w600,
                              // color: VmodelColors.mainColor,
                              // color: Theme.of(context).colorScheme.onPrimary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                      child: Container(
                    height: 100,
                    margin: EdgeInsets.only(bottom: 16),
                    child: hottestCouponsSimple.maybeWhen(data: (value) {
                      if (value.isEmpty)
                        return Padding(
                          padding: const EdgeInsets.all(16),
                          child: Text(
                            "No data for hottest coupons.",
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(),
                          ),
                        );
                      return ListView.separated(
                          scrollDirection: Axis.horizontal,
                          physics: BouncingScrollPhysics(),
                          itemCount: value.length,
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          separatorBuilder: (context, index) {
                            return addHorizontalSpacing(8);
                          },
                          itemBuilder: (context, index) {
                            return HottestCouponTile(
                              index: index,
                              date: value[index].dateCreated,
                              username: value[index].owner!.username!,
                              thumbnail: value[index].owner!.profilePictureUrl!,
                              couponId: value[index].id!,
                              couponTitle: value[index].title!,
                              couponCode: value[index].code!,
                            );
                          });
                    }, orElse: () {
                      return Text('Error fetching data');
                    }),
                  )),
                  SliverList.separated(
                    itemCount: data.length,
                    separatorBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Divider(),
                      );
                    },
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Column(
                          children: [
                            addVerticalSpacing(5),
                            CouponsWidgetSimple(
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
        onTryAgain: () => ref.refresh(allCouponsProvider),
        title: "Coupons",
        showAppbar: false,
      );
    }, loading: () {
      return const SearchShimmerPage();
    }, error: (error, stackTrace) {
      return CustomErrorDialogWithScaffold(
        onTryAgain: () => ref.refresh(allCouponsProvider),
        title: "Coupons",
        showAppbar: false,
      );
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
  //                 "CouponsSimple",
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
