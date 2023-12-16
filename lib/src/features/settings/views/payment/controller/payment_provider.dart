import 'package:get/get.dart';
import 'package:vmodel/src/features/settings/views/payment/controller/stripe_urls.dart';
import 'package:vmodel/src/features/settings/views/payment/data/card_object.dart';
import 'package:vmodel/src/features/settings/views/payment/data/customer_object.dart';
import 'package:vmodel/src/features/settings/views/payment/data/payment_method.dart';

const paymentHeader = {
  'Authorization':
      "Bearer sk_test_51LvQvWHCDYA19PR21dlapXVRyfIzO4fvvRMcrpIkqt2ReXdT77jnRVsNJgosFINKzrhI8pcwlG2xgW95M7fsB87y00bYuawCn5"
};

class PaymentProvider extends GetConnect {
  Future<CustomerObject?> getCustomer(String email) async {
    try {
      var resp = await get(getCustomerUrl(email),
          headers: paymentHeader,
          contentType: 'application/x-www-form-urlencoded');
      if (resp.hasError || resp.body["data"].length < 1) {
        return Future(() => null);
      }

      return Future(() => CustomerObject.fromJson(resp.body["data"].first));
    } on Exception catch (_) {
      return Future(() => null);
    }
  }

  Future<CustomerObject?> createCustomer(
      {required String email,
      required String name,
      required String description}) async {
    try {
      var resp = await post(createCustomerUrl,
          {"email": email, "name": name, "description": description},
          headers: paymentHeader,
          contentType: 'application/x-www-form-urlencoded');
      if (resp.hasError) {
        return Future(() => null);
      }
      return CustomerObject.fromJson(resp.body);
    } on Exception catch (_) {
      return Future(() => null);
    }
  }

  Future<List<PaymentMethodObject>> getPaymentMethods(String customerId) async {
    try {
      var resp = await get(retrievePaymentMethodUrl(customerId),
          headers: paymentHeader,
          contentType: 'application/x-www-form-urlencoded');
      if (resp.hasError) {
        return Future(() => []);
      }
      return Future(() => (resp.body["data"] as List)
          .map((e) => PaymentMethodObject.fromJson(e))
          .toList());
    } on Exception catch (_) {
      return Future(() => []);
    }
  }

  Future<PaymentMethodObject?> createPaymentMethod(
      {required CardObject card,
      required String customerId,
      required String holderName}) async {
    try {
      var body = {
        "type": 'card',
        "card[number]": card.cardNumbers,
        "card[exp_month]": card.expMonth,
        "card[exp_year]": card.expYear,
        "card[cvc]": card.cvc,
        "billing_details[name]": holderName
      };
      var resp = await post(createPaymentMethodUrl, body,
          headers: paymentHeader,
          contentType: 'application/x-www-form-urlencoded');
      if (resp.hasError) {
        return Future(() => null);
      }
      return PaymentMethodObject.fromJson(resp.body);
    } on Exception catch (_) {
      return Future(() => null);
    }
  }

  Future<void> attachPaymentMethod(
      PaymentMethodObject payment, String customerId) async {
    try {
      await post(attachPaymentMethodUrl(payment.id), {"customer": customerId},
          headers: paymentHeader,
          contentType: 'application/x-www-form-urlencoded');
    } on Exception catch (_) {
      return;
    }
  }

  Future<void> detechPaymentMethod(PaymentMethodObject payment) async {
    try {
      var resp = await post(detachPaymentMethodUrl(payment.id), null,
          headers: paymentHeader,
          contentType: 'application/x-www-form-urlencoded');
    } on Exception catch (_) {
      return;
    }
  }
}
