import 'package:carousel_slider/carousel_controller.dart';
import 'package:vmodel/src/vmodel.dart';

class HomeController extends GetxController {
  RxInt imageIndex = 0.obs;
  final CarouselController imageController = CarouselController();
}
