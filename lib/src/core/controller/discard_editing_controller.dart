// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vmodel/src/core/utils/validators_mixins.dart';

// final showDiscardPopupProvider = StateProvider.autoDispose<bool>((ref) {
//   return false;
// });

final discardProvider = NotifierProvider.autoDispose<DiscardNotifier,
    Map<dynamic, InputValueState>>(DiscardNotifier.new);

class DiscardNotifier
    extends AutoDisposeNotifier<Map<dynamic, InputValueState>> {
  @override
  Map<dynamic, InputValueState> build() {
    return {};
  }

  initialState(String field, {required dynamic initial, dynamic current}) {
    final currentState = state;
    final newState = currentState.addEntries([
      MapEntry(
          field, InputValueState(initial: initial, current: current ?? null))
    ]);
  }

  updateState(String field, {dynamic initial, required dynamic newValue}) {
    final currentState = state;
    final item = currentState[field];
    debugPrint('[discard] item ===> $item');
    currentState.addEntries([
      MapEntry(
          field,
          item != null
              ? item.copyWith(current: newValue)
              : InputValueState(initial: initial, current: newValue))
    ]);

    state = currentState;
  }

  bool checkForChanges() {
    bool hasAnyChangeOccured = false;
    final currentState = state;
    debugPrint('[discard] $currentState');
    for (var item in currentState.entries) {
      hasAnyChangeOccured = hasAnyChangeOccured || item.value.hasChanges;
    }
    return hasAnyChangeOccured;
  }
}

class InputValueState {
  final dynamic initial;
  final dynamic current;

  bool get hasChanges {
    if (initial is String? && current is String?) {
      debugPrint("[discard1] It's a String");
      final val1 =
          (initial as String?).isEmptyOrNull ? '' : (initial as String).trim();
      final val2 =
          (current as String?).isEmptyOrNull ? '' : (current as String).trim();
      // (current as String?).isEmptyOrNull;
      return val1 != val2;
    }
    if (initial is List? && current is List?) {
      debugPrint("[discard1] It's a List");
      final v1 = (initial as List?);
      final v2 = (current as List?);
      return !listEquals(v1, v2);
    }
    print(current.runtimeType);

    return initial != current;
  }

  InputValueState({
    required this.initial,
    required this.current,
  });

  InputValueState copyWith({
    dynamic? initial,
    dynamic? current,
  }) {
    return InputValueState(
      initial: initial ?? this.initial,
      current: current ?? this.current,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'initial': initial,
      'current': current,
    };
  }

  factory InputValueState.fromMap(Map<String, dynamic> map) {
    return InputValueState(
      initial: map['initial'] as dynamic,
      current: map['current'] as dynamic,
    );
  }

  String toJson() => json.encode(toMap());

  factory InputValueState.fromJson(String source) =>
      InputValueState.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'InputValueState(initial: $initial, current: $current)';

  @override
  bool operator ==(covariant InputValueState other) {
    if (identical(this, other)) return true;

    return other.initial == initial && other.current == current;
  }

  @override
  int get hashCode => initial.hashCode ^ current.hashCode;
}
