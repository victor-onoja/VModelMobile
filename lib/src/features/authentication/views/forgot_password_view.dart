import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:vmodel/src/core/utils/enum/auth_enum.dart';
import 'package:vmodel/src/core/utils/validators_mixins.dart';
import 'package:vmodel/src/features/authentication/views/reset_password_otp.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/shared/buttons/primary_button.dart';
import 'package:vmodel/src/shared/loader/full_screen.dart';
import 'package:vmodel/src/shared/text_fields/login_text_field.dart';
import 'package:vmodel/src/vmodel.dart';

import '../../../core/api/graphql_service.dart';

class ForgotPasswordView extends ConsumerStatefulWidget with VValidatorsMixin {
  ForgotPasswordView({Key? key}) : super(key: key);

  @override
  ConsumerState<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends ConsumerState<ForgotPasswordView> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool buttonVisibility = true;
  // after onpressing 'Confirm Email' button I don't want to create another screen because of performance
  // it makes 'Confirm Email' button invisible after pressing on it.

  bool isMessageVisible = false;
  // It works in reverse of buttonVisiblity.
  // final GraphQlService _graphQLService = GraphQlService();
  bool isButtonActive = false;
  late TextEditingController controller;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    controller = TextEditingController();
    controller.addListener(() {
      if (controller.text.isNotEmpty && controller.text.contains('@')) {
        final isButtonActive = controller.text.isNotEmpty;

        setState(() {
          this.isButtonActive = isButtonActive;
        });
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: VmodelColors.background,
      appBar: AppBar(
        leading: const VWidgetsBackButton(),
        elevation: 0,
        iconTheme: IconThemeData(color: VmodelColors.mainColor),
      ),
      body: ProgressHUD(
          child: Builder(
        builder: (context) => Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              Padding(
                padding:
                    EdgeInsets.only(bottom: SizeConfig.screenHeight * 0.35),
                child: Column(
                  children: [
                    Center(
                        child: Text(
                      'Forgot Password',
                      style: textFieldTitleTextStyle,
                    )),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding:
                          const VWidgetsPagePadding.horizontalSymmetric(18),
                      child: VWidgetsLoginTextField(
                        hintText: "Ex. email@example.com",
                        validator: VValidatorsMixin.isEmailValid,
                        controller: controller,
                        obscureText: false,
                      ),
                    ),
                    Visibility(
                      visible: isMessageVisible,
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: SizeConfig.screenHeight * 0.036,
                            left: SizeConfig.screenWidth * 0.086,
                            right: SizeConfig.screenWidth * 0.086),
                        child: Center(
                          child: Text(
                            'If you created an account with us, we’ll send you an email containing a link to reset your password.',
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .displayMedium!
                                .copyWith(
                                  color:
                                      VmodelColors.hintColor.withOpacity(0.5),
                                ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Visibility(
                visible: buttonVisibility,
                child: VWidgetsPrimaryButton(
                  onPressed: () async {
                    HapticFeedback.lightImpact();
                    final progress = ProgressHUD.of(context);
                    if (_formKey.currentState!.validate() == false) {
                      Fluttertoast.showToast(
                          msg: "Please fill all the fields",
                          gravity: ToastGravity.TOP,
                          timeInSecForIosWeb: 1,
                          backgroundColor: VmodelColors.error.withOpacity(0.6),
                          textColor: Colors.white,
                          fontSize: 16.0);
                    } else {
                      _formKey.currentState?.save();
                      progress?.show();
                      final authNotifier = ref.read(authProvider.notifier);
                      await authNotifier.resetLink(controller.text.trim());
                      if (authNotifier.state.status ==
                          AuthStatus.authenticated) {
                        progress?.dismiss();
                        if (mounted) {
                          navigateToRoute(
                              context,
                              ResetVerificationCodePage(
                                  otp: authNotifier.state.otp.toString(),
                                  link: authNotifier.state.token.toString()));
                          // navigateToRoute(context, CreatePasswordView(link: _graphQLService.link));
                        }
                      } else {
                        progress?.dismiss();
                        Fluttertoast.showToast(
                            msg: "Email account not found",
                            gravity: ToastGravity.TOP,
                            timeInSecForIosWeb: 1,
                            backgroundColor:
                                VmodelColors.black.withOpacity(0.6),
                            textColor: Colors.white,
                            fontSize: 16.0);
                      }
                    }
                  },
                  buttonTitle: isButtonActive ? 'Confirm Email' : 'Continue',
                  buttonTitleTextStyle: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      fontFamily: VModelTypography1.primaryfontName),
                  enableButton: isButtonActive,
                  buttonHeight: SizeConfig.screenHeight * 0.05,
                  butttonWidth: SizeConfig.screenWidth * 0.87,
                ),
              ),
              addVerticalSpacing(SizeConfig.screenHeight * 0.07),
            ],
          ),
        ),
      )),
    );
  }
}
