import 'package:flutter/services.dart';
import 'package:vmodel/src/features/print/views/preview_screen.dart';
import 'package:vmodel/src/res/colors.dart';
import 'package:vmodel/src/res/gap.dart';
import 'package:vmodel/src/shared/appbar/appbar.dart';
import 'package:vmodel/src/shared/buttons/primary_button.dart';
import 'package:vmodel/src/shared/rend_paint/render_svg.dart';
import 'package:vmodel/src/vmodel.dart';

import '../../../core/utils/costants.dart';
import '../../../shared/modal_pill_widget.dart';

class PrintProfile extends StatelessWidget {
  const PrintProfile({super.key, this.username});
  final String? username;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const VWidgetsAppBar(
        appbarTitle: "Print",
        leadingIcon: VWidgetsBackButton(),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.circle,
                  color: VmodelColors.greyColor,
                  size: 5.sp,
                ),
                addHorizontalSpacing(5),
                Flexible(
                  child: Text(
                    'This is how your printed portfolio photos will appear.',
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        height: 1.3,
                        color: VmodelColors.greyColor),
                  ),
                ),
              ],
            ),
            addVerticalSpacing(5),
            Row(
              children: [
                Icon(
                  Icons.circle,
                  color: VmodelColors.greyColor,
                  size: 5.sp,
                ),
                addHorizontalSpacing(5),
                Flexible(
                  child: Text(
                    'You must have at least 6 photos to use this template.',
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        height: 1.3,
                        color: VmodelColors.greyColor),
                  ),
                ),
              ],
            ),
            addVerticalSpacing(5),
            Row(
              children: [
                Icon(
                  Icons.circle,
                  color: VmodelColors.greyColor,
                  size: 5.sp,
                ),
                addHorizontalSpacing(5),
                Text(
                  'You can only print from one gallery at a time.',
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      height: 1.3,
                      color: VmodelColors.greyColor),
                ),
              ],
            ),
            addVerticalSpacing(15),
            Center(
              child: RotatedBox(
                quarterTurns: 3,
                child: Container(
                    height: MediaQuery.of(context).size.height * 0.4,
                    decoration: BoxDecoration(boxShadow: [
                      BoxShadow(
                          color: VmodelColors.greyColor.withOpacity(0.4),
                          spreadRadius: 1.0,
                          blurRadius: 10,
                          offset: const Offset(1, 3))
                    ]),
                    child: Image.asset('assets/images/print.jpg')),
              ),
            ),
            addVerticalSpacing(12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RenderSvg(
                  svgPath: './assets/icons/rotate-right.svg',
                  svgHeight: 14,
                  svgWidth: 14,
                  color: VmodelColors.greyColor,
                ),
                addHorizontalSpacing(4),
                Text(
                  'Rotate to view template',
                  style:
                      TextStyle(fontSize: 11.sp, color: VmodelColors.greyColor),
                )
              ],
            ),
            addVerticalSpacing(15),
            Row(
              children: [
                Flexible(
                  child: VWidgetsPrimaryButton(
                    onPressed: () {
                      showModalBottomSheet(
                          context: context,
                          // showDragHandle: true,
                          // shape: const RoundedRectangleBorder(
                          //     borderRadius: BorderRadius.vertical(
                          //         top: Radius.circular(10))),

                          backgroundColor: Colors.transparent,
                          builder: (context) => Container(
                                // height: 40,
                                // padding: const EdgeInsets.only(
                                //     left: 18, right: 18),
                                padding: const EdgeInsets.only(
                                  left: 16,
                                  right: 16,
                                  bottom:
                                      VConstants.bottomPaddingForBottomSheets,
                                ),
                                decoration: BoxDecoration(
                                  color:
                                      Theme.of(context).scaffoldBackgroundColor,
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(13),
                                    topRight: Radius.circular(13),
                                  ),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    addVerticalSpacing(15),
                                    const VWidgetsModalPill(),
                                    addVerticalSpacing(15),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Template 1',
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleSmall,
                                        ),
                                        Radio(
                                            value: true,
                                            groupValue: const [],
                                            onChanged: (value) {}),
                                      ],
                                    ),
                                    addVerticalSpacing(10),
                                    // const Divider(
                                    //   thickness: 0.5,
                                    // ),
                                  ],
                                ),
                              ));
                    },
                    buttonTitle: "Choose template",
                    enableButton: true,
                    buttonColor: Theme.of(context).primaryColor.withOpacity(.2),
                    buttonTitleTextStyle:
                        Theme.of(context).textTheme.displayMedium!.copyWith(
                              fontWeight: FontWeight.w600,
                              fontSize: 13,
                              // color: Theme.of(context).primaryColor,
                            ),
                  ),
                ),
                addHorizontalSpacing(6),
                Flexible(
                  child: VWidgetsPrimaryButton(
                    onPressed: () {
                      HapticFeedback.lightImpact();
                      navigateToRoute(
                          context,
                          PreviewScreen(
                            username: username,
                          ));
                    },
                    buttonTitle: "Continue",
                    enableButton: true,
                    buttonColor:
                        Theme.of(context).buttonTheme.colorScheme?.background,
                    buttonTitleTextStyle:
                        Theme.of(context).textTheme.displayMedium!.copyWith(
                              fontWeight: FontWeight.w600,
                              fontSize: 13,
                            ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

// Future<void> deletePost(BuildContext context) {
//   return showModalBottomSheet<void>(
//       context: context,
//       backgroundColor: Colors.transparent,
//       builder: (BuildContext context) {
//         return Consumer(
//           builder: (BuildContext context, WidgetRef ref, Widget? child) {
//             return Container(
//               padding: const EdgeInsets.only(left: 16, right: 16),
//               decoration: const BoxDecoration(
//                 color: VmodelColors.appBarBackgroundColor,
//                 borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(13),
//                   topRight: Radius.circular(13),
//                 ),
//               ),
//               child: // VWidgetsReportAccount(username: widget.username));
//                   Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 mainAxisSize: MainAxisSize.min,
//                 children: <Widget>[
//                   addVerticalSpacing(15),
//                   VWidgetsModalPill(),
//                   addVerticalSpacing(25),
//                   Center(
//                     child: Text(
//                         postItemsLength > 1
//                             ? 'Are you sure you want to delete this post? This action cannot be undone. '
//                             : 'Are you sure you want to delete this picture? This action cannot be undone. ',
//                         style:
//                             Theme.of(context).textTheme.displaySmall!.copyWith(
//                                   color: Theme.of(context).primaryColor,
//                                 )),
//                   ),
//                   addVerticalSpacing(30),
//                   Padding(
//                     padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
//                     child: GestureDetector(
//                       onTap: () async {
//                         // navigateToRoute(
//                         //     context,
//                         //     ReportAccountHomepage(
//                         //         username: widget.username,
//                         //         profilePictureUrl:  "${user?.profilePictureUrl}",));
//                         // navigateToRoute(context, const ReportAccountOptionsPage());
//                         VLoader.changeLoadingState(true);
//                         final isSuccess = await ref
//                             .read(galleryProvider(null).notifier)
//                             .deletePost(postId: postId);
//                         VLoader.changeLoadingState(false);
//                         if (isSuccess && context.mounted) {
//                           goBack(context);
//                         }
//                       },
//                       child: Text("Delete",
//                           style: Theme.of(context)
//                               .textTheme
//                               .displayMedium!
//                               .copyWith(
//                                 fontWeight: FontWeight.w600,
//                                 color: Theme.of(context).primaryColor,
//                               )),
//                     ),
//                   ),
//                   const Divider(
//                     thickness: 0.5,
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.fromLTRB(0, 5, 0, 40),
//                     child: GestureDetector(
//                       onTap: () {
//                         goBack(context);
//                       },
//                       child: Text('Cancel',
//                           style: Theme.of(context)
//                               .textTheme
//                               .displayMedium!
//                               .copyWith(
//                                 fontWeight: FontWeight.w600,
//                                 color: Theme.of(context).primaryColor,
//                               )),
//                     ),
//                   ),
//                 ],
//               ),
//             );
//           },
//           // child:
//         );
//       });
// }
