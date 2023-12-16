import 'package:vmodel/src/res/icons.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/shared/rend_paint/render_svg.dart';
import 'package:vmodel/src/vmodel.dart';

class VWidgetsProfileBio extends StatelessWidget {
  final String imgLink;
  final String? extendedbioInfo;
  final String? mainBioInfo;
  final VoidCallback? onPressedIcon;

  const VWidgetsProfileBio(
      {required this.extendedbioInfo,
      required this.onPressedIcon,
      required this.mainBioInfo,
      required this.imgLink,
      required super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return ListView(
      // physics: const NeverScrollableScrollPhysics(),
      children: [
        addVerticalSpacing(18),
        Padding(
          padding: const VWidgetsPagePadding.horizontalSymmetric(18),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 80,
                width: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border:
                      Border.all(width: 3, color: VmodelColors.primaryColor),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Container(
                    height: 80,
                    width: 80,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                            width: 1, color: VmodelColors.primaryColor),
                        image: DecorationImage(
                            image: AssetImage(imgLink), fit: BoxFit.cover)),
                  ),
                ),
              ),
              addHorizontalSpacing(12),
              Flexible(
                child: Row(
                  // alignment: Alignment.bottomCenter,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Flexible(
                      child: Text(
                        mainBioInfo!,
                        style: theme.displayMedium!.copyWith(
                          fontSize: 11.sp,
                          decorationThickness: 10,
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.w500,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 4,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        addVerticalSpacing(9),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 25),
          child: Center(
            child: Text(
              extendedbioInfo!,
              style: Theme.of(context).textTheme.displayMedium!.copyWith(
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).primaryColor.withOpacity(1),
                    fontSize: 11.sp,
                  ),
            ),
          ),
        ),
        RichText(
          text: const TextSpan(children: []),
        ),
        Padding(
          padding: const VWidgetsPagePadding.horizontalSymmetric(18),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              addHorizontalSpacing(20),
              Expanded(
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    'VModel',
                    style: Theme.of(context).textTheme.displayMedium!.copyWith(
                          fontWeight: FontWeight.w600,
                          color:
                              Theme.of(context).primaryColor.withOpacity(0.2),
                          fontSize: 12.sp,
                        ),
                  ),
                ),
              ),
              IconButton(
                  padding: const EdgeInsets.all(0),
                  onPressed: onPressedIcon,
                  icon: const NormalRenderSvgWithColor(
                    svgPath: VIcons.shrinkBioIcon,
                  )),
            ],
          ),
        ),
        addVerticalSpacing(20),
        const Divider(
          thickness: 1,
        )
      ],
    );
  }
}
