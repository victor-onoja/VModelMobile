import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:qr_flutter/qr_flutter.dart';
import 'package:screenshot/screenshot.dart';
import 'package:vmodel/src/core/controller/app_user_controller.dart';
import 'package:vmodel/src/core/models/app_user.dart';
import 'package:vmodel/src/core/utils/share.dart';
import 'package:vmodel/src/features/dashboard/new_profile/profile_features/widgets/profile_picture_widget.dart';
import 'package:vmodel/src/res/gap.dart';
import 'package:vmodel/src/shared/popup_dialogs/response_dialogue.dart';

import '../../../core/utils/shared.dart';
import '../../../res/icons.dart';
import '../../../res/res.dart';
import '../../../shared/appbar/appbar.dart';
import '../../../shared/buttons/primary_button.dart';
import '../../../shared/rend_paint/render_svg.dart';
import '../controllers/qr_colors_controller.dart';
import '../widgets/qr_color_dialog.dart';

class ReferAndEarnQrPage extends ConsumerStatefulWidget {
  const ReferAndEarnQrPage({super.key});
  static const routeName = 'QR-gen';

  @override
  ConsumerState<ReferAndEarnQrPage> createState() => _ReferAndEarnQrPageState();
}

class _ReferAndEarnQrPageState extends ConsumerState<ReferAndEarnQrPage> {
  VAppUser? currentUser;
  VUtilsShare? share;
  final screenshotController = ScreenshotController();
  bool showSavingLoader = false;
  final socialAppNames = ['X', 'Facebook', 'Whatsapp'];
  @override
  void initState() {
    super.initState();
    // isCurrentUser =
    //     ref.read(appUserProvider.notifier).isCurrentUser(widget.username);
    currentUser = ref.read(appUserProvider).valueOrNull;
  }

  @override
  Widget build(BuildContext context) {
    final userState = ref.watch(appUserProvider);
    final user = userState.valueOrNull;
    final pageColors = ref.watch(qrPageColorsProvider);

    LinearGradient myGradient = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [pageColors.page.begin, pageColors.page.end],
      stops: [0.0, 1.0],
    );

    return Scaffold(
        appBar: VWidgetsAppBar(
          backgroundColor: pageColors.page.begin,
          leadingIcon: VWidgetsBackButton(
            buttonColor: VmodelColors.white,
          ),
          appbarTitle: 'Your QR code',
          style: Theme.of(context).textTheme.displayLarge!.copyWith(
                color: VmodelColors.white,
                fontWeight: FontWeight.w600,
              ),
          trailingIcon: [
            IconButton(
              onPressed: () {
                HapticFeedback.lightImpact();
                showDialog(
                    context: context,
                    builder: (context) {
                      return QRColorPickerDialog();
                    });
              },
              icon: RenderSvg(
                svgPath: VIcons.splatter,
                color: VmodelColors.white,
              ),
            ),
            // IconButton(
            //   onPressed: () => captureAndSaveScreenshot(),
            //   icon: showSavingLoader
            //       ? CircularProgressIndicator.adaptive()
            //       : Icon(
            //           Icons.save_alt,
            //           // color: Theme.of(context).iconTheme.color,
            //           color: VmodelColors.white,
            //         ),
            // ),
          ],
        ),
        body: SafeArea(
            child: Container(
          decoration: BoxDecoration(gradient: myGradient),
          child: Screenshot(
            controller: screenshotController,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                // mainAxisSize: MainAxisSize.min,
                children: [
                  addVerticalSpacing(25),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ProfilePicture(
                        size: 60,
                        displayName: '${user?.displayName}',
                        url: user?.profilePictureUrl,
                        headshotThumbnail: user?.thumbnailUrl,
                        showBorder: false,
                      ),
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              user?.displayName ?? "",
                              style: Theme.of(context)
                                  .textTheme
                                  .displayMedium
                                  ?.copyWith(
                                    fontSize: 14,
                                    color: VmodelColors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                            addVerticalSpacing(7),
                            Text(
                              user?.labelOrUserType.toUpperCase() ?? "",
                              style: Theme.of(context)
                                  .textTheme
                                  .displayMedium
                                  ?.copyWith(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: VmodelColors.white,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  addVerticalSpacing(25),
                  Container(
                    width: 70.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      boxShadow: [
                        // CustomBoxShadow(
                        //     color: Colors.grey.withOpacity(.5),
                        //     offset: Offset(5.0, 5.0),
                        //     blurRadius: 5.0,
                        //     blurStyle: BlurStyle.outer)
                        BoxShadow(
                          color: Colors.black.withOpacity(.07),
                          blurRadius: 5.0, // soften the shadow
                          spreadRadius: -3, //extend the shadow
                          offset: const Offset(0.0, 0.0),
                        )
                        // BoxShadow(
                        //   color: Colors.black.withOpacity(.07),
                        //   blurRadius: 10.0, // soften the shadow
                        //   spreadRadius: 5.0, //extend the shadow
                        //   offset: const Offset(
                        //     2.0, // Move to right 10  horizontally
                        //     5.0, // Move to bottom 10 Vertically
                        //   ),
                        // )
                      ],
                    ),
                    child: Card(
                      elevation: 0,
                      // color: Theme.of(context).primaryColor,
                      // color: Colors.white,
                      color: pageColors.qr.end,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: QrImageView(
                        data: 'https://www.google.com/',
                        eyeStyle: QrEyeStyle(
                            eyeShape: QrEyeShape.circle,
                            color:
                                // Theme.of(context).appBarTheme.backgroundColor),
                                pageColors.qr.begin),
                        dataModuleStyle: QrDataModuleStyle(
                            dataModuleShape: QrDataModuleShape.circle,
                            color:
                                // Theme.of(context).appBarTheme.backgroundColor),
                                pageColors.qr.begin),
                      ),
                    ),
                  ),
                  addVerticalSpacing(16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      showSavingLoader
                          ? Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SizedBox(
                                height: 24,
                                width: 24,
                                child: CircularProgressIndicator.adaptive(
                                  backgroundColor: Colors.white,
                                  strokeWidth: 2,
                                ),
                              ),
                            )
                          : IconButton(
                              // onPressed: () => captureAndSaveScreenshot(),
                              onPressed: () {},
                              icon: RenderSvg(
                                svgPath: VIcons.downloadRounded,
                                color: Colors.white,
                              ))
                    ],
                  ),
                  addVerticalSpacing(28),
                  ...List.generate(socialAppNames.length, (index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 10.w, vertical: 0.5.h),
                      child: VWidgetsPrimaryButton(
                        onPressed: () {},
                        enableButton: true,
                        buttonTitle: "Share via ${socialAppNames[index]}",
                        buttonColor: Colors.white.withOpacity(0.3),
                      ),
                    );
                  }).toList(),
                  // addVerticalSpacing(25),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     Expanded(
                  //         child: ReferAndEarnActionButton(
                  //             onPressed: () {}, title: 'Download')),
                  //     const SizedBox(width: 60),
                  //     Expanded(
                  //         child: ReferAndEarnActionButton(
                  //             onPressed: () {
                  //               VUtilsShare.onShare(
                  //                   context,
                  //                   imagesList,
                  //                   "VModel \nCheck out my account on VModel",
                  //                   "Check out my account on VModel");
                  //             },
                  //             title: 'Share')),
                  //   ],
                  // )
                ],
              ),
            ),
          ),
        )));
  }

  // List<Widget> getButtons() {
  //   List<Widget> widgets = [];
  //   for (var x in socialAppNames) {
  //     widgets.add(addVerticalSpacing(48));
  //     widgets.add(addVerticalSpacing(48));
  //   }
  // }

  // Future<void> captureAndSaveScreenshot() async {
  //   try {
  //     setState(() {
  //       showSavingLoader = true;
  //     });
  //     final screenshotBytes = await screenshotController.capture();

  //     final result = await ImageGallerySaver.saveImage(screenshotBytes!);

  //     if (result['isSuccess'] == true) {
  //       setState(() {
  //         showSavingLoader = false;
  //       });
  //       responseDialog(context, 'Image saved');
  //       await Future.delayed(Duration(seconds: 2));
  //       Navigator.pop(context);
  //     } else {
  //       setState(() {
  //         showSavingLoader = false;
  //       });
  //     }
  //   } catch (e) {
  //     setState(() {
  //       showSavingLoader = false;
  //     });
  //     print('Error: $e');
  //   }
  // }

  // showModal() {
  //   showModalBottomSheet(
  //     isScrollControlled: true,
  //     isDismissible: true,
  //     useRootNavigator: true,
  //     backgroundColor: Colors.transparent,
  //     context: context,
  //     builder: (context) => Container(
  //       padding: const EdgeInsets.only(left: 16, right: 16),
  //       decoration: BoxDecoration(
  //         // color: VmodelColors.appBarBackgroundColor,
  //         color: Theme.of(context).colorScheme.surface,
  //         borderRadius: BorderRadius.only(
  //           topLeft: Radius.circular(13),
  //           topRight: Radius.circular(13),
  //         ),
  //       ),
  //       child: Column(
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           crossAxisAlignment: CrossAxisAlignment.center,
  //           mainAxisSize: MainAxisSize.min,
  //           children: [
  //             addVerticalSpacing(15),
  //             VWidgetsBottomSheetTile(
  //               onTap: () async {
  //                 Navigator.of(context)..pop();
  //               },
  //               message: "Save",
  //             ),
  //             const Divider(thickness: 0.5, height: 20),
  //             VWidgetsBottomSheetTile(
  //               onTap: () async {
  //                 Navigator.of(context)..pop();
  //                 VUtilsShare.onShare(
  //                   context,
  //                   imagesList,
  //                   "VModel \nCheck out my account on VModel",
  //                   "Check out my account on VModel",
  //                 );
  //               },
  //               message: 'Share',
  //             ),
  //             addVerticalSpacing(40),
  //           ]),
  //     ),
  //   );
  // }
}
