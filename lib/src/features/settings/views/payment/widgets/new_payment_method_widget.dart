import 'package:flutter/material.dart';
import 'package:vmodel/src/features/settings/views/payment/controller/payment_interactor.dart';
import 'package:vmodel/src/features/settings/widgets/settings_submenu_tile_widget.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/shared/modal_pill_widget.dart';

class VWidgetsPaymentMethodsWidget extends StatelessWidget {
  const VWidgetsPaymentMethodsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    List paymentMethodsItems = [
      VWidgetsSettingsSubMenuTileWidget(
        title: "PayPal",
        onTap: () {},
      ),
      VWidgetsSettingsSubMenuTileWidget(
        title: "Credit/Debit Card",
        onTap: () {
          PaymentSettingInteractor.onCreatePayment(context);
        },
      ),
    ];
    return Column(
      // mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      // mainAxisSize: MainAxisSize.min,
      children: [
        addVerticalSpacing(15),
        const Align(alignment: Alignment.center, child: VWidgetsModalPill()),
        addVerticalSpacing(25),
        Expanded(
          child: ListView.separated(
              itemBuilder: ((context, index) => paymentMethodsItems[index]),
              separatorBuilder: (context, index) => const Divider(),
              itemCount: paymentMethodsItems.length),
        )
      ],
    );
  }
}
