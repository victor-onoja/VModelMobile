// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:vmodel/src/core/utils/validators_mixins.dart';

import '../../../../core/models/app_user.dart';
import '../../../../core/models/id_name_field.dart';
import '../../../../core/models/location_model.dart';
import '../../../../core/utils/enum/ethnicity_enum.dart';
import '../../../../core/utils/enum/service_job_status.dart';
import '../../../../core/utils/enum/service_pricing_enum.dart';
import '../../../../core/utils/enum/size_enum.dart';
import '../../create_jobs/controller/create_job_controller.dart';
import '../../create_jobs/model/job_application.dart';

@immutable
class JobPostModel {
  final String id;
  final String jobTitle;
  final String jobType;
  final bool? userSaved;
  final ServicePeriod priceOption;
  final double priceValue;
  final List<String> talents;
  final String preferredGender;
  final String shortDescription;
  final String? brief;
  final String? category;
  final String? briefFile;
  final String? briefLink;
  final LocationData jobLocation;
  final List<JobDeliveryDate> jobDelivery;
  final String deliverablesType;
  final bool isDigitalContent;
  final bool acceptingMultipleApplicants;
  // final String? usageType;
  // final String? usageLength;
  final NameIDField? usageType;
  final NameIDField? usageLength;
  final int minAge;
  final int maxAge;
  final int? saves;
  final int noOfApplicants;
  final Map<String, dynamic>? talentHeight;
  final ModelSize? size;
  final Ethnicity? ethnicity;
  final String? skinComplexion;
  final DateTime createdAt;
  // final FeedUser creator;
  final VAppUser? creator;
  final List<JobApplication>? applicationSet;
  final bool paused;
  final bool closed;
  final bool processing;
  final ServiceOrJobStatus status;

  JobPostModel({
    required this.id,
    required this.jobTitle,
    required this.jobType,
    this.userSaved,
    required this.priceOption,
    required this.priceValue,
    required this.talents,
    required this.preferredGender,
    required this.shortDescription,
    this.brief,
    this.category,
    this.briefFile,
    this.briefLink,
    required this.jobLocation,
    required this.jobDelivery,
    required this.deliverablesType,
    required this.isDigitalContent,
    required this.acceptingMultipleApplicants,
    this.usageType,
    this.usageLength,
    required this.minAge,
    required this.maxAge,
    this.saves,
    required this.noOfApplicants,
    this.talentHeight,
    this.size,
    this.ethnicity,
    this.skinComplexion,
    required this.createdAt,
    required this.creator,
    this.applicationSet,
    required this.paused,
    required this.closed,
    required this.processing,
    required this.status,
  });

  bool get hasBrief =>
      (!brief.isEmptyOrNull || briefFile != null || !briefLink.isEmptyOrNull);

  bool get hasAdvancedRequirements => (minAge > 0 ||
      maxAge > 0 ||
      ethnicity != null ||
      size != null ||
      talentHeight != null);

  bool hasUserApplied(String username) {
    if (applicationSet == null) {
      print('Hasssss ussser applied is FFFFAaalllsseee');
      return false;
    }
    final res = applicationSet
            ?.any((element) => element.applicant.username == username) ??
        false;
    print('Hasssss ussser applied is $res');
    return res;
  }

  JobPostModel copyWith({
    String? id,
    String? jobTitle,
    String? jobType,
    bool? userSaved,
    ServicePeriod? priceOption,
    double? priceValue,
    List<String>? talents,
    String? preferredGender,
    String? shortDescription,
    String? brief,
    String? category,
    String? briefFile,
    String? briefLink,
    LocationData? jobLocation,
    List<JobDeliveryDate>? jobDelivery,
    String? deliverablesType,
    bool? isDigitalContent,
    bool? acceptingMultipleApplicants,
    NameIDField? usageType,
    NameIDField? usageLength,
    int? minAge,
    int? maxAge,
    int? saves,
    int? noOfApplicants,
    Map<String, dynamic>? talentHeight,
    ModelSize? size,
    Ethnicity? ethnicity,
    String? skinComplexion,
    DateTime? createdAt,
    VAppUser? creator,
    List<JobApplication>? applicationSet,
    bool? paused,
    bool? closed,
    bool? processing,
    ServiceOrJobStatus? status,
  }) {
    return JobPostModel(
      id: id ?? this.id,
      jobTitle: jobTitle ?? this.jobTitle,
      jobType: jobType ?? this.jobType,
      userSaved: userSaved ?? this.userSaved,
      priceOption: priceOption ?? this.priceOption,
      priceValue: priceValue ?? this.priceValue,
      talents: talents ?? this.talents,
      preferredGender: preferredGender ?? this.preferredGender,
      shortDescription: shortDescription ?? this.shortDescription,
      brief: brief ?? this.brief,
      category: category ?? this.category,
      briefFile: briefFile ?? this.briefFile,
      briefLink: briefLink ?? this.briefLink,
      jobLocation: jobLocation ?? this.jobLocation,
      jobDelivery: jobDelivery ?? this.jobDelivery,
      deliverablesType: deliverablesType ?? this.deliverablesType,
      isDigitalContent: isDigitalContent ?? this.isDigitalContent,
      acceptingMultipleApplicants:
          acceptingMultipleApplicants ?? this.acceptingMultipleApplicants,
      usageType: usageType ?? this.usageType,
      usageLength: usageLength ?? this.usageLength,
      minAge: minAge ?? this.minAge,
      maxAge: maxAge ?? this.maxAge,
      saves: saves ?? this.saves,
      noOfApplicants: noOfApplicants ?? this.noOfApplicants,
      talentHeight: talentHeight ?? this.talentHeight,
      size: size ?? this.size,
      ethnicity: ethnicity ?? this.ethnicity,
      skinComplexion: skinComplexion ?? this.skinComplexion,
      createdAt: createdAt ?? this.createdAt,
      creator: creator ?? this.creator,
      applicationSet: applicationSet ?? this.applicationSet,
      paused: paused ?? this.paused,
      closed: closed ?? this.closed,
      processing: processing ?? this.processing,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> duplicateDataMap() {
    return <String, dynamic>{
      'jobTitle': "$jobTitle Copy",
      'jobType': jobType,
      'saves': saves,
      'userSaved': userSaved,

      'priceOption': priceOption.simpleName,
      'priceValue': priceValue,
      'talents': talents,
      'preferredGender': preferredGender,
      'shortDescription': shortDescription,
      'category': category,
      'brief': brief,
      'noOfApplicants': noOfApplicants,
      'briefFile': briefFile,
      'briefLink': briefLink,
      'location': jobLocation.toMap(),
      "deliveryData": jobDelivery.map((x) => x.toMap()).toList(),
      'deliverablesType': deliverablesType,
      'isDigitalContent': isDigitalContent,
      'acceptMultiple': acceptingMultipleApplicants,
      'usageType': usageType,
      'usageLength': usageLength,
      'minAge': minAge,
      'maxAge': maxAge,
      'height': talentHeight,
      'size': size?.apiValue,
      'ethnicity': ethnicity?.apiValue,
      'skinComplexion': skinComplexion,
      'publish': false,
      // 'deliveryType': "type", //redundant non-used field
    };
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'jobTitle': jobTitle,
      'saves': saves,
      'userSaved': userSaved,
      'jobType': jobType,
      'priceOption': priceOption.simpleName,
      'priceValue': priceValue,
      'talents': talents,
      'preferredGender': preferredGender,
      'shortDescription': shortDescription,
      'category': category,
      'noOfApplicants': noOfApplicants,
      'brief': brief,
      'briefFile': briefFile,
      'briefLink': briefLink,
      'jobLocation': jobLocation.toMap(),
      'jobDelivery': jobDelivery.map((x) => x.toMap()).toList(),
      'deliverablesType': deliverablesType,
      'isDigitalContent': isDigitalContent,
      'acceptMultiple': acceptingMultipleApplicants,
      'usageType': usageType?.toMap(),
      'usageLength': usageLength?.toMap(),
      // 'usageType': usageType,
      // 'usageLength': usageLength,
      'minAge': minAge,
      'maxAge': maxAge,
      'talentHeight': talentHeight,
      'size': size?.apiValue,
      'ethnicity': ethnicity?.apiValue,
      'skinComplexion': skinComplexion,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'creator': creator!.toMap(),
      'paused': paused,
      'closed': closed,
      'processing': processing,
      'status': status.apiValue,
      'applicationSet': applicationSet?.map((x) => x.toMap()).toList(),
    };
  }

  factory JobPostModel.fromMap(Map<String, dynamic> map) {
    try {
      String priceOptionMap = map['priceOption'] as String;
      final talentHeightMap = map['talentHeight'] as Map<String, dynamic>?;
      String? sizeMap = map['size'];
      String? ethnicityMap = map['ethnicity'];

      //todo remove this in prod
      if (priceOptionMap.toLowerCase().contains('hour') ||
          priceOptionMap.toLowerCase().contains('service')) {
      } else {
        priceOptionMap = 'service';
      }
      return JobPostModel(
        id: map['id'] as String,
        jobTitle: map['jobTitle'] as String,
        saves: map['saves'] != null ? map['saves'] as int : 0,
        userSaved: map['userSaved'] != null ? map['userSaved'] as bool : false,
        jobType: map['jobType'] as String,
        priceOption: ServicePeriod.servicePeriodByApiValue(priceOptionMap),
        priceValue: map['priceValue'] as double,
        talents: List<String>.from(
          (map['talents'] as List).map<String>(
            (x) => x as String,
          ),
        ),
        preferredGender: map['preferredGender'] as String,
        noOfApplicants:
            map['noOfApplicants'] != null ? map['noOfApplicants'] as int : 0,
        shortDescription: map['shortDescription'] as String,
        brief: map['brief'] as String?,
        briefFile: map['briefFile'] as String?,
        briefLink: map['briefLink'] as String?,
        jobLocation:
            LocationData.fromMap(map['jobLocation'] as Map<String, dynamic>),
        jobDelivery: List<JobDeliveryDate>.from(
          (map['jobDelivery'] as List).map<JobDeliveryDate>(
            (x) => JobDeliveryDate.fromMap(x as Map<String, dynamic>),
          ),
        )..sort((a, b) => a.date.compareTo(b.date)),
        deliverablesType: map['deliverablesType'] as String,
        isDigitalContent: map['isDigitalContent'] as bool,
        acceptingMultipleApplicants: (map['acceptMultiple'] as bool?) ?? false,
        // usageType: map['usageType'] != null
        //     ? map['usageType']['name'] as String?
        //     : null,
        // usageLength: map['usageLength'] != null
        //     ? map['usageLength']['name'] as String?
        //     : null,
        usageType: map['usageType'] != null
            ? NameIDField.fromMap(map['usageType'] as Map<String, dynamic>)
            : null,
        usageLength: map['usageLength'] != null
            ? NameIDField.fromMap(map['usageLength'] as Map<String, dynamic>)
            : null,
        minAge: map['minAge'] as int,
        maxAge: map['maxAge'] as int,
        talentHeight: map['talentHeight'] != null
            ? Map<String, dynamic>.from(
                (map['talentHeight'] as Map<String, dynamic>))
            : null,
        size: map['size'] != null
            ? ModelSize.modelSizeByApiValue(map['size'] as String)
            : null,
        ethnicity: map['ethnicity'] != null
            ? Ethnicity.ethnicityByApiValue(map['ethnicity'] as String)
            : null,
        skinComplexion: map['skinComplexion'] as String?,
        createdAt: DateTime.parse(map['createdAt']),
        // creator: FeedUser.fromMap(map['creator'] as Map<String, dynamic>),
        creator:
            VAppUser.fromMinimalMap(map['creator'] as Map<String, dynamic>),
        category: map['category'] as String?,
        paused: map['paused'] as bool,
        closed: map['closed'] as bool,
        processing: (map['processing'] as bool?) ?? false,
        status: ServiceOrJobStatus.serviceOrJobStatusByApiValue(
            map['status'] ?? ''),
        applicationSet: map['applicationSet'] != null
            ? List<JobApplication>.from(
                (map['applicationSet'] as List).map<JobApplication?>(
                  (x) => JobApplication.fromMap(x as Map<String, dynamic>),
                ),
              )
            : null,
      );
    } catch (e, st) {
      print('$e \n $st');

      rethrow;
    }
  }

  String duplicateToJson() => json.encode(duplicateDataMap());

  String toJson() => json.encode(toMap());

  factory JobPostModel.fromJson(String source) =>
      JobPostModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'JobPostModel(id: $id, jobTitle: $jobTitle, jobType: $jobType, userSaved: $userSaved, priceOption: $priceOption, priceValue: $priceValue, talents: $talents, preferredGender: $preferredGender, shortDescription: $shortDescription, brief: $brief, category: $category, briefFile: $briefFile, briefLink: $briefLink, jobLocation: $jobLocation, jobDelivery: $jobDelivery, deliverablesType: $deliverablesType, isDigitalContent: $isDigitalContent, acceptingMultipleApplicants: $acceptingMultipleApplicants, usageType: $usageType, usageLength: $usageLength, minAge: $minAge, maxAge: $maxAge, saves: $saves, noOfApplicants: $noOfApplicants, talentHeight: $talentHeight, size: $size, ethnicity: $ethnicity, skinComplexion: $skinComplexion, createdAt: $createdAt, creator: $creator, applicationSet: $applicationSet, paused: $paused, closed: $closed, processing: $processing, status: $status)';
  }

  @override
  bool operator ==(covariant JobPostModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.jobTitle == jobTitle &&
        other.jobType == jobType &&
        other.userSaved == userSaved &&
        other.priceOption == priceOption &&
        other.priceValue == priceValue &&
        listEquals(other.talents, talents) &&
        other.preferredGender == preferredGender &&
        other.shortDescription == shortDescription &&
        other.brief == brief &&
        other.category == category &&
        other.briefFile == briefFile &&
        other.briefLink == briefLink &&
        other.jobLocation == jobLocation &&
        listEquals(other.jobDelivery, jobDelivery) &&
        other.deliverablesType == deliverablesType &&
        other.isDigitalContent == isDigitalContent &&
        other.acceptingMultipleApplicants == acceptingMultipleApplicants &&
        other.usageType == usageType &&
        other.usageLength == usageLength &&
        other.minAge == minAge &&
        other.maxAge == maxAge &&
        other.saves == saves &&
        other.noOfApplicants == noOfApplicants &&
        mapEquals(other.talentHeight, talentHeight) &&
        other.size == size &&
        other.ethnicity == ethnicity &&
        other.skinComplexion == skinComplexion &&
        other.createdAt == createdAt &&
        other.creator == creator &&
        listEquals(other.applicationSet, applicationSet) &&
        other.paused == paused &&
        other.closed == closed &&
        other.processing == processing &&
        other.status == status;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        jobTitle.hashCode ^
        jobType.hashCode ^
        userSaved.hashCode ^
        priceOption.hashCode ^
        priceValue.hashCode ^
        talents.hashCode ^
        preferredGender.hashCode ^
        shortDescription.hashCode ^
        brief.hashCode ^
        category.hashCode ^
        briefFile.hashCode ^
        briefLink.hashCode ^
        jobLocation.hashCode ^
        jobDelivery.hashCode ^
        deliverablesType.hashCode ^
        isDigitalContent.hashCode ^
        acceptingMultipleApplicants.hashCode ^
        usageType.hashCode ^
        usageLength.hashCode ^
        minAge.hashCode ^
        maxAge.hashCode ^
        saves.hashCode ^
        noOfApplicants.hashCode ^
        talentHeight.hashCode ^
        size.hashCode ^
        ethnicity.hashCode ^
        skinComplexion.hashCode ^
        createdAt.hashCode ^
        creator.hashCode ^
        applicationSet.hashCode ^
        paused.hashCode ^
        closed.hashCode ^
        processing.hashCode ^
        status.hashCode;
  }
}

/**
 

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:vmodel/src/core/utils/validators_mixins.dart';

import '../../../../core/models/app_user.dart';
import '../../../../core/models/id_name_field.dart';
import '../../../../core/models/location_model.dart';
import '../../../../core/utils/enum/ethnicity_enum.dart';
import '../../../../core/utils/enum/service_job_status.dart';
import '../../../../core/utils/enum/service_pricing_enum.dart';
import '../../../../core/utils/enum/size_enum.dart';
import '../../create_jobs/controller/create_job_controller.dart';
import '../../create_jobs/model/job_application.dart';

@immutable
class JobPostModel {
  final String id;
  final String jobTitle;
  final String jobType;
  final bool? userSaved;
  final ServicePeriod priceOption;
  final double priceValue;
  final List<String> talents;
  final String preferredGender;
  final String shortDescription;
  final String? brief;
  final String? category;
  final String? briefFile;
  final String? briefLink;
  final LocationData jobLocation;
  final List<JobDeliveryDate> jobDelivery;
  final String deliverablesType;
  final bool isDigitalContent;
  final bool acceptingMultipleApplicants;
  // final String? usageType;
  // final String? usageLength;
  final NameIDField? usageType;
  final NameIDField? usageLength;
  final int minAge;
  final int maxAge;
  final int? saves;
  final int noOfApplicants;
  final Map<String, dynamic>? talentHeight;
  final ModelSize? size;
  final Ethnicity? ethnicity;
  final String? skinComplexion;
  final DateTime createdAt;
  // final FeedUser creator;
  final VAppUser? creator;
  final List<JobApplication>? applicationSet;
  final bool paused;
  final bool closed;
  final bool processing;
  final ServiceOrJobStatus status;

  JobPostModel({
    required this.id,
    this.saves,
    this.userSaved,
    required this.jobTitle,
    required this.jobType,
    required this.priceOption,
    required this.priceValue,
    required this.talents,
    required this.preferredGender,
    required this.shortDescription,
    required this.noOfApplicants,
    this.brief,
    this.category,
    this.briefFile,
    this.briefLink,
    required this.jobLocation,
    required this.jobDelivery,
    required this.deliverablesType,
    required this.isDigitalContent,
    required this.acceptingMultipleApplicants,
    this.usageType,
    this.usageLength,
    required this.minAge,
    required this.maxAge,
    this.talentHeight,
    this.size,
    this.ethnicity,
    this.skinComplexion,
    required this.createdAt,
    required this.creator,
    this.applicationSet,
    required this.paused,
    required this.closed,
    required this.processing,
    required this.status,
  });

  bool get hasBrief =>
      (!brief.isEmptyOrNull || briefFile != null || !briefLink.isEmptyOrNull);

  bool get hasAdvancedRequirements => (minAge > 0 ||
      maxAge > 0 ||
      ethnicity != null ||
      size != null ||
      talentHeight != null);

  bool hasUserApplied(String username) {
    if (applicationSet == null) {
      print('Hasssss ussser applied is FFFFAaalllsseee');
      return false;
    }
    final res = applicationSet
            ?.any((element) => element.applicant.username == username) ??
        false;
    print('Hasssss ussser applied is $res');
    return res;
  }

  JobPostModel copyWith({
    String? id,
    String? jobTitle,
    String? jobType,
    int? saves,
    bool? userSaved,
    ServicePeriod? priceOption,
    double? priceValue,
    List<String>? talents,
    String? preferredGender,
    String? shortDescription,
    String? brief,
    String? category,
    String? briefFile,
    String? briefLink,
    LocationData? jobLocation,
    List<JobDeliveryDate>? jobDelivery,
    String? deliverablesType,
    bool? isDigitalContent,
    bool? acceptingMultipleApplicants,
    String? usageType,
    String? usageLength,
    int? minAge,
    int? maxAge,
    Map<String, dynamic>? talentHeight,
    ModelSize? size,
    Ethnicity? ethnicity,
    String? skinComplexion,
    DateTime? createdAt,
    VAppUser? creator,
    List<JobApplication>? applicationSet,
    bool? paused,
    bool? closed,
    bool? processing,
    ServiceOrJobStatus? status,
    int? noOfApplicants,
  }) {
    return JobPostModel(
      id: id ?? this.id,
      saves: saves ?? this.saves,
      userSaved: userSaved ?? this.userSaved,
      jobTitle: jobTitle ?? this.jobTitle,
      noOfApplicants: noOfApplicants ?? this.noOfApplicants,
      jobType: jobType ?? this.jobType,
      priceOption: priceOption ?? this.priceOption,
      priceValue: priceValue ?? this.priceValue,
      talents: talents ?? this.talents,
      preferredGender: preferredGender ?? this.preferredGender,
      shortDescription: shortDescription ?? this.shortDescription,
      brief: brief ?? this.brief,
      category: category ?? this.category,
      briefFile: briefFile ?? this.briefFile,
      briefLink: briefLink ?? this.briefLink,
      jobLocation: jobLocation ?? this.jobLocation,
      jobDelivery: jobDelivery ?? this.jobDelivery,
      deliverablesType: deliverablesType ?? this.deliverablesType,
      isDigitalContent: isDigitalContent ?? this.isDigitalContent,
      acceptingMultipleApplicants:
          acceptingMultipleApplicants ?? this.acceptingMultipleApplicants,
      usageType: usageType ?? this.usageType,
      usageLength: usageLength ?? this.usageLength,
      minAge: minAge ?? this.minAge,
      maxAge: maxAge ?? this.maxAge,
      talentHeight: talentHeight ?? this.talentHeight,
      size: size ?? this.size,
      ethnicity: ethnicity ?? this.ethnicity,
      skinComplexion: skinComplexion ?? this.skinComplexion,
      createdAt: createdAt ?? this.createdAt,
      creator: creator ?? this.creator,
      applicationSet: applicationSet ?? this.applicationSet,
      paused: paused ?? this.paused,
      closed: closed ?? this.closed,
      processing: processing ?? this.processing,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> duplicateDataMap() {
    return <String, dynamic>{
      'jobTitle': "$jobTitle Copy",
      'jobType': jobType,
      'saves': saves,
      'userSaved': userSaved,

      'priceOption': priceOption.simpleName,
      'priceValue': priceValue,
      'talents': talents,
      'preferredGender': preferredGender,
      'shortDescription': shortDescription,
      'category': category,
      'brief': brief,
      'noOfApplicants': noOfApplicants,
      'briefFile': briefFile,
      'briefLink': briefLink,
      'location': jobLocation.toMap(),
      "deliveryData": jobDelivery.map((x) => x.toMap()).toList(),
      'deliverablesType': deliverablesType,
      'isDigitalContent': isDigitalContent,
      'acceptMultiple': acceptingMultipleApplicants,
      'usageType': usageType,
      'usageLength': usageLength,
      'minAge': minAge,
      'maxAge': maxAge,
      'height': talentHeight,
      'size': size?.apiValue,
      'ethnicity': ethnicity?.apiValue,
      'skinComplexion': skinComplexion,
      'publish': false,
      // 'deliveryType': "type", //redundant non-used field
    };
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'jobTitle': jobTitle,
      'saves': saves,
      'userSaved': userSaved,
      'jobType': jobType,
      'priceOption': priceOption.simpleName,
      'priceValue': priceValue,
      'talents': talents,
      'preferredGender': preferredGender,
      'shortDescription': shortDescription,
      'category': category,
      'noOfApplicants': noOfApplicants,
      'brief': brief,
      'briefFile': briefFile,
      'briefLink': briefLink,
      'jobLocation': jobLocation.toMap(),
      'jobDelivery': jobDelivery.map((x) => x.toMap()).toList(),
      'deliverablesType': deliverablesType,
      'isDigitalContent': isDigitalContent,
      'acceptMultiple': acceptingMultipleApplicants,
      'usageType': usageType,
      'usageLength': usageLength,
      'minAge': minAge,
      'maxAge': maxAge,
      'talentHeight': talentHeight,
      'size': size?.apiValue,
      'ethnicity': ethnicity?.apiValue,
      'skinComplexion': skinComplexion,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'creator': creator!.toMap(),
      'paused': paused,
      'closed': closed,
      'processing': processing,
      'status': status.apiValue,
      'applicationSet': applicationSet?.map((x) => x.toMap()).toList(),
    };
  }

  factory JobPostModel.fromMap(Map<String, dynamic> map) {
    try {
      String priceOptionMap = map['priceOption'] as String;
      final talentHeightMap = map['talentHeight'] as Map<String, dynamic>?;
      String? sizeMap = map['size'];
      String? ethnicityMap = map['ethnicity'];

      //todo remove this in prod
      if (priceOptionMap.toLowerCase().contains('hour') ||
          priceOptionMap.toLowerCase().contains('service')) {
      } else {
        priceOptionMap = 'service';
      }
      return JobPostModel(
        id: map['id'] as String,
        jobTitle: map['jobTitle'] as String,
        saves: map['saves'] != null ? map['saves'] as int : 0,
        userSaved: map['userSaved'] != null ? map['userSaved'] as bool : false,
        jobType: map['jobType'] as String,
        priceOption: ServicePeriod.servicePeriodByApiValue(priceOptionMap),
        priceValue: map['priceValue'] as double,
        talents: List<String>.from(
          (map['talents'] as List).map<String>(
            (x) => x as String,
          ),
        ),
        preferredGender: map['preferredGender'] as String,
        noOfApplicants:
            map['noOfApplicants'] != null ? map['noOfApplicants'] as int : 0,
        shortDescription: map['shortDescription'] as String,
        brief: map['brief'] as String?,
        briefFile: map['briefFile'] as String?,
        briefLink: map['briefLink'] as String?,
        jobLocation:
            LocationData.fromMap(map['jobLocation'] as Map<String, dynamic>),
        jobDelivery: List<JobDeliveryDate>.from(
          (map['jobDelivery'] as List).map<JobDeliveryDate>(
            (x) => JobDeliveryDate.fromMap(x as Map<String, dynamic>),
          ),
        )..sort((a, b) => a.date.compareTo(b.date)),
        deliverablesType: map['deliverablesType'] as String,
        isDigitalContent: map['isDigitalContent'] as bool,
        acceptingMultipleApplicants: (map['acceptMultiple'] as bool?) ?? false,
        usageType: map['usageType'] != null
            ? map['usageType']['name'] as String?
            : null,
        usageLength: map['usageLength'] != null
            ? map['usageLength']['name'] as String?
            : null,
        minAge: map['minAge'] as int,
        maxAge: map['maxAge'] as int,
        talentHeight: map['talentHeight'] != null
            ? Map<String, dynamic>.from(
                (map['talentHeight'] as Map<String, dynamic>))
            : null,
        size: map['size'] != null
            ? ModelSize.modelSizeByApiValue(map['size'] as String)
            : null,
        ethnicity: map['ethnicity'] != null
            ? Ethnicity.ethnicityByApiValue(map['ethnicity'] as String)
            : null,
        skinComplexion: map['skinComplexion'] as String?,
        createdAt: DateTime.parse(map['createdAt']),
        // creator: FeedUser.fromMap(map['creator'] as Map<String, dynamic>),
        creator:
            VAppUser.fromMinimalMap(map['creator'] as Map<String, dynamic>),
        category: map['category'] as String?,
        paused: map['paused'] as bool,
        closed: map['closed'] as bool,
        processing: (map['processing'] as bool?) ?? false,
        status: ServiceOrJobStatus.serviceOrJobStatusByApiValue(
            map['status'] ?? ''),
        applicationSet: map['applicationSet'] != null
            ? List<JobApplication>.from(
                (map['applicationSet'] as List).map<JobApplication?>(
                  (x) => JobApplication.fromMap(x as Map<String, dynamic>),
                ),
              )
            : null,
      );
    } catch (e, st) {
      print('$e \n $st');

      rethrow;
    }
  }

  String duplicateToJson() => json.encode(duplicateDataMap());

  String toJson() => json.encode(toMap());

  factory JobPostModel.fromJson(String source) =>
      JobPostModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'JobPostModel(id: $id, jobTitle: $jobTitle, saves: $saves, userSaved: $userSaved, jobType: $jobType, priceOption: $priceOption, priceValue: $priceValue, talents: $talents, preferredGender: $preferredGender, shortDescription: $shortDescription, brief: $brief, category: $category, briefFile: $briefFile, briefLink: $briefLink, jobLocation: $jobLocation, jobDelivery: $jobDelivery, deliverablesType: $deliverablesType, isDigitalContent: $isDigitalContent, acceptingMultipleApplicants: $acceptingMultipleApplicants, usageType: $usageType, usageLength: $usageLength, minAge: $minAge, maxAge: $maxAge, talentHeight: $talentHeight, size: $size, ethnicity: $ethnicity, skinComplexion: $skinComplexion, createdAt: $createdAt, creator: $creator, applicationSet: $applicationSet, paused: $paused, closed: $closed, processing: $processing, status: $status, noOfApplicants: $noOfApplicants)';
  }

  @override
  bool operator ==(covariant JobPostModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.jobTitle == jobTitle &&
        other.saves == saves &&
        other.userSaved == userSaved &&
        other.jobType == jobType &&
        other.priceOption == priceOption &&
        other.priceValue == priceValue &&
        listEquals(other.talents, talents) &&
        other.preferredGender == preferredGender &&
        other.shortDescription == shortDescription &&
        other.brief == brief &&
        other.noOfApplicants == noOfApplicants &&
        other.category == category &&
        other.briefFile == briefFile &&
        other.briefLink == briefLink &&
        other.jobLocation == jobLocation &&
        listEquals(other.jobDelivery, jobDelivery) &&
        other.deliverablesType == deliverablesType &&
        other.isDigitalContent == isDigitalContent &&
        other.acceptingMultipleApplicants == acceptingMultipleApplicants &&
        other.usageType == usageType &&
        other.usageLength == usageLength &&
        other.minAge == minAge &&
        other.maxAge == maxAge &&
        mapEquals(other.talentHeight, talentHeight) &&
        other.size == size &&
        other.ethnicity == ethnicity &&
        other.skinComplexion == skinComplexion &&
        other.createdAt == createdAt &&
        other.creator == creator &&
        listEquals(other.applicationSet, applicationSet) &&
        other.paused == paused &&
        other.closed == closed &&
        other.processing == processing &&
        other.status == status;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        jobTitle.hashCode ^
        saves.hashCode ^
        userSaved.hashCode ^
        jobType.hashCode ^
        priceOption.hashCode ^
        priceValue.hashCode ^
        talents.hashCode ^
        preferredGender.hashCode ^
        shortDescription.hashCode ^
        brief.hashCode ^
        category.hashCode ^
        briefFile.hashCode ^
        briefLink.hashCode ^
        jobLocation.hashCode ^
        jobDelivery.hashCode ^
        deliverablesType.hashCode ^
        isDigitalContent.hashCode ^
        acceptingMultipleApplicants.hashCode ^
        usageType.hashCode ^
        noOfApplicants.hashCode ^
        usageLength.hashCode ^
        minAge.hashCode ^
        maxAge.hashCode ^
        talentHeight.hashCode ^
        size.hashCode ^
        ethnicity.hashCode ^
        skinComplexion.hashCode ^
        createdAt.hashCode ^
        creator.hashCode ^
        applicationSet.hashCode ^
        paused.hashCode ^
        closed.hashCode ^
        processing.hashCode ^
        status.hashCode;
  }
}


 */