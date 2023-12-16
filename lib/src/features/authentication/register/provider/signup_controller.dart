

import 'package:vmodel/src/vmodel.dart';

class SignupController extends GetxController {
  var selectedIndustry = ''.obs;
  bool isBusinessAccount = false;
  bool? isSelected;


  bool get isUserSpecifiedType => selectedIndustry.contains('Other');

  void resetSelectedIndustry() {
    selectedIndustry = ''.obs;
  }
}
