enum WorkLocation implements Comparable<WorkLocation> {
  onSite(id: 1, simpleName: 'On-Location', apiValue: 'ON-LOCATION'),
  hybrid(id: 2, simpleName: 'Hybrid', apiValue: 'HYBRID'),
  remote(id: 3, simpleName: 'Remote', apiValue: 'REMOTE');

  const WorkLocation(
      {required this.id, required this.simpleName, required this.apiValue});
  final int id;
  final String simpleName;
  final String apiValue;

  static WorkLocation workLocationByApiValue(String apiValue) {
    return WorkLocation.values.firstWhere(
        (WorkLocation) =>
            WorkLocation.apiValue.toLowerCase() == apiValue.toLowerCase(),
        orElse: () => WorkLocation.onSite);
  }

  @override
  int compareTo(WorkLocation other) => id - other.id;

  @override
  String toString() => simpleName;
}
