import '../../../../../../res/res.dart';
import '../../../../../../shared/rend_paint/render_svg.dart';
import '../../../../../../vmodel.dart';

class StatItem extends StatefulWidget {
  const StatItem({
    super.key,
    required this.outlineIcon,
    required this.text,
    this.filledIcon,
    this.iconWidth,
    this.iconHeight,
    this.userLike,
    this.onIconTapped,
  });
  final String outlineIcon;
  final String text;
  final String? filledIcon;
  final double? iconWidth;
  final double? iconHeight;
  final bool? userLike;
  // final bool disableColor;
  final VoidCallback? onIconTapped;

  @override
  State<StatItem> createState() => _StatItemState();
}

class _StatItemState extends State<StatItem> {
  final isTapped = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ValueListenableBuilder(
            valueListenable: isTapped,
            builder: (context, value, _) {
              return IconButton(
                  onPressed: () {
                    isTapped.value = !isTapped.value;
                    widget.onIconTapped?.call();
                  },
                  icon: RenderSvg(
                    svgPath: widget.outlineIcon,
                    svgHeight: widget.iconHeight,
                    svgWidth: widget.iconWidth,
                  ));
            }),
        Text(
          widget.text,
          style: Theme.of(context).textTheme.displayLarge!.copyWith(
                fontWeight: FontWeight.w500,
                // color: VmodelColors.primaryColor,
                fontSize: 12,
              ),
        ),
      ],
    );
  }

  String _getAsset(bool isShowFilledIcon) {
    if (isShowFilledIcon && widget.filledIcon != null) {
      return widget.filledIcon!;
    }
    return widget.outlineIcon;
  }
}

class StatItemV2 extends StatefulWidget {
  const StatItemV2({
    super.key,
    required this.outlineIcon,
    required this.text,
    this.filledIcon,
    this.iconWidth,
    this.iconHeight,
    this.userLike,
    this.onIconTapped,
  });
  final String outlineIcon;
  final String text;
  final String? filledIcon;
  final double? iconWidth;
  final double? iconHeight;
  final bool? userLike;
  // final bool disableColor;
  final VoidCallback? onIconTapped;

  @override
  State<StatItemV2> createState() => _StatItemV2State();
}

class _StatItemV2State extends State<StatItemV2> {
  final isTapped = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ValueListenableBuilder(
            valueListenable: isTapped,
            builder: (context, value, _) {
              return GestureDetector(
                  onTap: () {
                    isTapped.value = !isTapped.value;
                    widget.onIconTapped?.call();
                  },
                  child: RenderSvg(
                    svgPath: widget.outlineIcon,
                    svgHeight: widget.iconHeight,
                    svgWidth: widget.iconWidth,
                    color:widget.userLike!? Colors.red: Colors.white,
                  ));
            }),
        addVerticalSpacing(5),
        Text(
          widget.text,
          style: Theme.of(context).textTheme.displayLarge!.copyWith(
                fontWeight: FontWeight.w500,
                color: VmodelColors.white,
                fontSize: 12,
              ),
        ),
      ],
    );
  }
}
