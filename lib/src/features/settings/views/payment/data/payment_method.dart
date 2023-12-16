import 'card_object.dart';

class PaymentMethodObject {
  String id;
  CardObject card;
  String holderName;
  String type;

  PaymentMethodObject(
      {required this.id,
      required this.card,
      required this.holderName,
      required this.type});

  PaymentMethodObject.fromJson(Map<String, dynamic> json)
      : id = json['id'] ?? "",
        card = CardObject.fromJson(json['card']),
        holderName = json['billing_details']['name'] ?? "",
        type = json['type'];
}
