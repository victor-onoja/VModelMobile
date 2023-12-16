// enum PermissionSetting { ANYONE, NO_ONE, CONNECTIONS }

import 'dart:developer';

enum PermissionSetting implements Comparable<PermissionSetting> {
  ANYONE(id: 1, simpleName: 'Anyone'),
  NO_ONE(id: 2, simpleName: 'No one'),
  CONNECTIONS(id: 3, simpleName: 'My Connections');

  const PermissionSetting({
    required this.id,
    required this.simpleName,
  });
  final int id;
  final String simpleName;

  static PermissionSetting byApiValue(String apiValue) {
    log('apiValue is $apiValue');
    return PermissionSetting.values.firstWhere(
        (element) => element.name == apiValue,
        orElse: () => PermissionSetting.ANYONE);
  }

  @override
  String toString() => simpleName;

  @override
  int compareTo(PermissionSetting other) => id - other.id;
}
