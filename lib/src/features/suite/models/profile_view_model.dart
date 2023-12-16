import 'dart:math';

class DailyViewModel {
  int? day;
  int? week;
  int? month;
  int? year;
  int? total;

  DailyViewModel({this.day, this.month, this.year, this.total, this.week});

  DailyViewModel.fromJson(Map<String, dynamic> json) {
    day = json['day'] ?? this.day;
    week = json['week'] ?? this.week;
    month = json['month'] ?? this.month;
    year = json['year'] ?? this.year;
    total = json['total'] ?? this.total;
    // total = Random().nextInt(500);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['day'] = this.day;
    data['week'] = this.week;
    data['month'] = this.month;
    data['year'] = this.year;
    data['total'] = this.total;
    return data;
  }
}

class WeeklyViewModel {
  int? weekly;
  int? year;
  int? total;

  WeeklyViewModel({this.weekly, this.year, this.total});

  WeeklyViewModel.fromJson(Map<String, dynamic> json) {
    weekly = json['weekly'];
    year = json['year'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['weekly'] = this.weekly;
    data['year'] = this.year;
    data['total'] = this.total;
    return data;
  }
}

class MonthlyViewModel {
  int? month;
  int? year;
  int? total;

  MonthlyViewModel({this.month, this.year, this.total});

  MonthlyViewModel.fromJson(Map<String, dynamic> json) {
    month = json['month'];
    year = json['year'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['month'] = this.month;
    data['year'] = this.year;
    data['total'] = this.total;
    return data;
  }
}
