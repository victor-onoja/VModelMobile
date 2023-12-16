class AllUsersModel {
  String? username;
  String? id;
  String? email;
  String? bio;
  String? gender;
  String? userType;
  bool? isVerified;
  dynamic postcode;
  String? firstName;
  String? lastName;
  String? hair;
  String? eyes;
  String? profilePictureUrl;
  Location? location;

  AllUsersModel(
      {this.username,
      this.id,
      this.email,
      this.bio,
      this.gender,
      this.userType,
      this.isVerified,
      this.postcode,
      this.firstName,
      this.lastName,
      this.hair,
      this.eyes,
      this.profilePictureUrl,
      this.location});

  AllUsersModel.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    id = json['id'];
    email = json['email'];
    bio = json['bio'];
    gender = json['gender'];
    userType = json['userType'];
    isVerified = json['isVerified'];
    postcode = json['postcode'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    hair = json['hair'];
    eyes = json['eyes'];
    profilePictureUrl = json['profilePictureUrl'];
    location = json['location'] != null
        ? new Location.fromJson(json['location'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['id'] = this.id;
    data['email'] = this.email;
    data['bio'] = this.bio;
    data['gender'] = this.gender;
    data['userType'] = this.userType;
    data['isVerified'] = this.isVerified;
    data['postcode'] = this.postcode;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['hair'] = this.hair;
    data['eyes'] = this.eyes;
    data['profilePictureUrl'] = this.profilePictureUrl;
    if (this.location != null) {
      data['location'] = this.location!.toJson();
    }
    return data;
  }
}

class Location {
  String? id;
  double? latitude;
  double? longitude;

  Location({this.id, this.latitude, this.longitude});

  Location.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    return data;
  }
}
