import 'package:vmodel/src/features/settings/views/payment/controller/payment_controller.dart';
import 'package:vmodel/src/features/settings/views/payment/data/card_object.dart';
import 'package:vmodel/src/features/settings/views/payment/views/create_payment_page.dart';
import 'package:vmodel/src/vmodel.dart';
import '../data/payment_method.dart';
import 'payment_provider.dart';

class PaymentSettingInteractor {
  static void onSwitchDefault(int index) {
    var controller = Get.find<PaymentSettingController>();
    controller.setDefaultItem(controller.cards[index].id);
  }

  static void onAddCard(PaymentMethodObject card) {
    var controller = Get.find<PaymentSettingController>();
    controller.addCard(card);
  }

  static void onUpdateCard(int index, PaymentMethodObject card) {
    var controller = Get.find<PaymentSettingController>();
    controller.updateCard(index, card);
  }

  static void onCreatePayment(context) {
    navigateToRoute(context, const CreatePaymentPage());
  }

  static void onSaveCard(CardObject card, String holder, bool isDefault) async {
    var s = Get.find<PaymentSettingController>();
    PaymentProvider provider = PaymentProvider();
    PaymentMethodObject? payment = await provider.createPaymentMethod(
        card: card, customerId: s.customerId ?? '', holderName: holder);
    if (payment?.id == null) {
      return;
    }
    provider.attachPaymentMethod(payment!, s.customerId ?? '');
    s.addCard(payment);
    if (isDefault) {
      s.setDefaultItem(payment.id);
    }
    1;
  }

  static void removePayment(PaymentMethodObject payment) {
    var s = Get.find<PaymentSettingController>();
    PaymentProvider provider = PaymentProvider();
    provider.detechPaymentMethod(payment);
    s.removeCard(payment);
  }
}
