import 'package:get/get.dart';
import 'package:vmodel/src/features/settings/views/payment/data/customer_object.dart';
import 'package:vmodel/src/features/settings/views/payment/controller/payment_provider.dart';


import '../data/payment_method.dart';

class PaymentSettingController extends GetxController {
  late bool _isEditable = false;
  late String _defaultId = '';
   List<PaymentMethodObject> _cards = [];

  bool get isEditable => _isEditable;

  String? get defaultId => _defaultId;
  String? get customerId => _customerObject?.id;

  List<PaymentMethodObject> get cards => _cards;
  CustomerObject? _customerObject;

  final PaymentProvider _provider = PaymentProvider();

  @override
  void onInit() {
    _loadCards();
    super.onInit();
  }

  void _loadCards() async {
    _customerObject = await _provider.getCustomer('temp@vmodel.com');
    _customerObject ??= await _provider.createCustomer(
        email: 'temp@vmodel.com',
        name: 'vmodel tester',
        description: 'description');
    if (_customerObject?.id != null) {
      _cards = await _provider.getPaymentMethods(_customerObject!.id);
      update();
    }

  }

  void updateEditable() {
    _isEditable = !_isEditable;
    update();
  }

  void setDefaultItem(String id) {
    _defaultId = id;
    update();
  }

  void addCard(PaymentMethodObject item) {
    if (cards.isEmpty) {
      _defaultId = '';
    }
    _cards.add(item);
    update();
  }

  void removeCard(PaymentMethodObject payment) {
    if (payment.id == _defaultId) {
      _defaultId = '';
    }
    _cards.removeWhere((e) => e.id == payment.id);
    update();
  }

  void updateCard(int index, PaymentMethodObject method) {
    _cards[index] = method;
    update();
  }
}
