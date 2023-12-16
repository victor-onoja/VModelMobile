enum ModelFeet implements Comparable<ModelFeet> {
  small(id: 1, simpleName: '3', apiValue: 'S'),
  medium(id: 2, simpleName: '4', apiValue: 'M'),
  large(id: 3, simpleName: '5', apiValue: 'L'),
  xLarge(id: 4, simpleName: '6', apiValue: 'XL'),
  x2Large(id: 5, simpleName: '7', apiValue: 'XXL'),
  x3Large(id: 6, simpleName: '7.5', apiValue: 'XXXL'),
  x4Large(id: 7, simpleName: '8', apiValue: 'XXXXL'),
  x5Large(id: 8, simpleName: '8.5', apiValue: 'XXXXXL'),
  x6Large(id: 9, simpleName: '9', apiValue: 'XXXXXXL'),
  other(id: 10, simpleName: 'Other', apiValue: 'OTHER');

  const ModelFeet({
    required this.id,
    required this.simpleName,
    required this.apiValue,
  });
  final int id;
  final String simpleName;
  final String apiValue;

  static ModelFeet modelSizeByApiValue(String apiValue) {
    return ModelFeet.values.firstWhere(
        (userFeet) => userFeet.apiValue == apiValue,
        orElse: () => ModelFeet.other);
  }

  @override
  String toString() => simpleName;

  @override
  int compareTo(ModelFeet other) => id - other.id;
}