class VMCLeaderboardModel {
  String? id;
  String? username;
  String? displayName;
  String? userType;
  String? thumbnailUrl;
  double? totalPoints;

  VMCLeaderboardModel(
      {this.id,
      this.username,
      this.displayName,
      this.userType,
      this.thumbnailUrl,
      this.totalPoints});

  VMCLeaderboardModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    displayName = json['displayName'];
    userType = json['userType'];
    thumbnailUrl = json['thumbnailUrl'];
    totalPoints = json['totalPoints'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['displayName'] = this.displayName;
    data['userType'] = this.userType;
    data['thumbnailUrl'] = this.thumbnailUrl;
    data['totalPoints'] = this.totalPoints;
    return data;
  }
}
