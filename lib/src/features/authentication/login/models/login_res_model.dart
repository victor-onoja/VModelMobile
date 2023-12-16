class LoginResponsModel {
  final dynamic token;
  final dynamic error;
  final String? firstName;
  final String? otp;
  final String? lastName;
  final String? username;
  final int? pk;
  final dynamic uid;
  final String? email;
  final dynamic success;
  final String? height;
  final String? bio;
  final String? weight;
  final String? hair;
  final String? eyes;
  final String? chest;
  final int? profilePicture;
  final dynamic isActive;

//schema used to make up model
  //  success
  //     token
  //     errors
  //     user{
  //       username
  //       lastName
  //       firstName
  //       isActive
  //       bio
  //       id
  //       pk
  //      }
  //   }
  LoginResponsModel({
    this.token,
    this.error,
    this.firstName,
    this.otp,
    this.lastName,
    this.username,
    this.pk,
    this.height,
    this.weight,
    this.hair,
    this.email,
    this.eyes,
    this.chest,
    this.profilePicture,
    this.bio,
    this.uid,
    this.success,
    this.isActive,
  });

  factory LoginResponsModel.fromJson(Map<String, dynamic> json) {
    return LoginResponsModel(
      token: json['token'],
      error: json['errors'],
      success: json['success'],
      firstName: json['user']['lastName'] ?? "",
      lastName: json['user']['lastName'] ?? "",
      username: json['user']['username'] ?? "",
      pk: json['user']['pk'] ?? 0,
      profilePicture: json['user']['pk'] ?? 0,
      bio: json['user']['bio'] ?? "",
      // uid: json[''],
      isActive: json['user']['isActive'] ?? "",
    );
  }
}
