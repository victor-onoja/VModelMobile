import 'package:flutter/material.dart';
import 'package:vmodel/src/core/utils/validators_mixins.dart';
import 'package:vmodel/src/res/gap.dart';
import 'package:vmodel/src/res/icons.dart';
import 'package:vmodel/src/shared/picture_styles/rounded_square_avatar.dart';
import 'package:vmodel/src/shared/rend_paint/render_svg.dart';

class LocalServicesWidget extends StatelessWidget {
  const LocalServicesWidget({
    super.key,
    required this.title,
    required this.price,
    required this.applied,
    required ScrollController controller,
    required this.perService,
    required this.discount,
    this.serviceBanner,
  });

  final String? serviceBanner;
  final String title;
  final String price;
  final String perService;
  final bool applied;
  final String discount;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        // color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.2),
            blurRadius: 5.0, // soften the shadow
            spreadRadius: -3, //extend the shadow
            offset: const Offset(0.0, 0.0),
          )
        ],
      ),
      child: Card(
        elevation: 0,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (!serviceBanner.isEmptyOrNull)
                    // Todo add Thumbnail
                    RoundedSquareAvatar(
                      url: serviceBanner,
                      thumbnail: serviceBanner,
                    ),
                  addHorizontalSpacing(10),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Flexible(
                              child: Text(
                                title, // e.msg.toString(),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context)
                                    .textTheme
                                    .displayMedium!
                                    .copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: Theme.of(context).primaryColor,
                                    ),
                              ),
                            ),
                          ],
                        ),
                        addVerticalSpacing(10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ///location Icon
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const RenderSvg(
                                  svgPath: VIcons.locationIcon,
                                  svgHeight: 20,
                                  svgWidth: 20,
                                ),
                                addHorizontalSpacing(6),
                                Text(
                                  perService,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context)
                                      .textTheme
                                      .displaySmall!
                                      .copyWith(
                                        color: Theme.of(context).primaryColor,
                                      ),
                                ),
                              ],
                            ),
                            addHorizontalSpacing(15),
                            Expanded(
                              child: addHorizontalSpacing(15),
                            ),
                            //budget icon
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const RenderSvg(
                                  svgPath: VIcons.walletIcon,
                                  svgHeight: 15,
                                  svgWidth: 15,
                                ),
                                addHorizontalSpacing(6),
                                Text(
                                  price,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context)
                                      .textTheme
                                      .displaySmall!
                                      .copyWith(
                                        fontWeight: FontWeight.w500,
                                        color: Theme.of(context).primaryColor,
                                      ),
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

              // if (enableDescription) addVerticalSpacing(12),
              Row(
                mainAxisAlignment: int.parse(discount) > 0
                    ? MainAxisAlignment.spaceBetween
                    : MainAxisAlignment.end,
                children: [
                  if (int.parse(discount) > 0)
                    Text(
                      "Discounted ($discount %)", // e.msg.toString(),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                            color:
                                Theme.of(context).primaryColor.withOpacity(0.5),
                          ),
                    ),
                  Text(
                    "Per service", // e.msg.toString(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                          color:
                              Theme.of(context).primaryColor.withOpacity(0.5),
                        ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
