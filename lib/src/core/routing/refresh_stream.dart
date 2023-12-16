import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vmodel/src/core/utils/enum/auth_enum.dart';
import 'package:vmodel/src/features/authentication/controller/auth_status_provider.dart';

/// Converts a [Stream] into a [Listenable]
///
/// {@tool snippet}
/// Typical usage is as follows:
///
/// ```dart
/// GoRouter(
///  refreshListenable: GoRouterRefreshStream(stream),
/// );
/// ```
/// {@end-tool}
class GoRouterRefreshStream extends ChangeNotifier {
  // GoRouterRefreshStream({required this.ref});
  // final Ref ref;
  final AuthStatus status;

  /// Creates a [GoRouterRefreshStream].
  ///
  /// Every time the [stream] receives an event the [GoRouter] will refresh its
  /// current route.
  GoRouterRefreshStream(this.status) {
    notifyListeners();
    print('[kuks888 refresh] notifyLisstnesr ===');
    // _subscription = ;
  }

  // late final StreamSubscription<dynamic> _subscription;
  // late final StreamSubscription<dynamic> _subscription;

  // @override
  // void dispose() {
  //   _subscription.cancel();
  //   super.dispose();
  // }
}

final refreshProvider = Provider((ref) {
  final value = ref.watch(authenticationStatusProvider).value!;
  print('[kuks888 refresh] status:$value');
  return GoRouterRefreshStream(value);
});

// /// Converts a [Stream] into a [Listenable]
// ///
// /// {@tool snippet}
// /// Typical usage is as follows:
// ///
// /// ```dart
// /// GoRouter(
// ///  refreshListenable: GoRouterRefreshStream(stream),
// /// );
// /// ```
// /// {@end-tool}
// class GoRouterRefreshStream extends ChangeNotifier {
//   /// Creates a [GoRouterRefreshStream].
//   ///
//   /// Every time the [stream] receives an event the [GoRouter] will refresh its
//   /// current route.
//   GoRouterRefreshStream(Stream<dynamic> stream) {
//     notifyListeners();
//     _subscription = stream.asBroadcastStream().listen(
//           (dynamic _) => notifyListeners(),
//         );
//   }

//   late final StreamSubscription<dynamic> _subscription;

//   @override
//   void dispose() {
//     _subscription.cancel();
//     super.dispose();
//   }
// }