// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import '../../../../../core/utils/enum/service_pricing_enum.dart';

// "bookingData": {
//   "module": "JOB",
//     "moduleId": 219 ,
//     "title": "Addr Test",
//     "price": 327,
//     "pricingOption": "PER_SERVICE",
//     "bookingType":"ON_LOCATION",
//     "haveBrief": false,
//     "deliverableType": "5 High res (4k) photos",
//     "expectDeliverableContent":  true,
//     "usageType": 5,
//     "usageLength": 21,
//     "brief": "",
//     "briefLink": "",
//     "briefFile": null,
//     "bookedUser": "gg500",
//     "startDate": "2023-12-12T00:00:00",
//     "address": "{\"latitude\": \"0\",\"longitude\": \"0\",\"locationName\": \"\"}"
// }

enum BookingModule { JOB, SERVICE, OFFER }

enum BookingType { ON_LOCATION, REMOTE }

enum BookingPricingOption { PER_SERVICE, PER_HOUR }

@immutable
class BookingData {
  final BookingModule module;
  final String moduleId;
  final String title;
  final double price;
  final BookingPricingOption pricingOption;
  final BookingType bookingType;
  final bool haveBrief;
  final String deliverableType;
  final bool expectDeliverableContent;
  final int? usageType; //the id of usageType
  final int? usageLength; //the id of usageLength
  final String? brief;
  final String? briefLink;
  final String? briefFile;
  final String bookedUser; //username of user being booked
  final DateTime startDate;
  final Map<String, dynamic> address; //JSON encoded location info

  BookingData({
    required this.module,
    required this.moduleId,
    required this.title,
    required this.price,
    required this.pricingOption,
    required this.bookingType,
    required this.haveBrief,
    required this.deliverableType,
    required this.expectDeliverableContent,
    required this.usageType,
    required this.usageLength,
    required this.brief,
    required this.briefLink,
    this.briefFile,
    required this.bookedUser,
    required this.startDate,
    required this.address,
  });

  static BookingPricingOption getPricingOptionFromServicePeriod(
      ServicePeriod priceOption) {
    switch (priceOption) {
      case ServicePeriod.hour:
        return BookingPricingOption.PER_HOUR;
      default:
        return BookingPricingOption.PER_SERVICE;
    }
  }

  static BookingType getBookingType(String type) {
    if (type.toLowerCase() == 'on-location') {
      return BookingType.ON_LOCATION;
    } else {
      return BookingType.REMOTE;
    }
  }

  BookingData copyWith({
    BookingModule? module,
    String? moduleId,
    String? title,
    double? price,
    BookingPricingOption? pricingOption,
    BookingType? bookingType,
    bool? haveBrief,
    String? deliverableType,
    bool? expectDeliverableContent,
    int? usageType,
    int? usageLength,
    String? brief,
    String? briefLink,
    String? briefFile,
    String? bookedUser,
    DateTime? startDate,
    Map<String, dynamic>? address,
  }) {
    return BookingData(
      module: module ?? this.module,
      moduleId: moduleId ?? this.moduleId,
      title: title ?? this.title,
      price: price ?? this.price,
      pricingOption: pricingOption ?? this.pricingOption,
      bookingType: bookingType ?? this.bookingType,
      haveBrief: haveBrief ?? this.haveBrief,
      deliverableType: deliverableType ?? this.deliverableType,
      expectDeliverableContent:
          expectDeliverableContent ?? this.expectDeliverableContent,
      usageType: usageType ?? this.usageType,
      usageLength: usageLength ?? this.usageLength,
      brief: brief ?? this.brief,
      briefLink: briefLink ?? this.briefLink,
      briefFile: briefFile ?? this.briefFile,
      bookedUser: bookedUser ?? this.bookedUser,
      startDate: startDate ?? this.startDate,
      address: address ?? this.address,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'module': module.name,
      'moduleId': int.parse(moduleId),
      'title': title,
      'price': price,
      'pricingOption': pricingOption.name,
      'bookingType': bookingType.name,
      'haveBrief': haveBrief,
      'deliverableType': deliverableType,
      'expectDeliverableContent': expectDeliverableContent,
      'usageType': usageType ?? 5, //Private
      'usageLength': usageLength ?? 21, //1 week
      'brief': brief,
      'briefLink': briefLink,
      'briefFile': briefFile,
      'bookedUser': bookedUser,
      'startDate': startDate.toIso8601String(),
      'address': jsonEncode(address),
    };
  }

  factory BookingData.fromMap(Map<String, dynamic> map) {
    return BookingData(
      module: BookingModule.values.byName(map['module'] as String),
      moduleId: map['moduleId'] as String,
      title: map['title'] as String,
      price: map['price'] as double,
      pricingOption:
          BookingPricingOption.values.byName(map['pricingOption'] as String),
      bookingType: BookingType.values.byName(map['bookingType'] as String),
      haveBrief: map['haveBrief'] as bool,
      deliverableType: map['deliverableType'] as String,
      expectDeliverableContent: map['expectDeliverableContent'] as bool,
      usageType: map['usageType'] as int,
      usageLength: map['usageLength'] as int,
      brief: map['brief'] as String,
      briefLink: map['briefLink'] as String,
      briefFile: map['briefFile'] != null ? map['briefFile'] as String : null,
      bookedUser: map['bookedUser'] as String,
      startDate: DateTime.parse(map['startDate'] as String),
      address: jsonDecode((map['address'] as String)),
    );
  }

  String toJson() => json.encode(toMap());

  factory BookingData.fromJson(String source) =>
      BookingData.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'BookingData(module: $module, moduleId: $moduleId, title: $title, price: $price, pricingOption: $pricingOption, bookingType: $bookingType, haveBrief: $haveBrief, deliverableType: $deliverableType, expectDeliverableContent: $expectDeliverableContent, usageType: $usageType, usageLength: $usageLength, brief: $brief, briefLink: $briefLink, briefFile: $briefFile, bookedUser: $bookedUser, startDate: $startDate, address: $address)';
  }

  @override
  bool operator ==(covariant BookingData other) {
    if (identical(this, other)) return true;

    return other.module == module &&
        other.moduleId == moduleId &&
        other.title == title &&
        other.price == price &&
        other.pricingOption == pricingOption &&
        other.bookingType == bookingType &&
        other.haveBrief == haveBrief &&
        other.deliverableType == deliverableType &&
        other.expectDeliverableContent == expectDeliverableContent &&
        other.usageType == usageType &&
        other.usageLength == usageLength &&
        other.brief == brief &&
        other.briefLink == briefLink &&
        other.briefFile == briefFile &&
        other.bookedUser == bookedUser &&
        other.startDate == startDate &&
        mapEquals(other.address, address);
  }

  @override
  int get hashCode {
    return module.hashCode ^
        moduleId.hashCode ^
        title.hashCode ^
        price.hashCode ^
        pricingOption.hashCode ^
        bookingType.hashCode ^
        haveBrief.hashCode ^
        deliverableType.hashCode ^
        expectDeliverableContent.hashCode ^
        usageType.hashCode ^
        usageLength.hashCode ^
        brief.hashCode ^
        briefLink.hashCode ^
        briefFile.hashCode ^
        bookedUser.hashCode ^
        startDate.hashCode ^
        address.hashCode;
  }
}
