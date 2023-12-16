import 'package:vmodel/src/features/dashboard/new_profile/widgets/interest_dialog.dart';
import 'package:vmodel/src/features/settings/widgets/settings_submenu_tile_widget.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/shared/appbar/appbar.dart';
import 'package:vmodel/src/vmodel.dart';

import 'feed_view/default_feed_view.dart';

class FeedSettingsHomepage extends StatelessWidget {
  const FeedSettingsHomepage({super.key});

  @override
  Widget build(BuildContext context) {
    List feedItems = [
      VWidgetsSettingsSubMenuTileWidget(title: "Content", onTap: () {}),
      VWidgetsSettingsSubMenuTileWidget(
          title: "Default feed view",
          onTap: () {
            navigateToRoute(context, DefaultFeedViewDropdownInput());
          }),
      // VWidgetsSettingsSubMenuTileWidget(
      //     title: "Interests",
      //     onTap: () {
      //       navigateToRoute(context, InterestSelectionDialog());
      //     }),
    ];
    return Scaffold(
      appBar: const VWidgetsAppBar(
        appbarTitle: "Feed",
        leadingIcon: VWidgetsBackButton(),
      ),
      body: Column(
        children: [
          addVerticalSpacing(25),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ListView.separated(
                  itemBuilder: ((context, index) => feedItems[index]),
                  separatorBuilder: (context, index) => const Divider(),
                  itemCount: feedItems.length),
            ),
          ),
        ],
      ),
    );
  }
}
