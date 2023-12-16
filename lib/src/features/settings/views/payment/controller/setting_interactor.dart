import 'package:vmodel/src/features/settings/views/payment/views/payment_methods_page.dart';
import 'package:vmodel/src/vmodel.dart';

class SettingInteractor {
  static void onPaymentSetting(context) {
    navigateToRoute(context, const PaymentSettingsPage());
  }
}
