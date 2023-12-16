import 'package:vmodel/src/features/authentication/views/new_login_screens/sign_up.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/vmodel.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  Widget logoAsset = Image.asset(
    VmodelAssets1.logo,
    height: 216,
    width: 216,
  );
  Widget logoFullAsset = Image.asset(
    VmodelAssets1.logoFull,
    height: 64,
  );

  CrossFadeState _crossFadeState = CrossFadeState.showFirst;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _crossFadeState = CrossFadeState.showSecond;
      });
    });
    Future.delayed(const Duration(seconds: 3), () {
      navigateToRoute(context, const SignUpPage());
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      body: SafeArea(
        child: Stack(children: [
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: AnimatedCrossFade(
                crossFadeState: _crossFadeState,
                duration: const Duration(milliseconds: 500),
                firstChild: logoAsset,
                secondChild: logoFullAsset,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: const EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3),
                border: Border.all(color: VmodelColors.mainColor),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                child: Text(
                  'BETA',
                  style: TextStyle(color: VmodelColors.mainColor),
                ),
              ),
            ),
          )
        ]),
      ),
    );
  }
}
