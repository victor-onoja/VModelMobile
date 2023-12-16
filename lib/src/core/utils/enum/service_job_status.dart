import 'package:vmodel/src/core/utils/helper_functions.dart';

enum ServiceOrJobStatus implements Comparable<ServiceOrJobStatus> {
  draft(id: 1, apiValue: 'DRAFT'),
  active(id: 2, apiValue: 'ACTIVE'),
  paused(id: 3, apiValue: 'PAUSED'),
  expired(id: 4, apiValue: 'EXPIRED'),
  closed(id: 5, apiValue: 'CLOSED');

  const ServiceOrJobStatus({required this.id, required this.apiValue});
  final int id;
  final String apiValue;

  static ServiceOrJobStatus serviceOrJobStatusByApiValue(String apiValue) {
    return ServiceOrJobStatus.values.firstWhere(
        (status) => status.apiValue.toLowerCase() == apiValue.toLowerCase(),
        orElse: () => ServiceOrJobStatus.closed);
  }

  @override
  int compareTo(ServiceOrJobStatus other) => id - other.id;

  @override
  String toString() => apiValue.capitalizeFirstVExt;
}
