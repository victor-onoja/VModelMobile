import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vmodel/src/core/utils/helper_functions.dart';
import 'package:vmodel/src/features/dashboard/new_profile/profile_features/services/widgets/service_sub_item.dart';
import 'package:vmodel/src/features/dashboard/new_profile/profile_features/services/widgets/services_card_widget.dart';
import 'package:vmodel/src/features/dashboard/profile/controller/profile_controller.dart';
import 'package:vmodel/src/features/jobs/job_market/views/local_services.dart';
import 'package:vmodel/src/features/jobs/job_market/views/sort_bottom_sheet.dart';
import 'package:vmodel/src/features/settings/views/booking_settings/models/service_package_model.dart';
import 'package:vmodel/src/res/icons.dart';
import 'package:vmodel/src/shared/buttons/primary_button.dart';
import 'package:vmodel/src/shared/rend_paint/render_svg.dart';
import 'package:vmodel/src/vmodel.dart';

import '../../../../../../core/controller/app_user_controller.dart';
import '../../../../../../core/models/app_user.dart';
import '../../../../../settings/views/booking_settings/controllers/service_packages_controller.dart';
import '../../../../../settings/views/booking_settings/views/new_add_services_homepage.dart';
import 'new_service_detail.dart';

class ViewAllServicesHomepage extends ConsumerStatefulWidget {
  const ViewAllServicesHomepage({
    super.key,
    required this.username,
    this.showAppBar = true,
    required this.data,
    required this.title,
  });
  final String? username;
  final String? title;
  final bool showAppBar;
  final List<ServicePackageModel> data;

  @override
  ConsumerState<ViewAllServicesHomepage> createState() =>
      _ServicesHomepageState();
}

class _ServicesHomepageState extends ConsumerState<ViewAllServicesHomepage> {
  bool isCurrentUser = false;
  bool enableLargeTile = false;
  bool showGrid = true;
  ScrollController _scrollController = ScrollController();
  bool shouldShowButton = false;
  List<Map<String, dynamic>> sortByList = [
    {'sort': 'Suggested', 'selected': false},
    {'sort': 'Closest First', 'selected': false},
    {'sort': 'Newest First', 'selected': false},
    {'sort': 'Price: Lowest First', 'selected': false},
    {'sort': 'Price: Highest First', 'selected': false},
  ];

  @override
  void initState() {
    super.initState();
    isCurrentUser =
        ref.read(appUserProvider.notifier).isCurrentUser(widget.username);
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        // User has scrolled to the bottom, add the button.
        setState(() {
          shouldShowButton = true;
        });
      } else {
        shouldShowButton = false;
        setState(() {});
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
  Widget build(BuildContext context) {
    // final services = ref.watch(userServices(widget.username));
    VAppUser? user;

    final appUser = ref.watch(appUserProvider);
    user = appUser.valueOrNull;

    final requestUsername =
        ref.watch(userNameForApiRequestProvider('${widget.username}'));
    final services = ref.watch(servicePackagesProvider(requestUsername));

    print(services);
    return Scaffold(
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            leading: const VWidgetsBackButton(),
            centerTitle: true,
            title: Text(
              widget.title!,
              style: Theme.of(context).textTheme.displayLarge!.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            pinned: true,
            elevation: 0,
            actions: [
              if (!widget.title!
                  .toLowerCase()
                  .contains("recently viewed services"))
                Padding(
                  padding: const EdgeInsets.only(right: 5),
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
                            color: Theme.of(context).scaffoldBackgroundColor,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(13),
                              topRight: Radius.circular(13),
                            ),
                          ),
                          child: ServiceSortBottomSheet(
                            sortByList: sortByList,
                            onSelectSort: (int index) async {
                              sortService(index, widget.data);
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
                onPressed: () {
                  showGrid = !showGrid;
                  setState(() {});
                },
                icon: showGrid
                    ? RenderSvg(
                        svgPath: VIcons.viewSwitch,
                        color:
                            Theme.of(context).iconTheme.color?.withOpacity(.6),
                      )
                    : RenderSvg(
                        svgPath: VIcons.viewSwitch,
                      ),
              ),

              if (isCurrentUser)
                IconButton(
                    onPressed: () {
                      navigateToRoute(context, const AddNewServicesHomepage());
                    },
                    icon: const RenderSvg(svgPath: VIcons.addServiceOutline)),
              // addHorizontalSpacing(5),
            ],
          ),
          if (showGrid)
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(15, 20, 15, 40),
              sliver: SliverGrid.builder(
                itemCount: widget.data.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 20,
                  childAspectRatio: 0.63,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: [
                      ServiceSubItem(
                        user: user!,
                        item: widget.data[index],
                        onTap: () => navigateToRoute(
                          context,
                          ServicePackageDetail(
                            service: widget.data[index],
                            isCurrentUser: false,
                            username: "username",
                          ),
                        ),
                        onLongPress: () {},
                      ),
                    ],
                  );
                },
              ),
            ),
          if (!showGrid)
            SliverList.separated(
              itemCount: widget.data.length,
              separatorBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Divider(),
                );
              },
              itemBuilder: (context, index) {
                var item = widget.data[index];
                // final displayPrice = (item['price'] as double);

                return VWidgetsServicesCardWidget(
                  statusColor: item.status.statusColor(item.processing),
                  showDescription: enableLargeTile,
                  onTap: () {
                    navigateToRoute(
                        context,
                        ServicePackageDetail(
                          service: item,
                          isCurrentUser: isCurrentUser,
                          username: '${user?.username}',
                        ));
                  },
                  serviceName: item.title,
                  bannerUrl: item.banner.isNotEmpty
                      ? item.banner.first.thumbnail
                      : item.user!.thumbnailUrl,
                  serviceType: item.servicePricing
                      .tileDisplayName, // Add your service type logic here
                  serviceLocation: item.serviceType.simpleName,
                  serviceCharge: item.price,
                  user: item.user,
                  discount: item.percentDiscount ?? 0,
                  serviceDescription: item.description,
                  date: item.createdAt.getSimpleDateOnJobCard(),
                );
              },
            ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 16, right: 16, bottom: 20, top: 10),
              child: VWidgetsPrimaryButton(
                onPressed: () => navigateToRoute(
                    context, LocalServices(title: "All Services")),
                buttonTitle: "View more services",
              ),
            ),
          )
        ],
      ),
    );
  }
}
