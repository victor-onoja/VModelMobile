import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/vmodel.dart';

final spinkit = SpinKitThreeBounce(
  color: VmodelColors.white,
  size: 50.0,
);

class VLoader extends StatelessWidget {
  const VLoader({super.key});

  static void changeLoadingState(bool state) {
    if (state == true) {
      showDialog(
          context: AppNavigatorKeys.instance.navigatorKey.currentContext!,
          builder: (context) => const VLoader());
    } else {
      Navigator.pop(AppNavigatorKeys.instance.navigatorKey.currentContext!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: VmodelColors.black.withOpacity(0.2),
      body: Container(
        color: VmodelColors.black.withOpacity(0.2),
        child: Center(
          child: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: FittedBox(child: spinkit),
          ),
        ),
      ),
    );
  }
}
