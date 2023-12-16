class LocalServicesModel {
  String? id;
  String? title;
  int? discount;
  int? views;
  double? price;
  String? description;
  String? period;
  String? serviceType;
  bool? isOffer;
  String? usageType;
  bool? deleted;
  User? user;
  Delivery? delivery;
  bool? hasAdditional;
  int? likes;

  LocalServicesModel(
      {this.id,
      this.title,
      this.discount,
      this.views,
      this.serviceType,
      this.price,
      this.description,
      this.period,
      this.isOffer,
      this.usageType,
      this.deleted,
      this.user,
      this.delivery,
      this.hasAdditional,
      this.likes});

  LocalServicesModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    discount = json['discount'];
    views = json['views'];
    serviceType = json['serviceType'];
    price = json['price'];
    description = json['description'];
    period = json['period'];
    isOffer = json['isOffer'];
    usageType = json['usageType'];
    deleted = json['deleted'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    delivery = json['delivery'] != null
        ? new Delivery.fromJson(json['delivery'])
        : null;
    hasAdditional = json['hasAdditional'];
    likes = json['likes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['discount'] = this.discount;
    data['views'] = this.views;
    data['price'] = this.price;
    data['description'] = this.description;
    data['period'] = this.period;
    data['isOffer'] = this.isOffer;
    data['usageType'] = this.usageType;
    data['deleted'] = this.deleted;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    if (this.delivery != null) {
      data['delivery'] = this.delivery!.toJson();
    }
    data['hasAdditional'] = this.hasAdditional;
    data['likes'] = this.likes;
    return data;
  }
}

class User {
  String? id;
  String? username;
  String? fullName;
  String? profilePictureUrl;

  User({this.id, this.username, this.fullName, this.profilePictureUrl});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    fullName = json['fullName'];
    profilePictureUrl = json['profilePictureUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['fullName'] = this.fullName;
    data['profilePictureUrl'] = this.profilePictureUrl;
    return data;
  }
}

class Delivery {
  String? id;
  String? name;

  Delivery({this.id, this.name});

  Delivery.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}
