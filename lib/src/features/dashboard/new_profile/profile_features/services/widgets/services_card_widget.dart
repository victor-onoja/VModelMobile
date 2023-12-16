import 'package:vmodel/src/core/models/app_user.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/vmodel.dart';

import '../../../../../../core/utils/costants.dart';
import '../../../../../../core/utils/helper_functions.dart';
import '../../../../../../res/icons.dart';
import '../../../../../../shared/picture_styles/rounded_square_avatar.dart';
import '../../../../../../shared/rend_paint/render_svg.dart';

class VWidgetsServicesCardWidget extends StatelessWidget {
  final String serviceName;
  final String serviceType;
  final String serviceLocation;
  final String date;
  final String? bannerUrl;
  final double serviceCharge;
  final int discount;
  final String serviceDescription;
  final VoidCallback onTap;
  final VoidCallback? onLongPress;
  final bool? showDescription;
  final int? serviceLikes;
  final Color? statusColor;
  final VAppUser? user;

  const VWidgetsServicesCardWidget({
    super.key,
    required this.serviceName,
    required this.serviceType,
    required this.serviceLocation,
    required this.serviceCharge,
    required this.date,
    required this.discount,
    required this.serviceDescription,
    required this.onTap,
    required this.bannerUrl,
    this.onLongPress,
    this.showDescription = false,
    this.serviceLikes,
    this.statusColor,
    this.user,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // navigateToRoute(context, const JobDetailPage());
        onTap();
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // addHorizontalSpacing(10),
                  // if (!bannerUrl.isEmptyOrNull)
                  RoundedSquareAvatar(
                    url: bannerUrl ??
                        user!.thumbnailUrl ??
                        user!.profilePictureUrl ??
                        "",
                    thumbnail: bannerUrl ??
                        user!.thumbnailUrl ??
                        user!.profilePictureUrl ??
                        "",
                  ),
                  addHorizontalSpacing(10),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                serviceName,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context)
                                    .textTheme
                                    .displayLarge!
                                    .copyWith(
                                      fontWeight: FontWeight.w500,
                                    ),
                              ),
                            ),
                            if (statusColor != null)
                              Container(
                                height: 7,
                                width: 7,
                                decoration: BoxDecoration(
                                  color: statusColor,
                                  borderRadius: BorderRadius.circular(14),
                                ),
                              ),
                          ],
                        ),
                        addVerticalSpacing(15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ///location Icon
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                // RenderSvg(
                                //   svgPath: VIcons.locationIcon,
                                //   svgHeight: 20,
                                //   svgWidth: 20,
                                //   color: Theme.of(context).iconTheme.color,
                                // ),
                                // addHorizontalSpacing(6),
                                // Text(
                                //   '${VMString.bullet} ${date}',
                                //   maxLines: 1,
                                //   overflow: TextOverflow.ellipsis,
                                //   style: Theme.of(context)
                                //       .textTheme
                                //       .displaySmall!
                                //       .copyWith(
                                //         color: Theme.of(context).primaryColor,
                                //       ),
                                // ),
                              ],
                            ),
                            addHorizontalSpacing(15),

                            ///time Icon
                            // Row(
                            //   crossAxisAlignment:
                            //       CrossAxisAlignment.start,
                            //   children: [
                            //     const RenderSvg(
                            //       svgPath: VIcons.clockIcon,
                            //       svgHeight: 16,
                            //       svgWidth: 16,
                            //       color: VmodelColors.primaryColor,
                            //     ),
                            //     addHorizontalSpacing(6),
                            //     Text(
                            //       time!,
                            //       maxLines: 1,
                            //       overflow: TextOverflow.ellipsis,
                            //       style: Theme.of(context)
                            //           .textTheme
                            //           .displaySmall!
                            //           .copyWith(
                            //             color: Theme.of(context)
                            //                 .primaryColor,
                            //           ),
                            //     ),
                            //   ],
                            // ),
                            Expanded(
                              child: addHorizontalSpacing(15),
                            ),

                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // RenderSvg(
                                //   svgPath: VIcons.walletIcon,
                                //   svgHeight: 15,
                                //   svgWidth: 15,
                                //   color: Theme.of(context).iconTheme.color,
                                // ),
                                // addHorizontalSpacing(6),
                                if (discount > 5)
                                  Text(
                                    "${VMString.poundSymbol}${serviceCharge.round()}",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(
                                          // fontWeight: FontWeight.w500,
                                          color: Theme.of(context)
                                              .primaryColor
                                              .withOpacity(0.5),
                                          // color: Colors.pink,
                                          decoration:
                                              TextDecoration.lineThrough,
                                        ),
                                  ),
                                SizedBox(width: 4),
                                Text(
                                  // "${VMString.poundSymbol} $jobBudget",
                                  // "${VMString.poundSymbol} 1.5M",
                                  VConstants.noDecimalCurrencyFormatterGB
                                      .format(calculateDiscountedAmount(
                                              price: serviceCharge,
                                              discount: discount)
                                          .round()),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context).textTheme.bodyLarge!,
                                ),
                              ],
                            ),
                            addHorizontalSpacing(4),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              addVerticalSpacing(12),
              Row(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        '${VMString.bullet} $serviceLocation',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              fontWeight: FontWeight.w500,
                              color: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.color
                                  ?.withOpacity(0.5),
                            ),
                      ),
                    ],
                  ),
                  Expanded(child: SizedBox(width: 16)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${VMString.bullet} $serviceType', // e.msg.toString(),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              fontWeight: FontWeight.w500,
                              color: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.color
                                  ?.withOpacity(0.5),
                              // color: Colors.pink,
                            ),
                      ),
                    ],
                  ),
                  Expanded(child: SizedBox(width: 16)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      RenderSvg(
                        svgHeight: 15,
                        svgWidth: 15,
                        svgPath: VIcons.star,
                        color:
                            Theme.of(context).iconTheme.color?.withOpacity(.5),
                      ),
                      addHorizontalSpacing(5),
                      Text(
                        '4.5', // e.msg.toString(),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              fontWeight: FontWeight.w500,
                              color: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.color
                                  ?.withOpacity(0.5),
                              // color: Colors.pink,
                            ),
                      ),
                    ],
                  ),
                ],
              ),
              if (showDescription!) ...[
                addVerticalSpacing(10),
                Text(
                  serviceDescription,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.displayMedium!.copyWith(
                        fontWeight: FontWeight.w400,
                      ),
                ),
              ]
            ],
          ),
          // ),
        ),
      ),
    );
  }

  GestureDetector _oldBody(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      onLongPress: onLongPress,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  serviceName.capitalizeFirst!,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.displayMedium!.copyWith(
                        color: VmodelColors.primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ),
              addHorizontalSpacing(4),
              Row(
                children: [
                  Text(
                    serviceType,
                    style: Theme.of(context).textTheme.displayMedium!.copyWith(
                          color: VmodelColors.primaryColor,
                          fontWeight: FontWeight.w400,
                        ),
                  ),
                  addHorizontalSpacing(10),
                  Text(
                    "£$serviceCharge",
                    style: Theme.of(context).textTheme.displayMedium!.copyWith(
                          color: VmodelColors.primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ],
              ),
            ],
          ),
          addVerticalSpacing(10),
          Text(
            "serviceDescription",
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.displayMedium!.copyWith(
                  color: VmodelColors.primaryColor.withOpacity(0.5),
                  fontWeight: FontWeight.w400,
                ),
          ),
          addVerticalSpacing(5),
          Divider(
            thickness: 1,
            color: VmodelColors.dividerColor,
          ),
          addVerticalSpacing(12)
        ],
      ),
    );
  }
}
