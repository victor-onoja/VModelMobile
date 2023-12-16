import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sizer/sizer.dart';
import 'package:vmodel/src/features/create_coupons/add_coupons.dart';

import '../../../core/controller/app_user_controller.dart';
import '../../../core/routing/navigator_1.0.dart';
import '../../../core/utils/helper_functions.dart';
import '../../../res/colors.dart';
import '../../../res/gap.dart';
import '../../../res/icons.dart';
import '../../../shared/buttons/text_button.dart';
import '../../../shared/modal_pill_widget.dart';
import '../../../shared/rend_paint/render_svg.dart';
import '../../jobs/job_market/controller/coupons_controller.dart';
import '../controller/create_coupon_controller.dart';

class CouponBottomSheet extends ConsumerWidget {
  const CouponBottomSheet({
    super.key,
    required this.title,
    required this.username,
    this.isCurrentUser = false,
  });
  final bool isCurrentUser;
  final String title;
  final String username;
  // final bool

  // CouponNotifier _createCoupon = CouponNotifier();

  // List userCoupons = [];

  // Future getCouponData() async {
  //   final data = await _createCoupon.getCoupon('');

  //   print('----------------------------');
  //   print('-----$data-------');

  //   print(data['userCoupons']);

  //   return data['userCoupons'];
  // }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final String couponCode = 'Welcometonikediscount'.toUpperCase();

    final requrestUsername = ref.watch(userNameForApiRequestProvider(username));
    final copied = ValueNotifier<bool>(false);
    final copiedIndex = ValueNotifier<int>(0);
    final userCoupons =
        ref.watch(userCouponsProvider(requrestUsername)).valueOrNull ?? [];

    return Container(
      constraints: BoxConstraints(
        maxHeight: SizerUtil.height * 0.9,
        minHeight: SizerUtil.height * 0.2,
        minWidth: SizerUtil.width,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          addVerticalSpacing(15),
          const Align(alignment: Alignment.center, child: VWidgetsModalPill()),
          addVerticalSpacing(24),
          Text(
            title,
            style: Theme.of(context).textTheme.displayMedium!.copyWith(
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).primaryColor,
                  // fontSize: 12,
                ),
          ),
          addVerticalSpacing(16),
          Flexible(
            child: Container(
              width: double.maxFinite,
              margin: const EdgeInsets.symmetric(horizontal: 24),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: VmodelColors.jobDetailGrey.withOpacity(0.3),
                borderRadius: BorderRadius.circular(16),
              ),
              child: RawScrollbar(
                mainAxisMargin: 4,
                crossAxisMargin: -8,
                thumbVisibility: true,
                thumbColor: Theme.of(context).primaryColor.withOpacity(0.3),
                thickness: 4,
                radius: const Radius.circular(10),
                child: ListView.builder(
                  itemCount: userCoupons.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 16, bottom: 4),
                              child: Text(
                                userCoupons[index].title,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                      fontWeight: FontWeight.w500,
                                      color: Theme.of(context).primaryColor,
                                    ),
                              ),
                            ),
                            ValueListenableBuilder(
                                valueListenable: copiedIndex,
                                builder: (context, copiedIndexValue, child) {
                                  return ValueListenableBuilder(
                                      valueListenable: copied,
                                      builder: (context, value, child) {
                                        // show if copied and copied index is same as current index
                                        if (value &&
                                            copiedIndexValue == index) {
                                          return Padding(
                                            padding: const EdgeInsets.only(
                                                top: 16, bottom: 4),
                                            child: Text(
                                              'Copied!',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall!
                                                  .copyWith(
                                                    fontWeight: FontWeight.w500,
                                                    // color: VmodelColors
                                                    //     .primaryColor,
                                                  ),
                                            ),
                                          );
                                        }
                                        return const SizedBox.shrink();
                                      });
                                }),
                          ],
                        ),
                        SizedBox(
                          width: double.maxFinite,
                          child: TextButton(
                            style: TextButton.styleFrom(
                              backgroundColor: Theme.of(context)
                                  .scaffoldBackgroundColor
                                  .withOpacity(.5),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            onLongPress: isCurrentUser
                                ? () {
                                    goBack(context);
                                    navigateToRoute(
                                        context,
                                        AddNewCouponHomepage(
                                          context,
                                          servicePackage: null,
                                          couponCode: userCoupons[index].code,
                                          coupoTtitle: userCoupons[index].title,
                                          isUpdate: true,
                                          couponId: userCoupons[index].id,
                                        ));
                                  }
                                : null,
                            onPressed: () {
                              copiedIndex.value = index;
                              ref.read(recordCouponCopyProvider(
                                  userCoupons[index].id));
                              copyCouponToClipboard(
                                  userCoupons[index].code.toUpperCase());
                              copied.value = true;
                              Future.delayed(const Duration(seconds: 2), () {
                                copied.value = false;
                              });
                            },
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      // snapshot.data[index]['code']
                                      userCoupons[index]
                                          .code
                                          // .toString()
                                          .toUpperCase(),
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context)
                                          .textTheme
                                          .displayLarge!
                                          .copyWith(
                                            fontWeight: FontWeight.w500,
                                            color:
                                                Theme.of(context).primaryColor,
                                          ),
                                    ),
                                    RenderSvg(
                                      svgPath: VIcons.copyUrlIcon,
                                      svgHeight: 14,
                                      svgWidth: 14,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        addVerticalSpacing(8),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
          addVerticalSpacing(16),
          VWidgetsTextButton(
            text: 'Close',
            onPressed: () => goBack(context),
          ),
          addVerticalSpacing(24),
        ],
      ),
    );

    // return FutureBuilder(
    //   future: getCouponData(),
    //   builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
    //     if (snapshot.hasData) {
    //       userCoupons = [...snapshot.data];
    //     }

    //     print('usercoupons');
    //     print(userCoupons);

    //     return Container(
    //       constraints: BoxConstraints(
    //         maxHeight: SizerUtil.height * 0.6,
    //         minHeight: SizerUtil.height * 0.2,
    //         minWidth: SizerUtil.width,
    //       ),
    //       decoration: BoxDecoration(
    //         color: VmodelColors.white,
    //         borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
    //       ),
    //       child: Column(
    //         mainAxisSize: MainAxisSize.min,
    //         children: [
    //           addVerticalSpacing(24),
    //           Text(
    //             widget.title,
    //             style: Theme.of(context).textTheme.displayMedium!.copyWith(
    //                   fontWeight: FontWeight.w600,
    //                   color: VmodelColors.primaryColor,
    //                   // fontSize: 12,
    //                 ),
    //           ),
    //           addVerticalSpacing(16),
    //           Expanded(
    //             child: Container(
    //               //height: 250,
    //               width: double.maxFinite,
    //               margin: const EdgeInsets.symmetric(horizontal: 24),
    //               padding: const EdgeInsets.symmetric(horizontal: 16),
    //               decoration: BoxDecoration(
    //                 color: VmodelColors.jobDetailGrey.withOpacity(0.3),
    //                 borderRadius: BorderRadius.circular(16),
    //                 // borderRadius: const BorderRadius.only(
    //                 //     topLeft: Radius.circular(16),
    //                 //     topRight: Radius.circular(16)),
    //               ),
    //               child: ListView.builder(
    //                 itemCount: userCoupons.length,
    //                 itemBuilder: (context, index) {
    //                   return Flexible(
    //                     child: Container(
    //                       child: RawScrollbar(
    //                         mainAxisMargin: 4,
    //                         crossAxisMargin: -8,
    //                         thumbVisibility: true,
    //                         thumbColor:
    //                             VmodelColors.primaryColor.withOpacity(0.3),
    //                         thickness: 4,
    //                         radius: const Radius.circular(10),
    //                         child: SingleChildScrollView(
    //                           child: Column(
    //                             crossAxisAlignment: CrossAxisAlignment.start,
    //                             children: [
    //                               if (!widget.briefLink.isEmptyOrNull)
    //                                 Padding(
    //                                   padding: const EdgeInsets.symmetric(
    //                                       vertical: 16),
    //                                   child: Text(
    //                                     snapshot.data[index]['title']
    //                                         .toString()
    //                                         .toUpperCase(),
    //                                     style: Theme.of(context)
    //                                         .textTheme
    //                                         .bodyMedium!
    //                                         .copyWith(
    //                                           fontWeight: FontWeight.w500,
    //                                           color: VmodelColors.primaryColor,
    //                                         ),
    //                                   ),
    //                                 ),
    //                               if (!widget.briefLink.isEmptyOrNull)
    //                                 SizedBox(
    //                                   width: double.maxFinite,
    //                                   child: TextButton(
    //                                     style: TextButton.styleFrom(
    //                                       backgroundColor: VmodelColors.white,
    //                                       shape: RoundedRectangleBorder(
    //                                         borderRadius:
    //                                             BorderRadius.circular(8),
    //                                       ),
    //                                     ),
    //                                     onPressed: () {
    //                                       _copyToClipboard(couponCode);
    //                                     },
    //                                     child: Column(
    //                                       mainAxisSize: MainAxisSize.min,
    //                                       children: [
    //                                         Row(
    //                                           mainAxisAlignment:
    //                                               MainAxisAlignment
    //                                                   .spaceBetween,
    //                                           children: [
    //                                             Text(
    //                                               snapshot.data[index]['code']
    //                                                   .toString()
    //                                                   .toUpperCase(),
    //                                               textAlign: TextAlign.center,
    //                                               style: Theme.of(context)
    //                                                   .textTheme
    //                                                   .displayLarge!
    //                                                   .copyWith(
    //                                                     fontWeight:
    //                                                         FontWeight.w500,
    //                                                     color: VmodelColors
    //                                                         .primaryColor,
    //                                                   ),
    //                                             ),
    //                                             RenderSvgWithoutColor(
    //                                               svgPath:
    //                                                   VIcons.copyCouponIcon,
    //                                               svgHeight: 14,
    //                                               svgWidth: 14,
    //                                             ),
    //                                           ],
    //                                         ),
    //                                       ],
    //                                     ),
    //                                   ),
    //                                 ),
    //                             ],
    //                           ),
    //                         ),
    //                       ),
    //                     ),
    //                   );
    //                 },
    //               ),
    //             ),
    //           ),
    //           addVerticalSpacing(16),
    //           VWidgetsTextButton(
    //             text: 'Close',
    //             onPressed: () => goBack(context),
    //           ),
    //           addVerticalSpacing(24),
    //         ],
    //       ),
    //     );
    //   },
    // );
  }
}
