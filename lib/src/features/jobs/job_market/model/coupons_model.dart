class AllCouponsModel {
  String? id;
  String? title;
  bool? deleted;
  String? expiryDate;
  DateTime? dateCreated;
  int? useLimit;
  bool? isExpired;
  String? code;
  Owner? owner;

  AllCouponsModel({
    this.id,
    this.title,
    this.deleted,
    this.expiryDate,
    this.useLimit,
    this.isExpired,
    this.code,
    this.owner,
    this.dateCreated,
  });

  AllCouponsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    deleted = json['deleted'];
    expiryDate = json['expiryDate'];
    useLimit = json['useLimit'];
    isExpired = json['isExpired'];
    code = json['code'];
    dateCreated = DateTime.parse(json['dateCreated']);
    owner = json['owner'] != null ? new Owner.fromJson(json['owner']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['deleted'] = this.deleted;
    data['expiryDate'] = this.expiryDate;
    data['useLimit'] = this.useLimit;
    data['isExpired'] = this.isExpired;
    data['dateCreated'] = this.dateCreated;
    data['code'] = this.code;
    if (this.owner != null) {
      data['owner'] = this.owner!.toJson();
    }
    return data;
  }
}

class Owner {
  String? id;
  String? fullName;
  String? profilePictureUrl;
  String? username;

  Owner({
    this.id,
    this.fullName,
    this.username,
    this.profilePictureUrl,
  });

  Owner.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['fullName'];
    profilePictureUrl = json['profilePictureUrl'];
    username = json['username'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['fullName'] = this.fullName;
    data['username'] = this.username;
    data['profilePictureUrl'] = this.profilePictureUrl;
    return data;
  }
}
