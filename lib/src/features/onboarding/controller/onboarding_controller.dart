import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vmodel/src/features/authentication/register/views/upload_photo_page.dart';
import 'package:vmodel/src/features/onboarding/views/birthday_view.dart';
import 'package:vmodel/src/features/onboarding/views/business_address_view.dart';
import 'package:vmodel/src/features/onboarding/views/location_view.dart';
import 'package:vmodel/src/features/onboarding/views/phone_view.dart';
import 'package:vmodel/src/vmodel.dart';

import '../views/name_view.dart';

class OnboardingController extends GetxController {
  final String selectedIndustry;
  var email = ''.obs;
  var emailController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var pin = ''.obs;
  var name = ''.obs;
  var phone = ''.obs;
  var birthday = DateTime.now().obs;
  Rx<Uint8List?> photo = null.obs;
  var location = ''.obs;
  var streetAddress = ''.obs;
  var city = ''.obs;
  var postCode = ''.obs;
  var state = ''.obs;

  OnboardingController(this.selectedIndustry);
}

class OnboardingInteractor {
  static void onIndustrySelected(OnboardingController controller, String type) {
    // controller.selectedIndustry(type);
  }

  static void onEmailSubmitted(context) {
    var controller = Get.find<OnboardingController>();
    controller.email(controller.emailController.text);
    navigateToRoute(
        context,
        OnboardingName(
          selectedIndustry: controller.selectedIndustry,
        ));
  }

  static void onNameSubmitted(context) {
    var controller = Get.find<OnboardingController>();
    controller.name(controller.nameController.text);
    // navigateToRoute(context,  OnboardingPhone());
    // navigateToRoute(context,  OnboardingBirthday());

    if (controller.selectedIndustry == 'Business') {
      navigateToRoute(context, OnboardingPhone());
    } else {
      navigateToRoute(context, OnboardingBirthday());
    }
  }

  static void onPhoneSubmitted(context) {
    var controller = Get.find<OnboardingController>();
    print(controller.phoneController.text);

    controller.phone(controller.phoneController.text);
    navigateToRoute(context, OnboardingPhone());
  }

  static void onPinSubmitted(context) {
    var controller = Get.find<OnboardingController>();
    // controller.phone(controller.phoneController.text);
    if (controller.selectedIndustry == 'Business') {
      navigateToRoute(context, OnboardingAddress());
    } else {
      navigateToRoute(context, OnboardingBirthday());
    }
  }

  static void onBirthdaySubmitted(context) {
    navigateToRoute(context, OnboardingLocation());
  }

  static void onLocationSubmitted(context) {
    navigateToRoute(context, const SignUpUploadPhotoPage());
  }

  static void onBusinessAddressSubmitted(context) {
    navigateToRoute(context, const SignUpUploadPhotoPage());
  }

  static void uploadPhoto() async {
    Get.snackbar('Navigate to Saved', 'Navigating to Dashboard');
    var controller = Get.find<OnboardingController>();
    String photoPathTest = ' ';
    // Rx<Uint8List?> photoPath = '';
    List<int> list = 'xxx'.codeUnits;
    Uint8List bytes = Uint8List.fromList(list);
    String string = String.fromCharCodes(bytes);
    //Rx<Uint8List?> photoPath = bytes;

    final ImagePicker picker = ImagePicker();
    XFile? image = await picker.pickImage(
      source: ImageSource.gallery,
    ); // Upload file from gallery

    final bytesImage = await image!.readAsBytes();
    MemoryImage(bytesImage);
    //controller.photo(bytesImage);

    // navigateToRoute(context,  const SavedScreen());
    // navigateToRoute(context, );
  }
}
