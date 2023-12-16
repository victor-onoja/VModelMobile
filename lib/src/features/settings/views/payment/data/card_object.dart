class CardObject {
  String? id;
  String? cardLastNumbers;
  String? cardNumbers;
  int? expMonth;
  int? expYear;
  String? brand;
  String? cvc;
  String? funding;

  CardObject(
      {this.cardLastNumbers,
      this.brand,
      this.cardNumbers,
      this.expMonth,
      this.expYear,
      this.cvc});

  CardObject.fromJson(Map<String, dynamic> json)
      : id = json['fingerprint'] ?? '',
        cardLastNumbers = json['last4'],
        brand = json['brand'],
        expMonth = json['exp_month'],
        expYear = json['exp_year'],
        funding = json['funding'];

  Map<String, dynamic> toJson() => {
        "number": cardNumbers,
        "exp_month": expMonth,
        "exp_year": expYear,
        "cvc": cvc,
      };
}
