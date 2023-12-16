import 'package:vmodel/src/features/settings/other_options/controller/account_settings_controller.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/vmodel.dart';

class AccountBase extends StatelessWidget {
  final String currentPage;
  const AccountBase({super.key, this.currentPage = 'bio'});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AccountSettignsController>();
    controller.selectedPage(currentPage);
    return Obx(() {
      return Scaffold(
        backgroundColor: VmodelColors.background,
        appBar: AppBar(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.zero,
              side: BorderSide(color: Colors.grey[200]!)),
          elevation: 0,
          toolbarHeight: 80,
          backgroundColor: VmodelColors.background,
          leading: const VWidgetsBackButton(),
          title: Text(
            currentPage[0].toUpperCase() + currentPage.substring(1),
            style: VModelTypography1.pageTitleTextStyle
                .copyWith(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: TextButton(
                onPressed: () {},
                child: Text(
                  'Done',
                  style: VModelTypography1.pageTitleTextStyle
                      .copyWith(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
            )
          ],
        ),
        body: AccountSettignsController.getCurrentPage(),
      );
    });
  }
}
