// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../repository/register_repo.dart';

enum AccountTypes { enterprise, talent, none }

// final accountTypesProvider =
final selectedAccountTypeProvider = StateProvider((ref) => '');
final selectedAccountLabelProvider = StateProvider((ref) => '');
final isAccountTypeBusinessProvider = StateProvider((ref) => false);

final accountTypesProvider =
    AsyncNotifierProvider<UserAccountTypesNotifier, AccountType?>(
        UserAccountTypesNotifier.new);

class UserAccountTypesNotifier extends AsyncNotifier<AccountType?> {
  final _repository = RegisterReposity.instance;

  @override
  Future<AccountType?> build() async {
    print('Fetching user types........');
    final result = await _repository.getUserTypes();

    return result.fold((left) {
      return null;
    }, (right) {
      final userTypes = AccountType.fromMap(right);
      return userTypes;
    });
  }
}

class AccountType {
  final List<String> enterprise;
  final List<String> businessLabels;
  final List<String> talents;
  final Map<String, dynamic> talentLabels;

  Future<List<String>> getSubTalents(String talent,
      {bool isBusiness = false}) async {
    if (isBusiness) return businessLabels;
    List<String> labels = [];
    try {
      final search = talent.toLowerCase().replaceAll(' ', '');
      final key = talentLabels.keys.firstWhere((element) {
        print('Comparing $element ====== $search');
        return element.toLowerCase().contains(search);
      });
      // print('All keys issssss ${talentLabels.keys}');
      print('Found key issssss  $key');
      if (search == 'petmodel') {
        //Todo this code is likely to break in the future
        labels = List<String>.from((talentLabels[key] as Map).keys.skip(1));
      } else {
        labels = List<String>.from((talentLabels[key] as List));
      }
      // print('Lbels  $labels');
    } catch (e) {
      print(e);
    }
    return labels;
  }

  List<String> getPetBreed(String key) {
    return List<String>.from(talentLabels['petModel'][key]);
  }

  AccountType({
    required this.enterprise,
    required this.businessLabels,
    required this.talents,
    required this.talentLabels,
  });

  AccountType copyWith({
    List<String>? enterprise,
    List<String>? businessLabels,
    List<String>? talents,
    Map<String, dynamic>? talentLabels,
  }) {
    return AccountType(
      enterprise: enterprise ?? this.enterprise,
      businessLabels: businessLabels ?? this.businessLabels,
      talents: talents ?? this.talents,
      talentLabels: talentLabels ?? this.talentLabels,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'enterprise': enterprise,
      'businessLabels': businessLabels,
      'talents': talents,
      'talentLabels': talentLabels,
    };
  }

  factory AccountType.fromMap(Map<String, dynamic> map) {
    // print('HH>>>>>>>>LLLLLLLLL');
    print("[ssq] ${map['businessLabels']}");
    return AccountType(
      enterprise: List<String>.from((map['enterprise'] as List)),
      businessLabels: List<String>.from((map['businessLabels'] as List)),
      talents: List<String>.from((map['talents'] as List)),
      talentLabels: Map<String, dynamic>.from((map['talentLabels'] as Map)),
    );
  }
  // factory AccountType.fromMap(Map<String, dynamic> map) {
  //   return AccountType(
  //     enterprise: List<String>.from((map['enterprise'] as List<String>),
  //     talents: List<String>.from((map['talents'] as List<String>),
  //     talentLabels: Map<String, dynamic>.from((map['talentLabels'] as Map<String, dynamic>),
  //   );
  // }

  @override
  String toString() {
    return 'AccountType(enterprise: $enterprise, businessLabels: $businessLabels, talents: $talents, talentLabels: $talentLabels)';
  }

  @override
  bool operator ==(covariant AccountType other) {
    if (identical(this, other)) return true;

    return listEquals(other.enterprise, enterprise) &&
        listEquals(other.businessLabels, businessLabels) &&
        listEquals(other.talents, talents) &&
        mapEquals(other.talentLabels, talentLabels);
  }

  @override
  int get hashCode {
    return enterprise.hashCode ^
        businessLabels.hashCode ^
        talents.hashCode ^
        talentLabels.hashCode;
  }

  String toJson() => json.encode(toMap());

  factory AccountType.fromJson(String source) =>
      AccountType.fromMap(json.decode(source) as Map<String, dynamic>);
}
