// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vmodel/src/shared/response_widgets/toast.dart';

import '../../../../core/utils/enum/ethnicity_enum.dart';
import '../../../../core/utils/enum/service_pricing_enum.dart';
import '../../../../core/utils/enum/size_enum.dart';
import '../model/job_data.dart';
import '../repository/create_job_repo.dart';

final createJobIsSingleSelectionProvider = StateProvider<bool>((ref) {
  return true;
});

final calculatedTotalDurationProvider = StateProvider<Duration>((ref) {
  final allDurations = ref.watch(selectedDateTimeAndDurationProvider);
  print('FFFFFFFFFFFFFFFF allDurations is ${allDurations.length}');
  if (allDurations.isEmpty) return Duration.zero;
  Duration res = Duration.zero;
  for (var item in allDurations) {
    res += item.dateDuration;
  }
  return res;
});

final timeOpProvider = Provider<List<Duration>>((ref) {
  return List.generate(49, (index) => Duration(minutes: index * 30)).toList();
});

final jobDataProvider = StateProvider<JobDataModel?>((ref) {
  return const JobDataModel(
      jobTitle: '',
      jobType: '',
      priceOption: '',
      priceValue: 0.0,
      talents: [],
      preferredGender: '',
      shortDescription: '',
      location: {},
      deliverablesType: '',
      isDigitalContent: false,
      acceptMultiple: false,
      usageType: '',
      usageLength: '',
      minAge: 0,
      maxAge: 0,
      height: {},
      size: ModelSize.other,
      ethnicity: Ethnicity.black,
      complexion: '');
});

// class TimeOptionsNotifier extends Notifier<List<Duration>> {
//   @override
//   build() {
//     return List.generate(48, (index) => Duration(minutes: index * 30)).toList();
//   }
// }

final selectedDateTimeAndDurationProvider =
    NotifierProvider<CalculationNotifier, List<JobDeliveryDate>>(
        CalculationNotifier.new);

class CalculationNotifier extends Notifier<List<JobDeliveryDate>> {
  // bool _isSingleSelection = true;
  @override
  List<JobDeliveryDate> build() {
    print('FFFFFFFFFFFFFFFF rebuild calculation state');
    return [];
  }

  setAll(List<JobDeliveryDate> data) {
    state = data;
    // state.sort((a, b) => a.date.compareTo(b.date));
    // ref.invalidate(calculatedTotalDurationProvider);
    print('set state len ${state.length}');
  }

  add({
    required DateTime dateTime,
    required Duration start,
    required Duration end,
    required ServicePeriod priceType,
  }) {
    print('[jj] ---->>>> $dateTime');
    // final isExists = ;
    final deliveryDate =
        JobDeliveryDate(date: dateTime, startTime: start, endTime: end);
    // if (priceType == ServicePeriod.hour) {
    final isExist = containsDateTime(dateTime);
    print('F?????????????????????? $isExist');
    if (isExist) {
      final temp = state;
      temp.removeWhere((element) => element.date == dateTime);
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
    state.sort((a, b) => a.date.compareTo(b.date));
    ref.invalidate(calculatedTotalDurationProvider);
    print('Ad(dddddddddddddddddddddddd state len ${state.length}');
  }

  void removeDateEntry(DateTime dateTime) {
    final isExist = containsDateTime(dateTime);
    print('F?????????????????????? $isExist');
    if (isExist) {
      final temp = state;
      temp.removeWhere((element) => element.date == dateTime);
      // temp.remove(deliveryDate);
      state = temp;
    }
    state.sort((a, b) => a.date.compareTo(b.date));
    ref.invalidate(calculatedTotalDurationProvider);
  }

  bool containsDateTime(DateTime dt) {
    return state.any((element) => element.date == dt);
  }

  // void ssls(){
  //   ref.in
  // }

  void updateDeliveryDateTimes(DateTime dateTime,
      {Duration? start, Duration? end, bool? isFullDay}) {
    if (containsDateTime(dateTime)) {
      // state.map((e) => )
      state = [
        for (JobDeliveryDate s in state)
          if (s.date == dateTime)
            s.copyWith(startTime: start, endTime: end, isFullDay: isFullDay)
          else
            s
      ];
    }
    ref.invalidate(calculatedTotalDurationProvider);
  }

  Future<bool> createJob({required bool isAdvanced}) async {
    final repository = CreateJobRepository.instance;
    final data = ref.read(jobDataProvider);
    final response = await repository.createJob(
      jobData: data!,
      deliveryData: state.map((e) => e.toMap()).toList(),
      isAdvanced: isAdvanced,
    );
    return response.fold((left) {
      VWidgetShowResponse.showToast(ResponseEnum.sucesss,
          message: 'Failed to create job');
      return false;
    }, (right) {
      final success = right['success'] ?? false;
      // if (success) {
      //   VWidgetShowResponse.showToast(ResponseEnum.sucesss,
      //       message: 'Job created successfully');
      // }
      return success;
    });
  }

  Future<bool> updateJob(
      {required String jobId, required bool isAdvanced}) async {
    final repository = CreateJobRepository.instance;
    final data = ref.read(jobDataProvider);

    int? id = int.tryParse(jobId);

    if (id == null) {
      VWidgetShowResponse.showToast(ResponseEnum.warning,
          message: 'Invalid job id provided');
      return false;
    }

    final response = await repository.updateJob(
        jobId: id,
        jobData: data!,
        deliveryData: state.map((e) => e.toMap()).toList(),
        isAdvanced: isAdvanced);

    return response.fold((left) {
      VWidgetShowResponse.showToast(ResponseEnum.warning,
          message: 'Failed to upate job');
      return false;
    }, (right) {
      final success = right['success'] ?? false;
      // if (success) {
      //   VWidgetShowResponse.showToast(ResponseEnum.sucesss,
      //       message: 'Job updated successfully');
      // }
      return success;
    });
  }

  Future<bool> duplicateJob({required Map<String, dynamic> data}) async {
    final repository = CreateJobRepository.instance;
    final response = await repository.duplicateJob(
      data: data,
    );
    return response.fold((left) {
      VWidgetShowResponse.showToast(ResponseEnum.sucesss,
          message: 'Failed to duplicate job');
      return false;
    }, (right) {
      final success = right['success'] ?? false;
      if (success) {
        VWidgetShowResponse.showToast(ResponseEnum.sucesss,
            message: 'Job duplicated successfully');
      }
      return success;
    });
  }
}

// Duration get dateDuration => endTime - startTime;
@immutable
class JobDeliveryDate {
  final DateTime date;
  final Duration startTime;
  final Duration endTime;
  final bool isFullDay;

  Duration get dateDuration => endTime - startTime;

//Generated
  const JobDeliveryDate({
    required this.date,
    required this.startTime,
    required this.endTime,
    this.isFullDay = false,
  });

  JobDeliveryDate copyWith({
    DateTime? date,
    Duration? startTime,
    Duration? endTime,
    bool? isFullDay,
  }) {
    return JobDeliveryDate(
      date: date ?? this.date,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      isFullDay: isFullDay ?? this.isFullDay,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      // 'date': '${date.year}-${date.month}-${date.day}',
      'date': date.toIso8601String(),
      'startTime': startTime.inMinutes.toString(),
      'endTime': endTime.inMinutes.toString(),
      // 'isFullDay': isFullDay,
    };
  }

  factory JobDeliveryDate.fromMap(Map<String, dynamic> map) {
    try {
      dynamic start = map['startTime'] as String;
      start = int.parse(start);
      dynamic end = map['endTime'] as String;
      end = int.parse(end);

      return JobDeliveryDate(
        date: DateTime.parse(map['date'] as String),
        startTime: Duration(minutes: start),
        endTime: Duration(minutes: end),

        // isFullDay: map['isFullDay'] as bool,
        isFullDay: false,
      );
    } catch (e, st) {
      print('$e \n $st');
      rethrow;
    }
  }

  String toJson() => json.encode(toMap());

  // factory JobDeliveryDate.fromJson(String source) =>
  //     JobDeliveryDate.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'JobDeliveryDate(date: $date, startTime: $startTime, endTime: $endTime, isFullDay: $isFullDay)';
  }

  @override
  bool operator ==(covariant JobDeliveryDate other) {
    if (identical(this, other)) return true;

    return other.date == date &&
        other.startTime == startTime &&
        other.endTime == endTime &&
        other.isFullDay == isFullDay;
  }

  @override
  int get hashCode {
    return date.hashCode ^
        startTime.hashCode ^
        endTime.hashCode ^
        isFullDay.hashCode;
  }
}
