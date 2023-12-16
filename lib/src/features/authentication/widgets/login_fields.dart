import 'package:vmodel/src/features/authentication/controller/password_interactors.dart';
import 'package:vmodel/src/features/authentication/views/new_login_screens/sign_up.dart';
import 'package:vmodel/src/features/dashboard/dash/dashboard_ui.dart';
import 'package:vmodel/src/vmodel.dart';
import 'package:vmodel/src/res/res.dart';

class LoginFields extends StatelessWidget {
  const LoginFields({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Material(
          elevation: 20,
          borderRadius: BorderRadius.circular(20),
          shadowColor: Colors.black,
          clipBehavior: Clip.antiAlias,
          child: Container(
            decoration: BoxDecoration(color: VmodelColors.background),
            width: MediaQuery.of(context).size.width * 0.8,
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              const TextField(
                decoration: InputDecoration(prefixIcon: Icon(Icons.person)),
              ),
              const TextField(
                obscureText: true,
                decoration: InputDecoration(prefixIcon: Icon(Icons.lock)),
              ),
              Container(
                decoration: BoxDecoration(
                    color: VmodelColors.mainColor,
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20)),
                    border: Border.all(color: VmodelColors.background)),
                child: Container(
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                    begin: Alignment.bottomRight,
                    end: Alignment.topLeft,
                    colors: [
                      Color(0x55F77474),
                      Color(0x55503C3B),
                    ],
                  )),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          // LoginInteractor.onSignupClicked(context);
                          navigateToRoute(context, const SignUpPage());
                        },
                        child: Container(
                          color: Colors.transparent,
                          child: Text(
                            'Sign up',
                            style: Theme.of(context)
                                .textTheme
                                .displayMedium!
                                .copyWith(color: VmodelColors.white),
                          ),
                        ),
                      ),
                      TextButton(
                        child: Text(
                          'Sign in',
                          style: Theme.of(context)
                              .textTheme
                              .displayMedium!
                              .copyWith(color: VmodelColors.white),
                        ),
                        onPressed: () {
                          navigateToRoute(context, const DashBoardView());
                        },
                      ),
                    ],
                  ),
                ),
              )
            ]),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: TextButton(
            onPressed: () {
              PasswordInteractor.onForgotPasswordClicked(context);
            },
            child: Text(
              'Forgot password?',
              style: TextStyle(color: VmodelColors.background),
            ),
          ),
        ),
      ],
    );
  }
}
