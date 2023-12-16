import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vmodel/src/core/utils/helper_functions.dart';
import 'package:vmodel/src/core/utils/validators_mixins.dart';
import 'package:vmodel/src/res/gap.dart';
import 'package:vmodel/src/vmodel.dart';

import '../../../../core/utils/debounce.dart';
import '../../../../shared/response_widgets/error_dialogue.dart';
import '../../../../shared/shimmer/search_shimmer.dart';
import '../../../dashboard/new_profile/profile_features/services/views/new_service_detail.dart';
import '../../../dashboard/new_profile/profile_features/services/widgets/services_card_widget.dart';
import '../controller/local_services_controller.dart';
import '../widget/services_end_widget.dart';

class ServicesSearchResult extends ConsumerStatefulWidget {
  const ServicesSearchResult({super.key});
  static const routeName = 'localServices';

  @override
  ConsumerState<ServicesSearchResult> createState() => _LocalServicesState();
}

class _LocalServicesState extends ConsumerState<ServicesSearchResult> {
  final selectedPanel = ValueNotifier<String>('jobs');
  bool enableLargeTile = false;

  ScrollController _scrollController = ScrollController();
  final _debounce = Debounce();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      final maxScroll = _scrollController.position.maxScrollExtent;
      final currentScroll = _scrollController.position.pixels;
      // final delta = SizerUtil.height * 0.2;
      // if (maxScroll - currentScroll <= delta) {
      //   _debounce(() {
      //     ref.read(allServicesProvider.notifier).fetchMoreData();
      //   });
      // }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
    _debounce.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final allServices = ref.watch(allServicesProvider);
    return allServices.when(data: (data) {
      if (data != null)
        return Scaffold(
          body: CustomScrollView(
            // physics: const BouncingScrollPhysics(),
            physics: const AlwaysScrollableScrollPhysics(
                parent: BouncingScrollPhysics()),
            controller: _scrollController,
            slivers: [
              if (data.isNotEmpty)
                SliverPadding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  sliver: SliverList.separated(
                    itemCount: data.length,
                    separatorBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Divider(),
                      );
                    },
                    itemBuilder: ((context, index) {
                      return VWidgetsServicesCardWidget(
                        onTap: () {
                          navigateToRoute(
                              context,
                              ServicePackageDetail(
                                service: data[index],
                                isCurrentUser: false,
                                username: '${data[index].user?.username}',
                              ));
                        },
                        serviceLikes: data[index].likes,
                        serviceName: data[index].title,
                        // bannerUrl: data[index].bannerUrl,
                        bannerUrl: data[index].banner.length > 0
                            ? data[index].banner.first.thumbnail
                            : data[index].user!.thumbnailUrl ??
                                data[index].user!.profilePictureUrl,
                        // serviceDescription:data[index].description,
                        serviceType: data[index]
                            .servicePricing
                            .tileDisplayName, // Add your service type logic here
                        serviceLocation: data[index].serviceType.simpleName,
                        serviceCharge: data[index].price,
                        showDescription: enableLargeTile,
                        discount: data[index].percentDiscount ?? 0,
                        serviceDescription: data[index].description,
                        date: data[index].createdAt.getSimpleDateOnJobCard(),
                      );
                    }),
                    // children: [
                    //   addVerticalSpacing(20),
                    //   for (int index = 0; index < data!.length; index++)
                    // ],
                  ),
                ),
              if (data.isEmpty)
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      addVerticalSpacing(100),
                      Text("No service found")
                    ],
                  ),
                ),
              if (ref.watch(allServiceSearchProvider).isEmptyOrNull)
                ServicesEndWidget(),
            ],
          ),
        );

      return CustomErrorDialogWithScaffold(
        onTryAgain: () => ref.refresh(allServicesProvider),
        title: "Local Services",
      );
    }, loading: () {
      return const SearchShimmerPage();
    }, error: (error, stackTrace) {
      print("jkcnwe $error $stackTrace");
      return CustomErrorDialogWithScaffold(
        onTryAgain: () => ref.refresh(allServicesProvider),
        title: "Local Services",
      );
    });
  }
}
