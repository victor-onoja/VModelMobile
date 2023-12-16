
enum BusinessAccountType implements Comparable<BusinessAccountType> {

  business(id: 1, displayName: 'Business'),
  creativeDirector(id: 2, displayName: 'Creative director'),
  producer(id: 3, displayName: 'Producer'),
  other(id: 8, displayName: 'Other (please specify)');

  const BusinessAccountType(
      {required this.id, required this.displayName});
  final int id;
  final String displayName;

  static BusinessAccountType getTypeFromSimpleName(String simpleName) {
    return BusinessAccountType.values.firstWhere((accountType) => accountType.displayName == simpleName,
        orElse: () => BusinessAccountType.other);
  }

  @override
  int compareTo(BusinessAccountType other) => id - other.id;

  @override
  String toString() => displayName;
}


enum TalentAccountType implements Comparable<TalentAccountType> {

  model(id: 1, displayName: 'Model'),
  influencer(id: 2, displayName: 'Influencer'),
  digitalCreator(id: 3, displayName: 'Digital creator'),
  hairStylist(id: 4, displayName: 'Hair Stylist'),
  makeUpStylist(id: 5, displayName: 'Make-up Stylist'),
  beautician(id: 6, displayName: 'Beautician'),
  dj(id: 7, displayName: 'DJ'),
  virtualInfluencers(id: 8, displayName: 'Virtual influencer'),
  petModels(id: 9, displayName: 'Pet model'),
  other(id: 10, displayName: 'Other (please specify)');

  const TalentAccountType(
      {required this.id, required this.displayName});
  final int id;
  final String displayName;

  static TalentAccountType getTypeFromSimpleName(String simpleName) {
    return TalentAccountType.values.firstWhere((accountType) => accountType.displayName == simpleName,
        orElse: () => TalentAccountType.other);
  }

  @override
  int compareTo(TalentAccountType other) => id - other.id;

  @override  
  String toString() => displayName;
}
