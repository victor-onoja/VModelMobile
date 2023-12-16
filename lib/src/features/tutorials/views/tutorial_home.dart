
// import 'package:vmodel/src/features/help_support/views/help_details_two.dart';
// import 'package:vmodel/src/features/help_support/widgets/help_tile.dart';
// import 'package:vmodel/src/features/tutorials/models/tutorial_mock.dart';
// import 'package:vmodel/src/features/tutorials/views/tutorial_details.dart';
// import 'package:vmodel/src/res/res.dart';
// import 'package:vmodel/src/shared/appbar/appbar.dart';
// import 'package:vmodel/src/vmodel.dart';

// import '../../../res/icons.dart';
// import '../../../shared/rend_paint/render_svg.dart';
// import '../../dashboard/dash/dashboard_ui.dart';

// class TutorialMainView extends StatelessWidget {
//   const TutorialMainView({super.key});

//   @override
//   Widget build(BuildContext context) {

//     return Scaffold(
//       appBar:  VWidgetsAppBar(
//         leadingIcon: IconButton(
//             onPressed: () {
//       navigateToRoute(context, const DashBoardView());
//       },
//         icon: const RotatedBox(
//           quarterTurns: 2,
//           child: RenderSvg(
//             svgPath: VIcons.forwardIcon,
//             svgWidth: 13,
//             svgHeight: 13,
//           ),
//         ),
//       ),
        
//         appBarHeight: 50,
//         appbarTitle: "FAQs",
//       ),
//       body: SingleChildScrollView(
//         child: Container(
//           margin: const VWidgetsPagePadding.horizontalSymmetric(18),
//           padding: const VWidgetsPagePadding.verticalSymmetric(18),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 "Popular FAQs",
//                 style: Theme.of(context).textTheme.displayMedium!.copyWith(
//                     fontWeight: FontWeight.w600,
//                     fontSize: 14.sp,
//                     color: Theme.of(context).primaryColor),
//               ),
//               addVerticalSpacing(10),
//               for (int i = 0; i < HelpSupportModel.popularFAQS().length; i++)
//                 VWigetsHelpTile(
//                   titleTitle:
//                       HelpSupportModel.popularFAQS()[i].title.toString(),
//                   onTap: () {
//                     navigateToRoute(
//                         context,
//                         HelpDetailsViewTwo(
//                           tutorialDetailsTitle: HelpSupportModel.popularFAQS()[i]
//                               .title
//                               .toString(),
//                           tutorialDetailsDescription: HelpSupportModel.popularFAQS()[i]
//                               .body
//                               .toString(),
//                         ));
//                   },
//                   iconPath: '',
//                 ),
//               addVerticalSpacing(50),
//               Text(
//                 "FAQs Topics",
//                 style: Theme.of(context).textTheme.displayLarge!.copyWith(
//                     fontWeight: FontWeight.w600,
//                     color: Theme.of(context).primaryColor),
//               ),
//               addVerticalSpacing(10),
//               for (int i = 0; i < HelpSupportModel.faqTopics().length; i++)
//                 VWigetsHelpTile(
//                   titleTitle: HelpSupportModel.faqTopics()[i].title.toString(),
//                   shouldHaveIcon: true,
//                   onTap: () {
//                     navigateToRoute(
//                         context,
//                         TutorialDetailsView(
//                           helpDetailsTitle:
//                               HelpSupportModel.faqTopics()[i].title.toString(),
//                         ));
//                   },
//                   iconPath: HelpSupportModel.faqTopics()[i].iconPath.toString(),
//                 ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
