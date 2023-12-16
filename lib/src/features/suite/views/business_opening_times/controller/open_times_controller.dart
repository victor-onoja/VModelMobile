import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/open_day_times_model.dart';

final localOpenTimesNotifier =
    NotifierProvider<LocalOpenTimesNotifier, List<OpenDayTimes>>(
        LocalOpenTimesNotifier.new);

class LocalOpenTimesNotifier extends Notifier<List<OpenDayTimes>> {
  @override
  List<OpenDayTimes> build() {
    return [];
  }

  bool containsDay(String day) {
    return state
        .any((element) => element.day.toLowerCase() == day.toLowerCase());
  }

  add({
    required String day,
    required Duration start,
    required Duration end,
    required bool isAllDay,
  }) {
    // print('[jj] ---->>>> $dateTime');
    // final isExists = ;
    final deliveryDate = OpenDayTimes(
        day: day,
        open: DateTime.fromMillisecondsSinceEpoch(start.inMilliseconds),
        close: DateTime.fromMillisecondsSinceEpoch(end.inMilliseconds),
        allDay: isAllDay);
    final isExist = containsDay(day);
    // print('F?????????????????????? $isExist');
    if (isExist) {
      final temp = state;
      temp.removeWhere(
          (element) => element.day.toLowerCase() == day.toLowerCase());
      // temp.remove(deliveryDate);
      state = temp;
    } else {
      final temp = state;
      temp.add(deliveryDate);
      state = temp;
    }
    // } else {
    //   if (state.isNotEmpty) {
    //     final temp = state;
    //     temp[0] = deliveryDate;
    //     state = temp;
    //   } else {
    //     final temp = state;
    //     temp.add(deliveryDate);
    //     state = temp;
    //     // state.add(deliveryDate);
    //   }
    // }
    state.sort((a, b) => a.day.compareTo(b.day));
    print('Ad( state len ${state.length}');
  }

  void removeDateEntry(String day) {
    final isExist = containsDay(day);
    print('F?????????????????????? $isExist');
    if (isExist) {
      final temp = state;
      temp.removeWhere((element) => element.day == day);
      // temp.remove(deliveryDate);
      state = temp;
    }
    state.sort((a, b) => a.day.compareTo(b.day));
  }
}
