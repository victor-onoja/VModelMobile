import 'package:flutter/material.dart';
import 'package:vmodel/src/res/res.dart';

class VWidgetsOnboardingCard extends StatelessWidget {
  final String? title;
  final bool isSelected;
  final VoidCallback onTap;
  const VWidgetsOnboardingCard({
    super.key,
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.maxFinite,
        padding: const EdgeInsets.symmetric(vertical: 6.0),
        color: Colors.transparent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              isSelected
                  ? Icons.radio_button_checked_rounded
                  : Icons.radio_button_off_rounded,
              color: VmodelColors.primaryColor,
            ),
            addHorizontalSpacing(12),
            Text(
              title!,
              style: Theme.of(context).textTheme.displayMedium!.copyWith(
                  color: VmodelColors.primaryColor,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}
