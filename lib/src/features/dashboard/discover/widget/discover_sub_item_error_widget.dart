import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/vmodel.dart';


class DiscoverSubListError extends ConsumerWidget {
  final String title;
  const DiscoverSubListError({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Column(
      children: [
        addVerticalSpacing(10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 13),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                title,
                style: textTheme.displayMedium!.copyWith(
                  fontWeight: FontWeight.w600,
                  // color: VmodelColors.mainColor,
                  // color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
              // Text(
              //   "View all".toUpperCase(),
              //   style: Theme.of(context).textTheme.bodySmall!.copyWith(
              //       // fontWeight: FontWeight.w600,
              //       // color: VmodelColors.mainColor.withOpacity(0.5),
              //       // color: Theme.of(context).colorScheme.onPrimary,
              //       ),
              // ),
              // const RenderSvg(
              //   svgPath: VIcons.forwardIcon,
              //   svgWidth: 12.5,
              //   svgHeight: 12.5,
              // ),
            ],
          ),
        ),
        addVerticalSpacing(9),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error_outline),
              addHorizontalSpacing(16),
              Flexible(
                child: Text(
                  'Error fetching data',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: textTheme.displayMedium!.copyWith(
                      // fontWeight: FontWeight.w600,
                      // color: VmodelColors.mainColor,
                      // color: Theme.of(context).colorScheme.onPrimary,
                      ),
                ),
              ),
            ],
          ),
        ),
        addVerticalSpacing(5),
      ],
    );
  }
}
