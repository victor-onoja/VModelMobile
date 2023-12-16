import 'package:vmodel/src/features/settings/other_options/controller/settings_controller.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/vmodel.dart';

class VSettingsBase extends StatelessWidget {
  final String currentPage;
  const VSettingsBase({super.key, this.currentPage = 'bio'});

  @override
  Widget build(BuildContext context) {
    Get.find<VSettingsController>().selectedPage(currentPage);
    return Obx(() {
      var controller = Get.find<VSettingsController>();
      return Scaffold(
        backgroundColor: VmodelColors.background,
        appBar: AppBar(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.zero,
              side: BorderSide(color: Colors.grey[200]!)),
          elevation: 0,
          toolbarHeight: 100,
          backgroundColor: VmodelColors.background,
          leading: const VWidgetsBackButton(),
          title: Text(
            VSettingsController.pageTitles[controller.selectedPage.value] ??
                'Default',
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
            ),
          ],
        ),
        body: VSettingsController.getCurrentPage(),
      );
    });
  }
}
