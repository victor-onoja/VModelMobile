// ignore: file_names

import 'package:vmodel/src/features/settings/other_options/controller/settings_controller.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/vmodel.dart';

class JobTypesSettings extends StatelessWidget {
  const JobTypesSettings({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<VSettingsController>();

    return Obx(() {
      return  Padding(
          padding:
              const VWidgetsPagePadding.horizontalSymmetric(18),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                addVerticalSpacing(25),
                Text(
                  'What kind of jobs are you interested in?',
                  style: Theme.of(context).textTheme.displayLarge!.copyWith(
                              fontWeight: FontWeight.w600,
                              color: Theme.of(context).primaryColor,
                            ),
                ),
               addVerticalSpacing(6),
                Text(
                  'Select upto 4',
                  style: Theme.of(context).textTheme.displaySmall!.copyWith(
                              fontWeight: FontWeight.w500,
                              color: Theme.of(context).primaryColor,
                              fontSize: 11.sp,
                            ),
                ),
               addVerticalSpacing(10),
               SizedBox(
                height: 64.h,
                // width: 80.h,
                child: SingleChildScrollView(
                  child: Column(
                   children: [
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
                ),
               ),
                
              addVerticalSpacing(15),
              vWidgetsInitialButton(
                  controller.location.value.trim().length < 4 ? null : () {},
                  'Done',
                ),
        ]),
        
      );
    });
  }
}
