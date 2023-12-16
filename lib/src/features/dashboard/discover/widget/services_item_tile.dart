import 'package:vmodel/src/res/icons.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/shared/rend_paint/render_svg.dart';
import 'package:vmodel/src/vmodel.dart';


class VWidgetDiscoverServiceItemTile extends StatelessWidget {
  final String? profileImage;
  final String? profileName;
  final String? jobDescription;
  final String? rating;
  final String? time;
  final String? appliedCandidateCount;
  final String? jobBudget;
  final String? candidateType;
  final VoidCallback? shareJobOnPressed;
  final VoidCallback onItemTap;
  final Widget imageWidget;

  const VWidgetDiscoverServiceItemTile(
      {required this.profileImage,
      required this.profileName,
      required this.jobDescription,
      required this.rating,
      required this.time,
      required this.appliedCandidateCount,
      required this.jobBudget,
      required this.candidateType,
      required this.shareJobOnPressed,
      required this.onItemTap,
      required this.imageWidget,
      super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onItemTap();
        // VWidgetShowResponse.showToast(ResponseEnum.sucesss,
        //     message: "#22 Service item tapped");
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            // CustomBoxShadow(
            //     color: Colors.grey.withOpacity(.5),
            //     offset: Offset(5.0, 5.0),
            //     blurRadius: 5.0,
            //     blurStyle: BlurStyle.outer)
            BoxShadow(
              color: Colors.black.withOpacity(.07),
              blurRadius: 5.0, // soften the shadow
              spreadRadius: -3, //extend the shadow
              offset: const Offset(0.0, 0.0),
            )
          ],
        ),
        child: Card(
          elevation: 0.0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child:
                // Column(
                //   mainAxisSize: MainAxisSize.min,
                //   mainAxisAlignment: MainAxisAlignment.1start,
                //   crossAxisAlignment: CrossAxisAlignment.start,
                //   children: [
                Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                imageWidget,
                addHorizontalSpacing(10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              profileName!,
                              // profileName!.substring(0, 5), // e.msg.toString(),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context)
                                  .textTheme
                                  .displayMedium!
                                  .copyWith(
                                    fontWeight: FontWeight.w500,
                                    color: VmodelColors.primaryColor,
                                  ),
                            ),
                          ),
                          addHorizontalSpacing(8),
                          // GestureDetector(
                          //   onTap: shareJobOnPressed,
                          //   child: const RenderSvg(
                          //     svgPath: "assets/images/svg_images/export.svg",
                          //     svgHeight: 20,
                          //     svgWidth: 20,
                          //   ),
                          // ),
                        ],
                      ),
                      addVerticalSpacing(10),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                ///location Icon
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const RenderSvg(
                                      svgPath: VIcons.walletIcon,
                                      svgHeight: 14,
                                      svgWidth: 14,
                                    ),
                                    addHorizontalSpacing(6),
                                    Text(
                                      "£$jobBudget",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: Theme.of(context)
                                          .textTheme
                                          .displaySmall!
                                          .copyWith(
                                            color:
                                                Theme.of(context).primaryColor,
                                            fontSize: 11.sp,
                                          ),
                                    ),
                                  ],
                                ),
                                addHorizontalSpacing(15),

                                ///time Icon
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const RenderSvg(
                                      svgPath: VIcons.clockIconFilled,
                                      svgHeight: 14,
                                      svgWidth: 14,
                                      color: VmodelColors.primaryColor,
                                    ),
                                    addHorizontalSpacing(6),
                                    Text(
                                      time!,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: Theme.of(context)
                                          .textTheme
                                          .displaySmall!
                                          .copyWith(
                                            color:
                                                Theme.of(context).primaryColor,
                                            fontSize: 11.sp,
                                          ),
                                    ),
                                  ],
                                ),
                                addHorizontalSpacing(15),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const RenderSvg(
                                      svgPath: VIcons.jobDetailRating,
                                      svgHeight: 14,
                                      svgWidth: 14,
                                    ),
                                    addHorizontalSpacing(6),
                                    Text(
                                      "$rating",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: Theme.of(context)
                                          .textTheme
                                          .displaySmall!
                                          .copyWith(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 11.sp,
                                              color:
                                                  Theme.of(context).primaryColor
                                              // .withOpacity(0.5),
                                              ),
                                    ),
                                  ],
                                ),
                                addHorizontalSpacing(4),
                                // Row(
                                //   children: [
                                //     const NormalRenderSvg(
                                //       svgPath: VIcons.humanIcon,
                                //     ),
                                //     addHorizontalSpacing(5),
                                //     Text(
                                //       candidateType!,
                                //       maxLines: 1,
                                //       overflow: TextOverflow.ellipsis,
                                //       style: Theme.of(context)
                                //           .textTheme
                                //           .displaySmall!
                                //           .copyWith(
                                //             fontWeight: FontWeight.w500,
                                //             color: Theme.of(context).primaryColor,
                                //           ),
                                //     ),
                                //   ],
                                // ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            // ],
            // ),
          ),
        ),
      ),
    );
  }
}

class CustomBoxShadow extends BoxShadow {
  @override
  final BlurStyle blurStyle;

  const CustomBoxShadow({
    Color color = const Color(0xFF000000),
    Offset offset = Offset.zero,
    double blurRadius = 0.0,
    this.blurStyle = BlurStyle.normal,
  }) : super(color: color, offset: offset, blurRadius: blurRadius);

  @override
  Paint toPaint() {
    final Paint result = Paint()
      ..color = color
      ..maskFilter = MaskFilter.blur(blurStyle, blurSigma);
    assert(() {
      if (debugDisableShadows) result.maskFilter = null;
      return true;
    }());
    return result;
  }
}
