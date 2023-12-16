import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final exploreProvider = ChangeNotifierProvider((ref) {
  return ExploreProvider();
});

class ExploreProvider extends ChangeNotifier {
  bool isSave = false;
  void isSaved() {
    isSave = !isSave;
    notifyListeners();
  }

  bool isExplore = false;
  void isExplorePage({bool isExploreOnly = false}) {
    if (isExploreOnly) {
      // print('^^^^^^^^^^^^^ if 2');
      isExplore = true;
      notifyListeners();
      return;
    } else {
      isExplore = false;
      notifyListeners();
    }
  }

}