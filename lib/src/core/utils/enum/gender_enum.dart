enum Gender implements Comparable<Gender> {
  male(id: 1, simpleName: 'Male', apiValue: 'MALE'),
  female(id: 2, simpleName: 'Female', apiValue: 'FEMALE'),
  // transMale(
  //     id: 3, simpleName: 'Transgender Male', apiValue: 'TRANSGENDER_MALE'),
  // transFemale(
  //     id: 4, simpleName: 'Transgender Female', apiValue: 'TRANSGENDER_FEMALE'),
  // transNonBinary(
  //     id: 5,
  //     simpleName: 'Transgender (as non-binary)',
  //     apiValue: 'TRANSGENDER_NON_BINARY'),
  // nonBinary(id: 5, simpleName: 'Non-binary', apiValue: 'NON_BINARY'),
  // queer(id: 6, simpleName: 'Gender-queer', apiValue: 'GENDER_QUEER'),
  // twoSpirit(id: 7, simpleName: 'Two-spirit', apiValue: 'TWO_SPIRIT'),
  // ratherNotSay(id: 8, simpleName: 'Rather not say', apiValue: 'RATHER_NOT_SAY'),
  // notSure(id: 9, simpleName: 'Not sure', apiValue: 'NOT_SURE'),
  any(id: 10, simpleName: 'Any', apiValue: 'ANY');

  const Gender(
      {required this.id, required this.simpleName, required this.apiValue});
  final int id;
  final String simpleName;
  final String apiValue;

  static Gender genderByApiValue(String apiValue) {
    return Gender.values.firstWhere(
        (gender) => gender.apiValue.toLowerCase() == apiValue.toLowerCase(),
        orElse: () => Gender.any);
  }

  @override
  int compareTo(Gender other) => id - other.id;

  @override
  String toString() => simpleName;
}
