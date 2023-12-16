// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

class Debounce {
  Timer? _timer;
  final Duration delay;

  Debounce({
    this.delay = const Duration(milliseconds: 300),
  });

  void call(Function() callback) {
    _timer?.cancel();
    _timer = Timer(delay, callback);
  }

  void dispose() {
    _timer?.cancel();
    _timer = null;
  }
}
