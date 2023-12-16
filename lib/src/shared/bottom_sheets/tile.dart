import 'package:flutter/material.dart';
import 'package:vmodel/src/res/res.dart';

class VWidgetsBottomSheetTile extends StatelessWidget {
  const VWidgetsBottomSheetTile({
    super.key,
    required this.onTap,
    required this.message,
    this.showWarning = false,
  });

  final VoidCallback onTap;
  final String message;
  final bool showWarning;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.fromLTRB(0, 6, 0, 6),
        color: Colors.transparent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(message,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.displayMedium!.copyWith(
                      fontWeight: FontWeight.w600,
                      color: showWarning
                          ? VmodelColors.error
                          : Theme.of(context).primaryColor,
                    )),
          ],
        ),
      ),
    );
  }
}
