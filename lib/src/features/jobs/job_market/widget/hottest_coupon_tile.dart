import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vmodel/src/features/dashboard/new_profile/views/other_profile_router.dart';
import 'package:vmodel/src/res/colors.dart';
import 'package:vmodel/src/res/gap.dart';
import 'package:vmodel/src/shared/picture_styles/rounded_square_avatar.dart';
import 'package:vmodel/src/vmodel.dart';
import 'package:vmodel/src/shared/response_widgets/toast.dart';
import 'package:vmodel/src/features/messages/widgets/date_time_message.dart';

import '../../../../core/utils/helper_functions.dart';
import '../controller/coupons_controller.dart';

class HottestCouponTile extends ConsumerStatefulWidget {
  const HottestCouponTile({
    super.key,
    required this.index,
    required this.couponId,
    required this.couponTitle,
    required this.couponCode,
    required this.thumbnail,
    this.username,
    this.date,
    // required this.createdDate,
  });

  final int index;
  final String couponId;
  final String couponTitle;
  final String couponCode;
  final String thumbnail;
  final String? username;
  final DateTime? date;
  // final DateTime createdDate;

  @override
  ConsumerState<HottestCouponTile> createState() => _HottestCouponTileState();
}

class _HottestCouponTileState extends ConsumerState<HottestCouponTile> {
  final _isCopied = ValueNotifier(false);
  // List<MaterialColor> _colors = [];
  List<MaterialColor> _colors = [
    Colors.deepPurple,
    Colors.indigo,
    Colors.blue,
    Colors.lightBlue,
    Colors.cyan,
    Colors.teal,
    Colors.green,
    Colors.lightGreen,
    // Colors.lime,
    // Colors.yellow,
    Colors.amber,
    Colors.orange,
    Colors.deepOrange,
    Colors.purple,
    Colors.pink,
    Colors.red,
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60.w,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: _colors[widget.index % Colors.primaries.length],
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
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
                onTap: () {
                  ref.read(recordCouponCopyProvider(widget.couponId));
                  copyCouponToClipboard(widget.couponCode.toUpperCase());
                  // _isCopied.value = true;
                  print("nbwaoifejk");
                  toastContainer(text: "Coupon copied");
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
                                  color: Colors.white,
                                  // color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.w500,
                                )),
                    addVerticalSpacing(5),
                    Text(
                      widget.couponCode,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.displaySmall!.copyWith(
                            fontWeight: FontWeight.w600,
                            // color: Theme.of(context).primaryColor,
                            color: Colors.white,
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
                        // color: VmodelColors.greyColor,
                        color: Colors.white,
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