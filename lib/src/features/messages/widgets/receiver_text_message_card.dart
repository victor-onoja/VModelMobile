import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/vmodel.dart';

class VWidgetsReceiverTextCard extends StatelessWidget {
  final String? receiverMessage;
  final double fontSize;

  const VWidgetsReceiverTextCard(
      {required this.receiverMessage, super.key, this.fontSize = 16});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const VWidgetsPagePadding.verticalSymmetric(5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Flexible(
            child: Container(
              constraints: BoxConstraints(
                maxWidth: SizeConfig.screenWidth * 0.75,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                // color: Theme.of(context).dividerColor,
                color: Theme.of(context).colorScheme.primary,
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
                child: Text(
                  receiverMessage!,
                  maxLines: null,
                  style: Theme.of(context).textTheme.displayMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onPrimary,
                        fontSize: fontSize,
                        fontWeight: FontWeight.w500,
                      ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
