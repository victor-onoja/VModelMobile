import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/shared/rend_paint/render_svg.dart';
import 'package:vmodel/src/vmodel.dart';

class VWigetsHelpTile extends StatelessWidget {
  final bool shouldHaveIcon;
  final String iconPath;
  final String titleTitle;
  final Function()? onTap;
  const VWigetsHelpTile({
    Key? key,
    required this.onTap,
    required this.iconPath,
    required this.titleTitle,
    this.shouldHaveIcon = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return Column(
      children: [
        SizedBox(
          height: 38,
          child: ListTile(
            contentPadding: const VWidgetsPagePadding.all(0),
            onTap: onTap,
            title: Row(
              children: [
                if (shouldHaveIcon == true)
                  Row(
                    children: [
                      RenderSvg(svgPath: iconPath),
                      addHorizontalSpacing(10),
                    ],
                  ),
                Expanded(child: Text(
                  // titleTitle + "NON",
                  titleTitle.contains('.') ? titleTitle.replaceAll(".", "") : titleTitle,
                  style: theme.displayMedium!.copyWith(
                      fontSize: 12.5.sp, color: Theme.of(context).primaryColor),
                ),)
              ],
            ),
            trailing: Icon(
              Icons.arrow_forward_ios,
              size: 17,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
        addHorizontalSpacing(0),
        addVerticalSpacing(15),
        Divider(
          color: VmodelColors.dividerColor,
        ),
        addVerticalSpacing(6),
      ],
    );
  }
}
