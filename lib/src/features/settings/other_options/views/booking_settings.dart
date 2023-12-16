
import 'package:flutter/cupertino.dart';
import 'package:vmodel/src/features/settings/other_options/controller/settings_controller.dart';
import 'package:vmodel/src/features/settings/other_options/views/jobTypes.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/shared/text_fields/counting_textfield.dart';
import 'package:vmodel/src/vmodel.dart';

class BookingSettingsOptions extends StatelessWidget {
  const BookingSettingsOptions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    VSettingsController controller = Get.find<VSettingsController>();
    return Scaffold(
      body: CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          backgroundColor: Colors.white,
          trailing: Text(
            "Done",
            style: TextStyle(
                fontWeight: FontWeight.w700,
                fontFamily: "AvenirNext",
                color: VmodelColors.buttonColor,
                fontSize: 16),
          ),
          // leading: BackButton(
          //   color: VmodelColors.buttonColor,
          // ),
          middle: Text(
            "Prices",
            style: TextStyle(
                fontSize: 16,
                fontFamily: "AvenirNext",
                fontWeight: FontWeight.w700,
                color: VmodelColors.buttonColor),
          ),
        ),
        child: Column(
          children: [
            
            SizedBox(
              height: 80.h,
              child: ListView(
                padding: const VWidgetsPagePadding.horizontalSymmetric(18),
                children: [
                  addVerticalSpacing(25),
                  GetBuilder<VSettingsController>(builder: (context) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Glamour",
                                    style: TextStyle(
                                        fontFamily: "Avenir",
                                        fontWeight: FontWeight.w600,
                                        fontSize: 11.5.sp)
                                        ),
                            addHorizontalSpacing(15),
                             VWidgetsCountingTextField(
                                  boxWidth: 40.w,
                                  hintText: controller.glamour.toString(),
                                  onTapMinus: (){ controller.decreaseGlamour();}, 
                                  onTapPlus: (){ controller.increaseGlamour();}),
                              
                            ],
                          ),
                           addVerticalSpacing(20),
                           Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Commercial",
                               style: TextStyle(
                                        fontFamily: "Avenir",
                                        fontWeight: FontWeight.w600,
                                        fontSize: 11.5.sp)
                                        ),
                            addHorizontalSpacing(15),
                              VWidgetsCountingTextField(
                                  boxWidth: 40.w,
                                  hintText:  controller.cmercial.toString(),
                                  onTapMinus: (){controller.decreaseCmercial();}, 
                                  onTapPlus: (){controller.increaseCmercial();}),
                              
                            ],
                          ),
                           addVerticalSpacing(20),
                           Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                             Text("Fashion",
                                    style: TextStyle(
                                        fontFamily: "Avenir",
                                        fontWeight: FontWeight.w600,
                                        fontSize: 11.5.sp)
                                        ),
                            addHorizontalSpacing(15),
                            VWidgetsCountingTextField(
                                  boxWidth: 40.w,
                                  hintText: controller.fashion.toString(),
                                  onTapMinus: (){controller.decreaseFashion();}, 
                                  onTapPlus: (){controller.increaseFashion();}),
                              
                            ],
                          ),
                           addVerticalSpacing(20),
                           Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Food",
                                    style: TextStyle(
                                        fontFamily: "Avenir",
                                        fontWeight: FontWeight.w600,
                                        fontSize: 11.5.sp)
                                        ),
                            addHorizontalSpacing(15),
                              VWidgetsCountingTextField(
                                  boxWidth: 40.w,
                                  hintText: controller.food.toString(),
                                  onTapMinus: (){controller.decreaseFood();}, 
                                  onTapPlus: (){controller.increaseFood();}, 
                                  ),
                              
                            ],
                          ),
                           addVerticalSpacing(20),
                        ],
                      );
                    }),
                  
               
                
                ],
              ),
            ),
            addVerticalSpacing(15),
            vWidgetsInitialButton(() {}, "Done"),
          ],
        ),
      ),
    );
  }
}

class BookingSettings extends StatelessWidget {
  const BookingSettings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(

      child: Column(
        children: [
          SizedBox(
            height: 74.h,
            child: ListView(
              children: [
        addVerticalSpacing(10),
        ListTile(
                        onTap: () {
                          navigateToRoute(context, const JobTypesSettings());
                        },
                        leading: Text(
                          "Job Prices",
                           style: Theme.of(context).textTheme.displayMedium!.copyWith(
                              fontWeight: FontWeight.w600,
                              color: Theme.of(context).primaryColor,
                            ),
                        ),
                       trailing: const Icon(Icons.arrow_forward_ios_rounded,
                        size: 20,
                        color: VmodelColors.primaryColor,)),
                    ListTile(
                        onTap: () {
                          navigateToRoute(context, const BookingSettingsOptions());
                        },
                        leading: Text(
                          "Prices",
                           style: Theme.of(context).textTheme.displayMedium!.copyWith(
                              fontWeight: FontWeight.w600,
                              color: Theme.of(context).primaryColor,
                            ),
                        ),
                       trailing: const Icon(Icons.arrow_forward_ios_rounded,
                        size: 20,
                        color: VmodelColors.primaryColor,)),
                    ListTile(
                        onTap: () {},
                        leading: Text(
                          "Availability",
                              style: Theme.of(context).textTheme.displayMedium!.copyWith(
                              fontWeight: FontWeight.w600,
                              color: Theme.of(context).primaryColor,
                            ),
                        ),
                        trailing: const Icon(Icons.arrow_forward_ios_rounded,
                        size: 20,
                       color: VmodelColors.primaryColor,)),
                 
               
              ],
            ),
          ),
          addVerticalSpacing(10),
          vWidgetsInitialButton(() {}, "Done"),
                
        ],
      ),
    );
  }
}
