import 'package:vmodel/src/res/gap.dart';
import 'package:vmodel/src/vmodel.dart';

class EmptySearchResultsWidget extends StatelessWidget {
  final String? message;
  final Widget? iconWidget;
  final bool showIcon;
  const EmptySearchResultsWidget(
      {super.key, this.message, this.iconWidget, this.showIcon = true});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        addVerticalSpacing(16),
        if (showIcon)
          iconWidget ??
              Icon(
                Icons.search_off_rounded,
                color: context.theme.iconTheme.color?.withOpacity(0.4),
              ),
        addVerticalSpacing(16),
        Text(
          message ?? "No results found",
          style: context.textTheme.bodyMedium?.copyWith(
            color: context.textTheme.bodyMedium?.color?.withOpacity(0.4),
          ),
        )
      ],
    );
  }
}
