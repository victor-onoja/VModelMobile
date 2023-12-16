import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vmodel/src/features/dashboard/new_profile/profile_features/services/models/unavailable_days_model.dart';

import '../repository/unavailable_days_repo.dart';

final unavailableDaysProvider = AsyncNotifierProvider.family
    .autoDispose<UnavailableDaysNotifier, List<UnavailableDaysModel>, String?>(
        UnavailableDaysNotifier.new);

class UnavailableDaysNotifier extends AutoDisposeFamilyAsyncNotifier<
    List<UnavailableDaysModel>, String?> {
  final _repository = UnavailabiltyRepository.instance;
  int _pageCount = 20;
  @override
  Future<List<UnavailableDaysModel>> build(String? username) async {
    return getUnavailableDays(
        pageCount: _pageCount, pageNumber: 1, username: username);
  }

  bool containsDateTime(DateTime dt) {
    final currentState = state.valueOrNull ?? [];

    return currentState.any((element) {
      // print('[xxw] ==== the day is $dt and resonse is ${element.date}');
      return element.date?.toUtc() == dt.toUtc();
    });
  }

  Future<List<UnavailableDaysModel>> getUnavailableDays({
    required int pageCount,
    required int pageNumber,
    String? username,
  }) async {
    final res = await _repository.getUnavailableDays(
      pageCount: pageCount,
      pageNumber: pageNumber,
      username: username,
    );

    return res.fold((left) {
      print("leftttttt $left");

      return [];
    }, (right) {
      // print('in AsyncBuild rieght is .............. $res');
      // final jobsCount = right['jobsTotalNumber'];
      final List jobsData = right;

      if (jobsData.isNotEmpty) {
        return jobsData.map<UnavailableDaysModel>((e) {
          print("rightrightrightttttt ${jobsData.length}");
          return UnavailableDaysModel.fromJson(e as Map<String, dynamic>);
        }).toList();
      }
      return [];
    });
  }

  Future<void> saveUnavailableDays({
    required List<Unavailable> dates,
  }) async {
    // print('[pd] The id to delete is $packageId');

    final makeRequest = await _repository.saveUnavailableDays(
      date: dates.map((e) => e.toMap()).toList(),
    );

    makeRequest.fold((onLeft) {
      print('Failed to save day ${onLeft.message}');
      // run this block when you have an error
    }, (onRight) async {
      // print('[pd] $onRight');
      print('successfully saved day');
      // if the success field in the mutation response is true
    });
  }

  Future<bool> deleteUnavailableDay({
    required String id,
  }) async {
    // print('[pd] The id to delete is $packageId');

    final makeRequest =
        await _repository.deleteUnavailableDay(int.tryParse(id) ?? -1);

    return makeRequest.fold((onLeft) {
      print('Failed to remove day ${onLeft.message}');
      return false;
      // run this block when you have an error
    }, (onRight) async {
      // print('[pd] $onRight');
      final isSuccess = onRight['message'] == null
          ? false
          : (onRight['message'] as String).contains('successfully');
      if (isSuccess) {
        final currentState = state.valueOrNull ?? [];
        state = AsyncData([
          for (var i in currentState)
            if (i.id != id) i,
        ]);
      }
      print('successfully removed day');
      return isSuccess;
      // if the success field in the mutation response is true
    });
  }
}

class Unavailable {
  bool? allDay;
  DateTime? date;
  String? startTime;
  String? endTime;

  Unavailable({
    this.allDay = false,
    this.date,
    this.startTime,
    this.endTime,
  });
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'date': date!.toIso8601String().split("T")[0],
      'startTime': startTime,
      'endTime': endTime,
      "allDay": false,
    };
  }
}
