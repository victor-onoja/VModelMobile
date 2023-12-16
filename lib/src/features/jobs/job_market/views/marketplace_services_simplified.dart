import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vmodel/src/core/controller/app_user_controller.dart';
import 'package:vmodel/src/core/utils/debounce.dart';
import 'package:vmodel/src/res/gap.dart';
import 'package:vmodel/src/vmodel.dart';
import '../../../../core/utils/costants.dart';
import '../../../../core/utils/enum/discover_category_enum.dart';
import '../../../../core/utils/enum/upload_ratio_enum.dart';
import '../../../dashboard/discover/models/mock_data.dart';
import '../../../dashboard/new_profile/profile_features/services/views/service_details_sub_list.dart';
import '../../../dashboard/new_profile/profile_features/services/views/view_all_services.dart';
import '../controller/category_services_controller.dart';
import '../controller/coupons_controller.dart';
import '../controller/recommended_services.dart';
import '../widget/carousel_with_close.dart';
import 'category_services.dart';
import 'local_services.dart';

class MarketPlaceServicesTabPage extends ConsumerStatefulWidget {
  const MarketPlaceServicesTabPage({super.key});
  static const routeName = 'allMarketPlaceServicesTabPage';

  @override
  ConsumerState<MarketPlaceServicesTabPage> createState() =>
      _MarketPlaceServicesTabPageState();
}

class _MarketPlaceServicesTabPageState
    extends ConsumerState<MarketPlaceServicesTabPage> {
  final TextEditingController _searchController = TextEditingController();
  late final Debounce _debounce;
  ScrollController _scrollController = ScrollController();
  DiscoverCategory? _discoverCategoryType = DiscoverCategory.values.first;

  @override
  void initState() {
    _debounce = Debounce(delay: Duration(milliseconds: 300));
    //Todo implement services pagination
    // _scrollController.addListener(() {
    //   final maxScroll = _scrollController.position.maxScrollExtent;
    //   final currentScroll = _scrollController.position.pixels;
    //   final delta = SizerUtil.height * 0.2;
    //   if (maxScroll - currentScroll <= delta) {
    //     _debounce(() {
    //       ref.read(allCouponsProvider.notifier).fetchMoreData();
    //     });
    //   }
    // });
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
    // final allMarketPlaceServicesTabPage = ref.watch(allCouponsProvider);
    final recommendedServices = ref.watch(recommendedServicesProvider);

    return RefreshIndicator.adaptive(
      onRefresh: () async {
        HapticFeedback.lightImpact();
        await ref.refresh(recommendedServicesProvider.future);
      },
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(
            parent: BouncingScrollPhysics()),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          CarouselWithClose(
            aspectRatio: UploadAspectRatio.wide.ratio,
            padding: EdgeInsets.zero,
            autoPlay: false,
            height: 180,
            cornerRadius: 0,
            children:
                List.generate(mockMarketPlaceServicesImages.length, (index) {
              return GestureDetector(
                onTap: () {
                  if (index == 1) {
                    navigateCategoryServices('Photography');
                  }
                  if (index == 2) {
                    navigateCategoryServices('Modelling');
                  }
                },
                child: Container(
                  height: 180,
                  width: 90.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    image: DecorationImage(
                      image: AssetImage(mockMarketPlaceServicesImages[index]),
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
              );
            }),
          ),
          addVerticalSpacing(16),
          recommendedServices.when(
            data: (data) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: ServiceSubList(
                  isCurrentUser: false,
                  username: '',
                  items: data,
                  onTap: (value) {},
                  onViewAllTap: () => navigateToRoute(
                    context,
                    ViewAllServicesHomepage(
                      username: '',
                      data: data,
                      title: "Recommended services",
                    ),
                  ),
                  title: 'Recommended services',
                ),
              );
            },
            error: (Object error, StackTrace stackTrace) {
              return Text("Error");
            },
            loading: () {
              return CircularProgressIndicator.adaptive();
            },
          ),
          // SizedBox(
          //   height: 200,
          //   child: ListView.separated(
          //     shrinkWrap: true,
          //     physics: BouncingScrollPhysics(),
          //     scrollDirection: Axis.horizontal,
          //     padding: EdgeInsets.symmetric(horizontal: 16),
          //     itemCount: mockMarketPlaceImages.length,
          //     separatorBuilder: (context, index) {
          //       return SizedBox(width: 20);
          //     },
          //     itemBuilder: (context, index) {
          //       return GestureDetector(
          //         onTap: () {
          //           if (index == 0)
          //             navigateToRoute(context, const PopularFAQsHomepage());
          //         },
          //         child: Container(
          //           width: 150,
          //           // margin: EdgeInsets.symmetric(
          //           //     horizontal: 16, vertical: 8),
          //           clipBehavior: Clip.hardEdge,
          //           decoration: BoxDecoration(
          //             color: Colors.black,
          //             borderRadius: BorderRadius.circular(5),
          //           ),
          //           child: Image.asset(
          //             mockMarketPlaceImages[index],
          //             fit: BoxFit.cover,
          //           ),
          //         ),
          //       );
          //     },
          //   ),
          // ),
          // const SizedBox(height: 20),
          ListView.separated(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 16),
            itemCount: VConstants.tempCategories.length + 1,
            separatorBuilder: (context, index) {
              return Divider();
            },
            itemBuilder: (context, index) {
              if (index == 0)
                return GestureDetector(
                  onTap: () {
                    navigateToRoute(context, LocalServices());
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    color: Colors.transparent,
                    child: Text(
                      "All ${DiscoverCategory.service.shortName}",
                      style:
                          Theme.of(context).textTheme.displayMedium?.copyWith(
                                fontWeight: FontWeight.w500,
                              ),
                    ),
                  ),
                );
              return GestureDetector(
                onTap: () => navigateCategoryServices(
                    VConstants.tempCategories[index - 1]),
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  color: Colors.transparent,
                  child: Text(
                    VConstants.tempCategories[index - 1],
                    style: Theme.of(context).textTheme.displayMedium?.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                ),
              );
            },
          ),
          addVerticalSpacing(10),
          // Padding(
          //   padding: EdgeInsets.symmetric(horizontal: 16),
          //   child: Text("Sponsored",
          //       style: Theme.of(context).textTheme.displayLarge?.copyWith(
          //             color: Theme.of(context).primaryColor.withOpacity(0.3),
          //           )),
          // ),
          // addVerticalSpacing(20),
          // CarouselWithClose(
          //   aspectRatio: UploadAspectRatio.square.ratio,
          // ),
          addVerticalSpacing(10),
        ]),
      ),
    );
  }

  void navigateCategoryServices(String category) {
    ref.read(selectedCategoryServiceProvider.notifier).state = category;
    navigateToRoute(context, CategoryServices(title: category));
  }
}
