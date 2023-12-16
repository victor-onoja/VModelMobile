import 'package:vmodel/src/features/settings/other_options/controller/settings_controller.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/shared/appbar/appbar.dart';
import 'package:vmodel/src/shared/buttons/primary_button.dart';
import 'package:vmodel/src/shared/buttons/text_button.dart';
import 'package:vmodel/src/vmodel.dart';

class JobTypesSettingPage extends StatelessWidget {
  const JobTypesSettingPage({super.key});

  @override
  Widget build(BuildContext context) {
  var controller = Get.find<VSettingsController>();
  
    return Scaffold(
      appBar: VWidgetsAppBar(
        leadingIcon: const VWidgetsBackButton(),
        appbarTitle: "Job Types",
        trailingIcon: [
          VWidgetsTextButton(
              text: "Done",
              onPressed: () {
                popSheet(context);
              },
            ),
          
        ],
      ),
      body: Padding(
        padding: const VWidgetsPagePadding.horizontalSymmetric(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            addVerticalSpacing(25),
            Expanded(
                child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:  [
                 Text(
                'What kind of jobs you interested in?',
                 style: Theme.of(context).textTheme.displayMedium!.copyWith(
                 fontWeight: FontWeight.w600,
                 color: VmodelColors.primaryColor,
                ),
                ),
                 Text(
                'Select upto 4 job types',
                 style: Theme.of(context).textTheme.displayMedium!.copyWith(
                 fontWeight: FontWeight.w500,
                 color: VmodelColors.primaryColor,
                ),
                ),
               const Divider(
              thickness: 1,
               ),
               addVerticalSpacing(6),
                    ...VSettingsController.allJobTypes
                    .map(
                      (v) => Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '$v',
                            style:  controller.selectedJobTypes.length < 4 ? Theme.of(context).textTheme.displayMedium!.copyWith(
                              fontWeight: FontWeight.w500,
                              color: Theme.of(context).primaryColor,
                            ) : Theme.of(context).textTheme.displayMedium!.copyWith(
                              fontWeight: FontWeight.w600,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                          Checkbox(
                            checkColor: Colors.white,
                            activeColor: VmodelColors.buttonColor,
                            shape: RoundedRectangleBorder(
                                side: BorderSide(
                                  color: controller.selectedJobTypes.length < 4
                                      ? VmodelColors.buttonColor
                                      : VmodelColors.borderColor,
                                ),
                                borderRadius: BorderRadius.circular(4)),
                            value: controller.selectedJobTypes.contains(v),
                            onChanged: (val) => val == true
                                ? controller.selectedJobTypes.length < 4
                                    ? controller.selectedJobTypes.add(v)
                                    : null
                                : controller.selectedJobTypes.remove(v),
                          ),
                        ],
                      ),
                    )
                    .toList(),
                ],
              ),
            )),
            addVerticalSpacing(12),
            VWidgetsPrimaryButton(
              buttonTitle: "Done",
              onPressed: () {
                popSheet(context);
              },
              enableButton: true,
            ),
            addVerticalSpacing(40),
          ],
        ),
      ),
    );
  }
}
