// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/cupertino.dart';

import 'package:vmodel/src/core/models/bust_model.dart';
import 'package:vmodel/src/core/models/chest.dart';
import 'package:vmodel/src/core/models/feet_model.dart';
import 'package:vmodel/src/core/models/height_model.dart';
import 'package:vmodel/src/core/models/phone_number_model.dart';
import 'package:vmodel/src/core/models/vmc_record_model.dart';
import 'package:vmodel/src/core/models/waist_model.dart';
import 'package:vmodel/src/core/utils/enum/size_enum.dart';
import 'package:vmodel/src/core/utils/validators_mixins.dart';
import 'package:vmodel/src/vmodel.dart';

import '../utils/enum/ethnicity_enum.dart';
import '../utils/enum/gender_enum.dart';
import '../utils/helper_functions.dart';
import 'location_model.dart';
import 'user_socials.dart';

@immutable
class VAppUser {
  // final AuthStatus status;
  final bool? allowConnectionView;
  final int? id;
  final String firstName;
  final String email;
  final String lastName;
  final String username;
  final String displayName;
  final String whoCanConnectWithMe;
  final String whoCanFeatureMe;
  final String whoCanMessageMe;
  final String whoCanViewMyNetwork;
  final bool alertOnProfileVisit;
  final DateTime? dob;
  final PhoneNumberModel? phone;
  final String? connectionStatus;
  final int? connectionId;
  final Gender? gender;
  final Ethnicity? ethnicity;
  final String? bio;
  final VMCRecordModel? vmcrecord;
  final String? website;
  final String? weight;
  final String? hair;
  final String? eyes;
  final double? price;
  final LocationData? location;
  final String? profilePictureUrl;
  final String? thumbnailUrl;
  final bool isVerified;
  final bool blueTickVerified;
  final ModelSize? modelSize;
  final bool? isBusinessAccount;
  final String? userType;
  final String? label;
  final String? zodiacSign;
  final String? personality;
  final UserSocials? socials;
  final bool? isFollowing;
  final bool? postNotification;
  final bool? jobNotification;
  final bool? couponNotification;
  final int? yearsOfExperience;
  final DateTime? dateJoined;
  final DateTime? lastLogin;

  final HeightModel? height;
  final WaistModel? waist;
  final ChestModel? chest;
  final FeetModel? feet;
  final BustModel? bust;

  String get fullName => '$firstName $lastName';
  String get labelOrUserType {
    if (!label.isEmptyOrNull)
      return label!;
    else if (!userType.isEmptyOrNull) return userType!;
    return 'No user type';
  }

  VAppUser({
    this.allowConnectionView,
    this.id,
    required this.firstName,
    required this.email,
    required this.lastName,
    required this.username,
    required this.displayName,
    this.dob,
    this.phone,
    this.connectionStatus,
    this.connectionId,
    this.gender,
    this.ethnicity,
    this.bio,
    required this.whoCanConnectWithMe,
    required this.whoCanFeatureMe,
    required this.whoCanMessageMe,
    required this.whoCanViewMyNetwork,
    required this.alertOnProfileVisit,
    this.vmcrecord,
    this.website,
    this.weight,
    this.hair,
    this.eyes,
    this.price,
    this.location,
    this.profilePictureUrl,
    this.thumbnailUrl,
    required this.isVerified,
    required this.blueTickVerified,
    this.modelSize,
    this.isBusinessAccount,
    this.userType,
    this.label,
    this.zodiacSign,
    this.personality,
    this.socials,
    this.isFollowing,
    this.postNotification,
    this.jobNotification,
    this.couponNotification,
    this.yearsOfExperience,
    this.height,
    this.waist,
    this.chest,
    this.feet,
    this.bust,
    this.dateJoined,
    this.lastLogin,
  });

  VAppUser copyWith({
    bool? allowConnectionView,
    int? id,
    String? firstName,
    String? email,
    String? lastName,
    String? username,
    String? displayName,
    DateTime? dob,
    PhoneNumberModel? phone,
    String? connectionStatus,
    int? connectionId,
    Gender? gender,
    Ethnicity? ethnicity,
    String? bio,
    VMCRecordModel? vmcrecord,
    String? website,
    String? weight,
    String? hair,
    String? eyes,
    double? price,
    LocationData? location,
    String? profilePictureUrl,
    String? thumbnailUrl,
    bool? isVerified,
    bool? blueTickVerified,
    ModelSize? modelSize,
    bool? isBusinessAccount,
    String? userType,
    String? label,
    String? zodiacSign,
    String? personality,
    UserSocials? socials,
    bool? isFollowing,
    bool? postNotification,
    bool? jobNotification,
    bool? couponNotification,
    int? yearsOfExperience,
    HeightModel? height,
    WaistModel? waist,
    ChestModel? chest,
    FeetModel? feet,
    BustModel? bust,
    String? whoCanConnectWithMe,
    String? whoCanFeatureMe,
    String? whoCanMessageMe,
    String? whoCanViewMyNetwork,
    bool? alertOnProfileVisit,
  }) {
    return VAppUser(
      allowConnectionView: allowConnectionView ?? this.allowConnectionView,
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      email: email ?? this.email,
      lastName: lastName ?? this.lastName,
      username: username ?? this.username,
      displayName: displayName ?? this.displayName,
      dob: dob ?? this.dob,
      phone: phone ?? this.phone,
      connectionStatus: connectionStatus ?? this.connectionStatus,
      connectionId: connectionId ?? this.connectionId,
      gender: gender ?? this.gender,
      ethnicity: ethnicity ?? this.ethnicity,
      bio: bio ?? this.bio,
      vmcrecord: vmcrecord ?? this.vmcrecord,
      website: website ?? this.website,
      weight: weight ?? this.weight,
      hair: hair ?? this.hair,
      eyes: eyes ?? this.eyes,
      price: price ?? this.price,
      location: location ?? this.location,
      profilePictureUrl: profilePictureUrl ?? this.profilePictureUrl,
      thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
      isVerified: isVerified ?? this.isVerified,
      blueTickVerified: blueTickVerified ?? this.blueTickVerified,
      modelSize: modelSize ?? this.modelSize,
      isBusinessAccount: isBusinessAccount ?? this.isBusinessAccount,
      userType: userType ?? this.userType,
      label: label ?? this.label,
      zodiacSign: zodiacSign ?? this.zodiacSign,
      personality: personality ?? this.personality,
      socials: socials ?? this.socials,
      isFollowing: isFollowing ?? this.isFollowing,
      postNotification: postNotification ?? this.postNotification,
      jobNotification: jobNotification ?? this.jobNotification,
      couponNotification: couponNotification ?? this.couponNotification,
      yearsOfExperience: yearsOfExperience ?? this.yearsOfExperience,
      height: height ?? this.height,
      waist: waist ?? this.waist,
      chest: chest ?? this.chest,
      feet: feet ?? this.feet,
      bust: bust ?? this.bust,
      whoCanConnectWithMe: whoCanConnectWithMe ?? this.whoCanConnectWithMe,
      whoCanFeatureMe: whoCanFeatureMe ?? this.whoCanFeatureMe,
      whoCanMessageMe: whoCanMessageMe ?? this.whoCanMessageMe,
      whoCanViewMyNetwork: whoCanViewMyNetwork ?? this.whoCanViewMyNetwork,
      alertOnProfileVisit: alertOnProfileVisit ?? this.alertOnProfileVisit,
      dateJoined: this.dateJoined,
      lastLogin: this.lastLogin,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'allowConnectionView': allowConnectionView,
      'id': id.toString(),
      'firstName': firstName,
      'email': email,
      'lastName': lastName,
      'displayName': displayName,
      'postNotification': postNotification,
      'couponNotification': couponNotification,
      'jobNotification': jobNotification,
      'dob': dob,
      'vmcrecord': vmcrecord,
      'username': username,
      'phone': phone?.toMap(),
      'connectionStatus': connectionStatus,
      'connectionId': connectionId,
      'gender': gender?.apiValue,
      'ethnicity': ethnicity?.apiValue,
      'height': {"value": height!.value, "unit": "cm"},
      'weight': {"value": weight, "unit": "kg"},
      'waist': {"value": waist!.value, "unit": "cm"},
      'bust': {"value": bust!.value, "unit": "cm"},
      'feet': {"value": feet!.value, "unit": "cm"},
      'chest': {"value": chest!.value, "unit": "cm"},
      'bio': bio,
      'website': website,
      'hair': hair,
      'eyes': eyes,
      'price': price,
      'locationName': location?.toMap(),
      'profilePictureUrl': profilePictureUrl,
      'thumbnailUrl': thumbnailUrl,
      'isVerified': isVerified,
      'blueTickVerified': blueTickVerified,
      'modelSize': modelSize?.apiValue,
      'isBusinessAccount': isBusinessAccount,
      'userType': userType,
      'label': label,
      'personality': personality,
      'isFollowing': isFollowing,
      'socials': socials?.toMap(),
      'yearsOfExperience': yearsOfExperience,
      'zodiacSign': zodiacSign,
      'whoCanConnectWithMe': whoCanConnectWithMe,
      'whoCanFeatureMe': whoCanFeatureMe,
      'whoCanMessageMe': whoCanMessageMe,
      'whoCanViewMyNetwork': whoCanViewMyNetwork,
      'alertOnProfileVisit': alertOnProfileVisit,
      'dateJoined': dateJoined?.toIso8601String(),
      'lastLogin': lastLogin?.toIso8601String(),
    };
  }

  factory VAppUser.fromMap(Map<String, dynamic> map, {igNoreEmail = false}) {
    final socials = map['socials'] ?? {"ss": null};
    print("vmcrecords${map['vmcrecord'] == null}");
    print('Sociallllslslslsls  map >>>  $socials');
    if (igNoreEmail) {
      map['email'] = '';
    }

    // final ss = UserSocials.fromMap(socials);
    Map<String, dynamic> locationData = {};
    try {
      locationData = Map<String, dynamic>.from((map['location'] as Map?) ?? {});
      final fn = map['firstName'] as String;
      final ln = map['lastName'] as String;
      // print('DFDFDFDFDFDFDF $ss');
      return VAppUser(
        allowConnectionView: map['allowConnectionView'] as bool?,
        id: int.tryParse(map['id']) ?? -1,
        firstName: fn.capitalizeFirstVExt,
        email: map['email'] as String,

        lastName: ln.capitalizeFirstVExt,
        username: map['username'] as String,
        displayName: map['displayName'] ??
            '${fn.capitalizeFirstVExt} ${ln.capitalizeFirstVExt}',
        phone: map['phone'] != null
            ? PhoneNumberModel.fromMap(map['phone'] as Map<String, dynamic>)
            : null,
        connectionStatus: map['connectionStatus'],
        connectionId: map['connectionId'],
        gender: Gender.genderByApiValue(map['gender'] ?? ''),
        ethnicity: Ethnicity.ethnicityByApiValue(map['ethnicity'] ?? ''),
        modelSize: ModelSize.modelSizeByApiValue(map['size'] ?? ''),
        bio: map['bio'] as String?,
        vmcrecord: map['vmcrecord'] != null
            ? VMCRecordModel.fromJson(map['vmcrecord'] as Map<String, dynamic>)
            : null,
        website: map['website'] as String?,
        height: map['height'] != null
            ? HeightModel(value: map['height']['value'], unit: "cm")
            : HeightModel(value: "", unit: ""),
        waist: map['waist'] != null
            ? WaistModel(value: map['waist']['value'], unit: "cm")
            : WaistModel(value: "", unit: ""),
        bust: map['bust'] != null
            ? BustModel(value: map['bust']['value'], unit: "cm")
            : BustModel(value: "", unit: ""),
        feet: map['feet'] != null
            ? FeetModel(value: map['feet']['value'], unit: "cm")
            : FeetModel(value: "", unit: ""),
        chest: map['chest'] != null
            ? ChestModel(value: map['chest']['value'], unit: "cm")
            : ChestModel(value: "", unit: ""),
        weight: map['weight'] != null ? map['weight']['value'] : "",
        hair: map['hair'] as String?,
        dob: map['dob'] != null ? DateTime.parse(map['dob']) : null,
        eyes: map['eyes'] as String?,
        price: map['price'] as double?,
        location: LocationData.fromMap(locationData),
        postNotification: map['postNotification'] as bool?,
        couponNotification: map['couponNotification'] as bool?,
        jobNotification: map['jobNotification'] as bool?,
        profilePictureUrl: map['profilePictureUrl'] ?? '',
        thumbnailUrl: map['thumbnailUrl'],
        isVerified: (map['isVerified'] as bool?) ?? false,
        blueTickVerified: (map['blueTickVerified'] as bool?) ?? false,
// modelSize: map['modelSize'] as ModelSize,
        isBusinessAccount: map['isBusinessAccount'] as bool,
        userType: map['userType'] as String,
        label: map['label'] as String?,
        personality: map['personality'] as String?,
        isFollowing: map['isFollowing'] ?? false,
        dateJoined: map['dateJoined'] != null
            ? DateTime.parse(map['dateJoined'])
            : null,
        lastLogin:
            map['lastLogin'] != null ? DateTime.parse(map['lastLogin']) : null,
        socials: UserSocials.fromMap(Map<String, dynamic>.from(socials)),
        yearsOfExperience: map['yearsOfExperience'] != null
            ? map['yearsOfExperience'] as int
            : null,
        zodiacSign: map['zodiacSign'] as String? ?? '',

        whoCanConnectWithMe: map['whoCanConnectWithMe'] != null
            ? (map['whoCanConnectWithMe'] as String)
            : "No one",
        whoCanFeatureMe: map['whoCanFeatureMe'] != null
            ? (map['whoCanFeatureMe'] as String)
            : "No one",
        whoCanMessageMe: map['whoCanMessageMe'] != null
            ? (map['whoCanMessageMe'] as String)
            : "No one",
        whoCanViewMyNetwork: map['whoCanViewMyNetwork'] != null
            ? (map['whoCanViewMyNetwork'] as String)
            : "No one",
        alertOnProfileVisit: map['alertOnProfileVisit'] != null
            ? (map['alertOnProfileVisit'] as bool)
            : false,
      );
    } catch (e, st) {
      print('DFDFDFFFFFFFFFFF  $e $st');
      rethrow;
    }
  }

  factory VAppUser.fromMinimalMap(Map<String, dynamic> map) {
    map['email'] = map['email'] ?? '';
    map['firstName'] = map['firstName'] ?? '';
    map['lastName'] = map['lastName'] ?? '';
    map['isBusinessAccount'] = map['isBusinessAccount'] ?? false;
    map['userType'] = map['userType'] ?? '';
    map['label'] = map['label'] ?? '';

    return VAppUser.fromMap(map);
  }

  String toJson() => json.encode(toMap());

  factory VAppUser.fromJson(String source) =>
      VAppUser.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'VAppUser(allowConnectionView: $allowConnectionView,whoCanConnectWithMe:$whoCanConnectWithMe,whoCanFeatureMe:$whoCanFeatureMe, whoCanMessageMe:$whoCanMessageMe,whoCanViewMyNetwork:$whoCanViewMyNetwork,alertOnProfileVisit:$alertOnProfileVisit, id: $id, firstName: $firstName, email: $email, lastName: $lastName, username: $username, displayName: $displayName, dob: $dob, phone: $phone, connectionStatus: $connectionStatus, connectionId: $connectionId, gender: $gender, ethnicity: $ethnicity, bio: $bio, vmcrecord: $vmcrecord, website: $website, weight: $weight, hair: $hair, eyes: $eyes, price: $price, location: $location, profilePictureUrl: $profilePictureUrl, thumbnailUrl: $thumbnailUrl, isVerified: $isVerified, blueTickVerified: $blueTickVerified, modelSize: $modelSize, isBusinessAccount: $isBusinessAccount, userType: $userType, label: $label, zodiacSign: $zodiacSign, personality: $personality, socials: $socials, isFollowing: $isFollowing, postNotification: $postNotification, jobNotification: $jobNotification, couponNotification: $couponNotification, yearsOfExperience: $yearsOfExperience, height: $height, waist: $waist, chest: $chest, feet: $feet, bust: $bust)';
  }

  @override
  bool operator ==(covariant VAppUser other) {
    if (identical(this, other)) return true;

    return other.allowConnectionView == allowConnectionView &&
        other.id == id &&
        other.firstName == firstName &&
        other.email == email &&
        other.whoCanConnectWithMe == whoCanConnectWithMe &&
        other.whoCanFeatureMe == whoCanFeatureMe &&
        other.whoCanMessageMe == whoCanMessageMe &&
        other.whoCanViewMyNetwork == whoCanViewMyNetwork &&
        other.alertOnProfileVisit == alertOnProfileVisit &&
        other.lastName == lastName &&
        other.username == username &&
        other.displayName == displayName &&
        other.dob == dob &&
        other.phone == phone &&
        other.connectionStatus == connectionStatus &&
        other.connectionId == connectionId &&
        other.gender == gender &&
        other.ethnicity == ethnicity &&
        other.bio == bio &&
        other.vmcrecord == vmcrecord &&
        other.website == website &&
        other.weight == weight &&
        other.hair == hair &&
        other.eyes == eyes &&
        other.price == price &&
        other.location == location &&
        other.profilePictureUrl == profilePictureUrl &&
        other.thumbnailUrl == thumbnailUrl &&
        other.isVerified == isVerified &&
        other.blueTickVerified == blueTickVerified &&
        other.modelSize == modelSize &&
        other.isBusinessAccount == isBusinessAccount &&
        other.userType == userType &&
        other.label == label &&
        other.zodiacSign == zodiacSign &&
        other.personality == personality &&
        other.socials == socials &&
        other.isFollowing == isFollowing &&
        other.postNotification == postNotification &&
        other.jobNotification == jobNotification &&
        other.couponNotification == couponNotification &&
        other.yearsOfExperience == yearsOfExperience &&
        other.height == height &&
        other.waist == waist &&
        other.chest == chest &&
        other.feet == feet &&
        other.whoCanConnectWithMe == whoCanConnectWithMe &&
        other.whoCanFeatureMe == whoCanFeatureMe &&
        other.whoCanMessageMe == whoCanMessageMe &&
        other.whoCanViewMyNetwork == whoCanViewMyNetwork &&
        other.alertOnProfileVisit == alertOnProfileVisit &&
        other.bust == bust;
  }

  @override
  int get hashCode {
    return allowConnectionView.hashCode ^
        id.hashCode ^
        firstName.hashCode ^
        email.hashCode ^
        lastName.hashCode ^
        username.hashCode ^
        displayName.hashCode ^
        dob.hashCode ^
        phone.hashCode ^
        connectionStatus.hashCode ^
        connectionId.hashCode ^
        gender.hashCode ^
        ethnicity.hashCode ^
        bio.hashCode ^
        vmcrecord.hashCode ^
        website.hashCode ^
        weight.hashCode ^
        hair.hashCode ^
        eyes.hashCode ^
        price.hashCode ^
        location.hashCode ^
        profilePictureUrl.hashCode ^
        thumbnailUrl.hashCode ^
        isVerified.hashCode ^
        blueTickVerified.hashCode ^
        modelSize.hashCode ^
        isBusinessAccount.hashCode ^
        userType.hashCode ^
        label.hashCode ^
        zodiacSign.hashCode ^
        personality.hashCode ^
        socials.hashCode ^
        isFollowing.hashCode ^
        postNotification.hashCode ^
        jobNotification.hashCode ^
        couponNotification.hashCode ^
        yearsOfExperience.hashCode ^
        height.hashCode ^
        waist.hashCode ^
        chest.hashCode ^
        feet.hashCode ^
        whoCanConnectWithMe.hashCode ^
        whoCanFeatureMe.hashCode ^
        whoCanMessageMe.hashCode ^
        whoCanViewMyNetwork.hashCode ^
        alertOnProfileVisit.hashCode ^
        bust.hashCode;
  }
}







/*



  Map<String, dynamic> toMap() {
    return {
      'allowConnectionView': allowConnectionView,
      'id': id.toString(),
      'firstName': firstName,
      'email': email,
      'lastName': lastName,
      'displayName': displayName,
      'postNotification': postNotification,
      'couponNotification': couponNotification,
      'jobNotification': jobNotification,
      'dob': dob,
      'vmc': vmc,
      'username': username,
      'phone': phone?.toMap(),
      'connectionStatus': connectionStatus,
      'connectionId': connectionId,
      'gender': gender?.apiValue,
      'ethnicity': ethnicity?.apiValue,
      'height': {"value": height, "unit": "cm"},
      'weight': {"value": weight, "unit": "kg"},
      'bio': bio,
      'website': website,
      'hair': hair,
      'eyes': eyes,
      'price': price,
      'locationName': location?.toMap(),
      'chest': chest,
      'profilePictureUrl': profilePictureUrl,
      'isVerified': isVerified,
      'blueTickVerified': blueTickVerified,
      'modelSize': modelSize?.apiValue,
      'isBusinessAccount': isBusinessAccount,
      'userType': userType,
      'label': label,
      'personality': personality,
      'isFollowing': isFollowing,
      'socials': socials?.toMap(),
    };
  }

  factory VAppUser.fromMap(Map<String, dynamic> map, {igNoreEmail = false}) {
    final socials = map['socials'] ?? {"ss": null};

    print('Sociallllslslslsls  map >>>  $socials');

    if (igNoreEmail) {
      map['email'] = '';
    }

    // final ss = UserSocials.fromMap(socials);
    Map<String, dynamic> locationData = {};
    try {
      locationData = Map<String, dynamic>.from((map['location'] as Map?) ?? {});
      final fn = map['firstName'] as String;
      final ln = map['lastName'] as String;
      // print('DFDFDFDFDFDFDF $ss');
      return VAppUser(
        allowConnectionView: map['allowConnectionView'] as bool?,
        id: int.tryParse(map['id']) ?? -1,
        firstName: fn.capitalizeFirstVExt,
        email: map['email'] as String,
        lastName: ln.capitalizeFirstVExt,
        username: map['username'] as String,
        displayName: map['displayName'] ??
            '${fn.capitalizeFirstVExt} ${ln.capitalizeFirstVExt}',
        phone: map['phone'] != null
            ? PhoneNumberModel.fromMap(map['phone'] as Map<String, dynamic>)
            : null,
        connectionStatus: map['connectionStatus'],
        connectionId: map['connectionId'],
        gender: Gender.genderByApiValue(map['gender'] ?? ''),
        ethnicity: Ethnicity.ethnicityByApiValue(map['ethnicity'] ?? ''),
        modelSize: ModelSize.modelSizeByApiValue(map['size'] ?? ''),
        bio: map['bio'] as String?,
        vmc: map['vmc'] as int?,
        website: map['website'] as String?,
        height: map['height'] != null ? map['height']['value'] : "",
        weight: map['weight'] != null ? map['weight']['value'] : "",
        hair: map['hair'] as String?,
        dob: map['dob'] != null ? DateTime.parse(map['dob']) : null,
        eyes: map['eyes'] as String?,
        price: map['price'] as double?,
        location: LocationData.fromMap(locationData),
        chest: map['chest'] as String?,
        postNotification: map['postNotification'] as bool?,
        couponNotification: map['couponNotification'] as bool?,
        jobNotification: map['jobNotification'] as bool?,
        profilePictureUrl: map['profilePictureUrl'] ?? '',
        isVerified: (map['isVerified'] as bool?) ?? false,
        blueTickVerified: (map['blueTickVerified'] as bool?) ?? false,
// modelSize: map['modelSize'] as ModelSize,
        isBusinessAccount: map['isBusinessAccount'] as bool,
        userType: map['userType'] as String,
        label: map['label'] as String?,
        personality: map['personality'] as String?,
        isFollowing: map['isFollowing'] ?? false,
        socials: UserSocials.fromMap(Map<String, dynamic>.from(socials)),
      );
    } catch (e, st) {
      print('DFDFDFFFFFFFFFFF  $e $st');
      rethrow;
    }
    // return VAppUser(
    //     firstName: "lsjf",
    //     email: 'lsfj',
    //     lastName: 'slfsjl',
    //     username: 'ljfslj',
    //     displayName: 'default name');
  }

  factory VAppUser.fromMinimalMap(Map<String, dynamic> map) {
    map['email'] = map['email'] ?? '';
    map['firstName'] = map['firstName'] ?? '';
    map['lastName'] = map['lastName'] ?? '';
    map['isBusinessAccount'] = map['isBusinessAccount'] ?? false;
    map['userType'] = map['userType'] ?? '';
    map['label'] = map['label'] ?? '';

    return VAppUser.fromMap(map);
  }




*/






/*




*/