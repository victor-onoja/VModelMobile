import 'package:vmodel/src/res/icons.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/shared/rend_paint/render_svg.dart';
import 'package:vmodel/src/vmodel.dart';

class VWidgetsBusinessMyCardGrid extends StatelessWidget {
  final String? cardImage;
  final String? profileName;
  final String? jobDescription;
  final String? location;
  final String? time;
  final String? appliedCandidateCount;
  final String? jobBudget;
  final String? candidateType;

  final VoidCallback? shareJobOnPressed;
  final VoidCallback? cardOnPressed;

  const VWidgetsBusinessMyCardGrid({
    required this.profileName,
    required this.cardImage,
    required this.jobDescription,
    required this.location,
    required this.time,
    required this.appliedCandidateCount,
    required this.jobBudget,
    required this.candidateType,
    required this.shareJobOnPressed,
    required this.cardOnPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: cardOnPressed,
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Stack(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width / 2.3,
                      height: 105,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          image: DecorationImage(
                              image: AssetImage(
                                cardImage!,
                              ),
                              filterQuality: FilterQuality.high,
                              fit: BoxFit.cover)),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 2.3,
                      height: 105,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                GestureDetector(
                                  onTap: shareJobOnPressed,
                                  child: RenderSvg(
                                      svgHeight: 20,
                                      svgWidth: 20,
                                      svgPath: VIcons.shareFilled,
                                      color: VmodelColors.white),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(profileName!,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context)
                                    .textTheme
                                    .displaySmall!
                                    .copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    )),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 7,
                ),
                SizedBox(
                  width: 164,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
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
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Theme.of(context).primaryColor,
                                ),
                          ),
                        ],
                      ),
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
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Theme.of(context).primaryColor,
                                ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                )
              ],
            ),
            Column(
              children: [
                Stack(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width / 2.3,
                      height: 105,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          image: DecorationImage(
                              image: AssetImage(
                                cardImage!,
                              ),
                              filterQuality: FilterQuality.high,
                              fit: BoxFit.cover)),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 2.3,
                      height: 105,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                GestureDetector(
                                  onTap: shareJobOnPressed,
                                  child: RenderSvg(
                                      svgHeight: 20,
                                      svgWidth: 20,
                                      svgPath: VIcons.shareFilled,
                                      color: VmodelColors.white),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(profileName!,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context)
                                    .textTheme
                                    .displaySmall!
                                    .copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    )),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 7,
                ),
                SizedBox(
                  width: 164,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
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
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Theme.of(context).primaryColor,
                                ),
                          ),
                        ],
                      ),
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
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Theme.of(context).primaryColor,
                                ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
