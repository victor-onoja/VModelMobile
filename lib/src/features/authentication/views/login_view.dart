import 'package:vmodel/src/features/authentication/widgets/login_fields.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/vmodel.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  bool value = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Image.asset(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            VmodelAssets1.loginBackground,
            fit: BoxFit.cover,
          ),
          SafeArea(
            child: Align(
              alignment: Alignment.topCenter,
              child: Container(
                margin: const EdgeInsets.only(top: 10),
                child: Image.asset(
                  VmodelAssets1.logoFull,
                  width: MediaQuery.of(context).size.width / 2,
                ),
              ),
            ),
          ),
          const Align(
            alignment: Alignment.center,
            child:  LoginFields()),

            Align(
                alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal:10.0, vertical:25),
                child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                Text(
                  'Remember login',
                  style: Theme.of(context)
                      .textTheme
                      .displayMedium!
                      .copyWith(color: VmodelColors.white,

                        ),
                ),
                Theme(
                  data: Theme.of(context).copyWith(
                   unselectedWidgetColor: Colors.white),
                  child: Checkbox(
                    
                    shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(3)),
                    activeColor: VmodelColors.white,
                    checkColor: VmodelColors.primaryColor,
                      value: value,
                      onChanged: (bool? value) {
                        setState(() {
                        this.value = value!;
                        });
                      },
                    ),
                ),   
                       
             ],
                      ),
              ),
            )
        ],
      ),
    );
  }
}
