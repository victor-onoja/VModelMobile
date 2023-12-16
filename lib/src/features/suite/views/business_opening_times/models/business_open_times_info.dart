// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'simple_open_time.dart';

class BusinessOpenTimeInfoModel {
  final List<SimpleOpenTime> openingTimes;
  final List<BusinessWorkingInfoTag> extrasInfo;
  final List<BusinessWorkingInfoTag> safetyInfo;
  final bool isOpen;

  BusinessOpenTimeInfoModel({
    required this.openingTimes,
    required this.extrasInfo,
    required this.safetyInfo,
    required this.isOpen,
  });

  BusinessOpenTimeInfoModel copyWith({
    List<SimpleOpenTime>? openingTimes,
    List<BusinessWorkingInfoTag>? extrasInfo,
    List<BusinessWorkingInfoTag>? safetyInfo,
    bool? isOpen,
  }) {
    return BusinessOpenTimeInfoModel(
      openingTimes: openingTimes ?? this.openingTimes,
      extrasInfo: extrasInfo ?? this.extrasInfo,
      safetyInfo: safetyInfo ?? this.safetyInfo,
      isOpen: isOpen ?? this.isOpen,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'openingTimes': openingTimes.map((x) => x.toMap()).toList(),
      'extrasInfo': extrasInfo.map((x) => x.toMap()).toList(),
      'safetyInfo': safetyInfo.map((x) => x.toMap()).toList(),
      'isOpen': isOpen,
    };
  }

  factory BusinessOpenTimeInfoModel.fromMap(Map<String, dynamic> map) {
    final timesInfoMap = map["timesInfo"];

    try {
      return BusinessOpenTimeInfoModel(
        openingTimes: timesInfoMap != null
            ? List<SimpleOpenTime>.from(
                (timesInfoMap['times'] as List).map<SimpleOpenTime>(
                  (x) => SimpleOpenTime.fromMap(x as Map<String, dynamic>),
                ),
              )
            : [],
        extrasInfo: map['extrasInfo'] != null
            ? List<BusinessWorkingInfoTag>.from(
                (map['extrasInfo'] as List).map<BusinessWorkingInfoTag>(
                  (x) =>
                      BusinessWorkingInfoTag.fromMap(x as Map<String, dynamic>),
                ),
              )
            : [],
        safetyInfo: map['safetyInfo'] != null
            ? List<BusinessWorkingInfoTag>.from(
                (map['safetyInfo'] as List).map<BusinessWorkingInfoTag>(
                  (x) =>
                      BusinessWorkingInfoTag.fromMap(x as Map<String, dynamic>),
                ),
              )
            : [],
        isOpen: timesInfoMap != null ? timesInfoMap['isOpen'] as bool : false,
      );
    } catch (e, st) {
      print('[iki2] $e $st}');
      rethrow;
    }
  }

  String toJson() => json.encode(toMap());

  factory BusinessOpenTimeInfoModel.fromJson(String source) =>
      BusinessOpenTimeInfoModel.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'BusinessOpenTimeInfoModel(openingTimes: $openingTimes, extrasInfo: $extrasInfo, safetyInfo: $safetyInfo, isOpen: $isOpen)';
  }

  @override
  bool operator ==(covariant BusinessOpenTimeInfoModel other) {
    if (identical(this, other)) return true;

    return listEquals(other.openingTimes, openingTimes) &&
        listEquals(other.extrasInfo, extrasInfo) &&
        listEquals(other.safetyInfo, safetyInfo) &&
        other.isOpen == isOpen;
  }

  @override
  int get hashCode {
    return openingTimes.hashCode ^
        extrasInfo.hashCode ^
        safetyInfo.hashCode ^
        isOpen.hashCode;
  }
}

class BusinessWorkingInfoTag {
  final String? id;
  final String title;
  // Used fory local logic
  final bool isSelected;
  // Used fory local logic
  final bool isDeleted;

  // bool get markAsDeselected => isDeleted || !isSelected;
  bool get markAsSelected => isSelected;

  BusinessWorkingInfoTag({
    this.id,
    required this.title,
    this.isSelected = false,
    this.isDeleted = false,
  });

  BusinessWorkingInfoTag get copyWithNulledID {
    return BusinessWorkingInfoTag(
      id: null,
      title: this.title,
      isSelected: this.isSelected,
      isDeleted: false,
    );
  }

  BusinessWorkingInfoTag copyWith({
    String? id,
    String? title,
    bool? isSelected,
    bool? isDeleted,
  }) {
    return BusinessWorkingInfoTag(
      id: id ?? this.id,
      title: title ?? this.title,
      isSelected: isSelected ?? this.isSelected,
      isDeleted: isDeleted ?? this.isDeleted,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      // 'id': id,
      'title': title,
    };
  }

  factory BusinessWorkingInfoTag.fromMap(Map<String, dynamic> map) {
    try {
      return BusinessWorkingInfoTag(
        id: map['id'] as String,
        title: map['title'] as String,
        isSelected: true,
        isDeleted: false,
      );
    } catch (e, st) {
      print('[iki2] $e $st}');
      rethrow;
    }
  }

  String toJson() => json.encode(toMap());

  factory BusinessWorkingInfoTag.fromJson(String source) =>
      BusinessWorkingInfoTag.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'BusinessWorkingInfoTag(id: $id, title: $title, isSelected: $isSelected, isDeleted: $isDeleted)';
  }

  @override
  bool operator ==(covariant BusinessWorkingInfoTag other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.title == title &&
        other.isSelected == isSelected &&
        other.isDeleted == isDeleted;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        isSelected.hashCode ^
        isDeleted.hashCode;
  }
}

// factory BusinessWorkingInfoTag.fromMap(Map<String, dynamic> map) {
//   try {
//     return BusinessWorkingInfoTag(
//       id: map['id'] as String,
//       title: map['title'] as String,
//       isSelected: map['id'] != null ? true : false,
//     );
//   } catch (e, st) {
//     print('[iki2] $e $st}');
//     rethrow;
//   }
// }

// class BusinessOpenTimeInfoModel {
//   final List<SimpleOpenTime> openingTimes;
//   final List<String> extrasInfo;
//   final List<String> safetyInfo;
//   final bool isOpen;

//   BusinessOpenTimeInfoModel({
//     required this.openingTimes,
//     required this.extrasInfo,
//     required this.safetyInfo,
//     required this.isOpen,
//   });

//   BusinessOpenTimeInfoModel copyWith({
//     List<SimpleOpenTime>? openingTimes,
//     List<String>? extrasInfo,
//     List<String>? safetyInfo,
//     bool? isOpen,
//   }) {
//     return BusinessOpenTimeInfoModel(
//       openingTimes: openingTimes ?? this.openingTimes,
//       extrasInfo: extrasInfo ?? this.extrasInfo,
//       safetyInfo: safetyInfo ?? this.safetyInfo,
//       isOpen: isOpen ?? this.isOpen,
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return <String, dynamic>{
//       'times': openingTimes.map((x) => x.toMap()).toList(),
//       'extrasInfo': extrasInfo,
//       'safetyInfo': safetyInfo,
//       'isOpen': isOpen,
//     };
//   }

//   factory BusinessOpenTimeInfoModel.fromMap(Map<String, dynamic> map) {
//     // "businessInfo": {
//     // "timesInfo": {
//     //   "id": "4",
//     //   "isOpen": false,
//     //   "times": [
//     //     {
//     //       "day": "Friday",
//     //       "allDay": false,
//     //       "open": "13:17:00",
//     //       "close": "14:17:00"
//     //     }
//     //   ]
//     // },
//     // "extrasInfo": [],
//     // "safetyInfo": []
//     // }

//     final timesInfoMap = map["timesInfo"];

//     try {
//       return BusinessOpenTimeInfoModel(
//         openingTimes: timesInfoMap != null
//             ? List<SimpleOpenTime>.from(
//                 (timesInfoMap['times'] as List).map<SimpleOpenTime>(
//                   (x) => SimpleOpenTime.fromMap(x as Map<String, dynamic>),
//                 ),
//               )
//             : [],
//         extrasInfo: List<String>.from(
//             (map['extrasInfo'] as List).map((e) => e as String)),
//         safetyInfo: List<String>.from(
//             (map['safetyInfo'] as List).map((e) => e as String)),
//         isOpen: timesInfoMap != null ? timesInfoMap['isOpen'] as bool : false,
//       );
//     } catch (e, st) {
//       print('[iki2] $e $st}');
//       rethrow;
//     }
//   }
