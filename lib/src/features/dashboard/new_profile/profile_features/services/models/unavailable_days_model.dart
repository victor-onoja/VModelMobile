class UnavailableDaysModel {
  String? id;
  User? user;
  dynamic startTime;
  dynamic endtimeTime;
  bool? allDay;
  bool? deleted;
  DateTime? date;

  UnavailableDaysModel({
    this.id,
    this.user,
    this.startTime,
    this.endtimeTime,
    this.allDay,
    this.deleted,
    this.date,
  });

  UnavailableDaysModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    startTime = json['startTime'] ?? "";
    endtimeTime = json['endtimeTime'] ?? "";
    allDay = json['allDay'];
    deleted = json['deleted'];
    date = DateTime.parse(json['date']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    data['startTime'] = this.startTime;
    data['endtimeTime'] = this.endtimeTime;
    data['allDay'] = this.allDay;
    data['deleted'] = this.deleted;
    data['date'] = this.date;
    return data;
  }
}

class User {
  String? id;
  String? username;
  String? fullName;

  User({this.id, this.username, this.fullName});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    fullName = json['fullName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['fullName'] = this.fullName;
    return data;
  }
}
