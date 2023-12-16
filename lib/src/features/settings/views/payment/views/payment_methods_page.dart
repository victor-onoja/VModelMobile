import 'package:vmodel/src/features/settings/views/payment/controller/payment_controller.dart';
import 'package:vmodel/src/features/settings/views/payment/controller/payment_interactor.dart';
import 'package:vmodel/src/features/settings/views/payment/widgets/list_card_item.dart';
import 'package:vmodel/src/features/settings/views/payment/widgets/new_payment_method_widget.dart';
import 'package:vmodel/src/res/icons.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/shared/appbar/appbar.dart';
import 'package:vmodel/src/shared/rend_paint/render_svg.dart';
import 'package:vmodel/src/vmodel.dart';

class PaymentSettingsPage extends StatelessWidget {
  const PaymentSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PaymentSettingController>(
      init: PaymentSettingController(),
      builder: (s) => Scaffold(
        appBar: VWidgetsAppBar(
          leadingIcon: const VWidgetsBackButton(),
          appbarTitle: "Payment Methods",
          trailingIcon: [
            IconButton(
                onPressed: () {
                  showModalBottomSheet(
                      context: context,
                      backgroundColor: Colors.transparent,
                      builder: (BuildContext context) {
                        return Container(
                            height: 200,
                            padding: const EdgeInsets.only(left: 24, right: 24),
                            decoration: BoxDecoration(
                              color: Theme.of(context).scaffoldBackgroundColor,
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(13),
                                topRight: Radius.circular(13),
                              ),
                            ),
                            child: const VWidgetsPaymentMethodsWidget());
                      });
                },
                icon: RenderSvg(
                  svgPath: VIcons.addIcon,
                  color: Theme.of(context).primaryColor,
                ))
          ],
        ),
        body: Padding(
          padding: const VWidgetsPagePadding.horizontalSymmetric(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              addVerticalSpacing(25),
              Expanded(
                  child: SingleChildScrollView(
                child: Column(
                  children: [
                    if (s.cards.isEmpty)
                      Center(
                        child: Text(
                          'No payment methods saved yet!',
                          maxLines: 2,
                          style: Theme.of(context)
                              .textTheme
                              .displayMedium!
                              .copyWith(
                                fontWeight: FontWeight.w500,
                                color: Theme.of(context).primaryColor,
                              ),
                        ),
                      ),
                  ],
                ),
              )),
              addVerticalSpacing(12),
              ...s.cards
                  .map((e) => ListCardItem(
                        cardName:
                            '${e.card.funding} ${e.card.brand} card (${e.card.cardLastNumbers})',
                        owner: e.holderName,
                        exp:
                            '${e.card.expMonth.toString().padLeft(2, '0')}/${e.card.expYear! % 100}',
                        isDefault: s.defaultId == e.id,
                        isEditable: s.isEditable,
                        onSwitch: (v) => s.setDefaultItem(v ? e.id : ''),
                        onTap: () {
                          PaymentSettingInteractor.removePayment(e);
                        },
                      ))
                  .toList(),
              addVerticalSpacing(40),
            ],
          ),
        ),
      ),
    );
  }
}
