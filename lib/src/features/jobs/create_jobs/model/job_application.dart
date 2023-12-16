// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:vmodel/src/vmodel.dart';

import '../../../../core/models/app_user.dart';

@immutable
class JobApplication {
  final String id;
  final double proposedPrice;
  final VAppUser applicant;
  final bool accepted;
  final bool rejected;

  const JobApplication({
    required this.id,
    required this.proposedPrice,
    required this.applicant,
    required this.accepted,
    required this.rejected,
  });

  JobApplication copyWith({
    String? id,
    double? proposedPrice,
    VAppUser? applicant,
    bool? accepted,
    bool? rejected,
  }) {
    return JobApplication(
      id: id ?? this.id,
      proposedPrice: proposedPrice ?? this.proposedPrice,
      applicant: applicant ?? this.applicant,
      accepted: accepted ?? this.accepted,
      rejected: rejected ?? this.rejected,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'proposedPrice': proposedPrice,
      'applicant': applicant.toMap(),
      'accepted': accepted,
      'rejected': rejected,
    };
  }

  factory JobApplication.fromMap(Map<String, dynamic> map) {
    return JobApplication(
      id: map['id'] as String,
      proposedPrice: map['proposedPrice'] as double,
      applicant:
          VAppUser.fromMinimalMap(map['applicant'] as Map<String, dynamic>),
      accepted: map['accepted'] as bool,
      rejected: map['rejected'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory JobApplication.fromJson(String source) =>
      JobApplication.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'JobApplication(id: $id, proposedPrice: $proposedPrice, applicant: $applicant, accepted: $accepted, rejected: $rejected)';
  }

  @override
  bool operator ==(covariant JobApplication other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.proposedPrice == proposedPrice &&
        other.applicant == applicant &&
        other.accepted == accepted &&
        other.rejected == rejected;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        proposedPrice.hashCode ^
        applicant.hashCode ^
        accepted.hashCode ^
        rejected.hashCode;
  }
}
