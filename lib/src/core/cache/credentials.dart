import 'package:vmodel/src/core/cache/local_storage.dart';
import 'package:vmodel/src/core/network/graphql_confiq.dart';

class VSecureKeys {
  static const String userKey = 'vuser';
  static const String userTokenKey = 'token';
  static const String restTokenKey = 'restToken';
  static const String userIdPk = 'pk';
  static const String username = 'username';
  static const String savedAuthStatus = 'auth_status';
  static const String biometricEnabled = 'biometric_enabled';
}

class VCredentials {
  VCredentials._();
  final VModelSecureStorage stroage = VModelSecureStorage();

  static VCredentials inst = VCredentials._();

  //get user email/username and password
  Future<dynamic> getUserCredentials() async {
    final secureToken =
        await stroage.getSecuredKeyStoreData(VSecureKeys.userKey);
    final restToken = await getRestToken() as String?;
    // GraphQlConfig.token = secureToken ?? '';
    GraphQlConfig.instance.updateRestToken(restToken ?? '');

    print('[otpx] atu TOKEN IS $secureToken');
    print('RRRRRRRRREEEEEEEEEESSSSSSSSSSTTTTTTT TOKEN IS $restToken');
    return secureToken;
  }

  //store user credentials

  storeUserCredentials(dynamic userCredentials) async {
    await stroage.storeByKey(VSecureKeys.userKey, userCredentials);
  }

  //get token
  //get user email/username and password
  Future<dynamic> getUserToken() {
    return stroage.getSecuredKeyStoreData(VSecureKeys.userTokenKey);
  }

  deleteAll() async {
    await stroage.storage.deleteAll();
  }

  //store user credentials
  setRestToken(String token) async {
    await stroage.storeByKey(VSecureKeys.restTokenKey, token);
  }

  Future<dynamic> getRestToken() async {
    return stroage.getSecuredKeyStoreData(VSecureKeys.restTokenKey);
  }

  setUserToken(dynamic token) async {
    await stroage.storeByKey(VSecureKeys.userTokenKey, token);
  }

  Future<int?> getUserId() async {
    return await VModelSharedPrefStorage().getInt(VSecureKeys.userIdPk);
  }

  Future<String?> getUsername() async {
    return await VModelSharedPrefStorage().getString(VSecureKeys.username);
  }
}
