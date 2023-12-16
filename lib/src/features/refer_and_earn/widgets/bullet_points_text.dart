import 'package:flutter/material.dart';
import 'package:vmodel/src/res/res.dart';

class VWidgetsBulletPointTextWithButton extends StatelessWidget {
  final String? text;
  final VoidCallback onTapMore;
  const VWidgetsBulletPointTextWithButton({
    super.key,
    required this.text,
    required this.onTapMore,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            " • ",
            style: Theme.of(context).textTheme.displayMedium!.copyWith(
                color: VmodelColors.white, fontWeight: FontWeight.w500),
          ),
          addHorizontalSpacing(5),
          Flexible(
            child: Text.rich(
              TextSpan(
                children: <InlineSpan>[
                  TextSpan(
                    text: "$text",
                    style: Theme.of(context).textTheme.displayMedium!.copyWith(
                        color: VmodelColors.white, fontWeight: FontWeight.w500),
                  ),
                  TextSpan(
                    text: "   ",
                    style: Theme.of(context).textTheme.displayMedium!.copyWith(
                        color: VmodelColors.white, fontWeight: FontWeight.w500),
                  ),
                  WidgetSpan(
                    baseline: TextBaseline.alphabetic,
                      alignment: PlaceholderAlignment.baseline,
                    child: GestureDetector(
                      onTap: onTapMore,
                      child: Text(
                        "more",
                        style: Theme.of(context)
                            .textTheme
                            .displayMedium!
                            .copyWith(
                                decoration: TextDecoration.underline,
                                color: VmodelColors.white,
                                fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
