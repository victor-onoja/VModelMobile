import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/utils/enum/auth_enum.dart';
import '../../../../vmodel.dart';
import '../../../dashboard/dash/dashboard_ui.dart';
import '../../controller/auth_status_provider.dart';
import '../../new_Login_screens/login_screen.dart';
import '../../register/views/location_set_up.dart';

class GoAuthWidgetPage extends ConsumerStatefulWidget {
  const GoAuthWidgetPage({super.key});

  static const path = "goAuthWidget";
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _GoAuthWidgetPageState();
}

class _GoAuthWidgetPageState extends ConsumerState<GoAuthWidgetPage> {
  @override
  Widget build(BuildContext context) {
    ref.watch(invalidateStaleDataProvider);

    // ref.watch(loginProvider);

    ref.listen(authenticationStatusProvider, ((previous, next) {
      print('[lol] $next');
    }));

    final tto = ref.watch(authenticationStatusProvider);

    return tto.maybeWhen(
      data: (status) {
        switch (status) {
          case AuthStatus.authenticated:
            // ref
            //     .read(authenticationStatusProvider.notifier)
            //     .invalidateStaleUserData();
            return const DashBoardView();
          // context.go(DashBoardView.path);
          case AuthStatus.firstLogin:
            //User provide some basic setup details flow
            return const SignUpLocationViews();
          // Navigator.of(context).pushReplacement(const SignUpLocationViews());
          // case AuthStatus.verify2fa:
          //   //User provide some basic setup details flow
          //   return const Verify2FAOtp();
          default:
            //User can sign up or sign in
            return const OnBoardingPage();
        }
      },
      //User can sign up or sign in
      orElse: () => const OnBoardingPage(),
    );
  }
}
