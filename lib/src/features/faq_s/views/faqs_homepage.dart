import 'package:vmodel/src/features/faq_s/views/faq_topics.dart';
import 'package:vmodel/src/features/faq_s/views/popular_faqs_page.dart';
import 'package:vmodel/src/features/settings/widgets/settings_submenu_tile_widget.dart';
import 'package:vmodel/src/shared/appbar/appbar.dart';
import 'package:vmodel/src/vmodel.dart';

class FAQsHomepage extends StatelessWidget {
  const FAQsHomepage({super.key});
  static const routeName = 'faqs';

  @override
  Widget build(BuildContext context) {
    List fAQsItems = [
      VWidgetsSettingsSubMenuTileWidget(
          title: "Popular FAQs",
          onTap: () {
            navigateToRoute(context, const PopularFAQsHomepage());
          }),
      VWidgetsSettingsSubMenuTileWidget(
          title: "FAQs Topics",
          onTap: () {
            navigateToRoute(context, const FAQsTopics());
          }),
    ];

    return Scaffold(
      appBar: const VWidgetsAppBar(
        appbarTitle: "FAQs",
        leadingIcon: VWidgetsBackButton(),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 25.0),
        child: Container(
          margin: const EdgeInsets.only(
            left: 18,
            right: 18,
          ),
          child: ListView.separated(
              itemBuilder: ((context, index) => fAQsItems[index]),
              separatorBuilder: (context, index) => const Divider(),
              itemCount: fAQsItems.length),
        ),
      ),
    );
  }
}
