import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vmodel/src/app_locator.dart';
import 'package:vmodel/src/core/controller/app_user_controller.dart';
import '../../../core/utils/helper_functions.dart';
import '../../../core/utils/shared.dart';
import '../../../vmodel.dart';
import '../../authentication/login/provider/login_provider.dart';
import '../../authentication/login/views/auth_widget.dart';

class AnimatedLogo extends ConsumerStatefulWidget {
  const AnimatedLogo({Key? key}) : super(key: key);

  @override
  ConsumerState<AnimatedLogo> createState() => _AnimatedLogoState();
}

// class _AnimatedLogoState extends ConsumerState<AnimatedLogo> {
//   Offset logoOffset = const Offset(0, 0.2);
//   double logoRotation = -0.5;
//   double logoScale = 0.5;
//   late Animation<double> _fadeInAnimation;
//
//   Future<void> checkString() async {
//     if (globalUsername != null && GraphQlConfig.token.isNotEmpty) {
//       if (!mounted) return;
//
//       final user = ref.watch(appUserProvider);
//       print('%%%%%%%%%%%%%%%%%%%%%%%%%%%%% ${user.value?.firstName}');
//
// if(BiometricService.isEnabled) {
//   final isAuthenticated = await ref.read(loginProvider.notifier).authenticateWithBiometricsNew(context);
//
//         if(isAuthenticated) {
//           if(context.mounted) {
//             navigateToRoute(context,
//               PopupWrapper(popup: MyPopup(), child: const DashBoardView()));
//           }
//         } else {
//           VWidgetShowResponse.showToast(ResponseEnum.failed,
//               message: "Authentication failed");
//           moveAppToBackGround();
//         }
//       }
//       else {
//       navigateToRoute(context,
//           PopupWrapper(popup: MyPopup(), child: const DashBoardView()));
//       }
//
//     } else {
//       if (!mounted) return;
//       navigateToRoute(context, const OnboardingPage());
//     }
//   }
//
//
//
//
//   @override
//   void initState() {
//     // determinePosition();
//     Future.delayed(const Duration(milliseconds: 700), () {
//       setState(() {
//         logoOffset = const Offset(0, 0);
//         logoRotation = 0;
//       });
//     });
//     Future.delayed(const Duration(milliseconds: 2000), () {
//       setState(() {
//         logoScale = 1.5;
//       });
//     });
//     Future.delayed(const Duration(milliseconds: 3700), () {
//       checkString();
//     });
//     super.initState();
//   }
//
//   @override
//
//   void dispose(){
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: AnimatedSlide(
//         curve: Curves.ease,
//         offset: logoOffset,
//         duration: const Duration(milliseconds: 1500),
//         child: AnimatedRotation(
//           curve: Curves.ease,
//           turns: logoRotation,
//           duration: const Duration(milliseconds: 1500),
//           child: AnimatedScale(
//             duration: const Duration(milliseconds: 3200),
//             scale: logoScale,
//             curve: Curves.easeInCubic,
//             child: Image.asset(
//               VmodelAssets1.logo,
//               height: 216,
//               width: 216,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

class _AnimatedLogoState extends ConsumerState<AnimatedLogo>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeInAnimation;
  late Animation<double> _fadeOutAnimation;
  double logoOpacity = 0.1;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _fadeInAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.2),
      ),
    );
    _fadeOutAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.8, 1.0),
      ),
    );
    // _fadeInAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
    //   CurvedAnimation(
    //     parent: _controller,
    //     // curve: const Interval(0.0, 0.6),
    //     curve: Curves.easeIn
    //   ),
    // );

    // _fadeOutAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
    //   CurvedAnimation(
    //     parent: _controller,
    //     curve: const Interval(0.5, 1.0),
    //   ),
    // );

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.forward();
      } else if (status == AnimationStatus.dismissed) {
        _controller.forward();
      }
    });
    _controller.forward();

    Future<void> checkString() async {
      if (globalUsername != null) {
        if (!mounted) return;

        final user = ref.watch(appUserProvider);

        // if (BiometricService.isEnabled) {
        //   final isAuthenticated = await ref
        //       .read(loginProvider.notifier)
        //       .authenticateWithBiometricsNew(context);

        //   if (isAuthenticated) {
        //     if (context.mounted) {
        //       navigateToRoute(context,
        //           PopupWrapper(popup: MyPopup(), child: const DashBoardView()));
        //     }
        //   } else {
        //     VWidgetShowResponse.showToast(ResponseEnum.failed,
        //         message: "Authentication failed");
        //     moveAppToBackGround();
        //   }
        // } else {
        //   navigateToRoute(context,
        //       PopupWrapper(popup: MyPopup(), child: const DashBoardView()));
        // }
      }
      //else FeedMainUI.routeNamo{
      //   if (!mounted) return;
      //   //navigateToRoute(context, const OnboardingPage());
      //   //! testing new login screens
      //   navigateToRoute(context, const OnBoardingPage());
      // }

      if (BiometricService.isEnabled) {
        final isAuthenticated = await ref
            .read(loginProvider.notifier)
            .authenticateWithBiometricsNew(context);

        if (isAuthenticated) {
          if (context.mounted) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => const AuthWidgetPage(),
              ),
            );
          }
        } else {
          // VWidgetShowResponse.showToast(ResponseEnum.failed,
          //     message: "Authentication failed");
          moveAppToBackGround();
        }
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => const AuthWidgetPage(),
          ),
        );
      }

      // context.goNamed(FeedMainUI.routeName);
      // context.goNamed(LoginPage.name);
      // context.goNamed(GoDashBoardView.path);
    }

    Future.delayed(const Duration(milliseconds: 2000), () {
      checkString();
    });

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Opacity(
              opacity: _controller.value < 0.2
                  ? _fadeInAnimation.value
                  : _fadeOutAnimation.value,
              child: Image.asset(
                // VmodelAssets1.logo,
                VmodelAssets1.logoTransparant,
                height: 216,
                width: 216,
              ),
            );
          }),
    );
  }
}
