import 'package:vmodel/src/core/utils/enum/auth_enum.dart';
import 'package:vmodel/src/core/utils/enum/size_enum.dart';

import '../utils/enum/ethnicity_enum.dart';
import '../utils/enum/gender_enum.dart';

class AuthResponseModel {
  AuthResponseModel({
    this.status = AuthStatus.initial,
    this.token,
    this.error,
    this.firstName,
    this.lastName,
    this.email,
    this.username,
    this.phone,
    this.otp,
    this.pk,
    this.height,
    this.bio,
    this.hair,
    this.eyes,
    this.chest,
    this.weight,
    this.profilePicture,
    this.price,
    this.isVerified,
    this.locationName,
    this.gender,
    this.ethnicity,
    this.modelSize,
    this.isBusinessAccount,
    this.accountType,
  });

  final AuthStatus status;
  final String? token;
  final String? error;
  final String? firstName;
  final String? email;
  final String? phone;
  final Gender? gender;
  final Ethnicity? ethnicity;
  final String? otp;
  final String? lastName;
  final String? username;
  final int? pk;
  final String? height;
  final String? bio;
  final String? weight;
  final String? hair;
  final String? eyes;
  final double? price;
  final String? locationName;
  final String? chest;
  final String? profilePicture;
  final bool? isVerified;
  final ModelSize? modelSize;
  final bool? isBusinessAccount;
  final String? accountType;

  AuthResponseModel copyWith({
    AuthStatus? status,
    String? token,
    String? error,
    String? username,
    String? lastName,
    String? email,
    String? phone,
    Gender? gender,
    Ethnicity? ethnicity,
    String? otp,
    String? firstName,
    int? pk,
    String? height,
    double? price,
    String? bio,
    String? weight,
    String? hair,
    String? chest,
    String? eyes,
    String? profilePicture,
    String? locationName,
    bool? isVerified,
    ModelSize? modelSize,
    bool? isBusinessAccount,
    String? accountType,
  }) {
    return AuthResponseModel(
      status: status ?? this.status,
      token: token ?? this.token,
      error: error ?? this.error,
      username: username ?? this.username,
      email: email ?? this.email,
      firstName: firstName ?? this.firstName,
      gender: gender ?? this.gender,
      ethnicity: ethnicity ?? this.ethnicity,
      phone: phone ?? this.phone,
      otp: otp ?? this.otp,
      lastName: lastName ?? this.lastName,
      pk: pk ?? this.pk,
      height: height ?? this.height,
      bio: bio ?? this.bio,
      weight: weight ?? this.weight,
      hair: hair ?? this.hair,
      chest: chest ?? this.chest,
      eyes: eyes ?? this.eyes,
      profilePicture: profilePicture ?? this.profilePicture,
      isVerified: isVerified ?? this.isVerified,
      price: price ?? this.price,
      locationName: locationName ?? this.locationName,
      modelSize: modelSize ?? this.modelSize,
      isBusinessAccount: isBusinessAccount ?? this.isBusinessAccount,
      accountType: accountType ?? this.accountType,
    );
  }

  @override
  String toString() {
    return '''
        UserAccountInformation:
       pk: $pk
       email: $email
       username: $username
       firstname: $firstName
       lastname: $lastName
       bio: $bio
       height: $height
       hair: $hair
       eyes: $eyes
       gender: $gender
       ethnicity: $ethnicity
       size: $modelSize
        ''';
  }
}
