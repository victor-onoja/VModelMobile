import 'package:flutter_riverpod/flutter_riverpod.dart';


final themeProvider = StateProvider<bool>((ref) {
  
  return false; 
});



// final appThemeStateNotifier = ChangeNotifierProvider((ref)=>AppThemeState());

// class AppThemeState extends ChangeNotifier{
//   var isDarkModeEnabled = false;
//   void setLightTheme(){
//     isDarkModeEnabled = false;
//     notifyListeners();
//   }

//    void setDarkTheme(){
//     isDarkModeEnabled = true;
//     notifyListeners();
//   }
// }