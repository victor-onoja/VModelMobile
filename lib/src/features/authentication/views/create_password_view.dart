import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:vmodel/src/core/utils/validators_mixins.dart';
import 'package:vmodel/src/features/authentication/login/views/sign_in.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/shared/buttons/primary_button.dart';
import 'package:vmodel/src/shared/text_fields/signup_text_field.dart';
import 'package:vmodel/src/vmodel.dart';

import '../../../core/api/graphql_service.dart';

class CreatePasswordView extends ConsumerStatefulWidget with VValidatorsMixin {
  final String? link;
  CreatePasswordView({Key? key, this.link}) : super(key: key);

  @override
  ConsumerState<CreatePasswordView> createState() => CreatePasswordViewState();
}

class CreatePasswordViewState extends ConsumerState<CreatePasswordView> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool buttonVisibility = true;

  // bool isMessageVisible = false;
  // It works in reverse of buttonVisiblity.
  // final GraphQlService _graphQLService = GraphQlService();
  //
  late String screenMessage;
  // default message
  bool isButtonActive = false;
  late TextEditingController controller1;
  late TextEditingController controller2;

  @override
  void initState() {
    super.initState();

    controller1 = TextEditingController();
    controller2 = TextEditingController();
    screenMessage =
        'Password must contain at least 8 characters, including one uppercase letter and one special character. ';
    // controller1.addListener(() {
    //   if (controller1.text.length >= 8 &&
    //       controller1.text.contains(RegExp(r'[A-Z]')) &&
    //       controller1.text.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
    //     controller2.addListener(() {
    //       if (controller1.text == controller2.text) {
    //         final isButtonActive = controller1.text.isNotEmpty;
    //         setState(() {
    //           this.isButtonActive = isButtonActive;
    //         });
    //       } else {
    //         setState(() {
    //           screenMessage = 'Passwords do not match, please try again.';
    //         });
    //       }
    //     });
    //   }
    // });
  }

  @override
  void dispose() {
    controller1.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: VmodelColors.background,
      appBar: AppBar(
        leading: const VWidgetsBackButton(),
        backgroundColor: VmodelColors.background,
        elevation: 0,
        iconTheme: IconThemeData(color: VmodelColors.mainColor),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          Padding(
            padding: EdgeInsets.only(bottom: SizeConfig.screenHeight * 0.35),
            child: Column(
              children: [
                Center(
                    child: Text(
                  'Create a new password',
                  style: textFieldTitleTextStyle,
                )),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.symmetric(horizontal: 25),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        VWidgetsSignUpTextField(
                          onSaved: (String? value) {},
                          hintText: '',
                          controller: controller1,
                          obscureText: true,
                        ),
                        addVerticalSpacing(SizeConfig.screenHeight * 0.028),
                        VWidgetsSignUpTextField(
                          onSaved: (String? value) {},
                          hintText: '',
                          controller: controller2,
                          obscureText: true,
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: SizeConfig.screenHeight * 0.036,
                  ),
                  child: Center(
                    child: SizedBox(
                      height: SizeConfig.screenHeight * 0.04,
                      width: SizeConfig.screenWidth * 0.83,
                      child: Stack(
                        alignment: AlignmentDirectional.center,
                        children: [
                          Text(
                            screenMessage,
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .displayMedium!
                                .copyWith(
                                  color:
                                      VmodelColors.hintColor.withOpacity(0.5),
                                ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          //const Spacer(),
          VWidgetsPrimaryButton(
            onPressed: () async {
              // final progress = ProgressHUD.of(context);
              if (controller1.text.trim() == controller2.text.trim()) {
                final authNotifier = ref.read(authProvider.notifier);
                await authNotifier.resetPassword(
                    token: widget.link.toString(),
                    newPassword1: controller1.text.trim(),
                    newPassword2: controller2.text.trim());
                // await _graphQLService.resetPassword(
                //     token: widget.link.toString(),
                //     newPassword1: controller1.text.trim(),
                //     newPassword2: controller2.text.trim());
                // setState(() {
                //   buttonVisibility = false;
                //   screenMessage = 'Password changed.';
                // // });
                Future.delayed(const Duration(milliseconds: 500), () {
                  navigateAndRemoveUntilRoute(context, LoginPage());
                });
              } else {
                Fluttertoast.showToast(
                    msg: "Please make sure both passwords are the same",
                    gravity: ToastGravity.TOP,
                    timeInSecForIosWeb: 1,
                    backgroundColor: VmodelColors.error.withOpacity(0.6),
                    textColor: Colors.white,
                    fontSize: 16.0);
              }
            },
            buttonTitle: 'Confirm Password',
            buttonTitleTextStyle: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 16,
                fontFamily: VModelTypography1.primaryfontName),
            enableButton: true,
            buttonHeight: SizeConfig.screenHeight * 0.05,
            butttonWidth: SizeConfig.screenWidth * 0.87,
          ),
          addVerticalSpacing(SizeConfig.screenHeight * 0.07),
        ],
      ),
    );
  }
}
