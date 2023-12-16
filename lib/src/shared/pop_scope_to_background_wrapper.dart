import '../vmodel.dart';

class PopToBackgroundWrapper extends StatelessWidget {
  const PopToBackgroundWrapper({Key? key, required this.child})
      : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        moveAppToBackGround();
        return false;
      },
      child: child,
    );
  }
}
