import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:vmodel/src/app_locator.dart';
import 'package:vmodel/src/core/cache/credentials.dart';
import 'package:vmodel/src/core/cache/local_storage.dart';
import 'package:vmodel/src/core/models/user.dart';
import 'package:vmodel/src/core/utils/costants.dart';
import 'package:vmodel/src/core/utils/helper_functions.dart';
import 'package:vmodel/src/core/utils/validators_mixins.dart';
import 'package:vmodel/src/features/authentication/login/models/login_res_model.dart';
import 'package:vmodel/src/features/authentication/login/repository/login_repo.dart';
import 'package:vmodel/src/features/dashboard/dash/dashboard_ui.dart';
import 'package:vmodel/src/shared/loader/full_screen_dialog_loader.dart';
import 'package:vmodel/src/shared/response_widgets/toast.dart';
import 'package:vmodel/src/vmodel.dart';

import '../../../../core/controller/app_user_controller.dart';
import '../../../../core/controller/user_prefs_controller.dart';
import '../../../../core/network/graphql_confiq.dart';
import '../../../../core/utils/enum/auth_enum.dart';
import '../../../../res/colors.dart';
import '../../../push_notifications/service/firebase_api.dart';
import '../../controller/auth_status_provider.dart';
import '../views/auth_widget.dart';
import '../views/verify_2fa_otp.dart';

// final authStatusProvider = StateProvider<AuthStatus>((ref) {
//   return AuthStatus.initial;
// });

final loginProvider = StateNotifierProvider((ref) {
  return LoginProvider(ref);
});

class LoginProvider extends StateNotifier<LoginStateModel>
    with VValidatorsMixin {
  LoginProvider(this.ref) : super(LoginStateModel());

  final Ref ref;
  String _emailOrUsername = '';
//to run on login init
  runInit() {}

//to get provider state
  LoginStateModel get getState => state;

  // getter an variable for password obscure
  static bool obscure = true;
  bool get getPasswordObscure => obscure;

//logic for login session start
  Future<bool> startLoginSession(
      String userName, String password, BuildContext context,
      {bool isSignUp = false}) async {
    dismissKeyboard();
    //start loading
    // VLoader.changeLoadingState(true);

    _emailOrUsername = userName;
    //check if the inputted is username or email to know thich mutation to fire
    bool check = VValidatorsMixin.isUserNameValidator(userName);

//make request based on check
    final makeLoginRequest = check == false
        ? await loginRepoInstance.loginWithEmail(userName, password)
        : await loginRepoInstance.loginWithUserName(userName, password);
    // navigateToRoute(context, const DashBoardView());

    //on request ending fold the kind of response you are expecting onRight(when the mutation returns data)
    //for onLeft( probably when the mutation returns an unexpected data)

    // ref
    //     .read(authenticationStatusProvider.notifier)
    //     .updateStatus(AuthStatus.verify2fa);
    // if (context.mounted) {
    //   // goBack(context);
    //   navigateAndRemoveUntilRoute(context, const AuthWidgetPage());
    // }
    // return false;
    makeLoginRequest.fold((onLeft) {
      // VLoader.changeLoadingState(false);
      print('sign in fail');
      VWidgetShowResponse.showToast(ResponseEnum.failed,
          message: 'Invalid credentials');
      // navigateToRoute(
      //     context,
      //     TempErrorPage(
      //       fullErrorMessage: onLeft.message,
      //       stackTrace: StackTrace.current.toString(),
      //     ));

      return false;

      //run this block when you have error
    }, (onRight) async {
      print(onRight);
      //if the success field in the mutation response is true
      print('Login success is $onRight');
      final success = onRight['success'] ?? false;
      final isUse2FA = onRight['use2fa'] ?? false;
      if (success && isUse2FA) {
        // ref
        //     .read(authenticationStatusProvider.notifier)
        //     .updateStatus(AuthStatus.verify2fa);
        navigateToRoute(context, Verify2FAOtp());
        // if (context.mounted) {
        //   //goBack(context);
        //   navigateAndRemoveUntilRoute(context, const AuthWidgetPage());
        // }
        return false;
      }

      if (success) {
        await VCredentials.inst.storeUserCredentials(json.encode({
          'username': userName,
          'password': password,
        }));

        final restToken = onRight['restToken'] ?? '';

        //run this block when you have data
        LoginResponsModel responsModel = LoginResponsModel.fromJson(onRight);
        state = state.copyWith(
          loginResponse: responsModel,
        );
        state = state.copyWith(
            vuser: VUser(
          username: state.loginResponse?.username,
          firstName: state.loginResponse?.firstName,
          lastName: state.loginResponse?.lastName,
          bio: state.loginResponse?.bio,
          pk: state.loginResponse?.pk,
          token: state.loginResponse?.token,
        ));

        userIDPk = state.loginResponse?.pk;
        VConstants.logggedInUser = state.vuser;
        // userIDPk = state.loginResponse?.pk;
        globalUsername = state.loginResponse?.username;
        GraphQlConfig.instance.updateToken(state.loginResponse?.token);
        GraphQlConfig.instance.updateRestToken(restToken);
        // final storePk storeUserCredentials=
        //     VModelSharedPrefStorage().putInt('pk', state.loginResponse?.pk);
        //store username
        final storeUsername = VModelSharedPrefStorage()
            .putString(VSecureKeys.username, state.loginResponse?.username);

        // Commenting this out. Token shouldn't be stored in SharedPreferences
        final storeToken = VModelSharedPrefStorage()
            .putString(VSecureKeys.userTokenKey, state.loginResponse?.token);
        print('Auth token issssssssssssssssssssssssssssssssssss');
        print(state.loginResponse?.token);
        await VCredentials.inst
            .storeUserCredentials(state.loginResponse?.token);

        // await FirebaseApi().initNotification();

        await Future.wait([storeToken, storeUsername]);

        ref.invalidate(appUserProvider);

        if (isSignUp) {
          final userConfigs = ref.read(userPrefsProvider).value!;
          ref
              .read(userPrefsProvider.notifier)
              .addOrUpdatePrefsEntry(userConfigs.copyWith(
                savedAuthStatus: AuthStatus.firstLogin,
                // preferredLightTheme: _preferredTheme,
              ));
          ref
              .read(authenticationStatusProvider.notifier)
              .updateStatus(AuthStatus.firstLogin);
        } else {
          ref
              .read(authenticationStatusProvider.notifier)
              .updateStatus(AuthStatus.authenticated);

          print('[LoginProvider] GGGGGGGGGGot authenticated');
        }
        if (context.mounted) {
          // goBack(context);
          navigateAndRemoveUntilRoute(context, const AuthWidgetPage());
        }

        //
        // VLoader.changeLoadingState(false);
        //stop loading and navigate to dashboard
        // if (!isSignUp) {
        //   if (!context.mounted) return;
        //   navigateToRoute(context, const DashBoardView());
        // }
        print('GGGGGGGGGGot heeereeeeeee');
        return true;
      } else {
        print('[LoginProvider] GGGGGGGGGGot not authenticated');
        // final errorMessageFromApi = onRight['errors']['nonFieldErrors'][0]
        //         ['message'] ??
        //     "Something probably wrong with credentials";
        final errorMessageFromApi = onRight['errors'];
        //stop loading and show response
        VLoader.changeLoadingState(false);
        VWidgetShowResponse.showToast(ResponseEnum.failed,
            message: onRight['errors']);
        // TempErrorPage(
        //   fullErrorMessage: errorMessageFromApi,
        //   stackTrace: StackTrace.current.toString(),
        // );

        ref
            .read(authenticationStatusProvider.notifier)
            .updateStatus(AuthStatus.unauthenticated);
        if (context.mounted) {
          //goBack(context);
          navigateAndRemoveUntilRoute(context, const AuthWidgetPage());
        }
        return false;
      }
    });
    return false;
  }

  Future<bool> verify2FACode(
    BuildContext context, {
    required String code,
    // required String emailOrUsername,
  }) async {
    dismissKeyboard();
    //start loading
    // VLoader.changeLoadingState(true);

    //check if the inputted is username or email to know thich mutation to fire
    bool isUsername = VValidatorsMixin.isUserNameValidator(_emailOrUsername);

//make request based on check
    final makeLoginRequest = await loginRepoInstance.verify2FACode(
      code: code,
      username: isUsername ? _emailOrUsername : null,
      email: !isUsername ? _emailOrUsername : null,
    );
    // navigateToRoute(context, const DashBoardView());

    //on request ending fold the kind of response you are expecting onRight(when the mutation returns data)
    //for onLeft( probably when the mutation returns an unexpected data)

    makeLoginRequest.fold((onLeft) {
      // VLoader.changeLoadingState(false);
      print('sign in fail');
      VWidgetShowResponse.showToast(ResponseEnum.failed,
          message: 'Invalid credentials');
      return false;

      //run this block when you have error
    }, (onRight) async {
      print(onRight);
      //if the success field in the mutation response is true
      print('Login success is $onRight');
      final authToken = onRight['token'] as String?;
      print('[otpx] success is $authToken');

      if (!authToken.isEmptyOrNull) {
        final restToken = onRight['restToken'] ?? '';

        GraphQlConfig.instance.updateToken(authToken!);
        GraphQlConfig.instance.updateRestToken(restToken);
        // final storePk storeUserCredentials=
        //     VModelSharedPrefStorage().putInt('pk', state.loginResponse?.pk);
        final user = onRight['user'];

        // Commenting this out. Token shouldn't be stored in SharedPreferences
        // final storeToken = VModelSharedPrefStorage()
        //     .putString(VSecureKeys.userTokenKey, state.loginResponse?.token);
        print('Auth token issssssssssssssssssssssssssssssssssss');
        print(state.loginResponse?.token);
        await VCredentials.inst.storeUserCredentials(authToken);
        //store username
        await VModelSharedPrefStorage()
            .putString(VSecureKeys.username, user['username']);

        await FirebaseApi().initNotification();

        // await Future.wait([storeToken, storeUsername]);

        ref
            .read(authenticationStatusProvider.notifier)
            .updateStatus(AuthStatus.authenticated);

        print('[LoginProvider] GGGGGGGGGGot authenticated');
        if (context.mounted) {
          // goBack(context);
          navigateAndRemoveUntilRoute(context, const AuthWidgetPage());
        }

        //
        // VLoader.changeLoadingState(false);
        //stop loading and navigate to dashboard
        // if (!isSignUp) {
        //   if (!context.mounted) return;
        //   navigateToRoute(context, const DashBoardView());
        // }
        print('GGGGGGGGGGot heeereeeeeee');
        return true;
      } else {
        print('[LoginProvider] GGGGGGGGGGot not authenticated');
        // final errorMessageFromApi = onRight['errors']['nonFieldErrors'][0]
        //         ['message'] ??
        //     "Something probably wrong with credentials";
        final errorMessageFromApi = onRight['errors'];
        //stop loading and show response
        VLoader.changeLoadingState(false);
        VWidgetShowResponse.showToast(ResponseEnum.failed,
            message: onRight['errors']);
        // TempErrorPage(
        //   fullErrorMessage: errorMessageFromApi,
        //   stackTrace: StackTrace.current.toString(),
        // );

        ref
            .read(authenticationStatusProvider.notifier)
            .updateStatus(AuthStatus.unauthenticated);
        if (context.mounted) {
          //goBack(context);
          navigateAndRemoveUntilRoute(context, const AuthWidgetPage());
        }
        return false;
      }
    });
    return false;
  }

//logic for login session start
  startSocialLoginSession(
    String provider,
    String accessToken,
    String firstName,
    String lastName,
    BuildContext context,
  ) async {
    dismissKeyboard();
    //start loading
    VLoader.changeLoadingState(true);

    final makeLoginRequest = await loginRepoInstance.socialAuth(
        provider, accessToken, firstName, lastName);

    // navigateToRoute(context, const DashBoardView());

    //on request ending fold the kind of response you are expecting onRight(when the mutation returns data)
    //for onLeft( probably when the mutation returns an unexpected data)
    makeLoginRequest.fold((onLeft) {
      print(onLeft.message);
      VLoader.changeLoadingState(false);
      VWidgetShowResponse.showToast(
        ResponseEnum.failed,
      );
      //run this block when you have error
    }, (onRight) async {
      if ((onRight['social']['id'] != null && onRight['token'] != null) ==
          true) {
        userIDPk = int.parse(onRight['user']['id']);
        await VCredentials.inst.setUserToken(onRight['token']);
        VLoader.changeLoadingState(false);
        //stop loading and navigate to dashboard
        if (!mounted) return;
        navigateToRoute(context, const DashBoardView());
      }
    });
  }

// logic to change obscure state
  changeObScureState() {
    state = state.copyWith(
      isObscurePassword: !obscure,
    );
    obscure = state.isObscurePassword!;
  }

  //change rememberMe
  changeRememberMeState(bool? value) {
    state = state.copyWith(rememberMeOnLogin: value);
  }

  //authenticate with biometrics
  authenticateWithBiometrics(BuildContext context) async {
    bool isAuthenticated = await BiometricService.authenticateUser();
    if (isAuthenticated) {
      // // // ignore: use_build_context_synchronously
      // navigateToRoute(context, const DashBoardView());
      // // startLoginSession(userName, password, context);
      VLoader.changeLoadingState(true);
      final getUserCredentials = await VCredentials.inst.getUserCredentials();
      print(getUserCredentials.toString());
      VLoader.changeLoadingState(false);
      if (getUserCredentials != null) {
        final Map<String, dynamic> userMappedData =
            json.decode(getUserCredentials);
        // ignore: use_build_context_synchronously
        startLoginSession(
            userMappedData['username'], userMappedData['password'], context);
      } else {
        VWidgetShowResponse.showToast(ResponseEnum.failed,
            message: "Please login and enable your biometrics");
      }
    } else {
      VWidgetShowResponse.showToast(ResponseEnum.failed,
          message: "Authentication failed");
    }
  }

  //authenticate with biometrics
  Future<bool> authenticateWithBiometricsNew(BuildContext context) async {
    VLoader.changeLoadingState(true);
    bool isAuthenticated = await BiometricService.authenticateUser();
    VLoader.changeLoadingState(false);
    return isAuthenticated;
    // if (isAuthenticated) {
    // // // ignore: use_build_context_synchronously
    // navigateToRoute(context, const DashBoardView());
    // // startLoginSession(userName, password, context);
    // VLoader.changeLoadingState(true);
    // final getUserCredentials = await VCredentials.inst.getUserCredentials();
// print(getUserCredentials.toString());
//       VLoader.changeLoadingState(false);
//       if (getUserCredentials != null) {
//         final Map<String, dynamic> userMappedData =
//             json.decode(getUserCredentials);
//         // ignore: use_build_context_synchronously
//         startLoginSession(
//             userMappedData['username'], userMappedData['password'], context);
//       } else {
//         VWidgetShowResponse.showToast(ResponseEnum.failed,
//             message: "Please login and enable your biometrics");
//       }
//     } else {
//       VWidgetShowResponse.showToast(ResponseEnum.failed,
//           message: "Authentication failed");
//     }
  }

  ///
  ///
  // final progress = ProgressHUD.of(context);
  // if (_formKey.currentState!.validate() == false) {
  //   Fluttertoast.showToast(
  //       msg: "Please fill all the fields",
  //       gravity: ToastGravity.TOP,
  //       timeInSecForIosWeb: 1,
  //       backgroundColor:
  //           VmodelColors.error.withOpacity(0.6),
  //       textColor: Colors.white,
  //       fontSize: 16.0);
  // } else {
  //   _formKey.currentState?.save();
  //   progress?.show();

  //   final authNotifier = ref.read(authProvider.notifier);
  //   if (_usermail.text.isEmail) {
  //     await authNotifier.login(
  //         _usermail.text.toLowerCase().trim(),
  //         _password.text.trim());
  //   } else {
  //     await authNotifier.loginUsername(
  //         _usermail.text.capitalizeFirst!.trim(),
  //         _password.text.trim());
  //   }
  //   if (authNotifier.state.status ==
  //       AuthStatus.authenticated) {
  //     progress?.dismiss();
  //     // print(authNotifier.state.token);
  //     await VModelSharedPrefStorage()
  //         .putInt('pk', authNotifier.state.pk);
  //     navigateToRoute(context, const DashBoardView());
  //     print(authNotifier.state.token);
  //     if (checkboxValue == true) {
  //       await VModelSharedPrefStorage()
  //           .putString('token', authNotifier.state.token);
  //     }
  //   } else {
  //     progress?.dismiss();
  //     Fluttertoast.showToast(
  //         msg: 'Please enter valid credentials',
  //         gravity: ToastGravity.TOP,
  //         timeInSecForIosWeb: 1,
  //         backgroundColor:
  //             VmodelColors.error.withOpacity(0.6),
  //         textColor: Colors.white,
  //         fontSize: 16.0);
  //   }
  // if(authNotifier.state.status == AuthStatus.authenticated){
  // // if (_graphQLService.succ == false){
  //   progress?.dismiss();
  //   Fluttertoast.showToast(
  //       msg: _graphQLService.err,
  //       gravity: ToastGravity.TOP,
  //       timeInSecForIosWeb: 1,
  //       backgroundColor: VmodelColors.error.withOpacity(0.6),
  //       textColor: Colors.white,
  //       fontSize: 16.0
  //   );
  // }else {
  //   progress?.dismiss();
  //   if(mounted) {
  //     print(_graphQLService.token);
  //     navigateToRoute(context, const DashBoardView());
  //     if(checkboxValue == true){
  //       await VModelSharedPrefStorage().putString('token', _graphQLService.token);
  //     }
  //   }
  // }
  // }
}

//model to handle UI in your riverpod
class LoginStateModel {
  String? userName;
  String? password;
  bool? isLoading;
  bool? isUserNameType;
  bool? isObscurePassword;
  bool? rememberMeOnLogin;
  LoginResponsModel? loginResponse;
  VUser? vuser;

  LoginStateModel({
    this.isLoading,
    this.isUserNameType,
    this.password,
    this.userName,
    this.isObscurePassword = true,
    this.rememberMeOnLogin = false,
    this.loginResponse,
    this.vuser,
  });

  LoginStateModel copyWith(
      {String? userName,
      String? password,
      bool? isLoading,
      bool? isUserNameType,
      bool? isObscure,
      bool? checkboxValue,
      bool? rememberMeOnLogin,
      bool? isObscurePassword,
      VUser? vuser,
      LoginResponsModel? loginResponse}) {
    return LoginStateModel(
      userName: userName ?? this.userName,
      password: password ?? this.password,
      isLoading: isLoading ?? this.isLoading,
      isUserNameType: isUserNameType ?? this.isUserNameType,
      rememberMeOnLogin: rememberMeOnLogin ?? this.rememberMeOnLogin,
      isObscurePassword: isObscurePassword ?? this.isObscurePassword,
      loginResponse: loginResponse ?? this.loginResponse,
      vuser: vuser ?? this.vuser,
    );
  }
}

class SocialAuth {
  static Future<UserCredential> signInWithGoogle(
      {required BuildContext context}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    late AuthCredential credential;
    final GoogleSignIn googleSignIn = GoogleSignIn();
    late UserCredential userCredential;
    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();
    VLoader.changeLoadingState(true);
    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;
      credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      try {
        VLoader.changeLoadingState(false);
        userCredential = await auth.signInWithCredential(credential);
        user = userCredential.user;

        print('access token is:${credential.accessToken!}');
        await FirebaseApi().initNotification();
        print(user);
      } on FirebaseAuthException catch (e) {
        VLoader.changeLoadingState(false);
        if (e.code == 'account-exists-with-different-credential') {
          Fluttertoast.showToast(
              msg: "The account already exists with a different credential.",
              gravity: ToastGravity.TOP,
              timeInSecForIosWeb: 1,
              backgroundColor: VmodelColors.error.withOpacity(0.6),
              textColor: Colors.white,
              fontSize: 16.0);
        } else if (e.code == 'invalid-credential') {
          Fluttertoast.showToast(
              msg: "Error occurred while accessing credentials. Try again.",
              gravity: ToastGravity.TOP,
              timeInSecForIosWeb: 1,
              backgroundColor: VmodelColors.error.withOpacity(0.6),
              textColor: Colors.white,
              fontSize: 16.0);
        }
      } catch (e) {
        VLoader.changeLoadingState(false);
        // handle the error here
      }
    }

    return userCredential;
  }

  static Future<UserCredential> signInWithFacebook(
      {required BuildContext context}) async {
    final LoginResult loginResult = await FacebookAuth.instance
        .login(permissions: ['email', 'public_profile', 'user_birthday']);

    await FirebaseApi().initNotification();

    final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(loginResult.accessToken!.token);
    return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
  }
}
