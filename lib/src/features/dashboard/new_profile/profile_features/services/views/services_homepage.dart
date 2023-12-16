import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:vmodel/src/core/utils/helper_functions.dart';
import 'package:vmodel/src/features/dashboard/feed/widgets/share.dart';
import 'package:vmodel/src/features/dashboard/new_profile/profile_features/services/models/user_service_modal.dart';
import 'package:vmodel/src/features/dashboard/new_profile/profile_features/services/widgets/services_card_widget.dart';
import 'package:vmodel/src/features/dashboard/profile/controller/profile_controller.dart';
import 'package:vmodel/src/features/settings/views/booking_settings/controllers/user_service_controller.dart';
import 'package:vmodel/src/features/settings/views/booking_settings/models/service_package_model.dart';
import 'package:vmodel/src/res/assets/app_asset.dart';
import 'package:vmodel/src/res/icons.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/shared/appbar/appbar.dart';
import 'package:vmodel/src/shared/bottom_sheets/confirmation_bottom_sheet.dart';
import 'package:vmodel/src/shared/bottom_sheets/tile.dart';
import 'package:vmodel/src/shared/loader/full_screen_dialog_loader.dart';
import 'package:vmodel/src/shared/rend_paint/render_svg.dart';
import 'package:vmodel/src/vmodel.dart';

import '../../../../../../core/controller/app_user_controller.dart';
import '../../../../../../core/models/app_user.dart';
import '../../../../../settings/views/booking_settings/controllers/service_packages_controller.dart';
import '../../../../../settings/views/booking_settings/views/new_add_services_homepage.dart';
import 'new_service_detail.dart';

class ServicesHomepage extends ConsumerStatefulWidget {
  const ServicesHomepage({
    super.key,
    required this.username,
    this.showAppBar = true,
  });
  final String? username;
  final bool showAppBar;

  @override
  ConsumerState<ServicesHomepage> createState() => _ServicesHomepageState();
}

class _ServicesHomepageState extends ConsumerState<ServicesHomepage> {
  bool isCurrentUser = false;
  bool enableLargeTile = false;

  @override
  void initState() {
    super.initState();
    isCurrentUser =
        ref.read(appUserProvider.notifier).isCurrentUser(widget.username);
  }

  @override
  Widget build(BuildContext context) {
    // final services = ref.watch(userServices(widget.username));
    VAppUser? user;
    if (isCurrentUser) {
      final appUser = ref.watch(appUserProvider);
      user = appUser.valueOrNull;
    } else {
      final appUser = ref.watch(profileProvider(widget.username));
      user = appUser.valueOrNull;
    }
    final requestUsername =
        ref.watch(userNameForApiRequestProvider('${widget.username}'));
    final services = ref.watch(servicePackagesProvider(requestUsername));
    print('List of services');
    print(services);
    return Scaffold(
      appBar: !widget.showAppBar
          ? null
          : VWidgetsAppBar(
              leadingIcon: const VWidgetsBackButton(),
              appbarTitle: isCurrentUser ? "My Services" : "Services",
              trailingIcon: [
                GestureDetector(
                  onTap: () {
                    enableLargeTile == true
                        ? setState(() {
                            enableLargeTile = false;
                          })
                        : setState(() {
                            enableLargeTile = true;
                          });
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
                if (!isCurrentUser) addHorizontalSpacing(10),
                if (isCurrentUser)
                  IconButton(
                      onPressed: () {
                        navigateToRoute(
                            context, const AddNewServicesHomepage());
                      },
                      icon: const RenderSvg(svgPath: VIcons.addServiceOutline)),
                // addHorizontalSpacing(5),
              ],
            ),
      body: services.when(data: (value) {
        // sort services by created at date descending

        print('user service location ${user?.location?.locationName}');
        // return value.fold((p0) => Text(p0.message), (p0) {
        if (value.isEmpty) {
          return SingleChildScrollView(
            padding: const VWidgetsPagePadding.horizontalSymmetric(18),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                addVerticalSpacing(20),
                // VWidgetsServicesProfileWidget(
                //   profileImage: '${user?.profilePictureUrl}',
                //   profileImageThumbnail: '${user?.thumbnailUrl}',
                //   userName: user?.fullName,
                //   userType: user?.userType.toString().toUpperCase(),
                //   location: user?.location?.locationName,
                // ),
                // addVerticalSpacing(20),
                SizedBox(
                  height: 70.h, // Expand to fill available space
                  child: Center(
                    child: Text(
                      'No services has been offered yet',
                      style:
                          Theme.of(context).textTheme.displayMedium?.copyWith(
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                color: // VmodelColors.primaryColor.withOpacity(0.5),
                                    Theme.of(context)
                                        .textTheme
                                        .displayMedium
                                        ?.color
                                        ?.withOpacity(0.5),
                              ),
                    ),
                  ),
                )
              ],
            ),
          );
        }
        return RefreshIndicator.adaptive(
            onRefresh: () async {
              HapticFeedback.lightImpact();
              ref.refresh(servicePackagesProvider(requestUsername).future);
            },
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              physics: AlwaysScrollableScrollPhysics(
                  parent: BouncingScrollPhysics()),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // const SizedBox(height: 20),
                  // VWidgetsServicesProfileWidget(
                  //   profileImage: '${user?.profilePictureUrl}',
                  //   profileImageThumbnail: '${user?.thumbnailUrl}',
                  //   userName: user?.username,
                  //   userType: user?.userType.toString().toUpperCase(),
                  //   location: user?.location?.locationName,
                  // ),
                  const SizedBox(height: 20),
                  ConstrainedBox(
                    constraints: BoxConstraints(minHeight: 60.h),
                    child: ListView.separated(
                      shrinkWrap: true,
                      physics: const ScrollPhysics(),
                      itemCount: value.length,
                      separatorBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: Divider(),
                        );
                      },
                      itemBuilder: (context, index) {
                        var item = value[index];
                        // final displayPrice = (item['price'] as double);

                        return Slidable(
                          endActionPane: ActionPane(
                            extentRatio: isCurrentUser ? 0.2 : .5,
                            motion: const StretchMotion(),
                            children: [
                              if (!isCurrentUser)
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
                                        shareTitle: "${item.title}",
                                        shareImage:
                                            VmodelAssets2.imageContainer,
                                        shareURL:
                                            "Vmodel.app/job/tilly's-bakery-services",
                                      ),
                                    );
                                  },
                                  foregroundColor: Colors.white,
                                  backgroundColor:
                                      const Color.fromARGB(255, 224, 224, 224),
                                  label: 'Share',
                                ),
                              if (!isCurrentUser)
                                SlidableAction(
                                  onPressed: (context) async {
                                    print('successfully saved service');
                                    await ref
                                        .read(userServicePackagesProvider(
                                            UserServiceModel(
                                          serviceId: item.id,
                                          username: widget.username!,
                                        )).notifier)
                                        .saveService(item.id);
                                  },
                                  foregroundColor: Colors.white,
                                  backgroundColor: Colors.grey,
                                  label: 'Save',
                                ),
                              if (isCurrentUser)
                                SlidableAction(
                                  onPressed: (context) {
                                    deleteServiceModalSheet(context, item);
                                  },
                                  foregroundColor: Colors.white,
                                  backgroundColor: Colors.red,
                                  label: 'Delete',
                                ),
                            ],
                          ),
                          child: VWidgetsServicesCardWidget(
                            statusColor:
                                item.status.statusColor(item.processing),
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
                            user: item.user,
                            serviceName: item.title,
                            bannerUrl: item.banner.isNotEmpty
                                ? item.banner.first.thumbnail
                                : null,
                            serviceType: item.servicePricing.tileDisplayName,
                            serviceLocation: item.serviceType.simpleName,
                            serviceCharge: item.price,
                            discount: item.percentDiscount ?? 0,
                            serviceDescription: item.description,
                            date: item.createdAt.getSimpleDateOnJobCard(),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ));
        // }
        // );
        // services.when(data: (value) {
        //   print('Value is emptyyyyyy');
        //   print(value);
        //   if (value.isEmpty) {
        //     return SingleChildScrollView(
        //       padding: const VWidgetsPagePadding.horizontalSymmetric(18),
        //       child: Column(
        //         children: [
        //           addVerticalSpacing(20),
        //           VWidgetsServicesProfileWidget(
        //             profileImage: '${user?.profilePictureUrl}',
        //             userName: user?.fullName,
        //             userType: user?.bio,
        //             location: user?.locationName
        //                 .toString()
        //                 .replaceAll(",", "")
        //                 .split(" ")
        //                 .first
        //                 .toUpperCase(),
        //           ),
        //           addVerticalSpacing(20),
        //           SizedBox(
        //             height: MediaQuery.of(context).size.height *
        //                 0.5, // Expand to fill available space
        //             child: Center(
        //               child: Text(
        //                 'No services has been offered yet',
        //                 style: Theme.of(context).textTheme.headline6?.copyWith(
        //                       color: VmodelColors.primaryColor.withOpacity(0.5),
        //                       fontWeight: FontWeight.w400,
        //                       fontSize: 14,
        //                     ),
        //               ),
        //             ),
        //           )
        //         ],
        //       ),
        //     );
        //   }

        // return SingleChildScrollView(
        //   padding: const EdgeInsets.symmetric(horizontal: 18),
        //   child: Column(
        //     crossAxisAlignment: CrossAxisAlignment.start,
        //     children: [
        //       const SizedBox(height: 20),
        //       VWidgetsServicesProfileWidget(
        //         profileImage: '${user?.profilePictureUrl}',
        //         userName: user?.fullName,
        //         userType: user?.accountType.toString().toUpperCase(),
        //         location: user?.locationName
        //             .toString()
        //             .replaceAll(",", "")
        //             .split(" ")
        //             .first
        //             .toUpperCase(),
        //       ),
        //       const SizedBox(height: 20),
        //       ListView.builder(
        //         shrinkWrap: true,
        //         physics: const ScrollPhysics(),
        //         itemCount: value.length,
        //         itemBuilder: (context, index) {
        //           final ServicePackageModel item = value[index];

        //           return VWidgetsServicesCardWidget(
        //             onTap: () {
        //               navigateToRoute(
        //                   context,
        //                   ServicesDetailsPage(
        //                     serviceName: item.title,
        //                     serviceType: item.usageType,
        //                     serviceCharge: item.price,
        //                     serviceDelivery: item.delivery,
        //                     serviceUsageLength: item.usageLength,
        //                     serviceUsageType: item.usageType,
        //                     serviceDescription: item.description,
        //                   ));
        //             },
        //             serviceName: item.title,
        //             serviceType: "", // Add your service type logic here
        //             serviceCharge: item.price.toString(),
        //             serviceDescription: item.description,
        //           );
        //         },
        //       ),
        //     ],
        //   ),
        //   );
      }, error: (err, stackTrace) {
        return Text('There was an error showing services $stackTrace');
      }, loading: () {
        return const Center(child: CircularProgressIndicator.adaptive());
      }),
    );
  }

  Future<dynamic> deleteServiceModalSheet(
      BuildContext context, ServicePackageModel item) {
    return showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (context) {
          return Container(
            decoration: BoxDecoration(
              // color: VmodelColors.appBarBackgroundColor,
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(13),
                topRight: Radius.circular(13),
              ),
            ),
            child: VWidgetsConfirmationBottomSheet(
              actions: [
                VWidgetsBottomSheetTile(
                    onTap: () async {
                      VLoader.changeLoadingState(true);
                      await ref
                          .read(servicePackagesProvider(null).notifier)
                          .deleteService(item.id);
                      VLoader.changeLoadingState(false);
                      if (mounted) {
                        // goBack(context);
                        Navigator.of(context)..pop();
                      }
                    },
                    message: 'Yes'),
                const Divider(thickness: 0.5),
                VWidgetsBottomSheetTile(
                    onTap: () {
                      popSheet(context);
                    },
                    message: 'No'),
                const Divider(thickness: 0.5),
              ],
            ),
          );
        });
  }
}
