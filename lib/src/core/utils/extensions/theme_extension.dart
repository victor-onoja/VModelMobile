import 'package:vmodel/src/vmodel.dart';

extension ThemeExtension on BuildContext {
  ThemeData get appTheme => Theme.of(this);
  TextTheme get appTextTheme => appTheme.textTheme;
}

extension SnackBarExtension on BuildContext {
  void showSnackbar(String message) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(content: Text('$message')),
    );
  }
}
