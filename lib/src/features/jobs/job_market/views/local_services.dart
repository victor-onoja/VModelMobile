import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:vmodel/src/core/controller/app_user_controller.dart';
import 'package:vmodel/src/core/models/app_user.dart';
import 'package:vmodel/src/core/utils/helper_functions.dart';
import 'package:vmodel/src/core/utils/validators_mixins.dart';
import 'package:vmodel/src/features/dashboard/feed/widgets/share.dart';
import 'package:vmodel/src/features/dashboard/new_profile/profile_features/services/models/user_service_modal.dart';
import 'package:vmodel/src/features/dashboard/new_profile/profile_features/services/widgets/service_sub_item.dart';
import 'package:vmodel/src/features/jobs/job_market/views/filter_bottom_sheet.dart';
import 'package:vmodel/src/features/jobs/job_market/views/search_field.dart';
import 'package:vmodel/src/features/jobs/job_market/views/sort_bottom_sheet.dart';
import 'package:vmodel/src/res/assets/app_asset.dart';
import 'package:vmodel/src/res/gap.dart';
import 'package:vmodel/src/res/icons.dart';
import 'package:vmodel/src/shared/rend_paint/render_svg.dart';
import 'package:vmodel/src/vmodel.dart';

import '../../../../core/utils/debounce.dart';
import '../../../../shared/response_widgets/error_dialogue.dart';
import '../../../../shared/shimmer/jobShimmerPage.dart';
import '../../../dashboard/new_profile/profile_features/services/views/new_service_detail.dart';
import '../../../dashboard/new_profile/profile_features/services/widgets/services_card_widget.dart';
import '../../../settings/views/booking_settings/controllers/user_service_controller.dart';
import '../../../settings/views/booking_settings/models/service_package_model.dart';
import '../controller/local_services_controller.dart';
import '../widget/services_end_widget.dart';

class LocalServices extends ConsumerStatefulWidget {
  const LocalServices({super.key, this.title});
  static const routeName = 'localServices';
  final String? title;

  @override
  ConsumerState<LocalServices> createState() => _LocalServicesState();
}

class _LocalServicesState extends ConsumerState<LocalServices> {
  String selectedVal1 = "Photographers";
  String selectedVal2 = "Models";
  final selectedPanel = ValueNotifier<String>('jobs');
  final TextEditingController _searchController = TextEditingController();
  bool showGrid = true;
  bool _hideFloatingButton = true;
  bool enableLargeTile = false;

  ScrollController _scrollController = ScrollController();
  final _debounce = Debounce();
  List<Map<String, dynamic>> sortByList = [
    {'sort': 'Top Rated First', 'selected': false},
    {'sort': 'Suggested', 'selected': false},
    {'sort': 'Closest First', 'selected': false},
    {'sort': 'Newest First', 'selected': false},
    {'sort': 'Price: Lowest First', 'selected': false},
    {'sort': 'Price: Highest First', 'selected': false},
  ];

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      final maxScroll = _scrollController.position.maxScrollExtent;
      final currentScroll = _scrollController.position.pixels;
      final delta = SizerUtil.height * 0.2;
      if (maxScroll - currentScroll <= delta) {
        _debounce(() {
          ref.read(allServicesProvider.notifier).fetchMoreData();
        });
      }
      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        // Scrolling up
        if (_hideFloatingButton) {
          setState(() {
            _hideFloatingButton = false;
          });
        }
      } else if (_scrollController.position.userScrollDirection ==
          ScrollDirection.idle) {
        if (!_hideFloatingButton)
          setState(() {
            _hideFloatingButton = true;
          });
      } else {
        // Scrolling down or not scrolling
        if (!_hideFloatingButton) {
          setState(() {
            _hideFloatingButton = true;
          });
        }
      }
    });
  }

  sortService(int index, List<ServicePackageModel> data) async {
    setState(() {
      for (var data in sortByList) {
        data['selected'] = false;
      }
      sortByList[index]["selected"] = true;
    });

    print(sortByList[index]['sort'].toLowerCase());
    if (sortByList[index]['sort'].toLowerCase() == 'newest first') {
      return data.sort((a, b) {
        return a.createdAt.compareTo(b.createdAt);
      });
    }

    if (sortByList[index]['sort'].toLowerCase() == 'price: lowest first') {
      return data.sort((a, b) {
        return a.price.compareTo(b.price);
      });
    }

    if (sortByList[index]['sort'].toLowerCase() == 'price: highest first') {
      return data.sort((a, b) {
        return b.price.compareTo(a.price);
      });
    }
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
    VAppUser? user;
    final appUser = ref.watch(appUserProvider);

    user = appUser.valueOrNull;
    return allServices.when(data: (data) {
      if (data != null)
        return Scaffold(
          body: SafeArea(
            child: RefreshIndicator.adaptive(
              onRefresh: () async {
                HapticFeedback.lightImpact();
                await ref.refresh(allServicesProvider.future);
              },
              child: CustomScrollView(
                // physics: const BouncingScrollPhysics(),
                physics: const AlwaysScrollableScrollPhysics(
                    parent: BouncingScrollPhysics()),
                controller: _scrollController,
                slivers: [
                  SliverAppBar(
                    expandedHeight: 140.0,
                    elevation: 0,
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    leading: const VWidgetsBackButton(),
                    flexibleSpace: FlexibleSpaceBar(background: _titleSearch()),
                    centerTitle: true,
                    title: Text(
                      widget.title ?? "Local Services",
                      style: Theme.of(context).textTheme.displayLarge!.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    floating: true,
                    pinned: true,
                    actions: [
                      if (!showGrid)
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: GestureDetector(
                            onTap: () {
                              enableLargeTile = !enableLargeTile;
                              setState(() {});
                            },
                            child: enableLargeTile
                                ? RenderSvg(
                                    svgPath: VIcons.jobTileModeIcon,
                                  )
                                : RotatedBox(
                                    quarterTurns: 2,
                                    child: RenderSvg(
                                      svgPath: VIcons.jobTileModeIcon,
                                    ),
                                  ),
                          ),
                        ),
                      Padding(
                        padding: const EdgeInsets.only(right: 2),
                        child: GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                              isScrollControlled: true,
                              isDismissible: true,
                              useRootNavigator: true,
                              backgroundColor: Colors.transparent,
                              context: context,
                              builder: (context) => Container(
                                decoration: BoxDecoration(
                                  color:
                                      Theme.of(context).scaffoldBackgroundColor,
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(13),
                                    topRight: Radius.circular(13),
                                  ),
                                ),
                                child: ServiceSortBottomSheet(
                                  sortByList: sortByList,
                                  onSelectSort: (int index) async {
                                    sortService(index, data);
                                    setState(() {});
                                    Navigator.pop(context);
                                  },
                                ),
                              ),
                            );
                          },
                          child: RenderSvg(
                            svgPath: VIcons.funnel,
                            svgHeight: 13,
                            svgWidth: 13,
                            color: Theme.of(context).iconTheme.color,
                          ),
                        ),
                      ),
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
                  if (data.isNotEmpty)
                    if (showGrid)
                      SliverPadding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        sliver: SliverGrid.builder(
                          itemCount: data.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
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
                                  username: user!.username,
                                ),
                              ),
                              onLongPress: () {},
                            );
                          },
                        ),
                      ),
                  if (data.isNotEmpty)
                    if (!showGrid)
                      SliverPadding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        sliver: SliverList.separated(
                          itemCount: data.length,
                          separatorBuilder: (context, index) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: Divider(),
                            );
                          },
                          itemBuilder: ((context, index) {
                            return Slidable(
                              enabled:
                                  user!.username != data[index].user!.username,
                              endActionPane: ActionPane(
                                  extentRatio: .5,
                                  motion: const StretchMotion(),
                                  children: [
                                    if (user.username !=
                                        data[index].user!.username)
                                      SlidableAction(
                                        onPressed: (context) {
                                          showModalBottomSheet(
                                            isScrollControlled: true,
                                            isDismissible: true,
                                            useRootNavigator: true,
                                            backgroundColor: Colors.transparent,
                                            context: context,
                                            builder: (context) => ShareWidget(
                                              shareLabel: 'Share Service',
                                              shareTitle:
                                                  "${data[index].title}",
                                              shareImage:
                                                  VmodelAssets2.imageContainer,
                                              shareURL:
                                                  "Vmodel.app/job/tilly's-bakery-services",
                                            ),
                                          );
                                        },
                                        foregroundColor: Colors.white,
                                        backgroundColor: const Color.fromARGB(
                                            255, 224, 224, 224),
                                        label: 'Share',
                                      ),
                                    if (user.username !=
                                        data[index].user!.username)
                                      SlidableAction(
                                        onPressed: (context) async {
                                          print('successfully saved service');
                                          await ref
                                              .read(userServicePackagesProvider(
                                                  UserServiceModel(
                                                serviceId: data[index].id,
                                                username: user!.username,
                                              )).notifier)
                                              .saveService(data[index].id);
                                        },
                                        foregroundColor: Colors.white,
                                        backgroundColor: Colors.grey,
                                        label: 'Save',
                                      ),
                                  ]),
                              child: VWidgetsServicesCardWidget(
                                onTap: () {
                                  navigateToRoute(
                                      context,
                                      ServicePackageDetail(
                                        service: data[index],
                                        isCurrentUser: false,
                                        username:
                                            '${data[index].user?.username}',
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
                                serviceLocation:
                                    data[index].serviceType.simpleName,
                                serviceCharge: data[index].price,
                                showDescription: enableLargeTile,
                                discount: data[index].percentDiscount ?? 0,
                                serviceDescription: data[index].description,
                                date: data[index]
                                    .createdAt
                                    .getSimpleDateOnJobCard(),
                              ),
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
                          Text("No service available")
                        ],
                      ),
                    ),
                  if (ref.watch(allServiceSearchProvider).isEmptyOrNull)
                    ServicesEndWidget(),
                ],
              ),
            ),
          ),
          floatingActionButton: _hideFloatingButton
              ? null
              : FloatingActionButton(
                  backgroundColor: Theme.of(context).primaryColor,
                  onPressed: () {},
                  child: IconButton(
                    onPressed: () {
                      showModalBottomSheet(
                        isScrollControlled: true,
                        isDismissible: true,
                        useRootNavigator: true,
                        backgroundColor: Colors.transparent,
                        context: context,
                        builder: (context) => Container(
                          // height: 500,
                          decoration: BoxDecoration(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(13),
                              topRight: Radius.circular(13),
                            ),
                          ),
                          // color: VmodelColors.white,
                          child: const JobMarketFilterBottomSheet(),
                        ),
                      );
                    },
                    icon: RenderSvg(
                      svgPath: VIcons.filterIcon,
                      color: Theme.of(context).scaffoldBackgroundColor,
                    ),
                  ),
                ),
        );

      return CustomErrorDialogWithScaffold(
        onTryAgain: () => ref.invalidate(allServicesProvider),
        title: "Local Services",
      );
    }, loading: () {
      return const JobShimmerPage(showTrailing: true);
    }, error: (error, stackTrace) {
      print("jkcnwe $error $stackTrace");
      return CustomErrorDialogWithScaffold(
        onTryAgain: () => ref.invalidate(allServicesProvider),
        title: "Local Services",
      );
    });
  }

  Widget _titleSearch() {
    return SafeArea(
      child: Column(
        children: [
          addVerticalSpacing(60),
          Flexible(
            child: Container(
              //padding: const VWidgetsPagePadding.horizontalSymmetric(18),
              margin: const EdgeInsets.symmetric(horizontal: 24),
              // padding: const EdgeInsets.only(top: 12),
              alignment: Alignment.bottomCenter,

              child: ValueListenableBuilder(
                  valueListenable: selectedPanel,
                  builder: (context, value, child) {
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          flex: 3,
                          child: SearchTextFieldWidget(
                            showInputBorder: false,
                            hintText: value == 'jobs'
                                ? "Eg: Last minute stylists needed ASAP"
                                : "Eg: Model Wanted",
                            controller: _searchController,
                            enabledBorder: InputBorder.none,
                            onChanged: (val) {
                              _debounce(() {
                                ref
                                    .read(allServiceSearchProvider.notifier)
                                    .state = val;
                              });
                            },
                          ),
                        ),
                      ],
                    );
                  }),
            ),
          ),
          addVerticalSpacing(20)
        ],
      ),
    );
  }
}
