import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/vmodel.dart';

class VWidgetsHelpDetailsPointTile extends StatelessWidget {
  final String tileText;
  const VWidgetsHelpDetailsPointTile(
      {Key? key,
      this.tileText =
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit."})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return Padding(
      padding: const VWidgetsPagePadding.horizontalSymmetric(10),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Theme.of(context).primaryColor,
            radius: 4.0,
          ),
          addHorizontalSpacing(8),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 18.0),
                  child: Text(
                    tileText.toString(),
                    style: theme.displayMedium!.copyWith(
                        fontWeight: FontWeight.w500,
                        fontSize: 12.5.sp,
                        color: Theme.of(context).primaryColor),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
