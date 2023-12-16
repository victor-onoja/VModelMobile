import 'package:vmodel/src/res/icons.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/shared/rend_paint/render_svg.dart';
import 'package:vmodel/src/vmodel.dart';

import '../../../../../shared/picture_styles/rounded_square_avatar.dart';

class VWidgetsBusinessMyJobTwoTilesCard extends StatelessWidget {
  final String? profileImage;
  final String? profileName;
  final String? jobDescription;
  final String? location;
  final String? time;
  final String? appliedCandidateCount;
  final String? jobBudget;
  final String? candidateType;
  final VoidCallback? shareJobOnPressed;

  const VWidgetsBusinessMyJobTwoTilesCard(
      {required this.profileImage,
      required this.profileName,
      required this.jobDescription,
      required this.location,
      required this.time,
      required this.appliedCandidateCount,
      required this.jobBudget,
      required this.candidateType,
      required this.shareJobOnPressed,
      super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // navigateToRoute(context, const JobDetailPage());
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
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
            // BoxShadow(
            //   color: Colors.black.withOpacity(.07),
            //   blurRadius: 10.0, // soften the shadow
            //   spreadRadius: 5.0, //extend the shadow
            //   offset: const Offset(
            //     2.0, // Move to right 10  horizontally
            //     5.0, // Move to bottom 10 Vertically
            //   ),
            // )
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
                //   mainAxisAlignment: MainAxisAlignment.start,
                //   crossAxisAlignment: CrossAxisAlignment.start,
                //   children: [
                Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                RoundedSquareAvatar(
                  url: profileImage,
                  thumbnail: profileImage,
                ),
                addHorizontalSpacing(10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Flexible(
                            child: Text(
                              softWrap: true,
                              profileName!, // e.msg.toString(),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context)
                                  .textTheme
                                  .displayMedium!
                                  .copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: VmodelColors.primaryColor,
                                  ),
                            ),
                          ),
                          //addHorizontalSpacing(20),
                          /* GestureDetector(
                            onTap: shareJobOnPressed,
                            child: const RenderSvg(
                              svgPath: "assets/images/svg_images/export.svg",
                              svgHeight: 20,
                              svgWidth: 20,
                            ),
                          ),*/
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
                                location!,
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
                          // addHorizontalSpacing(20),

                          ///time Icon
                          // Row(
                          //   crossAxisAlignment: CrossAxisAlignment.start,
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
                          //             color:
                          //                 Theme.of(context).primaryColor,
                          //           ),
                          //     ),
                          //   ],
                          // ),
                          addHorizontalSpacing(20),
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
                                "£ $jobBudget",
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
