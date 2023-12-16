import 'package:vmodel/src/features/settings/other_options/views/account_settings/views/email_update_view.dart';
import 'package:vmodel/src/features/settings/other_options/views/account_settings/views/name_update_view.dart';
import 'package:vmodel/src/vmodel.dart';

class AccountSettignsController extends GetxController {
  var selectedPage = 'name'.obs;
  var email = ''.obs;
  var firstName = ''.obs;
  var lastName = ''.obs;
  var country = ''.obs;
  var ethnicity = ''.obs;
  var height = ''.obs;
  var weight = ''.obs;

  static Widget getCurrentPage() {
    var controller = Get.find<AccountSettignsController>();
    switch (controller.selectedPage.value) {
      case 'name':
        return const NameUpdateView();
      case 'email':
        return const EmailUpdateView();
      // case 'location':
      //   return const LocationUpdateView();
      // case 'height':
      //   return const HeightUpdateView();
      // case 'weight':
      //   return const WeightUpdateView();
      // case 'phone':
      //   return const PhoneUpdateView();
      // case 'ethnicity':
      //   return const EthnicityUpdateView();
      // case 'reviews':
      //   return const ReviewsUpdateView();

      default:
        return Container();
    }
  }
}
