import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vmodel/src/shared/shimmer/marketplace_home_items_shimmer.dart';

import '../../../../core/utils/enum/upload_ratio_enum.dart';
import '../../../../res/res.dart';
import '../../../../vmodel.dart';
import '../../../dashboard/discover/models/mock_data.dart';
import '../../../dashboard/new_profile/profile_features/services/views/service_details_sub_list.dart';
import '../../../dashboard/new_profile/profile_features/services/views/view_all_services.dart';
import '../../../settings/views/booking_settings/controllers/recently_viewed_services_controller.dart';
import '../controller/jobs_controller.dart';
import '../controller/recently_viewed_jobs_controller.dart';
import '../controller/recommended_jobs.dart';
import '../controller/recommended_services.dart';
import '../controller/filtered_services_controller.dart';
import '../controller/remote_jobs_controller.dart';
import '../widget/carousel_with_close.dart';
import 'job_details_sub_list.dart';
import 'sub_all_jobs.dart';

class MarketplaceHome extends ConsumerStatefulWidget {
  const MarketplaceHome({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _MarketplaceHomeState();
}

class _MarketplaceHomeState extends ConsumerState<MarketplaceHome> {
  @override
  Widget build(BuildContext context) {
    final recentlyViewedServices = ref.watch(recentlyViewedServicesProvider);
    final recentlyViewedJobs = ref.watch(recentlyViewedJobsProvider);
    final recommendedServices = ref.watch(recommendedServicesProvider);
    final recommendedJobs = ref.watch(recommendedJobsProvider);
    final popularServices = ref.watch(popularServicesProvider);
    final popularJobs = ref.watch(popularJobsProvider);
    final remoteJobs = ref.watch(remoteJobsProvider);
    final remoteServices =
        ref.watch(filteredServicesProvider(FilteredService.remoteOnly()));
    final discountedServices =
        ref.watch(filteredServicesProvider(FilteredService.discountOnly()));

    return RefreshIndicator.adaptive(
      onRefresh: () async {
        HapticFeedback.lightImpact();
        ref.invalidate(filteredServicesProvider(FilteredService.remoteOnly()));
        ref.invalidate(
            filteredServicesProvider(FilteredService.discountOnly()));
        await ref.refresh(recommendedServicesProvider.future);
        await ref.refresh(popularServicesProvider.future);
        await ref.refresh(recommendedJobsProvider.future);
        await ref.refresh(popularJobsProvider.future);
      },
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            CarouselWithClose(
              aspectRatio: UploadAspectRatio.wide.ratio,
              padding: EdgeInsets.zero,
              autoPlay: true,
              height: 180,
              cornerRadius: 0,
              children:
                  List.generate(mockMarketPlaceHomeImages.length, (index) {
                return Container(
                  height: 180,
                  width: 90.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    image: DecorationImage(
                      image: AssetImage(mockMarketPlaceHomeImages[index]),
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                );
              }),
            ),
            addVerticalSpacing(16),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  recentlyViewedServices.when(
                    data: (data) {
                      if (data.isEmpty) return SizedBox.shrink();
                      return ServiceSubList(
                        isCurrentUser: false,
                        username: '',
                        items: data,
                        onTap: (value) {},
                        onViewAllTap: () => navigateToRoute(
                          context,
                          ViewAllServicesHomepage(
                              username: '', data: data, title: "Fast delivery"),
                        ),
                        title: 'Fast delivery',
                      );
                    },
                    error: (Object error, StackTrace stackTrace) {
                      return MarketplaceHomeItemsShimmerPage();
                    },
                    loading: () {
                      return MarketplaceHomeItemsShimmerPage();
                    },
                  ),
                  recentlyViewedServices.when(
                    data: (data) {
                      if (data.isEmpty) return SizedBox.shrink();
                      return ServiceSubList(
                        isCurrentUser: false,
                        username: '',
                        items: data,
                        onTap: (value) {},
                        onViewAllTap: () => navigateToRoute(
                          context,
                          ViewAllServicesHomepage(
                              username: '',
                              data: data,
                              title: "Recently viewed services"),
                        ),
                        title: 'Recently viewed services',
                      );
                    },
                    error: (Object error, StackTrace stackTrace) {
                      return MarketplaceHomeItemsShimmerPage();
                    },
                    loading: () {
                      return MarketplaceHomeItemsShimmerPage();
                    },
                  ),
                  recommendedServices.when(
                    data: (data) {
                      return ServiceSubList(
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
                      );
                    },
                    error: (Object error, StackTrace stackTrace) {
                      print('[ukmote] $error $stackTrace');
                      return MarketplaceHomeItemsShimmerPage();
                    },
                    loading: () {
                      return MarketplaceHomeItemsShimmerPage();
                    },
                  ),
                  popularServices.when(
                    data: (data) {
                      return ServiceSubList(
                        isCurrentUser: false,
                        username: 'markshire',
                        items: data,
                        onTap: (value) {},
                        onViewAllTap: () => navigateToRoute(
                          context,
                          ViewAllServicesHomepage(
                              username: 'markshire',
                              data: data,
                              title: "Popular services"),
                        ),
                        title: 'Popular services',
                      );
                    },
                    error: (Object error, StackTrace stackTrace) {
                      return MarketplaceHomeItemsShimmerPage();
                    },
                    loading: () {
                      return MarketplaceHomeItemsShimmerPage();
                    },
                  ),
                  remoteServices.when(
                    data: (data) {
                      return ServiceSubList(
                        isCurrentUser: false,
                        username: '',
                        items: data,
                        onTap: (value) {},
                        onViewAllTap: () => navigateToRoute(
                          context,
                          ViewAllServicesHomepage(
                            username: '',
                            data: data,
                            title: "Remote services",
                          ),
                        ),
                        title: 'Remote services',
                      );
                    },
                    error: (Object error, StackTrace stackTrace) {
                      return MarketplaceHomeItemsShimmerPage();
                    },
                    loading: () {
                      return MarketplaceHomeItemsShimmerPage();
                    },
                  ),
                  discountedServices.when(
                    data: (data) {
                      return ServiceSubList(
                        isCurrentUser: false,
                        username: '',
                        items: data,
                        onTap: (value) {},
                        onViewAllTap: () => navigateToRoute(
                          context,
                          ViewAllServicesHomepage(
                            username: '',
                            data: data,
                            title: "Discounted services",
                          ),
                        ),
                        title: 'Discounted services',
                      );
                    },
                    error: (Object error, StackTrace stackTrace) {
                      return MarketplaceHomeItemsShimmerPage();
                    },
                    loading: () {
                      return MarketplaceHomeItemsShimmerPage();
                    },
                  ),
                  // addVerticalSpacing(15),
                  recentlyViewedJobs.when(
                    data: (data) {
                      if (data.isEmpty) return SizedBox.shrink();
                      return JobSubList(
                        isCurrentUser: false,
                        items: data,
                        onViewAllTap: () => navigateToRoute(
                            context,
                            SubAllJobs(
                              jobs: data,
                              title: "Recently viewed jobs",
                            )),
                        onTap: (value) {},
                        title: 'Recently viewed jobs',
                        username: '',
                      );
                    },
                    error: (Object error, StackTrace stackTrace) {
                      return MarketplaceHomeItemsShimmerPage();
                    },
                    loading: () {
                      return MarketplaceHomeItemsShimmerPage();
                    },
                  ),
                  recommendedJobs.when(
                    data: (data) {
                      return JobSubList(
                        isCurrentUser: false,
                        items: data,
                        onViewAllTap: () => navigateToRoute(
                            context,
                            SubAllJobs(
                              jobs: data,
                              title: "Recommended jobs",
                            )),
                        onTap: (value) {},
                        title: 'Recommended jobs',
                        username: '',
                      );
                    },
                    error: (Object error, StackTrace stackTrace) {
                      return MarketplaceHomeItemsShimmerPage();
                    },
                    loading: () {
                      return MarketplaceHomeItemsShimmerPage();
                    },
                  ),
                  popularJobs.when(
                    data: (data) {
                      return JobSubList(
                        isCurrentUser: false,
                        items: data,
                        onViewAllTap: () => navigateToRoute(
                            context,
                            SubAllJobs(
                              jobs: data,
                              title: "Popular jobs",
                            )),
                        onTap: (value) {},
                        title: 'Popular jobs',
                        username: '',
                      );
                    },
                    error: (Object error, StackTrace stackTrace) {
                      return MarketplaceHomeItemsShimmerPage();
                    },
                    loading: () {
                      return MarketplaceHomeItemsShimmerPage();
                    },
                  ),
                  remoteJobs.when(
                    data: (data) {
                      return JobSubList(
                        isCurrentUser: false,
                        items: data,
                        onViewAllTap: () => navigateToRoute(
                            context,
                            SubAllJobs(
                              jobs: data,
                              title: "Remote jobs",
                            )),
                        onTap: (value) {},
                        title: 'Remote jobs',
                        username: '',
                      );
                    },
                    error: (Object error, StackTrace stackTrace) {
                      return MarketplaceHomeItemsShimmerPage();
                    },
                    loading: () {
                      return MarketplaceHomeItemsShimmerPage();
                    },
                  ),
                  popularJobs.when(
                    data: (data) {
                      return JobSubList(
                        isCurrentUser: false,
                        items: data,
                        onViewAllTap: () => navigateToRoute(
                            context,
                            SubAllJobs(
                              jobs: data,
                              title: "Highest rated sellers",
                            )),
                        onTap: (value) {},
                        title: 'Highest rated sellers',
                        username: '',
                      );
                    },
                    error: (Object error, StackTrace stackTrace) {
                      return MarketplaceHomeItemsShimmerPage();
                    },
                    loading: () {
                      return MarketplaceHomeItemsShimmerPage();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
