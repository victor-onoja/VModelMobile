enum Ethnicity implements Comparable<Ethnicity> {
  white(id: 1, simpleName: 'White', apiValue: 'WHITE'),
  asian(id: 2, simpleName: 'Asian', apiValue: 'ASIAN'),
  black(id: 3, simpleName: 'Black/African', apiValue: 'BLACK'),
  nativeAmerican(
      id: 4, simpleName: 'Native American', apiValue: 'NATIVEAMERICAN'),
  hispanic(id: 5, simpleName: 'Hispanic/Latino', apiValue: 'HISPANIC'),
  pacificIslander(
      id: 6, simpleName: 'Pacific Islander', apiValue: 'PACIFICISLANDER'),
  mixed(id: 7, simpleName: 'Mixed', apiValue: 'MIXED');
  // other(id: 8, simpleName: 'Select ...', apiValue: 'OTHER');

  const Ethnicity(
      {required this.id, required this.simpleName, required this.apiValue});
  final int id;
  final String simpleName;
  final String apiValue;

  static Ethnicity? ethnicityByApiValue(String? apiValue) {
    if(apiValue == null) {
      return null;
    }
    try {
      return Ethnicity.values
          .firstWhere((ethnicity) => ethnicity.apiValue == apiValue);
    } catch (e) {
      // print('(IGNORE THIS) Error parsing API value for ethinicity. $e');
      return null;
    }
  }

  @override
  String toString() => simpleName;

  @override
  int compareTo(Ethnicity other) => id - other.id;
}
