@Deprecated("Use VAppUser instead")
class VUser {
  String? email;
  dynamic username;
  dynamic id;
  String? bio;
  String? gender;
  String? userType;
  dynamic isVerified;
  dynamic weight;
  dynamic height;
  String? postcode;
  dynamic pk;
  String? firstName;
  String? lastName;
  dynamic token;

  VUser(
      {this.email,
      this.firstName,
      this.lastName,
      this.bio,
      this.username,
      this.gender,
      this.height,
      this.id,
      this.isVerified,
      this.pk,
      this.postcode,
      this.userType,
      this.token,
      this.weight});

  factory VUser.fromJson(Map<String, dynamic> json) => VUser(
      email: json['email'],
      username: json['username'],
      lastName: json['lastName'],
      bio: json['bio'],
      id: json['id'],
      gender: json['gender'],
      userType: json['userType'],
      isVerified: json['isVerified'],
      weight: json['weight'],
      height: json['height'],
      postcode: json['postcode'],
      pk: json['pk'],
      firstName: json['firstName'],
      token: json['tokenAuth']['token']);
}
