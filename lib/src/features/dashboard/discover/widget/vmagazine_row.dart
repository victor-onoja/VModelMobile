import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/shared/rend_paint/render_svg.dart';
import 'package:vmodel/src/vmodel.dart';

import '../../../../res/icons.dart';

class VMagazineRow extends StatelessWidget {
  final String title;
  final String subTitle;
  final bool showTitleOnly;
  final String? icon;
  const VMagazineRow({
    Key? key,
    required this.title,
    required this.subTitle,
    this.showTitleOnly = false,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 18),
      // padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
          // borderRadius: BorderRadius.circular(8),
          // color: Colors.white,
          // color: Theme.of(context).cardTheme.color,
          boxShadow: [
            BoxShadow(
                color: Colors.black12,
                // color:
                //     Theme.of(context).colorScheme.onBackground.withOpacity(0.2),
                blurRadius: 9,
                spreadRadius: 0,
                offset: Offset(3, 3))
          ]),
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              RenderSvg(
                svgPath: icon ?? VIcons.vmodelLogo,
                svgHeight: 24,
                svgWidth: 24,
                // color:
                //     Theme.of(context).bottomNavigationBarTheme.backgroundColor,
              ),
              // ClipRRect(
              //   borderRadius: BorderRadius.circular(8),
              //   child: Image.asset(image),
              // ),
              addHorizontalSpacing(20),
              Expanded(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: textTheme.displayMedium?.copyWith(
                        // color: VmodelColors.mainColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 11.5.sp),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                  if (!showTitleOnly) addVerticalSpacing(5),
                  if (!showTitleOnly)
                    Text(
                      subTitle,
                      style: textTheme.bodySmall?.copyWith(
                        // color: VmodelColors.mainColor,
                        fontSize: 10.sp,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    )
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}
