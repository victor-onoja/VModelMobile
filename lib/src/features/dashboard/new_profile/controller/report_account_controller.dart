import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vmodel/src/core/utils/validators_mixins.dart';

import '../repository/report_account_repo.dart';

final reportAccountProvider =
    AsyncNotifierProvider.autoDispose<ReportAccountNotifier, void>(
        () => ReportAccountNotifier());

class ReportAccountNotifier extends AutoDisposeAsyncNotifier<void> {
  final _repository = ReportAccountRepository.instance;
  String? _accountToReport;

  @override
  FutureOr<void> build() async {}

  void setAccountToReport({
    required String username,
  }) {
    _accountToReport = username;
    print('report username: $username, acc2Report: $_accountToReport');
  }

  Future<String> reportAccount(
      {required String reason, String? content}) async {
    print('reporting $_accountToReport');

    if (_accountToReport.isEmptyOrNull) {
      return '';
    }

    final response = await _repository.reportAccount(
      userName: _accountToReport!,
      reason: reason,
      content: content?.trim(),
    );
    return response.fold((left) {
      print('Error reporting user : ${left.message} ${StackTrace.current}');
      return '';
    }, (right) {
      print('Success reporting user  ----------------------------->  $right');

      final message = right['message'] ?? '';

      return message;
    });
  }
}
