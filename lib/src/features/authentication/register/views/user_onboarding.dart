import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vmodel/src/shared/pop_scope_to_background_wrapper.dart';
import 'package:vmodel/src/features/authentication/login/views/sign_in.dart';
import 'package:vmodel/src/features/authentication/register/views/sign_up.dart';
import 'package:vmodel/src/vmodel.dart';
import '../../../../res/res.dart';

String signUpUserType = "";
String? signUpErrorMessage;
Map? errorList = {};

class OldOnboardingPage extends ConsumerStatefulWidget {
  const OldOnboardingPage({super.key});

  @override
  ConsumerState<OldOnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends ConsumerState<OldOnboardingPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  final businessList = [
    'Business',
    'Creative director',
    'Producer',
    'Booker',
  ];

  final talentList = [
    'Model',
    'Influencer',
    'Creator',
    'Photographer',
    'Virtual influencer',
    'Pet model',
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 12),
      vsync: this,
    )..repeat(reverse: true); // Set the animation to repeat in reverse.

    _animation = Tween<double>(
      begin: -0.1,
      end: 0.1,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.linear, // Change the animation curve to linear
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopToBackgroundWrapper(
      child: Scaffold(
        body: SafeArea(
          child: Container(
            child: Center(
              // Center is a layout widget. It takes a single child and positions it
              // in the middle of the parent.
              child: Stack(alignment: Alignment.center, children: <Widget>[
                SizedBox(
                  height: 892,
                  child: AnimatedBuilder(
                    animation: _animationController,
                    builder: (context, child) {
                      return FittedBox(
                        fit: BoxFit.cover,
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 1.2,
                          child: Transform.translate(
                            offset: Offset(
                              MediaQuery.of(context).size.width *
                                  _animation.value,
                              0.0,
                            ),
                            child: Image.asset(
                              'assets/images/backgrounds/onboarding_bg.jpg',
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Positioned(
                  top: MediaQuery.of(context).size.height - 785,
                  left: MediaQuery.of(context).size.width - 117,
                  width: 50,
                  height: 50,
                  child: Container(
                    alignment: Alignment.centerRight,
                    child: Container(
                        width: 50.00,
                        height: 50.00,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: ExactAssetImage('assets/images/camera.png'),
                            fit: BoxFit.fitHeight,
                          ),
                        )),
                  ),
                ),
                Positioned(
                  top: MediaQuery.of(context).size.height - 697,
                  // top: 10.h,
                  width: 250,
                  child: Container(
                    alignment: Alignment.center,
                    child: const Column(
                      children: [
                        Text(
                          'WELCOME TO VMODEL',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text('Select your account type',
                            style: TextStyle(
                                color: Color.fromRGBO(80, 60, 59, 1),
                                fontSize: 16,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  // top: MediaQuery.of(context).size.height - 245,
                  top: 70.h,
                  width: 84.w,
                  child: Container(
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                                child: _getOption('Brand', businessList,
                                    selectedBusiness: true)),
                            const SizedBox(width: 32),
                            Expanded(child: _getOption('Talent', talentList)),
                            // GestureDetector(
                            //   onTap: () {
                            //     // ref
                            //     //     .read(selectedGeneralUserAccountTypeProvider
                            //     //         .notifier)
                            //     //     .state = GeneralUserAccountType.talent;
                            //     navigateToRoute(context, const SignUpPage());
                            //   },
                            //   child: Container(
                            //     decoration: BoxDecoration(
                            //       borderRadius: BorderRadius.circular(4),
                            //       color: const Color.fromRGBO(80, 60, 59, 1),
                            //     ),
                            //     height: 144,
                            //     width: 118,
                            //     child: Column(
                            //       children: [
                            //         const SizedBox(
                            //           height: 18,
                            //         ),
                            //         const Text(
                            //           'Talent',
                            //           style: TextStyle(
                            //               color: Colors.white,
                            //               fontWeight: FontWeight.w700),
                            //         ),
                            //         const SizedBox(
                            //           height: 25,
                            //         ),
                            //         SizedBox(
                            //           width: 99,
                            //           height: 64,
                            //           child: Column(
                            //             children: const [
                            //               Text('Model',
                            //                   style: TextStyle(
                            //                       color: Colors.white,
                            //                       fontSize: 12)),
                            //               Text('Influencer',
                            //                   style: TextStyle(
                            //                       color: Colors.white,
                            //                       fontSize: 12)),
                            //               Text('Creator',
                            //                   style: TextStyle(
                            //                       color: Colors.white,
                            //                       fontSize: 12)),
                            //               Text('Photographer',
                            //                   style: TextStyle(
                            //                       color: Colors.white,
                            //                       fontSize: 12))
                            //             ],
                            //           ),
                            //         )
                            //       ],
                            //     ),
                            //   ),
                            // )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: MediaQuery.of(context).size.height - 75,
                  right: 12,
                  child: TextButton(
                    style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: const Size(50, 30),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        alignment: Alignment.centerLeft),
                    child: const Row(
                      children: [
                        Text(
                          "Already registered? ",
                          style: TextStyle(
                              color: Color.fromRGBO(255, 255, 255, 1),
                              fontWeight: FontWeight.w600),
                        ),
                        Text(
                          "Login",
                          style: TextStyle(
                              color: Color.fromRGBO(255, 255, 255, 1),
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    onPressed: () async {
                      navigateToRoute(context, LoginPage());
                    },
                  ),
                )
              ]),
            ),
          ),
        ),
      ),
    );
  }

  Widget _getOption(String title, List<String> cardOptions,
      {bool selectedBusiness = false}) {
    return GestureDetector(
      onTap: () {
        // selectedGeneralUserAccountTypeState.
        navigateToRoute(context, const SignUpPage());
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: const Color.fromRGBO(80, 60, 59, 1),
        ),
        height: 15.h,
        // width: 28,
        child: Column(
          children: [
            const SizedBox(
              height: 18,
            ),
            Text(
              title,
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 25),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(bottom: 4),
                child: SizedBox(
                  width: double.maxFinite,
                  child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: List.generate(
                        cardOptions.length,
                        (index) => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            cardOptions[index],
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: VmodelColors.white,
                            ),
                          ),
                        ),
                      ).toList()),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
