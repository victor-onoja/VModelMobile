import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:vmodel/src/core/controller/app_user_controller.dart';
import 'package:vmodel/src/core/utils/enum/auth_enum.dart';
import 'package:vmodel/src/features/authentication/controller/auth_status_provider.dart';
import 'package:vmodel/src/vmodel.dart';

FutureOr<String?> appRouteRedirect(
    BuildContext context, Ref ref, GoRouterState state) async {
  final status = ref.read(authenticationStatusProvider).value!;
  final user = ref.read(appUserProvider).valueOrNull;
  // final loggedIn = status == AuthStatus.authenticated && user != null;
  final loggedIn = status == AuthStatus.authenticated;
  final loggingIn = state.matchedLocation == 'signin';
  final isLoginScreen = state.matchedLocation == 'signin';
  final isSplashScreen = state.matchedLocation == '/splash';
  final isWelcomeScreen = state.matchedLocation == '/oboarding';
  final isFeed = state.matchedLocation == '/feed';

  print(
      '[GoRouter kuks] $isSplashScreen ${state.matchedLocation} status:$status,'
      ' loggedIn:$loggedIn, loggingIn:$loggingIn ${user?.username}');

  // if (loggingOut) return '/signin';

  // if (isSplashScreen)
  //   return null;
  // else if (!loggedIn) {
  //   return '/onboarding';
  // }
  // else if (!loggedIn && isWelcomeScreen) {
  //   return null;
  // } else if (!loggedIn && isLoginScreen) {
  //   return null;
  // }
  if (status == AuthStatus.unauthenticated)
    return '/signin';
  else if (!loggedIn && isFeed)
    return '/onboarding';
  // return null;
  else
    return null;

  if (!loggedIn && !loggingIn) {
    ref.read(authenticationStatusProvider.notifier).invalidateStaleUserData();
    // return '/onboarding';
    return '/signin';
  }
  if (loggedIn && user != null) return null;
  if (loggedIn) return '/feed';

  // if (!loggedIn && loggingIn) return n;
  // if (!loggedIn && loggingIn && user.username == null) return '/nameReg';

  // if (!loggingIn) return '/onboarding';
  return null;
}
