import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final jobSwitchProvider = ChangeNotifierProvider((ref) {
  return JobProvider();
});

class JobProvider extends ChangeNotifier {
  bool isSave = false;
  void isSaved() {
    isSave = !isSave;
    notifyListeners();
  }

  bool isAllJobs = false;
  void isAllJobPage({bool isAllJobOnly = false}) {
    if (isAllJobOnly) {
      // print('^^^^^^^^^^^^^ if 2');
      isAllJobs = true;
      notifyListeners();
      return;
    } else {
      isAllJobs = false;
      notifyListeners();
    }
  }

}
