import 'package:flutter/material.dart';

class VWidgetsSettingsSubMenuTileWidget extends StatelessWidget {
  final String title;
  final Color? textColor;
  final VoidCallback onTap;
  const VWidgetsSettingsSubMenuTileWidget({
    super.key,
    required this.title,
    required this.onTap,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Column(
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                Expanded(
                  child: Text(
                    title,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.displayLarge!.copyWith(
                          fontWeight: FontWeight.w500,
                          color: textColor,
                        ),
                  ),
                ),
              ]),
            ],
          ),
        ),
      ),
    );
  }
}
