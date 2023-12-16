import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vmodel/src/core/utils/enum/auth_enum.dart';
import 'package:vmodel/src/features/authentication/login/views/sign_in.dart';
import 'package:vmodel/src/features/authentication/views/new_login_screens/signup_view.dart';
import 'package:vmodel/src/res/icons.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/shared/appbar/appbar.dart';
import 'package:vmodel/src/shared/buttons/primary_button.dart';
import 'package:vmodel/src/shared/buttons/text_button.dart';
import 'package:vmodel/src/shared/loader/full_screen.dart';
import 'package:vmodel/src/shared/rend_paint/render_svg.dart';
import 'package:vmodel/src/shared/text_fields/login_text_field.dart';
import 'package:vmodel/src/vmodel.dart';

import '../../../../core/api/graphql_service.dart';

class SignUpPage extends ConsumerStatefulWidget {
  const SignUpPage({super.key});

  @override
  ConsumerState<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends ConsumerState<SignUpPage> {
  bool _isObscure = true;
  bool _isUserNameAvailable = true;
  bool _isPasswordTyping = false;
  // final GraphQlService _graphQLService = GraphQlService();
  RegExp pass_valid = RegExp(
      r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$");
  final TextEditingController _email = TextEditingController();
  final TextEditingController _firstName = TextEditingController();
  final TextEditingController _lastName = TextEditingController();
  final TextEditingController _password1 = TextEditingController();
  final TextEditingController _password2 = TextEditingController();
  final TextEditingController _username = TextEditingController();
  String text = '';
  final _formKey = GlobalKey<FormState>();

  //A function that validate user entered password
  bool validatePassword(String pass) {
    String password = pass.trim();
    if (pass_valid.hasMatch(password)) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: VWidgetsAppBar(
        backgroundColor: VmodelColors.white,
        appbarTitle: "",
        elevation: 0,
      ),
      body: ProgressHUD(
          child: Builder(
        builder: (context) => SingleChildScrollView(
            padding: const VWidgetsPagePadding.horizontalSymmetric(18),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Text(
                    "Sign Up",
                    style: Theme.of(context).textTheme.displayLarge!.copyWith(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).primaryColor,
                        ),
                  ),
                  addVerticalSpacing(25),
                  VWidgetsLoginTextField(
                    hintText: "First name",
                    textCapitalization: TextCapitalization.words,
                    controller: _firstName,
                    validator: (p0) {
                      if (p0!.isEmpty) {
                        return "First name is required";
                      }
                      return null;
                    },
                    onChanged: (p0) {
                      setState(() {
                        _isPasswordTyping = false;
                      });
                    },
                  ),
                  VWidgetsLoginTextField(
                    hintText: "Last name",
                    controller: _lastName,
                    textCapitalization: TextCapitalization.words,
                    validator: (p0) {
                      if (p0!.isEmpty) {
                        return "Last name is required";
                      }
                      return null;
                    },
                    onChanged: (p0) {
                      setState(() {
                        _isPasswordTyping = false;
                      });
                    },
                  ),
                  VWidgetsLoginTextField(
                    hintText: "User Name",
                    textCapitalization: TextCapitalization.words,
                    controller: _username,
                    validator: (p0) {
                      if (p0!.isEmpty) {
                        return "User name is required";
                      }
                      return null;
                    },
                    onChanged: (p0) {
                      setState(() {
                        _isPasswordTyping = false;
                      });
                    },
                    suffixIcon: IconButton(
                        padding: const EdgeInsets.all(0),
                        onPressed: () {
                          _userNameAvailable();
                        },
                        icon: Icon(
                          _isUserNameAvailable
                              ? Icons.error
                              : Icons.verified_rounded,
                        )),
                  ),
                  VWidgetsLoginTextField(
                    hintText: "Email",
                    controller: _email,
                    validator: (p0) {
                      if (p0!.isEmpty) {
                        return "Email is required";
                      }
                      return null;
                    },
                    onChanged: (p0) {
                      setState(() {
                        _isPasswordTyping = false;
                      });
                    },
                  ),
                  VWidgetsLoginTextField(
                    hintText: "Password",
                    controller: _password1,
                    obscureText: _isObscure,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Password is required";
                      } else {
                        //call function to check password
                        bool result = validatePassword(value);
                        if (result) {
                          // create account event
                          return null;
                        } else {
                          return " Password should contain Capital, small letter & Number & Special";
                        }
                      }
                    },
                    // validator: (p0) {
                    //   if (p0!.isEmpty) {
                    //     return "Password is required";
                    //   }
                    //   return null;
                    // },
                    onChanged: (p0) {
                      setState(() {
                        _isPasswordTyping = true;
                      });
                    },
                    suffixIcon: IconButton(
                        padding: const EdgeInsets.all(0),
                        onPressed: () {
                          _togglePasswordView();
                        },
                        icon: Icon(
                          _isObscure
                              ? Icons.visibility_rounded
                              : Icons.visibility_off_rounded,
                        )),
                  ),
                  // if (_isPasswordTyping)
                  //   Column(
                  //     children: [
                  //       Text(
                  //         "Password must contain at least 8 characters, including one uppercase letter and one special character.",
                  //         style: Theme.of(context).textTheme.displayMedium!.copyWith(
                  //           fontWeight: FontWeight.w500,
                  //           color: VmodelColors.primaryColor.withOpacity(0.5),
                  //         ),
                  //       ),
                  //       addVerticalSpacing(6),
                  //     ],
                  //   ),
                  VWidgetsLoginTextField(
                    hintText: "Confirm password",
                    controller: _password2,
                    obscureText: _isObscure,
                    // validator: (p0) {
                    //   if (p0!.isEmpty) {
                    //     return "Password is required";
                    //   }
                    //   return null;
                    // },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please confirm password";
                      } else {
                        //call function to check password
                        // bool result = validatePassword(value);
                        if (_password2.text.trim() == _password1.text.trim()) {
                          // create account event
                          return null;
                        } else {
                          return "Please make sure passwords are the same";
                        }
                      }
                    },
                    onChanged: (p0) {
                      setState(() {
                        _isPasswordTyping = true;
                      });
                    },
                    suffixIcon: IconButton(
                        padding: const EdgeInsets.all(0),
                        onPressed: () {
                          _togglePasswordView();
                        },
                        icon: Icon(
                          _isObscure
                              ? Icons.visibility_rounded
                              : Icons.visibility_off_rounded,
                        )),
                  ),
                  // if (_isPasswordTyping && _password1.text.trim() != _password2.text.trim())
                  //   Column(
                  //     children: [
                  //       Text(
                  //         "Password must be the same",
                  //         style: Theme.of(context).textTheme.displayMedium!.copyWith(
                  //           fontWeight: FontWeight.w500,
                  //           color: VmodelColors.primaryColor.withOpacity(0.5),
                  //         ),
                  //       ),
                  //       addVerticalSpacing(6),
                  //     ],
                  //   ),

                  addVerticalSpacing(40),
                  VWidgetsPrimaryButton(
                      buttonTitle: "Sign Up",
                      enableButton: true,
                      onPressed: () async {
                        final progress = ProgressHUD.of(context);
                        if (_formKey.currentState!.validate() == false) {
                          Fluttertoast.showToast(
                              msg: "Please fill all the fields",
                              gravity: ToastGravity.TOP,
                              timeInSecForIosWeb: 1,
                              backgroundColor: VmodelColors.error,
                              textColor: Colors.white,
                              fontSize: 16.0);
                        } else {
                          _formKey.currentState?.save();
                          progress?.show();
                          final authNotifier = ref.read(authProvider.notifier);
                          await authNotifier.register(
                              _email.text.toLowerCase().trim(),
                              _password1.text.trim(),
                              _username.text.capitalizeFirst!.trim(),
                              _password2.text.trim(),
                              _firstName.text.capitalizeFirst!.trim(),
                              _lastName.text.capitalizeFirst!.trim());
                          if (authNotifier.state.status ==
                              AuthStatus.authenticated) {
                            await authNotifier.login(
                                _email.text.trim(), _password1.text.trim());
                            progress?.dismiss();
                            if (mounted) {
                              navigateToRoute(context, const SignupView());
                            }
                          } else {
                            progress?.dismiss();
                            Fluttertoast.showToast(
                                msg: "User name or email already exists",
                                gravity: ToastGravity.TOP,
                                timeInSecForIosWeb: 1,
                                backgroundColor:
                                    VmodelColors.black.withOpacity(0.6),
                                textColor: Colors.white,
                                fontSize: 16.0);
                          }
                        }
                        // print('hello');
                        // navigateToRoute(context, OnboardingPhotoPage());
                      }),
                  addVerticalSpacing(25),
                  Text(
                    "or",
                    style: Theme.of(context).textTheme.displayMedium!.copyWith(
                          fontWeight: FontWeight.w500,
                          color: VmodelColors.primaryColor.withOpacity(0.5),
                        ),
                  ),
                  addVerticalSpacing(20),
                  OutlinedButton(
                      onPressed: () {
                        navigateToRoute(context, const SignupView());
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
                                "Sign up with facebook",
                                style: Theme.of(context)
                                    .textTheme
                                    .displayMedium!
                                    .copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: VmodelColors.primaryColor
                                          .withOpacity(1),
                                    ),
                              ),
                            ),
                          ],
                        ),
                      )),
                  addVerticalSpacing(10),
                  OutlinedButton(
                      onPressed: () {
                        navigateToRoute(context, const SignupView());
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
                                "Sign up with Google",
                                style: Theme.of(context)
                                    .textTheme
                                    .displayMedium!
                                    .copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: VmodelColors.primaryColor
                                          .withOpacity(1),
                                    ),
                              ),
                            ),
                          ],
                        ),
                      )),
                  addVerticalSpacing(10),
                  OutlinedButton(
                      onPressed: () {
                        navigateToRoute(context, const SignupView());
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
                            const NormalRenderSvg(svgPath: VIcons.appleIcon),
                            addHorizontalSpacing(5),
                            Padding(
                              padding: const EdgeInsets.only(left: 60.0),
                              child: Text(
                                "Sign up with Apple",
                                style: Theme.of(context)
                                    .textTheme
                                    .displayMedium!
                                    .copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: VmodelColors.primaryColor
                                          .withOpacity(1),
                                    ),
                              ),
                            ),
                          ],
                        ),
                      )),
                  addVerticalSpacing(20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Have an account?",
                        style: Theme.of(context)
                            .textTheme
                            .displayMedium!
                            .copyWith(
                              fontWeight: FontWeight.w500,
                              color: VmodelColors.primaryColor.withOpacity(0.5),
                            ),
                      ),
                      VWidgetsTextButton(
                        text: "Sign in",
                        onPressed: () {
                          navigateToRoute(context, LoginPage());
                        },
                        textStyle:
                            Theme.of(context).textTheme.displayMedium!.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.blue,
                                ),
                      )
                    ],
                  ),
                  addVerticalSpacing(30),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("By Sign-in/Signing-up, you agree to Vmodel's",
                          style: Theme.of(context)
                              .textTheme
                              .displaySmall!
                              .copyWith(
                                color:
                                    VmodelColors.primaryColor.withOpacity(0.5),
                              )),
                      addVerticalSpacing(2),
                      InkWell(
                        onTap: () {
                          launchUrl(Uri(
                            scheme: 'https',
                            path: 'v-model-web.vercel.app/privacypolicy',
                          ));
                        },
                        child: Text('Terms of Services',
                            style: Theme.of(context)
                                .textTheme
                                .displaySmall!
                                .copyWith(
                                  color: VmodelColors.primaryColor,
                                )),
                      ),
                    ],
                  ),
                ],
              ),
            )),
      )),
    );
  }

  /// Logic for switching password view
  void _togglePasswordView() {
    setState(() {
      _isObscure = !_isObscure;
    });
  }

  /// Logic for checking username is availabel
  void _userNameAvailable() {
    setState(() {
      _isUserNameAvailable = !_isUserNameAvailable;
    });
  }
}
