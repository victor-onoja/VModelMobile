import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:vmodel/src/core/utils/helper_functions.dart';
import 'package:vmodel/src/features/settings/views/booking_settings/controllers/user_service_controller.dart';
import 'package:vmodel/src/features/settings/views/booking_settings/models/service_package_model.dart';
import 'package:vmodel/src/shared/appbar/appbar.dart';
import 'package:vmodel/src/shared/bottom_sheets/tile.dart';
import 'package:vmodel/src/shared/carousel_indicators.dart';
import 'package:vmodel/src/shared/loader/full_screen_dialog_loader.dart';
import 'package:vmodel/src/vmodel.dart';

import '../../../../../core/controller/app_user_controller.dart';
import '../../../../../core/utils/costants.dart';
import '../../../../../res/icons.dart';
import '../../../../../res/res.dart';
import '../../../../../shared/bottom_sheets/confirmation_bottom_sheet.dart';
import '../../../../../shared/buttons/brand_outlined_button.dart';
import '../../../../../shared/buttons/primary_button.dart';
import '../../../../../shared/buttons/text_button.dart';
import '../../../../../shared/job_service_section_container.dart';
import '../../../../../shared/modal_pill_widget.dart';
import '../../../../../shared/rend_paint/render_svg.dart';
import '../../../../../shared/shimmer/post_shimmer.dart';
import '../../../../dashboard/new_profile/other_user_profile/other_user_profile.dart';
import '../../../../dashboard/new_profile/profile_features/services/models/user_service_modal.dart';
import '../../../../dashboard/new_profile/profile_features/widgets/profile_picture_widget.dart';
import '../../../../dashboard/new_profile/views/other_profile_router.dart';
import '../../../../../shared/bottom_sheets/description_detail_bottom_sheet.dart';
import '../../../../settings/views/booking_settings/controllers/service_images_controller.dart';
import '../../../../settings/views/booking_settings/controllers/service_packages_controller.dart';
import 'booking_progress_page.dart';

class BookingServiceDetail extends ConsumerStatefulWidget {
  const BookingServiceDetail({
    Key? key,
    required this.service,
    required this.isCurrentUser,
    required this.username,
  }) : super(key: key);

  final ServicePackageModel service;
  final bool isCurrentUser;
  final String username;

  @override
  ConsumerState<BookingServiceDetail> createState() =>
      _BookingServiceDetailState();
}

class _BookingServiceDetailState extends ConsumerState<BookingServiceDetail> {
  bool isSaved = false;
  bool userLiked = false;
  bool userSaved = false;
  int likes = 0;
  final _currencyFormatter = NumberFormat.simpleCurrency(locale: "en_GB");
  final Duration _maxDuration = Duration.zero;
  late ServicePackageModel serviceData;
  final CarouselController _controller = CarouselController();
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    serviceData = widget.service;
    ref
        .read(servicePackagesProvider(widget.username).notifier)
        .getService(serviceId: serviceData.id);

    // for (var item in widget.service.jobDelivery) {
    //   _maxDuration += item.dateDuration;
    // }
    print("data ${serviceData.id}");
  }

  @override
  Widget build(BuildContext context) {
    final requestUsername =
        ref.watch(userNameForApiRequestProvider('${widget.username}'));
    final serviceDetails = ref.watch(servicePackagesProvider(requestUsername));

    final userService = ref.watch(userServicePackagesProvider(UserServiceModel(
        serviceId: serviceData.id, username: widget.username)));

    ref.watch(serviceImagesProvider);
    print("userServicedwedfwe ${userService}");
    print("[ooxf] ${widget.service.id}");
    // data = ref.watch(serviceProvider)!;

    //Todo Wishwell fix this logic. It's causing a crash
    // for (int index = 0; index < serviceDetails.value!.length; index++)
    //   if (data.id == serviceDetails.value![index]) {
    //     data = serviceDetails.value![index];
    //   }

    return Scaffold(
        appBar: VWidgetsAppBar(
          elevation: 0,
          backgroundColor: VmodelColors.white,
          appbarTitle: 'Service Details',
          leadingIcon: const VWidgetsBackButton(),
          trailingIcon: [
            VWidgetsTextButton(
              text: 'More',
              onPressed: () {
                navigateToRoute(context, const BookingsProgressPage());
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
                    if (serviceData.banner.isNotEmpty)
                      Column(
                        children: [
                          CarouselSlider(
                            disableGesture: true,
                            items: List.generate(
                              serviceData.banner.length,
                              (index) => CachedNetworkImage(
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
                                      imageUrl:
                                          serviceData.banner[index].thumbnail!,
                                      fadeInDuration: Duration.zero,
                                      fadeOutDuration: Duration.zero,
                                      width: double.maxFinite,
                                      height: double.maxFinite,
                                      fit: BoxFit.cover,
                                      placeholder: (context, url) {
                                        return const PostShimmerPage();
                                      },
                                    );
                                  },
                                  errorWidget: (context, url, error) =>
                                      // const Icon(Icons.error),
                                      const PostShimmerPage()),
                              //     Image.asset(
                              //   widget.imageList[index],
                              //   width: double.infinity,
                              //   height: double.infinity,
                              //   fit: BoxFit.cover,
                              // ),
                            ),
                            carouselController: _controller,
                            options: CarouselOptions(
                              padEnds: false,
                              viewportFraction: 1,
                              aspectRatio:
                                  0.9 / 1, //UploadAspectRatio.portrait.ratio,
                              initialPage: 0,
                              enableInfiniteScroll: false,
                              // widget.imageList.length > 1 ? true : false,
                              onPageChanged: (index, reason) {
                                _currentIndex = index;
                                setState(() {});
                                // widget.onPageChanged(index, reason);
                              },
                            ),
                          ),
                          if (serviceData.banner.length > 1)
                            addVerticalSpacing(10),
                          if (serviceData.banner.length > 1)
                            VWidgetsCarouselIndicator(
                              currentIndex: _currentIndex,
                              totalIndicators: serviceData.banner.length,
                              height: 4.5,
                              width: 4.5,
                              radius: 8,
                              spacing: 7,
                            ),
                        ],
                      ),
                    addVerticalSpacing(20),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: SectionContainer(
                        // height: 100,
                        // padding: const EdgeInsets.all(16),
                        topRadius: 16,
                        bottomRadius: 0,
                        child: Text(
                          widget.service.title,
                          textAlign: TextAlign.center,
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
                    ),
                    // if (data.bannerUrl.isEmptyOrNull)
                    addVerticalSpacing(2),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: SectionContainer(
                        // padding: const EdgeInsets.all(16),
                        topRadius: 0,
                        bottomRadius: 16,
                        child: Column(
                          children: [
                            // if (!data.bannerUrl.isEmptyOrNull)
                            // RoundedSquareAvatar(
                            //   url: data.bannerUrl,
                            //   size: Size(SizerUtil.width * 0.8, 350),
                            // ),
                            addVerticalSpacing(32),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                // mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  VWidgetsOutlinedButton(
                                    buttonText: 'Read description',
                                    onPressed: () {
                                      _showBottomSheet(context,
                                          title: 'Description',
                                          content: data.description);
                                    },
                                  ),
                                  // addHorizontalSpacing(16),
                                  // VWidgetsOutlinedButton(
                                  //   buttonText: 'Read brief',
                                  //   onPressed: () {
                                  //     _showBottomSheet(context,
                                  //         title: 'Creative Brief',
                                  //         content: data.brief ?? '',
                                  //         briefLink: data.briefLink);
                                  //   },
                                  // ),
                                ],
                              ),
                            ),
                            addVerticalSpacing(32),
                            // _jobPersonRow(context,
                            //     field: 'Paused', value: '${data.paused}'),
                            if (data.category!.isNotEmpty)
                              _jobPersonRow(context,
                                  field: 'Category',
                                  value: '${data.category![0]}'),
                            _jobPersonRow(context,
                                field: 'Pricing',
                                value: data.servicePricing.tileDisplayName),
                            _jobPersonRow(context,
                                field: 'Location',
                                value: data.serviceType.simpleName),
                            _jobPersonRow(context,
                                field: 'Delivery', value: data.delivery),
                            if (data.initialDeposit != null &&
                                data.initialDeposit! > 0)
                              _jobPersonRow(context,
                                  field: 'Deposit',
                                  value:
                                      '${VConstants.noDecimalCurrencyFormatterGB.format(data.initialDeposit?.toInt().round())}'),
                            _jobPersonRow(context,
                                field: 'Status',
                                value: data.processing
                                    ? 'Processing'
                                    : "${data.status}"),
                            // _jobPersonRow(context,
                            //     field: 'Date',
                            //     value: VConstants.simpleDateFormatter
                            //         .format(data.jobDelivery.first.date)),
                          ],
                        ),
                      ),
                    ),
                    addVerticalSpacing(32),
                    _headingText(context, title: 'Price'),
                    addVerticalSpacing(16),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: SectionContainer(
                        padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
                        topRadius: 16,
                        bottomRadius: 16,
                        child: _priceDetails(context),
                      ),
                    ),
                    addVerticalSpacing(32),
                    if (data.isDigitalContentCreator)
                      _headingText(context,
                          title: 'Addtional details and delivery'),
                    if (data.isDigitalContentCreator) addVerticalSpacing(16),
                    if (data.isDigitalContentCreator)
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: SectionContainer(
                          // padding: const EdgeInsets.all(16),
                          topRadius: 16,
                          bottomRadius: 16,
                          child: Column(
                            children: [
                              _jobPersonRow(context,
                                  field: 'Content license',
                                  value: data.usageType?.capitalizeFirstVExt ??
                                      ''),
                              _jobPersonRow(context,
                                  field: 'Content license length',
                                  value:
                                      data.usageLength?.capitalizeFirstVExt ??
                                          ''),
                            ],
                          ),
                        ),
                      ),
                    if (data.isDigitalContentCreator) addVerticalSpacing(32),
                    _headingText(context, title: 'Service by'),
                    addVerticalSpacing(16),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: SectionContainer(
                        topRadius: 16,
                        bottomRadius: 16,
                        child: Row(
                          //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                navigateToRoute(
                                  context,
                                  OtherProfileRouter(
                                      username:
                                          "${widget.service.user?.username}"),
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
                            addHorizontalSpacing(10),
                            Column(
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
                                  crossAxisAlignment: CrossAxisAlignment.center,
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
                                            .displaySmall
                                        // !
                                        // .copyWith(color: VmodelColors.primaryColor,),
                                        ),
                                  ],
                                ),
                                addVerticalSpacing(4),
                                if (widget
                                        .service.user?.location?.locationName !=
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
                                          color:
                                              //  VmodelColors.primaryColor
                                              //     .withOpacity(0.5),
                                              Theme.of(context)
                                                  .textTheme
                                                  .displaySmall
                                                  ?.color
                                                  ?.withOpacity(0.5),
                                        ),
                                  ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    addVerticalSpacing(32),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          VWidgetsPrimaryButton(
                            butttonWidth: 40.w,
                            onPressed: () {
                              _showStartBookingBottomSheet(context);
                            },
                            buttonTitle: 'Start booking',
                            enableButton: true,
                          ),
                          addHorizontalSpacing(16),
                          VWidgetsPrimaryButton(
                            butttonWidth: 40.w,
                            onPressed: () {},
                            buttonTitle: 'Cancel',
                            enableButton: true,
                          ),
                        ],
                      ),
                    ),
                    addVerticalSpacing(32),
                    // Padding(
                    //   padding: EdgeInsets.symmetric(horizontal: 16),
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.center,
                    //     children: [
                    //       SolidCircle(
                    //         radius: 5,
                    //         color:
                    //             Theme.of(context).primaryColor.withOpacity(0.3),
                    //       ),
                    //       addHorizontalSpacing(4),
                    //       Flexible(
                    //         child: Text(
                    //           '${data.views?.pluralize('person', pluralString: 'people')}'
                    //           ' viewed this service in'
                    //           ' the last ${data.createdAt.timeAgoMessage()}',
                    //           style: Theme.of(context)
                    //               .textTheme
                    //               .bodyMedium
                    //               ?.copyWith(
                    //                 fontWeight: FontWeight.w500,
                    //                 fontSize: 12,
                    //                 color: // VmodelColors.primaryColor.withOpacity(0.3),
                    //                     Theme.of(context)
                    //                         .textTheme
                    //                         .bodyMedium
                    //                         ?.color
                    //                         ?.withOpacity(0.3),
                    //               ),
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
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
      padding: const EdgeInsets.symmetric(horizontal: 16),
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

  Future<void> _showStartBookingBottomSheet(
    BuildContext context,
  ) {
    return showModalBottomSheet<void>(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (BuildContext context) {
          return Consumer(builder: (context, ref, child) {
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
                        alignment: Alignment.center,
                        child: VWidgetsModalPill()),
                    addVerticalSpacing(16),
                    Text('Start booking',
                        style:
                            Theme.of(context).textTheme.displayMedium!.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: Theme.of(context).primaryColor,
                                )),
                    addVerticalSpacing(16),
                    Center(
                      child: Text(
                          "Selecting 'Book Now' initiates your order. Please proceed only if you've reviewed all necessary details.",
                          textAlign: TextAlign.center,
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    color: Theme.of(context).primaryColor,
                                  )),
                    ),
                    addVerticalSpacing(20),
                    const Divider(thickness: 0.5),
                    _optionItem(context, title: "Start booking",
                        onOptionTapped: () async {
                      popSheet(context);
                      navigateToRoute(context, const BookingsProgressPage());
                    }),
                    const Divider(thickness: 0.5),
                    _optionItem(context, title: "Go Back",
                        onOptionTapped: () async {
                      popSheet(context);
                    }),
                    addVerticalSpacing(40),
                  ]),
            );
          });
        });
  }

  Padding _optionItem(BuildContext context,
      {required String title, VoidCallback? onOptionTapped}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: GestureDetector(
        onTap: onOptionTapped,
        child: Text(
          title,
          style: Theme.of(context).textTheme.displayMedium!.copyWith(
                fontWeight: FontWeight.w600,
                // color: VmodelColors.primaryColor,
              ),
        ),
      ),
    );
  }
}
