import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vmodel/src/core/utils/validators_mixins.dart';
import 'package:vmodel/src/features/authentication/login/provider/login_provider.dart';
import 'package:vmodel/src/features/authentication/reset_password/views/forgot_password_view.dart';
import 'package:vmodel/src/res/icons.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/shared/appbar/appbar.dart';
import 'package:vmodel/src/shared/buttons/primary_button.dart';
import 'package:vmodel/src/shared/buttons/text_button.dart';
import 'package:vmodel/src/shared/rend_paint/render_svg.dart';
import 'package:vmodel/src/shared/text_fields/login_text_field.dart';
import 'package:vmodel/src/vmodel.dart';

import '../../../../shared/response_widgets/toast.dart';
import '../../new_Login_screens/new_user_onboarding.dart';

class LoginPage extends ConsumerWidget with VValidatorsMixin {
  static const name = "login";

  final TextEditingController _usermail = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final showLoading = ValueNotifier<bool>(false);

  LoginPage({super.key});

  // final GraphQlService _graphQLService = GraphQlService();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ref.listen(authStatusProvider, (p, n) {
    //   // ref.read(authStatusProvider.notifier).state =
    //   //     AuthStatus.unauthenticated;
    //   print(
    //       '-------LLLLLLLL----------- authStatus listen previous: $p next: $n');
    //   print('-------LLLLLLLL-----------invalidating feed and gallery');
    //   ref.read(dashTabProvider.notifier).changeIndexState(0);
    //   ref.invalidate(filteredGalleryListProvider(null));
    //   ref.invalidate(galleryProvider(null));
    //   ref.invalidate(mainFeedProvider);
    //   if (n == AuthStatus.authenticated) {
    //     VLoader.changeLoadingState(false);
    //     if (context.mounted) {
    //       navigateToRoute(
    //         context,
    //         const DashBoardView(),
    //       );
    //     } else {
    //       showLoading.value = false;
    //       VWidgetShowResponse.showToast(ResponseEnum.warning,
    //           message: "Error signing in");
    //     }
    //   } else {
    //     showLoading.value = false;
    //     VLoader.changeLoadingState(false);
    //     // VLoader.changeLoadingState(false);
    //     VWidgetShowResponse.showToast(ResponseEnum.warning,
    //         message: "Error signing in");
    //   }
    // });
    ref.watch(loginProvider);

    final loginNotifier = ref.watch(loginProvider.notifier);
    return Scaffold(
      appBar: const VWidgetsAppBar(
        leadingIcon: VWidgetsBackButton(),
        // appBarHeight: 2,
        appbarTitle: "",
        elevation: 0,
      ),
      body: GestureDetector(
        onTap: () => dismissKeyboard(),
        child: SafeArea(
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(
                  top: 0, right: 25, left: 25, bottom: 10),
              child: Column(
                children: [
                  Text(
                    "Sign in",
                    style: context.textTheme.displayLarge!.copyWith(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).primaryColor),
                  ),
                  addVerticalSpacing(35),
                  VWidgetsLoginTextField(
                    hintText: "Email or Username",
                    controller: _usermail,
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (val) {},
                    validator: (String? val) => VValidatorsMixin.isNotEmpty(val,
                        field: "Username/Email"),
                  ),
                  addVerticalSpacing(20),
                  VWidgetsLoginTextField(
                    hintText: "Password",
                    controller: _password,
                    obscureText: loginNotifier.getPasswordObscure,
                    onChanged: (val) {},
                    validator: (String? val) =>
                        VValidatorsMixin.isNotEmpty(val, field: "Password"),
                    suffixIcon: IconButton(
                      padding: const EdgeInsets.all(0),
                      onPressed: () {
                        loginNotifier.changeObScureState();
                      },
                      icon: loginNotifier.getPasswordObscure
                          ? const RenderSvg(svgPath: VIcons.eyeIcon)
                          : const RenderSvg(svgPath: VIcons.eyeSlashOutline),
                    ),
                  ),
                  addVerticalSpacing(15),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          navigateToRoute(context, ForgotPasswordView());
                        },
                        child: Text(
                          "Forgot Password ?",
                          style: context.textTheme.displayMedium!.copyWith(
                              fontWeight: FontWeight.w600,
                              color: Theme.of(context).primaryColor),
                        ),
                      ),
                    ],
                  ),
                  addVerticalSpacing(40),
                  ValueListenableBuilder<bool>(
                      valueListenable: showLoading,
                      builder: (context, value, child) {
                        return VWidgetsPrimaryButton(
                          showLoadingIndicator: value,
                          onPressed: () async {
                            HapticFeedback.lightImpact();
                            try {
                              if (_formKey.currentState!.validate()) {
                                showLoading.value = true;
                                final result =
                                    await loginNotifier.startLoginSession(
                                        _usermail.text.toLowerCase(),
                                        _password.text,
                                        context);
                                if (!result) {
                                  showLoading.value = false;
                                }
                              } else {
                                showLoading.value = false;
                                VWidgetShowResponse.showToast(
                                    ResponseEnum.warning,
                                    message: "Please fill all fields");
                              }
                            } on Exception {
                              showLoading.value = false;
                            }
                          },
                          buttonTitle: 'Sign in',
                        );
                      }),
                  // VWidgetsPrimaryButton(
                  //     buttonTitle: "Sign in",
                  //     enableButton: true,
                  //     onPressed: () async {
                  //       //VLoader.changeLoadingState(true);
                  //       // if (_formKey.currentState!.validate()) {
                  //       //   loginNotifier.startLoginSession(
                  //       //       _usermail.text.toLowerCase(),
                  //       //       _password.text,
                  //       //       context);

                  //       //   print('GGGGGGGGGGot completed start login session');
                  //       //   // VLoader.changeLoadingState(false);
                  //       // } else {
                  //       //   VWidgetShowResponse.showToast(ResponseEnum.warning,
                  //       //       message: "Please fill all fields");
                  //       // }
                  //     }),
                  addVerticalSpacing(10),
                  // OutlinedButton(
                  //     onPressed: () async {
                  //       loginNotifier.authenticateWithBiometrics(context);
                  //     },
                  //     style: ButtonStyle(
                  //       shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  //           borderRadius: BorderRadius.circular(8.0))),
                  //     ),
                  //     child: Padding(
                  //       padding: const EdgeInsets.symmetric(
                  //           horizontal: 2.0, vertical: 8),
                  //       child: Row(
                  //         children: [
                  //           const NormalRenderSvg(svgPath: VIcons.humanIcon),
                  //           addHorizontalSpacing(5),
                  //           Padding(
                  //             padding: const EdgeInsets.only(left: 60.0),
                  //             child: Text(
                  //               "Login with Biometrics",
                  //               style:
                  //                   context.textTheme.displayMedium!.copyWith(
                  //                 fontWeight: FontWeight.w600,
                  //                 color:
                  //                     VmodelColors.primaryColor.withOpacity(1),
                  //               ),
                  //             ),
                  //           ),
                  //         ],
                  //       ),
                  //     )),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.end,
                  //   children: [
                  //     Text(
                  //       'Remember login',
                  //       style: context.textTheme.displayMedium!
                  //           .copyWith(color: VmodelColors.primaryColor),
                  //     ),
                  //     Theme(
                  //       data: context.appTheme.copyWith(
                  //           unselectedWidgetColor: VmodelColors.primaryColor),
                  //       child: Checkbox(
                  //         shape: RoundedRectangleBorder(
                  //             borderRadius: BorderRadius.circular(5)),
                  //         activeColor: VmodelColors.primaryColor,
                  //         checkColor: VmodelColors.white,
                  //         value: loginNotifier.getState.rememberMeOnLogin,
                  //         onChanged: (bool? value) {
                  //           loginNotifier.changeRememberMeState(value);
                  //         },
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  addVerticalSpacing(25),
                  Text(
                    "or",
                    style: context.textTheme.displayMedium!.copyWith(
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).primaryColor.withOpacity(0.5),
                    ),
                  ),
                  addVerticalSpacing(20),
                  OutlinedButton(
                      onPressed: () {
                        SocialAuth.signInWithFacebook(context: context);
                      },
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0))),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 2.0, vertical: 8),
                        child: Row(
                          children: [
                            const NormalRenderSvg(svgPath: VIcons.facebookIcon),
                            addHorizontalSpacing(5),
                            Padding(
                              padding: const EdgeInsets.only(left: 60.0),
                              child: Text(
                                "Sign in with facebook",
                                style:
                                    context.textTheme.displayMedium!.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: Theme.of(context)
                                      .primaryColor
                                      .withOpacity(1),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )),
                  addVerticalSpacing(10),
                  OutlinedButton(
                      onPressed: () async {
                        UserCredential credentials =
                            await SocialAuth.signInWithGoogle(context: context);
                        List<String> nameParts =
                            credentials.user!.displayName!.split(' ');
                        loginNotifier.startSocialLoginSession(
                            "google-oauth2",
                            credentials.credential!.accessToken!,
                            nameParts[0],
                            nameParts[1],
                            context);
                      },
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0))),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 2.0, vertical: 8),
                        child: Row(
                          children: [
                            Image.asset(
                              VIcons.googleIcon,
                              height: 26,
                              width: 26,
                            ),
                            addHorizontalSpacing(5),
                            Padding(
                              padding: const EdgeInsets.only(left: 58.0),
                              child: Text(
                                "Sign in with Google",
                                style:
                                    context.textTheme.displayMedium!.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: Theme.of(context)
                                      .primaryColor
                                      .withOpacity(1),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )),
                  addVerticalSpacing(10),
                  OutlinedButton(
                      onPressed: () {},
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0))),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 2.0, vertical: 8),
                        child: Row(
                          children: [
                            const NormalRenderSvg(svgPath: VIcons.appleIcon),
                            addHorizontalSpacing(5),
                            Padding(
                              padding: const EdgeInsets.only(left: 60.0),
                              child: Text(
                                "Sign in with Apple",
                                style:
                                    context.textTheme.displayMedium!.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: Theme.of(context)
                                      .primaryColor
                                      .withOpacity(1),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )),
                  addVerticalSpacing(20),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        // height: 40,
        padding: EdgeInsets.only(bottom: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Don't have an account?",
              style: context.textTheme.displayMedium!.copyWith(
                fontWeight: FontWeight.w500,
                color: Theme.of(context).primaryColor.withOpacity(0.5),
              ),
            ),
            VWidgetsTextButton(
              text: "Sign Up",
              onPressed: () {
                //navigateToRoute(context, const SignUpPage());
                // navigateAndRemoveUntilRoute(context, const OnBoardingPage());
                navigateAndRemoveUntilRoute(
                    context, const UserOnBoardingPage());
              },
              textStyle: context.textTheme.displayMedium!.copyWith(
                fontWeight: FontWeight.w600,
                color: Colors.blue,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
