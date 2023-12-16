import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vmodel/src/features/dashboard/new_profile/views/other_profile_router.dart';
import 'package:vmodel/src/res/colors.dart';
import 'package:vmodel/src/res/gap.dart';
import 'package:vmodel/src/shared/picture_styles/rounded_square_avatar.dart';
import 'package:vmodel/src/shared/popup_dialogs/response_dialogue.dart';
import 'package:vmodel/src/vmodel.dart';
import 'package:vmodel/src/features/messages/widgets/date_time_message.dart';

import '../../../../core/utils/helper_functions.dart';
import '../controller/coupons_controller.dart';

class CouponsWidgetSimple extends ConsumerStatefulWidget {
  const CouponsWidgetSimple({
    super.key,
    required this.couponId,
    required this.couponTitle,
    required this.couponCode,
    required this.thumbnail,
    this.username,
    this.date,
    // required this.createdDate,
  });

  final String couponId;
  final String couponTitle;
  final String couponCode;
  final String thumbnail;
  final String? username;
  final DateTime? date;
  // final DateTime createdDate;

  @override
  ConsumerState<CouponsWidgetSimple> createState() =>
      _CouponsWidgetSimpleState();
}

class _CouponsWidgetSimpleState extends ConsumerState<CouponsWidgetSimple> {
  final _isCopied = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: widget.username == null
                  ? null
                  : () => navigateToRoute(
                      context, OtherProfileRouter(username: widget.username!)),
              child: RoundedSquareAvatar(
                url: widget.thumbnail,
                thumbnail: widget.thumbnail,
                radius: 100,
              ),
            ),
            addHorizontalSpacing(10),
            Flexible(
              child: InkWell(
                onTap: () async {
                  ref.read(recordCouponCopyProvider(widget.couponId));
                  copyCouponToClipboard(widget.couponCode.toUpperCase());

                  responseDialog(context, "Coupon copied");
                  await Future.delayed(Duration(seconds: 2));
                  Navigator.pop(context);
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    addVerticalSpacing(5),
                    Text(widget.couponTitle,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style:
                            Theme.of(context).textTheme.displayMedium!.copyWith(
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                )),
                    addVerticalSpacing(5),
                    Text(
                      widget.couponCode,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.displaySmall!.copyWith(
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).primaryColor,
                            fontSize: 14,
                          ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ValueListenableBuilder(
                            valueListenable: _isCopied,
                            builder: (context, value, _) {
                              if (value) {
                                Future.delayed(const Duration(seconds: 2), () {
                                  _isCopied.value = false;
                                });
                                return Text(
                                  "Copied",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context)
                                      .textTheme
                                      .displaySmall!
                                      .copyWith(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 12,
                                        color: VmodelColors.greyColor,
                                      ),
                                );
                              }
                              return const Spacer();
                            }),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            // GestureDetector(
            //   onTap: () {},
            //   child: RenderSvg(svgPath: VIcons.remove),
            // )
            Column(
              children: [
                addVerticalSpacing(10),
                Text(
                  widget.date?.dateAgoMessage() ?? "", // e.msg.toString(),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.normal,
                        fontSize: 12,
                        color: VmodelColors.greyColor,
                      ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}


//  addHorizontalSpacing(15),
//                               Expanded(
//                                 child: addHorizontalSpacing(15),
//                               ),
//                               //budget icon
//                               GestureDetector(
//                                 onTap: () {
//                                   copyTextToClipboard(
//                                       widget.couponCode.toUpperCase());
//                                   _isCopied.value = true;
//                                 },
//                                 child: Container(
//                                   color: Colors.transparent,
//                                   padding: const EdgeInsets.symmetric(
//                                       horizontal: 4, vertical: 1),
//                                   child: RenderSvg(
//                                     svgPath: VIcons.copyUrlIcon,
//                                     color: Theme.of(context).primaryColor,
//                                     svgHeight: 20,
//                                     svgWidth: 20,
//                                   ),
//                                 ),
//                               ),
//                               addHorizontalSpacing(4),