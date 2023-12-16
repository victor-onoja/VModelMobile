import 'package:flutter/material.dart';
import 'package:vmodel/src/res/res.dart';

class VWidgetsCategoryButton extends StatelessWidget {
  final bool isSelected;
  final String text;
  final Function onPressed;
  const VWidgetsCategoryButton({
    Key? key,
    required this.isSelected,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onPressed(),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isSelected ? VmodelColors.mainColor : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: VmodelColors.buttonColor, width: 2),
        ),
        height: 38,
        child: Text(
          text,
          style: Theme.of(context).textTheme.displayMedium?.copyWith(
                color: isSelected ? VmodelColors.white : VmodelColors.mainColor,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
              ),
        ),
      ),
    );
  }
}
