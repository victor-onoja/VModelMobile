import 'package:vmodel/src/vmodel.dart';

import '../../../core/network/urls.dart';
import '../../../res/res.dart';
import '../../dashboard/profile/view/webview_page.dart';
import '../../tutorials/models/tutorial_mock.dart';

class PopularFAQsHomepage extends StatelessWidget {
  const PopularFAQsHomepage({super.key});

  @override
  Widget build(BuildContext context) {
    final faqs = HelpSupportModel.popularFAQS();
    // List popularFAQs = [
    //   VWidgetsSettingsSubMenuTileWidget(
    //       title: "Change or reset your password", onTap: () {}),
    //   VWidgetsSettingsSubMenuTileWidget(
    //       title: "How to create a verified pets profile", onTap: () {}),
    //   VWidgetsSettingsSubMenuTileWidget(
    //       title: "How to pause your VModel account", onTap: () {}),
    //   VWidgetsSettingsSubMenuTileWidget(
    //       title: "How to close your VModel account", onTap: () {}),
    //   VWidgetsSettingsSubMenuTileWidget(
    //       title: "How to report something a breach of terms and conditions",
    //       onTap: () {}),
    //   VWidgetsSettingsSubMenuTileWidget(
    //       title: "How to create a booking (Job)", onTap: () {}),
    //   VWidgetsSettingsSubMenuTileWidget(
    //       title: "How to get booked by brands", onTap: () {}),
    //   VWidgetsSettingsSubMenuTileWidget(
    //       title: "How to qualify for a creator's badge at VModel",
    //       onTap: () {}),
    //   VWidgetsSettingsSubMenuTileWidget(
    //       title: "How to compete effectively with other creatives",
    //       onTap: () {}),
    // ];

    return const WebViewPage(url: VUrls.faqUrl);
    // return Scaffold(
    //   appBar: const VWidgetsAppBar(
    //     appbarTitle: "Popular FAQs",
    //     leadingIcon: VWidgetsBackButton(),
    //   ),
    //   body: Padding(
    //     padding: const EdgeInsets.symmetric(vertical: 25.0),
    //     child: Container(
    //       margin: const EdgeInsets.only(
    //         left: 18,
    //         right: 18,
    //       ),
    //       child: ListView.separated(
    //         itemCount: faqs.length,
    //         itemBuilder: ((context, index) {
    //           // return popularFAQs[index];

    //           return VWidgetsSettingsSubMenuTileWidget(
    //               title: faqs[index].title!,
    //               onTap: () {
    //                 var ss = faqs[index];
    //                 navigateToRoute(
    //                     context,
    //                     HelpDetailsViewTwo(
    //                       tutorialDetailsTitle: ss.title,
    //                       tutorialDetailsDescription: ss.body,
    //                     ));
    //               });
    //         }),
    //         separatorBuilder: (context, index) => const Divider(),
    //       ),
    //     ),
    //   ),
    // );
  }
}
