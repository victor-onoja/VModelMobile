import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:vmodel/src/core/models/app_user.dart';
import 'package:vmodel/src/core/utils/helper_functions.dart';
import 'package:vmodel/src/features/dashboard/new_profile/profile_features/services/views/view_all_services.dart';
import 'package:vmodel/src/features/messages/widgets/date_time_message.dart';
import 'package:vmodel/src/features/settings/views/booking_settings/controllers/recently_viewed_services_controller.dart';
import 'package:vmodel/src/features/settings/views/booking_settings/controllers/similar_services_controller.dart';
import 'package:vmodel/src/features/settings/views/booking_settings/controllers/user_service_controller.dart';
import 'package:vmodel/src/features/settings/views/booking_settings/models/service_package_model.dart';
import 'package:vmodel/src/res/assets/app_asset.dart';
import 'package:vmodel/src/res/colors.dart';
import 'package:vmodel/src/res/gap.dart';
import 'package:vmodel/src/shared/appbar/appbar.dart';
import 'package:vmodel/src/shared/bottom_sheets/tile.dart';
import 'package:vmodel/src/shared/loader/full_screen_dialog_loader.dart';
import 'package:vmodel/src/shared/modal_pill_widget.dart';
import 'package:vmodel/src/vmodel.dart';

import '../../../../../../core/controller/app_user_controller.dart';
import '../../../../../../core/utils/costants.dart';
import '../../../../../../core/utils/enum/service_job_status.dart';
import '../../../../../../res/icons.dart';
import '../../../../../../shared/bottom_sheets/confirmation_bottom_sheet.dart';
import '../../../../../../shared/buttons/primary_button.dart';
import '../../../../../../shared/job_service_section_container.dart';
import '../../../../../../shared/rend_paint/render_svg.dart';
import '../../../../../../shared/shimmer/post_shimmer.dart';
import '../../../../../booking/views/create_booking/views/create_booking_first.dart';
import '../../../../../../shared/bottom_sheets/description_detail_bottom_sheet.dart';
import '../../../../../settings/views/booking_settings/controllers/service_images_controller.dart';
import '../../../../../settings/views/booking_settings/controllers/service_packages_controller.dart';
import '../../../../../settings/views/booking_settings/models/banner_model.dart';
import '../../../../../settings/views/booking_settings/views/new_add_services_homepage.dart';
import '../../../../feed/widgets/send.dart';
import '../../../../feed/widgets/share.dart';
import '../../../other_user_profile/other_user_profile.dart';
import '../../../views/other_profile_router.dart';
import '../../widgets/profile_picture_widget.dart';
import '../models/user_service_modal.dart';
import '../widgets/readmore_service_description.dart';
import '../widgets/service_detail_icon_stat.dart';
import 'service_details_sub_list.dart';

class ServicePackageDetail extends ConsumerStatefulWidget {
  const ServicePackageDetail({
    Key? key,
    required this.service,
    required this.isCurrentUser,
    required this.username,
  }) : super(key: key);

  final ServicePackageModel service;
  final bool isCurrentUser;
  final String username;

  @override
  ConsumerState<ServicePackageDetail> createState() =>
      _ServicePackageDetailState();
}

class _ServicePackageDetailState extends ConsumerState<ServicePackageDetail> {
  bool isSaved = false;
  bool userLiked = false;
  bool userSaved = false;
  int likes = 0;
  final _currencyFormatter = NumberFormat.simpleCurrency(locale: "en_GB");
  final Duration _maxDuration = Duration.zero;
  late ServicePackageModel serviceData;
  final CarouselController _controller = CarouselController();
  ScrollController _listViewController = ScrollController();
  int _currentIndex = 0;
  bool isCurrentUser = false;

  @override
  void initState() {
    super.initState();
    serviceData = widget.service;
    // ref
    //     .read(servicePackagesProvider(widget.username).notifier)
    //     .getService(serviceId: serviceData.id);

    // for (var item in widget.service.jobDelivery) {
    //   _maxDuration += item.dateDuration;
    // }
    isCurrentUser =
        ref.read(appUserProvider.notifier).isCurrentUser(widget.username);
    print("data ${serviceData.id}");
  }

  void scrollToCenter(int index) {
    // Calculate the position to scroll to
    double itemExtent =
        SizerUtil.height * .1075; // Replace with your item height
    double targetOffset = itemExtent * index -
        _listViewController.position.viewportDimension / 2 +
        itemExtent / 2;

    // Use the ScrollController to animate the scroll
    _listViewController.animateTo(
      targetOffset,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final requestUsername =
        ref.watch(userNameForApiRequestProvider('${widget.username}'));
    // final serviceDetails = ref.watch(servicePackagesProvider(requestUsername));

    final userService = ref.watch(userServicePackagesProvider(
      UserServiceModel(serviceId: serviceData.id, username: widget.username),
    ));
    if (userService.valueOrNull != null) {
      serviceData = userService.value!;
    }
    final servicesByUser =
        ref.watch(servicePackagesProvider(serviceData.user!.username));
    final similarServices = ref.watch(similerServicesProvider(serviceData.id));
    final recentlyViewedServices = ref.watch(recentlyViewedServicesProvider);
    ref.watch(serviceImagesProvider);
    VAppUser? user;
    final appUser = ref.watch(appUserProvider);

    user = appUser.valueOrNull;
    // data = ref.watch(serviceProvider)!;

    //Todo Wishwell fix this logic. It's causing a crash
    // for (int index = 0; index < serviceDetails.value!.length; index++)
    //   if (data.id == serviceDetails.value![index]) {
    //     data = serviceDetails.value![index];
    //   }

    return Scaffold(
        appBar: VWidgetsAppBar(
          elevation: 0,
          appbarTitle: 'Service Details',
          leadingIcon: const VWidgetsBackButton(),
          trailingIcon: [
            if (isCurrentUser)
              IconButton(
                  onPressed: () {
                    showEditing();
                  },
                  icon: const RenderSvg(svgPath: VIcons.galleryEdit)),
            if (!isCurrentUser)
              IconButton(
                icon: NormalRenderSvgWithColor(
                  svgPath: VIcons.viewOtherProfileMenu,
                  color: Theme.of(context).iconTheme.color,
                ),
                onPressed: () {
                  //Menu settings

                  _showJobViewerBottomSheet(context);
                },
              ),
          ],
        ),
        body: userService.when(
            data: (data) {
              userLiked = data.userLiked;
              likes = data.likes!;
              userSaved = data.userSaved;
              return SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                // padding: const VWidgetsPagePadding.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (serviceData.banner.isNotEmpty || data.banner.isNotEmpty)
                      // if (serviceData.banner.length == 1)
                      Column(
                        children: [
                          CarouselSlider(
                            disableGesture: true,
                            items: List.generate(
                              serviceData.banner.length,
                              (index) => Stack(
                                children: [
                                  CachedNetworkImage(
                                    imageUrl: serviceData.banner[index].url!,
                                    fadeInDuration: Duration.zero,
                                    fadeOutDuration: Duration.zero,
                                    width: double.maxFinite,
                                    height: double.maxFinite,
                                    fit: BoxFit.cover,
                                    // fit: BoxFit.contain,
                                    placeholder: (context, url) {
                                      // return const PostShimmerPage();
                                      return CachedNetworkImage(
                                        imageUrl: serviceData
                                            .banner[index].thumbnail!,
                                        fadeInDuration: Duration.zero,
                                        fadeOutDuration: Duration.zero,
                                        fit: BoxFit.cover,
                                        placeholder: (context, url) {
                                          return const PostShimmerPage();
                                        },
                                      );
                                    },
                                    errorWidget: (context, url, error) =>
                                        // const Icon(Icons.error),
                                        const PostShimmerPage(),
                                  ),
                                  Positioned(
                                    right: 20,
                                    bottom: 10,
                                    child: StatItemV2(
                                      outlineIcon: userLiked
                                          ? VIcons.likedIcon
                                          : VIcons.unlikedIcon,
                                      userLike: userLiked,
                                      text: likes.toString(),
                                      iconWidth: 25,
                                      iconHeight: 25,
                                      onIconTapped: () async {
                                        bool success = await ref
                                            .read(userServicePackagesProvider(
                                                    UserServiceModel(
                                                        serviceId:
                                                            serviceData.id,
                                                        username:
                                                            widget.username))
                                                .notifier)
                                            .likeService(data.id);

                                        if (success) {
                                          userLiked = !userLiked;
                                          if (userLiked) {
                                            likes++;
                                          } else {
                                            print("fwefewvrever");
                                            likes--;
                                          }
                                        }
                                        setState(() {});
                                      },
                                    ),
                                  )
                                ],
                              ),
                            ),
                            carouselController: _controller,
                            options: CarouselOptions(
                              padEnds: false,
                              viewportFraction: 1,
                              aspectRatio:
                                  0.9 / 1, //UploadAspectRatio.portrait.ratio,
                              initialPage: 0,
                              enableInfiniteScroll: false,
                              onPageChanged: (index, reason) {
                                scrollToCenter(index);
                                _currentIndex = index;
                                setState(() {});
                                // widget.onPageChanged(index, reason);
                              },
                            ),
                          ),
                          addVerticalSpacing(10),
                          if (serviceData.banner.length >= 1)
                            Container(
                              height: SizerUtil.height * .118,
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: ListView.separated(
                                  physics: ClampingScrollPhysics(),
                                  controller: _listViewController,
                                  scrollDirection: Axis.horizontal,
                                  itemCount: serviceData.banner.length,
                                  padding: EdgeInsets.only(right: 10),
                                  separatorBuilder: (context, index) =>
                                      SizedBox(width: 2),
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () {
                                        scrollToCenter(index);
                                        _controller.animateToPage(index);
                                        setState(() {
                                          _currentIndex = index;
                                        });
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        padding: EdgeInsets.only(
                                            right: 8, top: 8, bottom: 8),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          child: CachedNetworkImage(
                                            imageUrl: serviceData
                                                .banner[index].thumbnail!,
                                            fadeInDuration: Duration.zero,
                                            fadeOutDuration: Duration.zero,
                                            width: _currentIndex == index
                                                ? 88
                                                : 80,
                                            height: _currentIndex == index
                                                ? SizerUtil.height * .115
                                                : SizerUtil.height * .1,
                                            fit: BoxFit.cover,
                                            placeholder: (context, url) {
                                              return const PostShimmerPage();
                                            },
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                            ),

                          // VWidgetsCarouselIndicator(
                          //   currentIndex: _currentIndex,
                          //   totalIndicators: serviceData.banner.length,
                          //   height: 4.5,
                          //   width: 4.5,
                          //   radius: 8,
                          //   spacing: 7,
                          // ),
                        ],
                      ),
                    addVerticalSpacing(20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: SectionContainer(
                        topRadius: 16,
                        bottomRadius: 16,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              children: [
                                addVerticalSpacing(10),
                                GestureDetector(
                                  onTap: () {
                                    navigateToRoute(
                                      context,
                                      OtherProfileRouter(
                                        username:
                                            "${widget.service.user?.username}",
                                      ),
                                    );
                                  },
                                  child: ProfilePicture(
                                    showBorder: false,
                                    displayName:
                                        '${widget.service.user?.displayName}',
                                    url: widget.service.user?.profilePictureUrl,
                                    headshotThumbnail:
                                        widget.service.user?.thumbnailUrl,
                                    size: 56,
                                  ),
                                ),
                              ],
                            ),
                            addHorizontalSpacing(10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      navigateToRoute(
                                          context,
                                          OtherUserProfile(
                                              username:
                                                  "${widget.service.user?.username}"));
                                    },
                                    child: Text(
                                      "${widget.service.user?.username}",
                                      style: Theme.of(context)
                                          .textTheme
                                          .displayMedium!
                                          .copyWith(
                                            fontWeight: FontWeight.w600,
                                            // color: VmodelColors.primaryColor,
                                          ),
                                    ),
                                  ),
                                  addVerticalSpacing(4),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      const RenderSvg(
                                        svgPath: VIcons.star,
                                        svgHeight: 12,
                                        svgWidth: 12,
                                        // color: VmodelColors.primaryColor,
                                      ),
                                      addHorizontalSpacing(4),
                                      Text(
                                        '4.5',
                                        style: Theme.of(context)
                                            .textTheme
                                            .displaySmall!
                                            .copyWith(
                                              fontWeight: FontWeight.w600,
                                              // color: VmodelColors.primaryColor,
                                            ),
                                      ),
                                      addHorizontalSpacing(4),
                                      Text('(25)',
                                          style: Theme.of(context)
                                              .textTheme
                                              .displaySmall),
                                    ],
                                  ),
                                  addVerticalSpacing(4),
                                  if (widget.service.user?.location
                                          ?.locationName !=
                                      null)
                                    Text(
                                      // "London, UK",
                                      widget.service.user?.location
                                              ?.locationName ??
                                          '',
                                      style: Theme.of(context)
                                          .textTheme
                                          .displaySmall!
                                          .copyWith(
                                            fontWeight: FontWeight.w500,
                                            color: Theme.of(context)
                                                .textTheme
                                                .displaySmall
                                                ?.color
                                                ?.withOpacity(0.5),
                                          ),
                                    ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    addVerticalSpacing(10),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Divider(
                            //     thickness: .5, color: Theme.of(context).primaryColor),
                            addVerticalSpacing(10),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8),
                              child: Text(
                                widget.service.title,
                                textAlign: TextAlign.left,
                                style: Theme.of(context)
                                    .textTheme
                                    .displayLarge!
                                    .copyWith(
                                      fontSize: 19,
                                      fontWeight: FontWeight.w600,
                                      // color: VmodelColors.primaryColor,
                                    ),
                              ),
                            ),
                            addVerticalSpacing(20),
                            DescriptionText(
                                readMore: () {
                                  _showBottomSheet(
                                    context,
                                    // briefLink: data.,
                                    content: data.description,
                                    title: 'Description',
                                  );
                                },
                                text: data.description),

                            addVerticalSpacing(10),
                            Divider(),
                            addVerticalSpacing(10),
                            _jobPersonRow(context,
                                field: 'Content license',
                                value:
                                    data.usageType?.capitalizeFirstVExt ?? ''),
                            _jobPersonRow(context,
                                field: 'Content license length',
                                value: data.usageLength?.capitalizeFirstVExt ??
                                    ''),
                            Divider(),
                            _jobPersonRow(context,
                                field: 'Pricing',
                                value: VConstants.noDecimalCurrencyFormatterGB
                                    .format(data.price.round())),
                            _jobPersonRow(
                              context,
                              field: 'Location',
                              value: data.serviceType.simpleName,
                            ),
                            _jobPersonRow(
                              context,
                              field: 'Delivery Range',
                              value: data.delivery,
                            ),
                            addVerticalSpacing(10),
                            _headingText(context, title: "Rate"),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8),
                              child: _priceDetails(context),
                            ),
                            addVerticalSpacing(32),
                            if (data.faq != null)
                              if (data.faq!.isNotEmpty)
                                readFAQ(context, data.faq!),
                            addVerticalSpacing(32),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                      width: 5,
                                      height: 5,
                                      decoration: BoxDecoration(
                                        color: Theme.of(context)
                                            .primaryColor
                                            .withOpacity(0.3),
                                        borderRadius: BorderRadius.circular(5),
                                      )),
                                  addHorizontalSpacing(4),
                                  Flexible(
                                    child: Text(
                                      '${data.views?.pluralize('person', pluralString: 'people')}'
                                      ' viewed this service in'
                                      ' the last ${data.createdAt.timeMessage()}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.copyWith(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 12,
                                            color: // VmodelColors.primaryColor.withOpacity(0.3),
                                                Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium
                                                    ?.color
                                                    ?.withOpacity(0.3),
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            if (!isCurrentUser) addVerticalSpacing(32),
                            if (!isCurrentUser)
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: VWidgetsPrimaryButton(
                                  onPressed: data.paused
                                      ? null
                                      : () {
                                          navigateToRoute(
                                              context,
                                              CreateBookingFirstPage(
                                                username:
                                                    // '${serviceData.user?.username}',
                                                    widget.username,
                                                displayName:
                                                    // widget?.displayName ?? 'No displayName',
                                                    '${serviceData.user?.displayName}',
                                              ));
                                        },
                                  buttonTitle:
                                      data.paused ? 'Paused' : 'Book Now',
                                  enableButton: !data.paused,
                                ),
                              ),
                            addVerticalSpacing(32),
                            if (user!.username != widget.service.user?.username)
                              Divider(),

                            if (user.username != widget.service.user?.username)
                              servicesByUser.when(
                                data: (data) {
                                  if (data.length <= 1) {
                                    return Container();
                                  }
                                  return ServiceSubList(
                                    isCurrentUser: widget.isCurrentUser,
                                    username: widget.username,
                                    items: data,
                                    onTap: (value) {},
                                    onViewAllTap: () => navigateToRoute(
                                      context,
                                      ViewAllServicesHomepage(
                                        username: widget.username,
                                        data: data,
                                        title: "All services",
                                      ),
                                    ),
                                    title: 'More services by this user',
                                  );
                                },
                                error: (Object error, StackTrace stackTrace) {
                                  return Text("Error");
                                },
                                loading: () {
                                  return CircularProgressIndicator.adaptive();
                                },
                              ),
                            if (user.username != widget.service.user?.username)
                              similarServices.when(
                                data: (data) {
                                  return ServiceSubList(
                                    isCurrentUser: widget.isCurrentUser,
                                    username: widget.username,
                                    items: data,
                                    onTap: (value) {},
                                    onViewAllTap: () => navigateToRoute(
                                      context,
                                      ViewAllServicesHomepage(
                                          username: widget.username,
                                          data: data,
                                          title: "Simialar services"),
                                    ),
                                    title: 'Similar services',
                                  );
                                },
                                error: (Object error, StackTrace stackTrace) {
                                  return Text("Error");
                                },
                                loading: () {
                                  return CircularProgressIndicator.adaptive();
                                },
                              ),
                            if (user.username != widget.service.user?.username)
                              recentlyViewedServices.when(
                                data: (data) {
                                  return ServiceSubList(
                                    isCurrentUser: widget.isCurrentUser,
                                    username: widget.username,
                                    items: data,
                                    onTap: (value) {},
                                    onViewAllTap: () => navigateToRoute(
                                      context,
                                      ViewAllServicesHomepage(
                                          username: widget.username,
                                          data: data,
                                          title: "Recently viewed services"),
                                    ),
                                    title: 'Recently viewed services',
                                  );
                                },
                                error: (Object error, StackTrace stackTrace) {
                                  return Text("Error");
                                },
                                loading: () {
                                  return CircularProgressIndicator.adaptive();
                                },
                              ),
                          ]),
                    ),
                    addVerticalSpacing(32),
                  ],
                ),
              );
            },
            error: (error, stack) => Center(
                  child: Text(error.toString()),
                ),
            loading: () => Center(
                  child: CircularProgressIndicator.adaptive(),
                )));
  }

  void showEditing() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
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
                onTap: () {
                  ref.read(serviceImagesProvider.notifier).state =
                      serviceData.banner
                          .map((e) => BannerModel(
                                bannerThumbnailUrl: e.thumbnail,
                                bannerUrl: e.url,
                              ))
                          .toList();
                  navigateToRoute(
                      context,
                      AddNewServicesHomepage(
                        servicePackage: serviceData,
                        onUpdateSuccess: (value) {
                          serviceData = value;
                          setState(() {});
                        },
                      ));
                },
                message: 'Edit',
              ),
              if (serviceData.status == ServiceOrJobStatus.draft)
                const Divider(thickness: 0.5),
              if (serviceData.status == ServiceOrJobStatus.draft)
                VWidgetsBottomSheetTile(
                  onTap: () async {
                    VLoader.changeLoadingState(true);
                    // final isSuccessful =

                    await ref
                        .read(servicePackagesProvider(null).notifier)
                        .publishService(
                          serviceId: serviceData.id,
                        );
                    // if (isSuccessful) {
                    //   data = data.copyWith(
                    //       paused: data.paused
                    //           ? false
                    //           : true);
                    // }
                    VLoader.changeLoadingState(false);
                    popSheet(context);
                  },
                  message: 'Publish',
                ),
              const Divider(thickness: 0.5),
              VWidgetsBottomSheetTile(
                onTap: () async {
                  VLoader.changeLoadingState(true);
                  await ref
                      .read(servicePackagesProvider(null).notifier)
                      .duplicate(data: serviceData.duplicateMap());
                  VLoader.changeLoadingState(false);
                  if (context.mounted) {
                    //Better to use named routes and popUntil
                    Navigator.of(context)
                      ..pop()
                      ..pop();
                  }
                },
                message: 'Duplicate',
              ),
              const Divider(thickness: 0.5),
              VWidgetsBottomSheetTile(
                onTap: () async {
                  VLoader.changeLoadingState(true);
                  final isSuccessful = await ref
                      .read(servicePackagesProvider(null).notifier)
                      .pauseOrResumeService(serviceData.id,
                          isResume: serviceData.paused);
                  if (isSuccessful) {
                    serviceData = serviceData.copyWith(
                        paused: serviceData.paused ? false : true);
                  }
                  VLoader.changeLoadingState(false);
                  popSheet(context);
                },
                message: serviceData.paused ? 'Resume' : 'Pause',
              ),
              const Divider(thickness: 0.5),
              VWidgetsBottomSheetTile(
                onTap: () async {
                  popSheet(context);
                  deleteServiceModalSheet(context);
                },
                message: 'Delete',
                showWarning: true,
              )
            ],
          ),
        );
      },
    );
  }

  Future<dynamic> deleteServiceModalSheet(BuildContext context) {
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
                          .deleteService(widget.service.id);
                      VLoader.changeLoadingState(false);
                      if (mounted) {
                        // goBack(context);
                        Navigator.of(context)
                          ..pop()
                          ..pop();
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

  // GestureDetector(
  //   onTap: () {
  //     widget.like();
  //   },
  //   child: RenderSvg(
  //     svgPath:
  //         widget.likedBool! ? VIcons.likedIcon : VIcons.feedLikeIcon,
  //     svgHeight: 22,
  //     svgWidth: 22,
  //   ),
  // ),

  Future<dynamic> _showBottomSheet(BuildContext context,
      {required String title, required String content, String? briefLink}) {
    return showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) {
          return DetailBottomSheet(
            title: title,
            content: content,
            briefLink: briefLink,
          );
        });
  }

  Widget _headingText(BuildContext context, {required String title}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Text(
        title,
        style: Theme.of(context).textTheme.displayLarge!.copyWith(
              fontWeight: FontWeight.w600,
              // color: VmodelColors.primaryColor,
            ),
      ),
    );
  }

  Column _priceDetails(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    VConstants.noDecimalCurrencyFormatterGB
                        .format(serviceData.price),
                    style: Theme.of(context).textTheme.displayLarge!.copyWith(
                          fontWeight: FontWeight.w600,
                          decoration:
                              isValidDiscount(serviceData.percentDiscount)
                                  ? TextDecoration.lineThrough
                                  : null,
                          decorationColor:
                              Theme.of(context).primaryColor.withOpacity(0.3),
                          color:
                              //  VmodelColors.primaryColor.withOpacity(0.3),
                              Theme.of(context)
                                  .textTheme
                                  .displayLarge
                                  ?.color
                                  ?.withOpacity(0.3),
                        ),
                  ),
                  Text(
                    serviceData.servicePricing.tileDisplayName,
                    style: Theme.of(context).textTheme.displayLarge!.copyWith(
                          fontWeight: FontWeight.w500,
                          color: // VmodelColors.primaryColor.withOpacity(0.3),

                              Theme.of(context)
                                  .textTheme
                                  .displayLarge
                                  ?.color
                                  ?.withOpacity(0.3),
                        ),
                  )
                ],
              ),
            ),
            addHorizontalSpacing(4),
            Flexible(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    // '8 x 300',
                    isValidDiscount(serviceData.percentDiscount)
                        ? '${serviceData.percentDiscount}% Discount'
                        : '',

                    style: Theme.of(context).textTheme.displayLarge!.copyWith(
                          fontWeight: FontWeight.w500,
                          color: // VmodelColors.primaryColor.withOpacity(0.3),

                              Theme.of(context)
                                  .textTheme
                                  .displayLarge
                                  ?.color
                                  ?.withOpacity(0.3),
                        ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Text(
                        'Total',
                        textAlign: TextAlign.end,
                        style:
                            Theme.of(context).textTheme.displayLarge!.copyWith(
                                  fontWeight: FontWeight.w500,
                                  color: //VmodelColors.primaryColor.withOpacity(0.3),

                                      Theme.of(context)
                                          .textTheme
                                          .displayLarge
                                          ?.color
                                          ?.withOpacity(0.3),
                                ),
                      ),
                      addHorizontalSpacing(8),
                      Flexible(
                        child: Text(
                          // '2,400',
                          VConstants.noDecimalCurrencyFormatterGB.format(
                              calculateDiscountedAmount(
                                      price: serviceData.price,
                                      discount: serviceData.percentDiscount)
                                  .round()),
                          textAlign: TextAlign.end,
                          style: Theme.of(context)
                              .textTheme
                              .displayLarge!
                              .copyWith(
                                fontWeight: FontWeight.w600,
                                fontSize: 24,
                                // color: VmodelColors.primaryColor,
                              ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            )
          ],
        )
      ],
    );
  }

  Widget _jobPersonRow(BuildContext context,
      {required String field, required String value}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            field,
            style: Theme.of(context).textTheme.displayMedium!.copyWith(
                  fontWeight: FontWeight.w600,
                  height: 1.7,
                  // color: VmodelColors.primaryColor,
                  // fontSize: 12,
                ),
          ),
          addHorizontalSpacing(32),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: Theme.of(context).textTheme.displayMedium!.copyWith(
                    fontWeight: FontWeight.w500,
                    height: 1.7,
                    // color: VmodelColors.primaryColor,
                    // fontSize: 12,
                  ),
            ),
          ),
        ],
      ),
    );
  }

  Widget iconText({required String assetIcon, required String text}) {
    return Row(
      children: [
        RenderSvg(svgPath: assetIcon, svgHeight: 16, svgWidth: 16),
        addHorizontalSpacing(8),
        Text(
          text,
          style: Theme.of(context).textTheme.displayMedium!.copyWith(
                fontWeight: FontWeight.w600,
                height: 1.7,
                // color: VmodelColors.primaryColor,
                // fontSize: 12,
              ),
        ),
      ],
    );
  }

  Future<void> _showJobViewerBottomSheet(BuildContext context) {
    return showModalBottomSheet<void>(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (BuildContext context) {
          return Container(
            padding: const EdgeInsets.only(left: 16, right: 16),
            decoration: BoxDecoration(
              // color: VmodelColors.appBarBackgroundColor,
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(13),
                topRight: Radius.circular(13),
              ),
            ),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  addVerticalSpacing(15),
                  const Align(
                      alignment: Alignment.center, child: VWidgetsModalPill()),
                  addVerticalSpacing(25),
                  VWidgetsBottomSheetTile(
                    onTap: () async {
                      await ref
                          .read(userServicePackagesProvider(UserServiceModel(
                            serviceId: serviceData.id,
                            username: widget.username,
                          )).notifier)
                          .saveService(serviceData.id);
                      Navigator.of(context)..pop();
                    },
                    message: userSaved ? 'Saved' : "Save",
                  ),
                  const Divider(thickness: 0.5, height: 20),
                  VWidgetsBottomSheetTile(
                    onTap: () async {
                      Navigator.of(context)..pop();
                      showModalBottomSheet(
                        isScrollControlled: true,
                        isDismissible: true,
                        useRootNavigator: true,
                        backgroundColor: Colors.transparent,
                        context: context,
                        builder: (context) => ShareWidget(
                          shareLabel: 'Share Service',
                          shareTitle: "${serviceData.title}",
                          shareImage: VmodelAssets2.imageContainer,
                          shareURL: "Vmodel.app/job/tilly's-bakery-services",
                        ),
                      );

                      // VLoader.changeLoadingState(false);
                      // if (context.mounted) {
                      //   //Better to use named routes and popUntil

                      //     ..pop();
                      // }
                    },
                    message: 'Share',
                  ),
                  const Divider(thickness: 0.5, height: 20),
                  VWidgetsBottomSheetTile(
                    onTap: () async {
                      // VLoader.changeLoadingState(true);
                      Navigator.of(context)..pop();
                      showModalBottomSheet(
                        isScrollControlled: true,
                        isDismissible: true,
                        useRootNavigator: true,
                        backgroundColor: Colors.transparent,
                        context: context,
                        builder: (context) => Container(
                            constraints: BoxConstraints(
                              maxHeight:
                                  MediaQuery.of(context).size.height * .85,
                              // minHeight: MediaQuery.of(context).size.height * .10,
                            ),
                            child: const SendWidget()),
                      );
                    },
                    message: 'Send',
                  ),
                  const Divider(thickness: 0.5, height: 20),
                  VWidgetsBottomSheetTile(
                    onTap: () async {},
                    message: 'Report',
                  ),
                  addVerticalSpacing(40),
                ]),
          );
        });
  }

  Widget readFAQ(BuildContext context, List<FAQModel> data) {
    return GestureDetector(
      onTap: () {
        HapticFeedback.lightImpact();
        showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (context) {
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(10),
                  ),
                  color: Theme.of(context).colorScheme.surface,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    addVerticalSpacing(10),
                    Center(
                      child: Text("FAQ",
                          style: context.textTheme.displaySmall!
                              .copyWith(fontWeight: FontWeight.bold)),
                    ),
                    addVerticalSpacing(10),
                    ListView.builder(
                        padding: EdgeInsets.fromLTRB(16, 10, 16, 15),
                        itemCount: data.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            margin: EdgeInsets.symmetric(vertical: 5),
                            decoration: BoxDecoration(
                                color:
                                    VmodelColors.jobDetailGrey.withOpacity(0.3),
                                borderRadius: BorderRadius.circular(16)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                RichText(
                                    maxLines: 2,
                                    text: TextSpan(
                                        text: "${index + 1}. ".toString(),
                                        style: context.textTheme.displayMedium!
                                            .copyWith(
                                          fontWeight: FontWeight.w600,
                                        ),
                                        children: [
                                          TextSpan(
                                            text: appendQuestionMark(
                                                data[index].question),
                                            style: context
                                                .textTheme.displaySmall!
                                                .copyWith(
                                                    fontWeight:
                                                        FontWeight.bold),
                                          ),
                                        ])),
                                addVerticalSpacing(5),
                                Text(data[index].answer!),
                              ],
                            ),
                          );
                        }),
                  ],
                ),
              );
            });
      },
      child: Container(
        // height: 100,
        alignment: Alignment.centerLeft,
        width: SizerUtil.width,
        margin: EdgeInsets.symmetric(horizontal: 8),
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Theme.of(context).buttonTheme.colorScheme!.secondary,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Read FAQ",
              style: context.textTheme.displayMedium!.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            addVerticalSpacing(10),
            Text(
              "Read frequently asked questions from others",
              style: context.textTheme.displaySmall!.copyWith(fontSize: 10.sp),
            ),
          ],
        ),
      ),
    );
  }

  String appendQuestionMark(String? question) {
    String? text = question;
    if (question != null) {
      if (question.split("").last != "?") {
        text = (question += "?");
      }
    }

    return text!;
  }
}
