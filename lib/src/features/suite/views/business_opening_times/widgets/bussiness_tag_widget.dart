import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class BusinessInfoTagWidget extends StatelessWidget {
  const BusinessInfoTagWidget({
    super.key,
    required this.text,
    required this.isSelected,
    required this.onPressed,
    this.borderColor,
  });

  final String text;
  final bool isSelected;
  final VoidCallback onPressed;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () {
        onPressed();
      },
      child: Text(
        text,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: isSelected || borderColor != null
                  ? Colors.white
                  : Theme.of(context).textTheme.bodyMedium?.color,
            ),
      ),
      style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        side: BorderSide(
            color: borderColor ?? Theme.of(context).colorScheme.primary),
        backgroundColor:
            isSelected ? Theme.of(context).colorScheme.primary : null,
      ),
    );
  }
}

//Repost button
class RepostButtonWidget extends StatelessWidget {
  const RepostButtonWidget({
    super.key,
    required this.text,
    this.isSelected = false,
    required this.isLoading,
    required this.onPressed,
    this.borderColor,
    this.padding = const EdgeInsets.only(bottom: 10),
  });

  final String text;
  final bool isSelected;
  final bool isLoading;
  final VoidCallback onPressed;
  final Color? borderColor;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () {
        if (isLoading) return;
        onPressed();
      },
      child: !isLoading
          ? Text(
              text,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: Colors.white),
            )
          : Container(
              height: 24,
              width: 24,
              padding: EdgeInsets.all(4),
              child: CircularProgressIndicator.adaptive(
                backgroundColor: Colors.white,
                strokeWidth: 2,
              )),
      style: OutlinedButton.styleFrom(
        padding: padding,
        minimumSize: Size(100.w, 40),
        visualDensity: VisualDensity.compact,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        side: BorderSide(color: Colors.white),
        backgroundColor:
            isSelected ? Theme.of(context).colorScheme.primary : null,
      ),
    );
  }
}
