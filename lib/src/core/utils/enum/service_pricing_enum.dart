enum ServicePeriod
    implements Comparable<ServicePeriod> {
  hour(id: 1, simpleName: 'Hour'),
  service(id: 3, simpleName: 'Service');

  const ServicePeriod(
      {required this.id, required this.simpleName});
  // {required this.id, required this.simpleName, required this.apiValue});
final int id;
  final String simpleName;

  // final String apiValue;
  //
  static ServicePeriod servicePeriodByApiValue(
      String apiValue) {
    return ServicePeriod.values.firstWhere(
        (element) =>
            element.simpleName.toLowerCase() == apiValue.toLowerCase());
  }

  String get tileDisplayName => 'Per $simpleName';

  @override
  int compareTo(ServicePeriod other) => id - other.id;

  @override
  String toString() => simpleName;
}
