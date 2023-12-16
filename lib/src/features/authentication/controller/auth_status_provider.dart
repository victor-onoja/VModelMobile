import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app_locator.dart';
import '../../../core/cache/credentials.dart';
import '../../../core/cache/local_storage.dart';
import '../../../core/controller/app_user_controller.dart';
import '../../../core/network/graphql_confiq.dart';
import '../../../core/utils/enum/auth_enum.dart';
import '../../../core/utils/helper_functions.dart';
import '../../dashboard/discover/controllers/discover_controller.dart';
import '../../dashboard/discover/controllers/follow_connect_controller.dart';
import '../../dashboard/feed/controller/new_feed_provider.dart';
import '../../dashboard/new_profile/controller/gallery_controller.dart';
import '../repository/logout_repo.dart';

final invalidateStaleDataProvider = StateProvider<bool>((ref) {
  final ssss = ref.watch(authenticationStatusProvider).valueOrNull;
  print('[lolo] $ssss ${ssss == AuthStatus.authenticated}');
  if (ssss != null && ssss == AuthStatus.unauthenticated ||
      ssss == AuthStatus.authenticated) {
    print('[lolo] true');
    ref.read(authenticationStatusProvider.notifier).invalidateStaleUserData();
    return true;
  }
  print('[lolo] false');
  return false;
});

final authenticationStatusProvider =
    AsyncNotifierProvider<AuthenticationNotifier, AuthStatus>(() {
  return AuthenticationNotifier();
});

// final authenticationStatusProvider =
//     AsyncNotifierProvider<AuthenticationNotifier, AuthStatus>(
//         AuthenticationNotifier.new);

class AuthenticationNotifier extends AsyncNotifier<AuthStatus> {
  final _repository = LogoutRepository.instance;
  final _firebaseMessaging = FirebaseMessaging.instance;
  // return .initial;
  @override
  Future<AuthStatus> build() async {
    final getToken = await VCredentials.inst.getUserCredentials();
    // final getUserId = await VCredentials.inst.getUserId();
    final getUsername = await VCredentials.inst.getUsername();

    final biometricStatus =
        await VModelSharedPrefStorage().getBool(VSecureKeys.biometricEnabled);
    BiometricService.isEnabled = biometricStatus;

    if (getToken != null && getUsername != null) {
      return AuthStatus.authenticated;
    }

    // ref.watch(hiveStoreProvider);
    ///
    return AuthStatus.initial;
  }

  void updateStatus(AuthStatus status) {
    state = AsyncData(status);
  }

  Future<void> logout() async {
    final fcmToken = await _firebaseMessaging.getToken();
    _repository.logout(fcmToken: fcmToken!);
    invalidateStaleUserData();
    await VModelSharedPrefStorage().clearObject(VSecureKeys.userTokenKey);
    await VModelSharedPrefStorage().clearObject(VSecureKeys.username);
    await VCredentials.inst.deleteAll();
    // ref.read(userPrefsProvider.notifier).addOrUpdatePrefsEntry(ref
    //     .read(userPrefsProvider)
    //     .value!
    //     .copyWith(savedAuthStatus: AuthStatus.initial));
    state = const AsyncData(AuthStatus.unauthenticated);

    // navigateAndRemoveUntilRoute(context, LoginPage());
  }

  void invalidateStaleUserData() {
    ref.invalidate(appUserProvider);
    ref.invalidate(mainFeedProvider);

    ref.invalidate(discoverProvider);
    ref.invalidate(accountToFollowProvider);
    ref.invalidate(galleryTypeFilterProvider(null));
    ref.invalidate(galleryProvider(null));
  }

  Future<void> updateCredentials({
    String? authToken,
    String? restToken,
    String? username,
    int? userId,
  }) async {
    // userIDPk = userId;
    // VConstants.logggedInUser = state.vuser;
    // userIDPk = state.loginResponse?.pk;

    print('[crd] Auth token new is $authToken');
    globalUsername = username;
    if (authToken != null) {
      GraphQlConfig.instance.updateToken(authToken);
      VCredentials.inst.storeUserCredentials(authToken);
      // Commenting this out. Token shouldn't be stored in SharedPreferences
      VModelSharedPrefStorage().putString(VSecureKeys.userTokenKey, authToken);
      print('Auth token issssssssssssssssssssssssssssssssssss $authToken');
    }
    if (restToken != null) GraphQlConfig.instance.updateRestToken(restToken);

    //store username
    if (username != null)
      VModelSharedPrefStorage().putString(VSecureKeys.username, username);
  }
}
