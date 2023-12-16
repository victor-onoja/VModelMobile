import 'package:vmodel/src/core/utils/enum/profile_types.dart';
import 'package:vmodel/src/res/icons.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/shared/rend_paint/render_svg.dart';
import 'package:vmodel/src/vmodel.dart';

class VWidgetsProfileSubInfoDetails extends StatelessWidget {
  final String? stars;
  final String? userName;
  // final String? category;
  final String? address;
  final String? budget;
  final String? companyUrl;
  final ProfileTypeEnum profileTypeEnum;
  final VoidCallback? onPressedCompanyURL;
  const VWidgetsProfileSubInfoDetails(
      {required this.stars,
      required this.userName,
      // required this.category,
      required this.address,
      required this.budget,
      required this.companyUrl,
      required this.onPressedCompanyURL,
      this.profileTypeEnum = ProfileTypeEnum.personal,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          userName!,
          style: Theme.of(context).textTheme.displayMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: Theme.of(context).primaryColor.withOpacity(1),
              ),
        ),
        addVerticalSpacing(8),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const RenderSvg(
              svgPath: VIcons.stars,
              svgWidth: 18,
              svgHeight: 18,
            ),
            addHorizontalSpacing(8),
            Text(
              stars!,
              style: Theme.of(context).textTheme.displayMedium?.copyWith(
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).primaryColor.withOpacity(1),
                  ),
            ),
          ],
        ),
        addVerticalSpacing(8),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 1.0),
              child: RenderSvg(
                svgPath: VIcons.locationIcon,
                svgWidth: 18,
                svgHeight: 20.5,
              ),
            ),
            addHorizontalSpacing(8),
            Flexible(
              child: Text(
                address!,
                maxLines: 2,
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).primaryColor.withOpacity(1),
                    ),
              ),
            ),
          ],
        ),
        // addVerticalSpacing(8),
        // Row(
        //   crossAxisAlignment: CrossAxisAlignment.center,
        //   mainAxisAlignment: MainAxisAlignment.start,
        //   children: [
        //     const RenderSvg(
        //       svgPath: VIcons.commercialIcon,
        //       svgWidth: 18,
        //       svgHeight: 18,
        //     ),
        //     addHorizontalSpacing(8),
        //     Flexible(
        //       child: Text(
        //         category!,
        //         maxLines: 2,
        //         style: Theme.of(context).textTheme.displayMedium?.copyWith(
        //               fontSize: 11.sp,
        //               fontWeight: FontWeight.w500,
        //               color: Theme.of(context).primaryColor.withOpacity(1),
        //             ),
        //       ),
        //     ),
        //   ],
        // ),
        addVerticalSpacing(8),
        profileTypeEnum == ProfileTypeEnum.business
            ? GestureDetector(
                onTap: onPressedCompanyURL,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const RenderSvg(
                      svgPath: VIcons.browserIcon,
                      svgWidth: 18,
                      svgHeight: 19,
                    ),
                    addHorizontalSpacing(8),
                    Text(
                      "$companyUrl",
                      style: Theme.of(context)
                          .textTheme
                          .displayMedium
                          ?.copyWith(
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w500,
                            color:
                                Theme.of(context).primaryColor.withOpacity(1),
                          ),
                    ),
                  ],
                ),
              )
            : Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const RenderSvg(
                    svgPath: VIcons.coinIcon,
                    svgWidth: 18,
                    svgHeight: 19,
                  ),
                  addHorizontalSpacing(8),
                  Text(
                    budget == "" ? "Price not set" : "From £$budget",
                    style: Theme.of(context).textTheme.displayMedium?.copyWith(
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).primaryColor.withOpacity(1),
                        ),
                  ),
                ],
              ),
      ],
    );
  }
}
