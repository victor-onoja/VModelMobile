import 'package:vmodel/src/res/ui_constants.dart';

import '../../../../res/icons.dart';
import '../../../../res/res.dart';
import '../../../../shared/rend_paint/render_svg.dart';
import '../../../../vmodel.dart';

class FeedEndWidget extends StatelessWidget {
  const FeedEndWidget({
    super.key,
    required this.mainText,
    this.subText,
    this.hideIcon = false
  });

  final String mainText;
  final String? subText;
  final bool? hideIcon;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        addVerticalSpacing(16),
        if(!hideIcon!) RenderSvg(
          svgPath: VIcons.commandIcon,
          // color: VmodelColors.blueColor9D,
          // color: Theme.of(context).colorScheme.primary.withOpacity(0.5),
          color: UIConstants.switchActiveColor(context)?.withOpacity(0.5),
        ),
        addVerticalSpacing(6),
        Text(
          mainText,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              // color: Theme.of(context).colorScheme.primary.withOpacity(0.5)),
              color: UIConstants.switchActiveColor(context)?.withOpacity(0.5)),
          // ?.copyWith(
          //   color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.5),
          //   // color: VmodelColors.blueColor9D,
          // ),
        ),
        addVerticalSpacing(4),
         if(!hideIcon!) Text(
          subText ?? VMString.feedEndSubText,
          style: Theme.of(context)
              .textTheme
              .bodyMedium
              // ?.copyWith(color: VmodelColors.primaryColor.withOpacity(0.5)),
              ?.copyWith(
                // color:
                //     Theme.of(context).colorScheme.primary.withOpacity(0.5)),

                color: UIConstants.switchActiveColor(context)?.withOpacity(0.5),
                // ?.copyWith(
                //   // color: Theme.of(context).textTheme.bodyLarge?.color,
                //   // color: VmodelColors.blueColor9D,
                //   color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.5),
              ),
        ),
        addVerticalSpacing(16),
      ],
    );
  }
}
