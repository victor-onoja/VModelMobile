import 'package:get/get.dart';

class PopupController extends GetxController {
  RxBool isPopupVisible = false.obs;

  void togglePopup() {
    isPopupVisible.value = !isPopupVisible.value;
  }
}
