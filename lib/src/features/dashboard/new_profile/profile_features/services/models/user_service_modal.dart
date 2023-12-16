
class UserServiceModel {
  final String username;
  final String serviceId;

  UserServiceModel({
    required this.username,
    required this.serviceId,
  });

  UserServiceModel copyWith({
    String? username,
    String? serviceId,
  }) {
    return UserServiceModel(
      username: username ?? this.username,
      serviceId: serviceId ?? this.serviceId,
    );
  }

  @override
  String toString() {
    return 'UserServiceModel(username: $username,'
        ' serviceId: $serviceId, )';
  }

  @override
  bool operator ==(covariant UserServiceModel other) {
    if (identical(this, other)) return true;

    return other.username == username && other.serviceId == serviceId;
  }

  @override
  int get hashCode {
    return username.hashCode ^ serviceId.hashCode;
  }
}
