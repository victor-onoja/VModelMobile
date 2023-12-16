import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vmodel/src/features/dashboard/new_profile/views/other_profile_router.dart';
import 'package:vmodel/src/res/gap.dart';
import 'package:vmodel/src/shared/picture_styles/rounded_square_avatar.dart';
import 'package:vmodel/src/vmodel.dart';

import '../../../../core/utils/helper_functions.dart';
import '../controller/coupons_controller.dart';

class CouponsWidget extends ConsumerStatefulWidget {
  const CouponsWidget({
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
  ConsumerState<CouponsWidget> createState() => _CouponsWidgetState();
}

class _CouponsWidgetState extends ConsumerState<CouponsWidget> {
  final _isCopied = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        // color: Colors.white,
        // boxShadow: [
        //   BoxShadow(
        //     color: Colors.black.withOpacity(.2),
        //     blurRadius: 5.0, // soften the shadow
        //     spreadRadius: -3, //extend the shadow
        //     offset: const Offset(0.0, 0.0),
        //   ),
        // ],
      ),
      child: GestureDetector(
        onTap: () {
          ref.read(recordCouponCopyProvider(widget.couponId));
          copyCouponToClipboard(widget.couponCode.toUpperCase());
          _isCopied.value = true;
        },
        // child: Card(
        //   elevation: 0,
        //   shape:
        //       RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            // crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: widget.username == null
                    ? null
                    : () => navigateToRoute(context,
                        OtherProfileRouter(username: widget.username!)),
                child: RoundedSquareAvatar(
                  url: widget.thumbnail,
                  thumbnail: widget.thumbnail,
                  radius: 100,
                ),
              ),
              addHorizontalSpacing(10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    addVerticalSpacing(5),
                    Text(widget.couponTitle,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style:
                            Theme.of(context).textTheme.displaySmall!.copyWith(
                                  color: Theme.of(context).primaryColor,
                                )),
                    addVerticalSpacing(5),
                    Text(
                      widget.couponCode,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.displaySmall!.copyWith(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).primaryColor,
                          ),
                    ),
                    // addVerticalSpacing(10),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     ValueListenableBuilder(
                    //         valueListenable: _isCopied,
                    //         builder: (context, value, _) {
                    //           if (value) {
                    //             Future.delayed(const Duration(seconds: 2), () {
                    //               _isCopied.value = false;
                    //             });
                    //             return Text(
                    //               "Copied",
                    //               maxLines: 1,
                    //               overflow: TextOverflow.ellipsis,
                    //               style: Theme.of(context)
                    //                   .textTheme
                    //                   .displaySmall!
                    //                   .copyWith(
                    //                     fontWeight: FontWeight.normal,
                    //                     fontSize: 12,
                    //                     color: VmodelColors.greyColor,
                    //                   ),
                    //             );
                    //           }
                    //           return const Spacer();
                    //         }),
                    //   ],
                    // ),
                  ],
                ),
              ),
              // Text(
              //   widget.date?.dateAgoMessage() ?? "", // e.msg.toString(),
              //   maxLines: 1,
              //   overflow: TextOverflow.ellipsis,
              //   style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              //         fontWeight: FontWeight.normal,
              //         fontSize: 12,
              //         color: VmodelColors.greyColor,
              //       ),
              // ),
              // GestureDetector(
              //   onTap: () {},
              //   child: RenderSvg(svgPath: VIcons.remove),
              // )
            ],
          ),
          // ),
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