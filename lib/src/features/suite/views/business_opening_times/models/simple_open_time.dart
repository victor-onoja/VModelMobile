// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class SimpleOpenTime {
  final String day;
  final String? open;
  final String? close;
  final bool allDay;

  factory SimpleOpenTime.defaultFromDay(String day) {
    //Default opening and closing is 9am-5pm
    return SimpleOpenTime(
        day: day, open: '09:00', close: '17:00', allDay: false);
  }

  SimpleOpenTime get alwaysOpen {
    return SimpleOpenTime(
        day: this.day, open: '00:00', close: '24:00', allDay: true);
  }

  SimpleOpenTime({
    required this.day,
    required this.open,
    required this.close,
    required this.allDay,
  });

  SimpleOpenTime copyWith({
    String? day,
    String? open,
    String? close,
    bool? allDay,
  }) {
    return SimpleOpenTime(
      day: day ?? this.day,
      open: open ?? this.open,
      close: close ?? this.close,
      allDay: allDay ?? this.allDay,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'day': day,
      'open': open,
      'close': close,
      'allDay': allDay,
    };
  }

  factory SimpleOpenTime.fromMap(Map<String, dynamic> map) {
    return SimpleOpenTime(
      day: map['day'] as String,
      open: map['open'] != null ? map['open'] as String : null,
      close: map['close'] != null ? map['close'] as String : null,
      allDay: map['allDay'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory SimpleOpenTime.fromJson(String source) =>
      SimpleOpenTime.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'SimpleOpenTime(day: $day, open: $open, close: $close, allDay: $allDay)';
  }

  @override
  bool operator ==(covariant SimpleOpenTime other) {
    if (identical(this, other)) return true;

    return other.day == day &&
        other.open == open &&
        other.close == close &&
        other.allDay == allDay;
  }

  @override
  int get hashCode {
    return day.hashCode ^ open.hashCode ^ close.hashCode ^ allDay.hashCode;
  }
}
