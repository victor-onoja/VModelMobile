/// License type for digital services and jobs. Formerly referred to as
/// usage type
///

enum LicenseType implements Comparable<LicenseType> {
  private(id: 1, simpleName: 'Private', apiValue: 'PRIVATE'),
  commercial(id: 2, simpleName: 'Commercial', apiValue: 'COMMERCIAL'),
  socialMedia(id: 3, simpleName: 'Social Media', apiValue: 'SOCIAL MEDIA'),
  any(id: 4, simpleName: 'Any', apiValue: 'ANY');

  const LicenseType(
      {required this.id, required this.simpleName, required this.apiValue});
  final int id;
  final String simpleName;
  final String apiValue;

  static LicenseType licenseTypeByApiValue(String apiValue) {
    return LicenseType.values.firstWhere(
        (licenseType) =>
            licenseType.apiValue.toLowerCase() == apiValue.toLowerCase(),
        orElse: () => LicenseType.private);
  }

  @override
  int compareTo(LicenseType other) => id - other.id;

  @override
  String toString() => simpleName;
}
