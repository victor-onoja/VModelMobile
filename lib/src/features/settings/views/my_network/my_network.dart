import 'package:vmodel/src/features/settings/views/blocked_list/blocked_list_homepage.dart';
import 'package:vmodel/src/features/settings/widgets/settings_submenu_tile_widget.dart';
import 'package:vmodel/src/res/gap.dart';
import 'package:vmodel/src/shared/appbar/appbar.dart';
import 'package:vmodel/src/vmodel.dart';

import '../../../dashboard/profile/view/connections_page.dart';
import '../../../dashboard/profile/view/network_received_requests_page.dart';
import '../../../dashboard/profile/view/network_sent_requests_page.dart';
import '../../../refer_and_earn/views/invite_contacts.dart';
import '../feed/followers_list/views/followers_list_homepage.dart';
import '../feed/following_list copy/views/following_list_homepage.dart';

class MyNetwork extends StatefulWidget {
  const MyNetwork({super.key});

  @override
  State<MyNetwork> createState() => _MyNetworkState();
}

class _MyNetworkState extends State<MyNetwork> {
  @override
  Widget build(BuildContext context) {
    List feedItems = [
      VWidgetsSettingsSubMenuTileWidget(
          title: "Connections",
          onTap: () {
            navigateToRoute(context, const Connections());
          }),
      VWidgetsSettingsSubMenuTileWidget(
          title: "Following",
          onTap: () {
            navigateToRoute(context, const FollowingListHomepage());
          }),
      VWidgetsSettingsSubMenuTileWidget(
          title: "Followers",
          onTap: () {
            navigateToRoute(context, const FollowersListHomepage());
          }),
      VWidgetsSettingsSubMenuTileWidget(
          title: "Sent Requests",
          onTap: () {
            navigateToRoute(context, const SentRequests());
          }),
      VWidgetsSettingsSubMenuTileWidget(
          title: "Received Requests",
          onTap: () {
            navigateToRoute(context, const ReceivedRequests());
          }),
      VWidgetsSettingsSubMenuTileWidget(
          title: "My Contacts",
          onTap: () {
            navigateToRoute(context, const ReferAndEarnInviteContactsPage());
          }),
      VWidgetsSettingsSubMenuTileWidget(
          title: "Blocked Accounts",
          textColor: Colors.red,
          onTap: () {
            navigateToRoute(context, const BlockedListHomepage());
          }),
    ];
    return Scaffold(
      appBar: const VWidgetsAppBar(
        leadingIcon: VWidgetsBackButton(),
        appbarTitle: "My Network",
      ),
      body: Column(
        children: [
          addVerticalSpacing(25),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ListView.separated(
                  itemBuilder: ((context, index) => feedItems[index]),
                  separatorBuilder: (context, index) => Divider(
                        color: Theme.of(context).dividerColor,
                      ),
                  itemCount: feedItems.length),
            ),
          ),
        ],
      ),
    );
  }
}
