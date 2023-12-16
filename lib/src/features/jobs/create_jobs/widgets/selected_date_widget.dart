import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vmodel/src/res/icons.dart';
import 'package:vmodel/src/shared/rend_paint/render_svg.dart';
import 'package:vmodel/src/vmodel.dart';

class VWidgetsSelectedDateWidget extends ConsumerStatefulWidget {
  final String? selectedDate;
  final String? selectedDateDay;
  final VoidCallback onTapCancel;
  const VWidgetsSelectedDateWidget({
    super.key,
    required this.selectedDate,
    required this.selectedDateDay,
    required this.onTapCancel,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _VWidgetsSelectedDateWidgetState();
}

class _VWidgetsSelectedDateWidgetState
    extends ConsumerState<VWidgetsSelectedDateWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.selectedDate!,
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                      // color: VmodelColors.primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
              ),
              Text(
                widget.selectedDateDay!,
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                      // color: VmodelColors.primaryColor.withOpacity(0.5),
                      color: Theme.of(context)
                          .textTheme
                          .displayMedium
                          ?.color
                          ?.withOpacity(0.5),
                      fontWeight: FontWeight.w500,
                    ),
              ),
            ],
          ),
          GestureDetector(
            onTap: widget.onTapCancel,
            child: const RenderSvg(svgPath: VIcons.cancelTile),
          )
        ],
      ),
    );
  }
}
