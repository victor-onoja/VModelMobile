enum DiscoverCategory implements Comparable<DiscoverCategory> {
  job(id: 2, simpleName: 'Job Categories', shortName: 'Jobs'),
  service(id: 1, simpleName: 'Service Categories', shortName: 'Services');
  // talent(id: 3, simpleName: 'Talent Categories');

  const DiscoverCategory({
    required this.id,
    required this.simpleName,
    required this.shortName,
    // required this.apiValue,
  });
  final int id;
  final String simpleName;
  final String shortName;
  // final String apiValue;

  // static DiscoverCategory aspectRatioByApiValue(String apiValue) {
  //   return DiscoverCategory.values.firstWhere(
  //       (value) => value.apiValue == apiValue,
  //       orElse: () => DiscoverCategory.service);
  // }

  @override
  int compareTo(DiscoverCategory other) => id - other.id;

  @override
  String toString() => simpleName;
}
