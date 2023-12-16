import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vmodel/src/core/controller/app_user_controller.dart';
import 'package:vmodel/src/core/utils/helper_functions.dart';
import 'package:vmodel/src/features/dashboard/new_profile/profile_features/services/widgets/service_sub_item.dart';
import 'package:vmodel/src/features/jobs/job_market/views/search_field.dart';
import 'package:vmodel/src/res/gap.dart';
import 'package:vmodel/src/res/icons.dart';
import 'package:vmodel/src/shared/appbar/appbar.dart';
import 'package:vmodel/src/shared/rend_paint/render_svg.dart';
import 'package:vmodel/src/vmodel.dart';

import '../../../../core/models/app_user.dart';
import '../../../../core/utils/debounce.dart';
import '../../../../shared/shimmer/jobShimmerPage.dart';
import '../../../dashboard/new_profile/profile_features/services/views/new_service_detail.dart';
import '../../../dashboard/new_profile/profile_features/services/widgets/services_card_widget.dart';
import '../controller/category_services_controller.dart';

class CategoryServices extends ConsumerStatefulWidget {
  const CategoryServices({required this.title, super.key});
  final String title;

  @override
  ConsumerState<CategoryServices> createState() => _CategoryServicesState();
}

class _CategoryServicesState extends ConsumerState<CategoryServices> {
  // String selectedVal1 = "Photographers";
  // String selectedVal2 = "Models";
  // final selectedPanel = ValueNotifier<String>('jobs');
  final TextEditingController _searchController = TextEditingController();
  bool showGrid = true;
  bool isDataNotNullOrEmpty = false;

  ScrollController _scrollController = ScrollController();
  final _debounce = Debounce();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      final maxScroll = _scrollController.position.maxScrollExtent;
      final currentScroll = _scrollController.position.pixels;
      final delta = SizerUtil.height * 0.2;
      if (maxScroll - currentScroll <= delta) {
        _debounce(() {
          ref.read(categoryServicesProvider.notifier).fetchMoreData();
        });
      }
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
    final categoryServices = ref.watch(categoryServicesProvider);
    VAppUser? user;

    final appUser = ref.watch(appUserProvider);
    user = appUser.valueOrNull;
    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator.adaptive(
          onRefresh: () async {
            HapticFeedback.lightImpact();
            await ref.refresh(categoryServicesProvider.future);
          },
          child: categoryServices.when(data: (data) {
            if (data != null || data!.isNotEmpty)
              return CustomScrollView(
                // physics: const BouncingScrollPhysics(),
                physics: const AlwaysScrollableScrollPhysics(
                    parent: BouncingScrollPhysics()),
                controller: _scrollController,
                slivers: [
                  SliverAppBar(
                    expandedHeight: 125.0,
                    elevation: 0,
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    leading: const VWidgetsBackButton(),
                    flexibleSpace: FlexibleSpaceBar(background: _titleSearch()),
                    floating: true,
                    pinned: true,
                    title: Text(
                      "${widget.title} Services",
                      style: Theme.of(context).textTheme.displayLarge!.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    actions: [
                      IconButton(
                        onPressed: () {},
                        icon: GestureDetector(
                          onTap: () {
                            showGrid == true
                                ? setState(() {
                                    showGrid = false;
                                  })
                                : setState(() {
                                    showGrid = true;
                                  });
                          },
                          child: showGrid
                              ? RenderSvg(
                                  svgPath: VIcons.viewSwitch,
                                )
                              : RotatedBox(
                                  quarterTurns: 2,
                                  child: RenderSvg(
                                    svgPath: VIcons.viewSwitch,
                                  ),
                                ),
                        ),
                      ),
                    ],
                  ),
                  if (showGrid)
                    SliverPadding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      sliver: SliverGrid.builder(
                        itemCount: data.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 20,
                          childAspectRatio: 0.65,
                        ),
                        itemBuilder: (BuildContext context, int index) {
                          return ServiceSubItem(
                            user: user!,
                            item: data[index],
                            onTap: () => navigateToRoute(
                              context,
                              ServicePackageDetail(
                                service: data[index],
                                isCurrentUser: false,
                                username: "username",
                              ),
                            ),
                            onLongPress: () {},
                          );
                        },
                      ),
                    ),
                  if (!showGrid)
                    SliverPadding(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      sliver: SliverList.separated(
                        itemCount: data.length ?? 0,
                        separatorBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16),
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
                                : null,
                            // serviceDescription:data[index].description,
                            serviceType: data[index]
                                .servicePricing
                                .tileDisplayName, // Add your service type logic here
                            serviceLocation: data[index].serviceType.simpleName,
                            serviceCharge: data[index].price,
                            showDescription: showGrid,
                            discount: data[index].percentDiscount ?? 0,
                            serviceDescription: data[index].description,
                            date:
                                data[index].createdAt.getSimpleDateOnJobCard(),
                          );
                        }),
                        // children: [
                        //   addVerticalSpacing(20),
                        //   for (int index = 0; index < data!.length; index++)
                        // ],
                      ),
                    ),
                ],
              );

            return Scaffold(
              appBar: VWidgetsAppBar(
                appbarTitle: "${widget.title} Services",
                leadingIcon: const VWidgetsBackButton(),
              ),
              body: RefreshIndicator.adaptive(
                color: Theme.of(context).primaryColor,
                onRefresh: () async {
                  ref.invalidate(categoryServicesProvider);
                },
                child: Center(
                  child: ListView(
                    children: [
                      addVerticalSpacing(300),
                      Center(
                        child: Text(
                          "No jobs here..\nPull down to refresh",
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.displayMedium,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          }, loading: () {
            return const JobShimmerPage();
          }, error: (error, stackTrace) {
            return Center(child: Text("Error: $error"));
          }),
        ),
      ),
    );
  }

  Widget _titleSearch() {
    return SafeArea(
      child: Column(
        children: [
          addVerticalSpacing(60),
          Flexible(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    flex: 3,
                    child: SearchTextFieldWidget(
                      showInputBorder: false,
                      hintText: "Eg: Model Wanted",
                      controller: _searchController,
                      enabledBorder: InputBorder.none,
                      onChanged: (val) {
                        _debounce(() {
                          ref
                              .read(categoryServiceSearchProvider.notifier)
                              .state = val;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          addVerticalSpacing(20)
        ],
      ),
    );
  }
}
