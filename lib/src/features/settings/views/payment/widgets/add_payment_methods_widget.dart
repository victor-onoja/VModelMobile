import 'package:flutter/material.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/shared/rend_paint/render_svg.dart';

class VWidgetsAddPaymentMethodsBottomsheetWidget extends StatelessWidget {
  final String paymentMethodText;
  final VoidCallback ontapPaymentMethod;
  final String svgPath;

  const VWidgetsAddPaymentMethodsBottomsheetWidget(
      {super.key,
      required this.paymentMethodText,
      required this.ontapPaymentMethod,
      required this.svgPath});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontapPaymentMethod,
      child: Column(
        children: [
          Row(
            children: [
              RenderSvg(
                svgPath: svgPath,
                svgHeight: 48,
                svgWidth: 48,
              ),
              addHorizontalSpacing(12),
              Text(
                paymentMethodText,
                style: Theme.of(context).textTheme.displayLarge!.copyWith(
                      color: VmodelColors.primaryColor,
                    ),
              )
            ],
          ),
          const Divider(
            thickness: 1,
            color: VmodelColors.primaryColor,
          )
        ],
      ),
    );
  }
}
