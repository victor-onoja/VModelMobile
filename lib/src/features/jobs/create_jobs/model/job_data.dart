// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import 'package:flutter/foundation.dart';

import '../../../../core/utils/enum/ethnicity_enum.dart';
import '../../../../core/utils/enum/size_enum.dart';

@immutable
class JobDataModel {
  final String jobTitle;
  final String jobType;
  final String priceOption;
  final double priceValue;
  final List<String> talents;
  final String preferredGender;
  final String shortDescription;
  final String? brief;
  final String? briefFile;
  final String? briefLink;
  final Map<String, dynamic> location;
  final String deliverablesType;
  final bool isDigitalContent;
  final bool acceptMultiple;
  final String? usageType;
  final String? usageLength;
  final int minAge;
  final int maxAge;
  final Map<String, dynamic>? height;
  final ModelSize? size;
  final Ethnicity? ethnicity;
  final String? complexion;
  final List<String>? category;

  const JobDataModel({
    required this.jobTitle,
    required this.jobType,
    required this.priceOption,
    required this.priceValue,
    required this.talents,
    required this.preferredGender,
    required this.shortDescription,
    this.brief,
    this.briefFile,
    this.briefLink,
    required this.location,
    required this.deliverablesType,
    required this.isDigitalContent,
    required this.acceptMultiple,
    this.usageType,
    this.usageLength,
    required this.minAge,
    required this.maxAge,
    this.height,
    this.size,
    this.ethnicity,
    this.complexion,
    this.category,
  });

  JobDataModel copyWith({
    String? jobTitle,
    String? jobType,
    String? priceOption,
    double? priceValue,
    List<String>? talents,
    String? preferredGender,
    String? shortDescription,
    String? brief,
    String? briefFile,
    String? briefLink,
    Map<String, dynamic>? location,
    String? deliverablesType,
    bool? isDigitalContent,
    bool? acceptMultiple,
    String? usageType,
    String? usageLength,
    int? minAge,
    int? maxAge,
    Map<String, dynamic>? height,
    ModelSize? size,
    Ethnicity? ethnicity,
    String? complexion,
    List<String>? category,
  }) {
    return JobDataModel(
      jobTitle: jobTitle ?? this.jobTitle,
      jobType: jobType ?? this.jobType,
      priceOption: priceOption ?? this.priceOption,
      priceValue: priceValue ?? this.priceValue,
      talents: talents ?? this.talents,
      preferredGender: preferredGender ?? this.preferredGender,
      shortDescription: shortDescription ?? this.shortDescription,
      brief: brief ?? this.brief,
      briefFile: briefFile ?? this.briefFile,
      briefLink: briefLink ?? this.briefLink,
      location: location ?? this.location,
      deliverablesType: deliverablesType ?? this.deliverablesType,
      isDigitalContent: isDigitalContent ?? this.isDigitalContent,
      acceptMultiple: acceptMultiple ?? this.acceptMultiple,
      usageType: usageType ?? this.usageType,
      usageLength: usageLength ?? this.usageLength,
      minAge: minAge ?? this.minAge,
      maxAge: maxAge ?? this.maxAge,
      height: height ?? this.height,
      size: size ?? this.size,
      ethnicity: ethnicity ?? this.ethnicity,
      complexion: complexion ?? this.complexion,
      category: category ?? this.category,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'jobTitle': jobTitle,
      'jobType': jobType,
      'priceOption': priceOption,
      'priceValue': priceValue,
      'talents': talents,
      'preferredGender': preferredGender,
      'shortDescription': shortDescription,
      'brief': brief,
      'briefFile': briefFile,
      'briefLink': briefLink,
      'location': location,
      'deliverablesType': deliverablesType,
      'isDigitalContent': isDigitalContent,
      'acceptMultiple': acceptMultiple,
      'usageType': usageType,
      'usageLength': usageLength,
      'minAge': minAge,
      'maxAge': maxAge,
      'height': height,
      'size': size?.apiValue,
      'ethnicity': ethnicity?.apiValue,
      'complexion': complexion,
      'category': category,
    };
  }

  // factory JobDataModel.fromMap(Map<String, dynamic> map) {
  //   return JobDataModel(
  //     jobTitle: map['jobTitle'] as String,
  //     jobType: map['jobType'] as String,
  //     priceOption: map['priceOption'] as String,
  //     priceValue: map['priceValue'] as double,
  //     talents: List<String>.from((map['talents'] as List<String>)),
  //     preferredGender: map['preferredGender'] as String,
  //     shortDescription: map['shortDescription'] as String,
  //     brief: map['brief'] != null ? map['brief'] as String : null,
  //     briefFile: map['briefFile'] != null ? map['briefFile'] as String : null,
  //     briefLink: map['briefLink'] != null ? map['briefLink'] as String : null,
  //     location: Map<String, dynamic>.from((map['location'] as Map<String, dynamic>)),
  //     deliverablesType: map['deliverablesType'] as String,
  //     isDigitalContent: map['isDigitalContent'] as bool,
  //     acceptMultiple: map['acceptMultiple'] as bool,
  //     usageType: map['usageType'] != null ? map['usageType'] as String : null,
  //     usageLength: map['usageLength'] != null ? map['usageLength'] as String : null,
  //     minAge: map['minAge'] as int,
  //     maxAge: map['maxAge'] as int,
  //     height: map['height'] != null ? Map<String, dynamic>.from((map['height'] as Map<String, dynamic>) : null,
  //     size: map['size'] != null ? ModelSize.fromMap(map['size'] as Map<String,dynamic>) : null,
  //     ethnicity: map['ethnicity'] != null ? Ethnicity.fromMap(map['ethnicity'] as Map<String,dynamic>) : null,
  //     complexion: map['complexion'] != null ? map['complexion'] as String : null,
  //   );
  // }

  factory JobDataModel.fromMap(Map<String, dynamic> map) {
    return JobDataModel(
      jobTitle: map['jobTitle'] as String,
      jobType: map['jobType'] as String,
      priceOption: map['priceOption'] as String,
      priceValue: map['priceValue'] as double,
      talents: List<String>.from((map['talents'] as List<String>)),
      preferredGender: map['preferredGender'] as String,
      shortDescription: map['shortDescription'] as String,
      brief: map['brief'] != null ? map['brief'] as String : null,
      briefFile: map['briefFile'] != null ? map['briefFile'] as String : null,
      briefLink: map['briefLink'] != null ? map['briefLink'] as String : null,
      location:
          Map<String, dynamic>.from((map['location'] as Map<String, dynamic>)),
      deliverablesType: map['deliverablesType'] as String,
      isDigitalContent: map['isDigitalContent'] as bool,
      acceptMultiple: map['acceptMultiple'] as bool,
      usageType: map['usageType'] as String,
      usageLength: map['usageLength'] as String,
      minAge: map['minAge'] as int,
      maxAge: map['maxAge'] as int,
      height:
          Map<String, dynamic>.from((map['height'] as Map<String, dynamic>)),
      size: map['size'] != null
          ? ModelSize.modelSizeByApiValue(map['size'] as String)
          : null,
      ethnicity: map['ethnicity'] != null
          ? Ethnicity.ethnicityByApiValue(map['ethnicity'] as String)
          : null,
      complexion:
          map['complexion'] != null ? map['complexion'] as String : null,
      category:
          map['category'] != null ? List<String>.from(map['category']) : null,
      // size: ModelSize.modelSizeByApiValue(map['size'] as String),
      // ethnicity: Ethnicity.ethnicityByApiValue(map['ethnicity'] as String) ??
      //     Ethnicity.black,
      // complexion: map['complexion'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory JobDataModel.fromJson(String source) =>
      JobDataModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return '''
JobDataModel(jobTitle: $jobTitle,
 jobType: $jobType,
  priceOption: $priceOption,
  priceValue: $priceValue,
  talents: $talents,
  preferredGender: $preferredGender,
  shortDescription: $shortDescription,
  brief: $brief,
  briefFile: $briefFile,
  briefLink: $briefLink,
  location: $location,
  deliverablesType: $deliverablesType,
  isDigitalContent: $isDigitalContent,
  acceptMultiple: $acceptMultiple,
  usageType: $usageType, usageLength: $usageLength,
  minAge: $minAge, maxAge: $maxAge, height: $height,
  size: $size, ethnicity: $ethnicity,
  complexion: $complexion,
  category: $category)
''';
  }

  @override
  bool operator ==(covariant JobDataModel other) {
    if (identical(this, other)) return true;

    return other.jobTitle == jobTitle &&
        other.jobType == jobType &&
        other.priceOption == priceOption &&
        other.priceValue == priceValue &&
        listEquals(other.talents, talents) &&
        other.preferredGender == preferredGender &&
        other.shortDescription == shortDescription &&
        other.brief == brief &&
        other.briefFile == briefFile &&
        other.briefLink == briefLink &&
        mapEquals(other.location, location) &&
        other.deliverablesType == deliverablesType &&
        other.isDigitalContent == isDigitalContent &&
        other.acceptMultiple == acceptMultiple &&
        other.usageType == usageType &&
        other.usageLength == usageLength &&
        other.minAge == minAge &&
        other.maxAge == maxAge &&
        mapEquals(other.height, height) &&
        other.size == size &&
        other.ethnicity == ethnicity &&
        other.complexion == complexion &&
        other.category == category;
  }

  @override
  int get hashCode {
    return jobTitle.hashCode ^
        jobType.hashCode ^
        priceOption.hashCode ^
        priceValue.hashCode ^
        talents.hashCode ^
        preferredGender.hashCode ^
        shortDescription.hashCode ^
        brief.hashCode ^
        briefFile.hashCode ^
        briefLink.hashCode ^
        location.hashCode ^
        deliverablesType.hashCode ^
        isDigitalContent.hashCode ^
        acceptMultiple.hashCode ^
        usageType.hashCode ^
        usageLength.hashCode ^
        minAge.hashCode ^
        maxAge.hashCode ^
        height.hashCode ^
        size.hashCode ^
        ethnicity.hashCode ^
        complexion.hashCode ^
        category.hashCode;
  }
}


/** *


  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'jobTitle': jobTitle,
      'jobType': jobType,
      'priceOption': priceOption,
      'priceValue': priceValue,
      'talents': talents,
      'preferredGender': preferredGender,
      'shortDescription': shortDescription,
      'brief': brief,
      'briefFile': briefFile,
      'briefLink': briefLink,
      'location': location,
      'deliverablesType': deliverablesType,
      'isDigitalContent': isDigitalContent,
      'acceptMultiple': acceptMultiple,
      'usageType': usageType,
      'usageLength': usageLength,
      'minAge': minAge,
      'maxAge': maxAge,
      'height': height,
      'size': size?.apiValue,
      'ethnicity': ethnicity?.apiValue,
      'complexion': complexion,
    };
  }

  factory JobDataModel.fromMap(Map<String, dynamic> map) {
    return JobDataModel(
      jobTitle: map['jobTitle'] as String,
      jobType: map['jobType'] as String,
      priceOption: map['priceOption'] as String,
      priceValue: map['priceValue'] as double,
      talents: List<String>.from((map['talents'] as List<String>)),
      preferredGender: map['preferredGender'] as String,
      shortDescription: map['shortDescription'] as String,
      brief: map['brief'] != null ? map['brief'] as String : null,
      briefFile: map['briefFile'] != null ? map['briefFile'] as String : null,
      briefLink: map['briefLink'] != null ? map['briefLink'] as String : null,
      location:
          Map<String, dynamic>.from((map['location'] as Map<String, dynamic>)),
      deliverablesType: map['deliverablesType'] as String,
      isDigitalContent: map['isDigitalContent'] as bool,
      acceptMultiple: map['acceptMultiple'] as bool,
      usageType: map['usageType'] as String,
      usageLength: map['usageLength'] as String,
      minAge: map['minAge'] as int,
      maxAge: map['maxAge'] as int,
      height:
          Map<String, dynamic>.from((map['height'] as Map<String, dynamic>)),
      size: ModelSize.modelSizeByApiValue(map['size'] as String),
      ethnicity: Ethnicity.ethnicityByApiValue(map['ethnicity'] as String) ??
          Ethnicity.black,
      complexion: map['complexion'] as String,
    );
  }


*/