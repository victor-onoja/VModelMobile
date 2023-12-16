import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vmodel/src/features/settings/other_options/views/account_settings/views/account_settings.dart';
import 'package:vmodel/src/features/settings/other_options/views/alert_settings.dart';
import 'package:vmodel/src/features/settings/other_options/views/await_design.dart';
import 'package:vmodel/src/features/settings/other_options/views/bio_screen.dart';
import 'package:vmodel/src/features/settings/other_options/views/booking_settings.dart';
import 'package:vmodel/src/features/settings/other_options/views/gender_screen.dart';
import 'package:vmodel/src/features/settings/other_options/views/interaction_settings.dart';
import 'package:vmodel/src/features/settings/other_options/views/location_screen.dart';
import 'package:vmodel/src/features/settings/other_options/views/nickname_settings.dart';
import 'package:vmodel/src/features/settings/other_options/views/profile_settings.dart';

import '../views/jobTypes.dart';

class VSettingsController extends GetxController {
  var selectedPage = 'bio'.obs;

  static Map pageTitles = {
    'bio': 'Bio',
    'location': 'Location',
    'jobTypes': 'Job Types',
    'profile': 'Profile',
    'verification': 'Verification',
    'gender': 'Gender',
    'nickname': 'Nickname',
    'interaction': 'Interaction Settings',
    'booking': 'Booking Settings',
    'alert': 'Alert Settings',
    'account': 'Account Settings',
  };

  var bio = ''.obs;
  var location = ''.obs;
  var gender = 'male'.obs;

  var identifyAs = 'Non-binary'.obs;
  var representingAPet = false.obs;

  static List<String> indentifyTypes = [
    'Male',
    'Female',
    'I\'m a Pet',
    'Androgyne',
    'Bigender',
    'Butch',
    'Cisgender',
    'Gender Expansive',
    'Gender Fluid',
    'Gender Outlaw',
    'Gender Queer',
    'Masculine of center',
    'Non-binary',
    'Omnigender',
    'Polygender and Pangender',
    'Transgender',
    'Trans',
    'Two Spirit'
  ];
  static List allJobTypes = [
    'Commercial',
    'Glamour',
    'BodyParts',
    'Lingerie and Swimsuit',
    'Face',
    'Fitness',
    'Fashion',
    'Runway',
    'Food',
    'Promotional',
    'Print',
    '3D',
  ];

  var selectedJobTypes = <String>[].obs;

  var nickname = ''.obs;

  static List<String> whoCanType = [
    'Anyone I\'ve worked with',
    'Brands and Photographers',
    'Photographers',
    'Anyone',
    'No one'
  ];
  static List<String> whoCanPolaroid = whoCanType.sublist(1);

  var whoCanMessageMe = 'Anyone I\'ve worked with'.obs;
  var whoCanFeatureMe = 'Anyone I\'ve worked with'.obs;
  var whoCanBookMe = 'Anyone I\'ve worked with'.obs;
  var whoCanPolaroidSee = 'Anyone'.obs;

  RxBool alertBooking = false.obs;
  RxBool alertFeature = false.obs;

  RxBool alertLike = false.obs;
  RxBool alertJobMatch = false.obs;
  RxBool alertOffer = false.obs;
  RxBool alertProfile =false.obs;

  static Widget getCurrentPage() {
    var controller = Get.find<VSettingsController>();
    switch (controller.selectedPage.value) {
      case 'bio':
        return const BioScreen();

      case 'location':
        return const LocationScreen();
      case 'verification':
        return const AwaitDesignScreen();
      case 'account':
        return const AccountSettings();
      case 'gender':
        return const GenderScreen();
      case 'interaction':
        return const InteractionSettings();
      case 'alert':
        return const AlertSettings();
      case 'nickname':
        return const NickNameSettings();
      case 'booking':
        return const BookingSettings();
      case 'jobTypes':
        return const JobTypesSettings();
      case 'profile':
        return const ProfileSettings();
      default:
        return Container();
    }
  }

// Fanterlino's Snippet
  late int _glamour = 0;

  late int _commercial = 0;
  late int _fashion = 0;
  late int _food = 0;

  int get glamour => _glamour;
  int get cmercial => _commercial;
  int get fashion => _fashion;
  int get food => _food;

  void increaseGlamour() {
    _glamour += 25;
    update();
  }

  void decreaseGlamour() {
    if (_glamour > 0) {
      _glamour -= 25;
      update();
    }
  }

  ////////////////////////////////////////////////////////////////
  void increaseCmercial() {
    _commercial += 25;
    update();
  }

  void decreaseCmercial() {
    if (_commercial > 0) {
      _commercial -= 25;
      update();
    }
  }

  void increaseFashion() {
    _fashion += 25;
    update();
  }

  void decreaseFashion() {
    if (_fashion > 0) {
      _fashion -= 25;
      update();
    }
  }

////////////////////////////////////////////////////////////////
  void increaseFood() {
    _food += 25;
    update();
  }

  void decreaseFood() {
    if (_food > 0) {
      _food -= 25;
      update();
    }
  }
}
