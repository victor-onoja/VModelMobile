import '../res/res.dart';
import 'buttons/text_button.dart';
import '../vmodel.dart';
import 'modal_pill_widget.dart';

class TextBottomSheet extends StatelessWidget {
  const TextBottomSheet({
    super.key,
    required this.title,
    required this.content,
    this.contentStyle,
  });

  final String title;
  final String content;
  final TextStyle? contentStyle;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: SizerUtil.height * 0.9,
        minHeight: SizerUtil.height * 0.2,
        minWidth: SizerUtil.width,
      ),
      decoration: BoxDecoration(
        // color: VmodelColors.white,
        color: Theme.of(context).colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          addVerticalSpacing(15),
          const Align(alignment: Alignment.center, child: VWidgetsModalPill()),
          addVerticalSpacing(24),
          Text(
            title,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontWeight: FontWeight.w600,
                  // color: VmodelColors.primaryColor,
                  // fontSize: 12,
                ),
          ),
          addVerticalSpacing(16),
          Flexible(
            child: Container(
              width: double.maxFinite,
              margin: const EdgeInsets.symmetric(horizontal: 24),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                  color: VmodelColors.jobDetailGrey.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(16)),
              child: RawScrollbar(
                mainAxisMargin: 4,
                crossAxisMargin: -8,
                thumbVisibility: true,
                // thumbColor: VmodelColors.primaryColor.withOpacity(0.3),
                thumbColor: Theme.of(context).primaryColor.withOpacity(0.3),
                thickness: 4,
                radius: const Radius.circular(10),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        content,
                        style: contentStyle ??
                            Theme.of(context).textTheme.bodyMedium!,
                        // .copyWith(
                        // fontWeight: FontWeight.w500,
                        // color: VmodelColors.primaryColor,
                        // ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          addVerticalSpacing(16),
          VWidgetsTextButton(
            text: 'Close',
            textStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontWeight: FontWeight.w600,
                  // color: VmodelColors.primaryColor,
                  // fontSize: 12,
                ),
            onPressed: () => goBack(context),
          ),
          addVerticalSpacing(24),
        ],
      ),
    );
  }
}
