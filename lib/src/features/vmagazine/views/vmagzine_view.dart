import 'dart:ui';

import 'package:flutter/services.dart';
import 'package:vmodel/src/features/vmagazine/views/vmagazine_body.dart';
// import 'package:vmodel/src/features/vmagazine/views/vMagazine_body.dart';
import 'package:vmodel/src/res/icons.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/shared/appbar/appbar.dart';
import 'package:vmodel/src/shared/rend_paint/render_svg.dart';
import 'package:vmodel/src/vmodel.dart';

class VMagazineView extends StatefulWidget {
  const VMagazineView({Key? key}) : super(key: key);




  @override
  State<VMagazineView> createState() => _VMagazineViewState();
}

class _VMagazineViewState extends State<VMagazineView> {

  var check = false;
  Future <void> reloadData() async{}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor:
            check == false ? const Color(0xFFFFFFFF) : const Color(0xFF191919),
        appBar: VWidgetsAppBar(
          appBarHeight: 50,
          leadingIcon: VWidgetsBackButton(
              buttonColor: check == true
                  ? VmodelColors.white
                  : Theme.of(context).primaryColor,
            ),
          
          appbarTitle: "Vell Magazine",
          style: VModelTypography1.normalTextStyle.copyWith(
            color: check == true
                ? VmodelColors.white
                : Theme.of(context).primaryColor,
            fontWeight: FontWeight.w600,
            fontSize: 13.sp,
          ),


          backgroundColor: check == false
              ? const Color(0xFFFFFFFF)
              : const Color(0xFF191919),
          trailingIcon: [
             RenderSvgWithoutColor(
                svgPath: check == false
                    ? VIcons.magazineSettingsLightMode
                    : VIcons.magazineSettingsDarktMode,
                svgWidth: 20,
                svgHeight: 18,
              ),
            
            addHorizontalSpacing(15),
             GestureDetector(
                onTap: () {
                  setState(() {
                    check = !check;
                  });
                },
                child: RenderSvg(
                  svgPath: check == false
                      ? VIcons.magazineMoonLIght
                      : VIcons.magazineMoodDarkMode,
                  color: check == true
                      ? const Color(0xFFFFFFFF)
                      : const Color(0xFF191919),
                  svgWidth: 20,
                  svgHeight: 18,
                ),
              ),
            
            addHorizontalSpacing(15),
            // Padding(
            //   padding: const EdgeInsets.only(top: 12),
            //   child: GestureDetector(
            //     onTap: () {
            //       navigateToRoute(context, NotificationsView());
            //     },
            //     child: RenderSvg(
            //       svgPath: check == false
            //           ? VIcons.magazineBellLight
            //           : VIcons.magazinebellDark,
            //       color: check == true
            //           ? const Color(0xFFFFFFFF)
            //           : const Color(0xFF191919),
            //       svgWidth: 20,
            //       svgHeight: 18,
            //     ),
            //   ),
            // ),
            // addHorizontalSpacing(15),
          ],
        ),
        body: RefreshIndicator.adaptive(
          onRefresh: (){
            HapticFeedback.lightImpact();
            return reloadData();
          },
          child: SizedBox(
              child: Stack(
            children: [
              VMagazineBody(
                check: check,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ClipRect(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 40.0),
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.095,
                        color: check == false
                            ? Colors.white.withOpacity(0.5)
                            : Colors.black.withOpacity(0.5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            RenderSvg(
                              svgPath: check == false
                                  ? VIcons.magazineBottomNavHeartDarkMode
                                  : VIcons.magazineBottomNavHeartDarkMode,
                              color: check == true
                                  ? const Color(0xFFFFFFFF)
                                  : const Color(0xFF191919),
                              svgHeight: 28,
                              svgWidth: 28,
                            ),
                            RenderSvgWithoutColor(
                              svgPath: check == false
                                  ? VIcons.vLogoIconLightMode
                                  : VIcons.vModelLogoDarkMode,
                              svgHeight: 40,
                              // color: iconColor,
                              svgWidth: 35,
                            ),


                           GestureDetector(
                             onTap:(){
                              //  navigateToRoute(context, const ProfileMainView(
                              //      profileTypeEnumConstructor:
                              //      ProfileTypeEnum.personal));
                             },
                             child:  Container(
                               width: 30,
                               height: 30,
                               decoration: BoxDecoration(
                                 shape: BoxShape.circle,
                                 border: Border.all(
                                   width: 1.5,
                                   color: check == false
                                       ? VmodelColors.ligtenedText
                                       : Colors.white,
                                 ),
                                 image: const DecorationImage(
                                   image: AssetImage(
                                       "assets/images/photographers/photographer_2.png"),
                                   fit: BoxFit.cover,
                                 ),
                               ),
                             ),
                           )

                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          )),
        ));
  }
}
