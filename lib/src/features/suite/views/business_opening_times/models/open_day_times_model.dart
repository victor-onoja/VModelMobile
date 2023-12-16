// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';


class OpenDayTimes {
  final String day;
  final DateTime open;
  final DateTime close;
  final bool allDay;

  Duration getDuration(DateTime dt) {
    return Duration(hours: dt.hour, minutes: dt.minute);
  }

  DateTime timeStringToDateTime(String dateTime) {
    var re = RegExp(
      r'^'
      r'(?<hour>[0-9]{1,2})'
      r':'
      r'(?<minutes>[0-9]{1,2})'
      r'$',
    );

    var match = re.firstMatch(dateTime);
    if (match == null) {
      throw FormatException('Unrecognized time format');
    }

    final ool = DateTime.now().toUtc();
    final fio = DateTime(
      ool.year,
      ool.month,
      ool.day,
      int.parse(match.namedGroup('hour')!),
      int.parse(match.namedGroup('minutes')!),
    );
    // final wwq = DateTime.fromMillisecondsSinceEpoch(
    //         Duration(hours: , minutes: 12).inMilliseconds)
    //     .toIso8601String();
    // print('[wsq ${fio.toUtc().toIso8601String()} || $ool');
    return fio;
  }

  OpenDayTimes({
    required this.day,
    required this.open,
    required this.close,
    required this.allDay,
  });

  OpenDayTimes copyWith({
    String? day,
    DateTime? open,
    DateTime? close,
    bool? allDay,
  }) {
    return OpenDayTimes(
      day: day ?? this.day,
      open: open ?? this.open,
      close: close ?? this.close,
      allDay: allDay ?? this.allDay,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'day': day,
      'open': open.millisecondsSinceEpoch,
      'close': close.millisecondsSinceEpoch,
      'allDay': allDay,
    };
  }

  factory OpenDayTimes.fromMap(Map<String, dynamic> map) {
    return OpenDayTimes(
      day: map['day'] as String,
      open: DateTime.fromMillisecondsSinceEpoch(map['open'] as int),
      close: DateTime.fromMillisecondsSinceEpoch(map['close'] as int),
      allDay: map['allDay'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory OpenDayTimes.fromJson(String source) =>
      OpenDayTimes.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'OpenDayTimes(day: $day, open: $open, close: $close, allDay: $allDay)';
  }

  @override
  bool operator ==(covariant OpenDayTimes other) {
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
