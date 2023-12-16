class CustomerObject {
  final String id;
  final String email;
  final String name;
  final String currency;

  CustomerObject(
      {required this.id,
      required this.email,
      required this.name,
      required this.currency});

  CustomerObject.fromJson(Map<String, dynamic> json)
      : id = json['id'] ?? "",
        email = json['email'] ?? "",
        name = json['name'] ?? "",
        currency = json['currency'] ?? "";
}
