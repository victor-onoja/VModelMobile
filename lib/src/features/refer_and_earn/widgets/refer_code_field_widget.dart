import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:vmodel/src/res/res.dart';

class VWidgetsReferAndEarnCodeField extends StatelessWidget {
  final String generatedCode;
  final VoidCallback onTapCopyCode;

  const VWidgetsReferAndEarnCodeField(
      {required this.generatedCode, required this.onTapCopyCode, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: VmodelColors.white.withOpacity(0.2),
        borderRadius: const BorderRadius.all(
          Radius.circular(21),
        ),
        border: Border.all(color: VmodelColors.white, width: 3),
      ),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 0, left: 16),
              child: Text(
                generatedCode,
                style: Theme.of(context).textTheme.displayLarge!.copyWith(
                    fontSize: 28.sp,
                    fontWeight: FontWeight.w600,
                    color: VmodelColors.white),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: onTapCopyCode,
                child: Container(
                  decoration: BoxDecoration(
                    color: VmodelColors.primaryColor,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(12),
                    ),
                    border: Border.all(color: VmodelColors.white, width: 3),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 6.0, horizontal: 18),
                    child: Text(
                      "COPY\nCODE",
                      style: Theme.of(context).textTheme.displaySmall!.copyWith(
                          fontWeight: FontWeight.w500,
                          fontSize: 10.sp,
                          color: VmodelColors.white),
                    ),
                  ),
                ),
              ),
            ),
          ]),
    );
  }
}
