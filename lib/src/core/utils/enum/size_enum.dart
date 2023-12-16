enum ModelSize implements Comparable<ModelSize> {
  small(id: 1, simpleName: 'S', apiValue: 'S'),
  medium(id: 2, simpleName: 'M', apiValue: 'M'),
  large(id: 3, simpleName: 'L', apiValue: 'L'),
  xLarge(id: 4, simpleName: 'XL', apiValue: 'XL'),
  x2Large(id: 5, simpleName: '2XL', apiValue: 'XXL'),
  x3Large(id: 6, simpleName: '3XL', apiValue: 'XXXL'),
  x4Large(id: 7, simpleName: '4XL', apiValue: 'XXXXL'),
  x5Large(id: 8, simpleName: '5XL', apiValue: 'XXXXXL'),
  x6Large(id: 9, simpleName: '6XL', apiValue: 'XXXXXXL'),
  other(id: 10, simpleName: 'Other', apiValue: 'OTHER');

  const ModelSize({
    required this.id,
    required this.simpleName,
    required this.apiValue,
  });
  final int id;
  final String simpleName;
  final String apiValue;

  static ModelSize modelSizeByApiValue(String apiValue) {
    return ModelSize.values.firstWhere(
        (userSize) => userSize.apiValue == apiValue,
        orElse: () => ModelSize.other);
  }

  @override
  String toString() => simpleName;

  @override
  int compareTo(ModelSize other) => id - other.id;
}
