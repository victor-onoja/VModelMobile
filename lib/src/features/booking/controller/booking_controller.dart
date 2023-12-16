

import 'package:vmodel/src/vmodel.dart';

class BookingTextControllers extends GetxController {
  var price = ''.obs;
  var priceController = TextEditingController();
}

class BookingController extends GetxController {
  late int _glamour = 0;
  late int _cmercial = 0;
  late int _fashion = 0;
  late int _food = 0;

  int get glamour => _glamour;
  int get cmercial => _cmercial;
  int get fashion => _fashion;
  int get food => _food;

  void increaseGlamour() {
    _glamour++;
    update();
  }

  void decreaseGlamour() {
    _glamour--;
    update();
  }

  ////////////////////////////////////////////////////////////////
  void increaseCmercial() {
    _cmercial++;
    update();
  }

  void decreaseCmercial() {
    _cmercial--;
    update();
  }

  void increaseFashion() {
    _fashion++;
    update();
  }

  void decreaseFashion() {
    _fashion--;
    update();
  }

////////////////////////////////////////////////////////////////
  void increaseFood() {
    _food++;
    update();
  }

  void decreaseFood() {
    _food--;
    update();
  }
}
