import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vmodel/src/core/controller/app_user_controller.dart';
import 'package:vmodel/src/core/models/app_user.dart';
import 'package:vmodel/src/core/utils/costants.dart';
import 'package:vmodel/src/res/icons.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/shared/picture_styles/rounded_square_avatar.dart';
import 'package:vmodel/src/shared/rend_paint/render_svg.dart';
import 'package:vmodel/src/shared/response_widgets/toast_dialogue.dart';
import 'package:vmodel/src/vmodel.dart';

import '../../../../../../core/utils/helper_functions.dart';
import '../../../../../settings/views/booking_settings/controllers/user_service_controller.dart';
import '../../../../../settings/views/booking_settings/models/service_package_model.dart';
import '../models/user_service_modal.dart';

class ServiceSubItem extends ConsumerStatefulWidget {
  final ServicePackageModel item;
  final VoidCallback? onTap;
  final bool isViewAll;
  final VoidCallback? onLongPress;
  final VAppUser user;
  const ServiceSubItem({
    Key? key,
    required this.item,
    required this.onTap,
    required this.user,
    required this.onLongPress,
    this.isViewAll = false,
  }) : super(key: key);

  @override
  ConsumerState<ServiceSubItem> createState() => _ServiceSubItemState();
}

class _ServiceSubItemState extends ConsumerState<ServiceSubItem> {
  bool? isSaved;
  @override
  Widget build(BuildContext context) {
    final isCurrentUser =
        ref.read(appUserProvider.notifier).isCurrentUser(widget.user.username);
    TextTheme textTheme = Theme.of(context).textTheme;
    int subFontSize = 10;
    int subGreyFontSize = 10;
    if (isSaved == null) isSaved = widget.item.userSaved;
    return Column(
      children: [
        Container(
          height: 154,
          width: SizerUtil.width * 0.40,
          margin: EdgeInsets.symmetric(horizontal: widget.isViewAll ? 0 : 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
          ),
          child: GestureDetector(
            onTap: () {
              widget.onTap!();
            },
            onLongPress: () {
              if (isCurrentUser){
                ref
                    .read(userServicePackagesProvider(UserServiceModel(
                      serviceId: widget.item.id,
                      username: widget.user.username,
                    )).notifier)
                    .saveService(widget.item.id);
              HapticFeedback.lightImpact();
              if (!isSaved!) {
                isSaved = true;
                toastDialoge(
                  text: "Service saved",
                  context: context,
                  toastLength: Duration(seconds: 2),
                );
              } else {
                toastDialoge(
                  text: "Service unsaved",
                  context: context,
                  toastLength: Duration(seconds: 2),
                );
                isSaved = false;
              }
              setState(() {});}
            },
            child: RoundedSquareAvatar(
              url: widget.item.banner.length > 0
                  ? widget.item.banner[0].url
                  : widget.item.user!.profilePictureUrl,
              thumbnail: widget.item.banner.length > 0
                  ? widget.item.banner[0].thumbnail
                  : widget.item.user!.thumbnailUrl ??
                      widget.item.user!.thumbnailUrl,
            ),
          ),
        ),
        addVerticalSpacing(15),
        Column(
          children: [
            SizedBox(
              width: SizerUtil.width * 0.42,
              child: Text(
                widget.item.title,
                style:
                    textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w400),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            addVerticalSpacing(5),
            SizedBox(
              width: SizerUtil.width * 0.42,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                      widget.item.servicePricing.tileDisplayName,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w300,
                            // fontSize: subFontSize.sp,
                          ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Row(
                    children: [
                      if (isValidDiscount(widget.item.percentDiscount))
                        Text(
                          VConstants.noDecimalCurrencyFormatterGB
                              .format(widget.item.price),
                          style: Theme.of(context)
                              .textTheme
                              .displaySmall!
                              .copyWith(
                                // fontWeight: FontWeight.w400,
                                fontSize: subFontSize.sp,
                                decoration: TextDecoration.lineThrough,
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.color
                                    ?.withOpacity(0.3),
                                // color: VmodelColors.primaryColor,
                              ),
                        ),
                      addHorizontalSpacing(8),
                      Text(
                        isValidDiscount(widget.item.percentDiscount)
                            ? VConstants.noDecimalCurrencyFormatterGB.format(
                                calculateDiscountedAmount(
                                        price: widget.item.price,
                                        discount: widget.item.percentDiscount)
                                    .round())
                            : VConstants.noDecimalCurrencyFormatterGB
                                .format(widget.item.price),
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              fontWeight: FontWeight.w300,
                              // fontSize: subFontSize.sp,
                              // color: VmodelColors.primaryColor,
                            ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            addVerticalSpacing(5),
            SizedBox(
              width: SizerUtil.width * 0.42,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.item.serviceType.simpleName,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w300,
                          // fontSize: subGreyFontSize.sp,
                          color:
                              Theme.of(context).primaryColor.withOpacity(0.5),
                        ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Row(
                    children: [
                      RenderSvg(
                        svgPath: VIcons.star,
                        svgHeight: 12,
                        svgWidth: 12,
                        color: Theme.of(context).primaryColor.withOpacity(0.5),
                      ),
                      addHorizontalSpacing(5),
                      Text(
                        '4.5',
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              fontWeight: FontWeight.w300,
                              // fontSize: subGreyFontSize.sp,
                              color: Theme.of(context)
                                  .primaryColor
                                  .withOpacity(0.5),
                            ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            addVerticalSpacing(5),
            SizedBox(
              width: SizerUtil.width * 0.42,
              child: Row(
                children: [
                  RenderSvg(
                    svgPath: VIcons.clock,
                    svgHeight: 15,
                    svgWidth: 15,
                    color: Theme.of(context).primaryColor.withOpacity(0.5),
                  ),
                  addHorizontalSpacing(3),
                  Text(
                    "${widget.item.delivery}",
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w300,
                          // fontSize: subGreyFontSize.sp,
                          color:
                              Theme.of(context).primaryColor.withOpacity(0.5),
                        ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
