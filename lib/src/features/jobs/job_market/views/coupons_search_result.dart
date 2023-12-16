import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vmodel/src/core/utils/debounce.dart';
import 'package:vmodel/src/core/utils/validators_mixins.dart';
import 'package:vmodel/src/res/gap.dart';
import 'package:vmodel/src/shared/response_widgets/error_dialogue.dart';
import 'package:vmodel/src/vmodel.dart';
import '../../../../shared/shimmer/search_shimmer.dart';
import '../controller/coupons_controller.dart';
import '../widget/coupons_widget_simple.dart';

class CouponsSearchResult extends ConsumerStatefulWidget {
  const CouponsSearchResult({super.key});

  @override
  ConsumerState<CouponsSearchResult> createState() => _CouponsSimpleState();
}

class _CouponsSimpleState extends ConsumerState<CouponsSearchResult> {
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
    return allCouponsSimple.when(data: (data) {
      if (data.isNotEmpty)
        return Scaffold(
          body: SafeArea(
            top: false,
            child: CustomScrollView(
              // physics: const BouncingScrollPhysics(),
              physics: const AlwaysScrollableScrollPhysics(
                  parent: BouncingScrollPhysics()),
              controller: _scrollController,
              slivers: [
                if (data.isNotEmpty)
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
                if (data.isEmpty)
                  SliverToBoxAdapter(
                    child: Column(
                      children: [
                        addVerticalSpacing(100),
                        Text("No Coupon found")
                      ],
                    ),
                  ),
                if (ref.watch(allCouponsSearchProvider).isEmptyOrNull)
                  SliverToBoxAdapter(
                    child: Column(
                      children: [
                        addVerticalSpacing(100),
                        Text("No Coupon found")
                      ],
                    ),
                  ),
              ],
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
}
