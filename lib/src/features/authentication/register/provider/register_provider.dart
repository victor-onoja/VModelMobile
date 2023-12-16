import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vmodel/src/vmodel.dart';
import '../../../../shared/response_widgets/toast.dart';
import '../../login/provider/login_provider.dart';
import '../repository/register_repo.dart';
import 'user_types_controller.dart';

final registerProvider = StateNotifierProvider((ref) {
  return RegisterProvider(ref);
});

class RegisterProvider extends StateNotifier<RegisterModel> {
  RegisterProvider(this.ref) : super(RegisterModel());

  final Ref ref;

  TextEditingController locationTextField = TextEditingController();
  TextEditingController websiteController = TextEditingController(text: "www.");
  TextEditingController priceController = TextEditingController(text: "");
  String location = "";

  Future<bool> registerUser({
    required BuildContext context,
    required String email,
    required String password1,
    required String username,
    required String password2,
    required String firstName,
    required String lastName,
    // required String userType,
    // required String userTypeLabel,
    // required bool isBusinessAccount,
  }) async {
    final userType = ref.watch(selectedAccountTypeProvider.notifier);
    final userTypeLabel = ref.watch(selectedAccountLabelProvider.notifier);
    final isBusinessAccount = ref.watch(isAccountTypeBusinessProvider.notifier);
    print('[qss] ${userTypeLabel.state}');

    // return false;
    final result = await registerRepoInstance.register(
      email: email,
      password1: password1,
      password2: '$password2',
      username: username,
      firstName: firstName,
      lastName: lastName,
      userType: userType.state,
      userTypeLabel: userTypeLabel.state,
      isBusinessAccount: isBusinessAccount.state,
    );
    print('''
    Calling register with values 
        email: $email,
        password: $password1,
        password2: $password2,
        username: $username,
        firstName: $firstName,
        lastName: $lastName,
        userType: ${userType.state},
        userTypeLabel: ${userTypeLabel.state},
        isBusinessAccount: ${isBusinessAccount.state};
   ''');
    return result.fold((left) {
      print('FFFFFFFFFFFFFFFFFFF ${left.message}');
      VWidgetShowResponse.showToast(ResponseEnum.failed,
          message: 'Error signing up');
      // return null;
      return false;
    }, (right) async {
      print(right);
      // final success = right['register']['success'];
      // final pk = right['register']['pk'];
      // final token = right['register']['token'];
      // final restToken = right['register']['restToken'];
      final success = right['success'] ?? false;
      if (success) {
        //Login user in if sign up is successful
        final isLoginSuccess = await ref
            .read(loginProvider.notifier)
            .startLoginSession(email, password1, context, isSignUp: true);
        print('Response from start session is+++++++++ $isLoginSuccess');
        // if (isLoginSuccess && context.mounted) {
        //   navigateToRoute(context, DashBoardView());
        // } else {
        //   navigateToRoute(context, LoginPage());
        // }
        // return isLoginSuccess;
      } else {
        print('FFFFFFFFFFFFFFFFFFF rightssss');

        String errors = right['errors']?.toString() ?? '';
        if (errors.isNotEmpty) {
          VWidgetShowResponse.showToast(ResponseEnum.failed,
              message: right['errors'].toString());
        }
      }
      // print('++++++++++++++++++ $token --- $restToken');
      //update and store user token
      // GraphQlConfig.instance.updateToken(token);
      // final storeToken =
      //     VModelSharedPrefStorage().putString(VSecureKeys.userTokenKey, token);
      // await VCredentials.inst.storeUserCredentials(token);
      // //upadate and store restToken
      // GraphQlConfig.instance.updateRestToken(restToken);
      // globalUsername = username;
      // //store username
      // final storeUsername =
      //     VModelSharedPrefStorage().putString(VSecureKeys.username, username);
      // Future.wait([storeToken, storeUsername]);
      // print('token stored');
      return success;
    });
    // return false;
  }

  Future<bool> checkUsernameAvailability(String username) async {
    final bool isUserNameTaken =
        await registerRepoInstance.checkUserNameAvailability(username);
    return isUserNameTaken;
  }
}

class RegisterModel {
  String? location;
  RegisterModel({this.location});

  RegisterModel copyWith({String? location}) {
    return RegisterModel(location: location ?? this.location);
  }
}
