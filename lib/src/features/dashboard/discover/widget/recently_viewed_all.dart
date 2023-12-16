import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vmodel/src/core/cache/hive_provider.dart';
import 'package:vmodel/src/features/dashboard/discover/widget/users_list_card_widget.dart';
import 'package:vmodel/src/shared/bottom_sheets/tile.dart';
import 'package:vmodel/src/shared/rend_paint/render_svg.dart';

import '../../../../core/routing/navigator_1.0.dart';
import '../../../../core/utils/shared.dart';
import '../../../../res/icons.dart';
import '../../../../shared/appbar/appbar.dart';
import '../../../../shared/bottom_sheets/picture_confirmation_bottom_sheet.dart';
import '../../new_profile/views/other_profile_router.dart';
import '../../../settings/views/feed/following_list/controller/following_list_controller.dart';

class RecentlyViewedAll extends ConsumerStatefulWidget {
  const RecentlyViewedAll({super.key});

  @override
  ConsumerState<RecentlyViewedAll> createState() => _RecentlyViewedAllState();
}

class _RecentlyViewedAllState extends ConsumerState<RecentlyViewedAll> {
  @override
  Widget build(BuildContext context) {
    final recentlyViewedProfileList = ref.watch(hiveStoreProvider.notifier);
    final recents = recentlyViewedProfileList.getRecentlyViewedList();
    return Scaffold(
      appBar: VWidgetsAppBar(
        appbarTitle: "Recently viewed",
        leadingIcon: VWidgetsBackButton(),
        trailingIcon: [
          GestureDetector(
              onTap: () {
                ref.read(hiveStoreProvider.notifier).clearRecent();
                setState(() {});
              },
              child: Container(
                color: Colors.transparent,
                padding: EdgeInsets.only(top: 20, right: 10),
                child: Text(
                  "Clear",
                  style: Theme.of(context)
                      .textTheme
                      .displayMedium
                      ?.copyWith(fontWeight: FontWeight.w600),
                ),
              ))
        ],
      ),
      body: recents.isEmpty
          ? Center(
              child: Text(
                "No recently viewed",
                style: Theme.of(context)
                    .textTheme
                    .displayMedium
                    ?.copyWith(fontWeight: FontWeight.w500),
              ),
            )
          : ListView.separated(
              physics: AlwaysScrollableScrollPhysics(
                  parent: BouncingScrollPhysics()),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              separatorBuilder: (context, index) => Divider(),
              itemCount: recents.length,
              itemBuilder: (context, index) {
                final item = recents[index];
                return VWidgetsUsersListTile(
                  // profileFullName:
                  //     "${item.firstName} ${item.lastName}",
                  displayName: "${item.displayName}",
                  title: "${item.username}",
                  profileImage: "${item.profilePictureUrl}",
                  profileImageThumbnail: "${item.thumbnailUrl}",
                  subTitle: item.labelOrUserType,
                  isVerified: item.isVerified,
                  blueTickVerified: item.blueTickVerified,
                  // trailingButtonText: 'Remove',
                  onTap: () {
                    navigateToRoute(
                        context,
                        OtherProfileRouter(
                          username: "${item.username}",
                        ));
                  },
                  trailingIcon: RenderSvg(svgPath: VIcons.remove),
                  onPressedDelete: () async {
                    _confirmationBottomSheet(context,
                        username: item.username,
                        pictureUrl: item.profilePictureUrl,
                        thumbnailUrl: item.thumbnailUrl);
                  },
                );
              },
            ),
    );
  }

  Future<void> _confirmationBottomSheet(
    BuildContext context, {
    required String username,
    String? pictureUrl,
    String? thumbnailUrl,
  }) {
    return showModalBottomSheet<void>(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (BuildContext context) {
          return Consumer(builder: (context, ref, child) {
            return Container(
                padding: const EdgeInsets.only(left: 16, right: 16),
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(13),
                    topRight: Radius.circular(13),
                  ),
                ),
                child: VWidgetsConfirmationWithPictureBottomSheet(
                  username: username,
                  profilePictureUrl: pictureUrl,
                  profileThumbnailUrl: thumbnailUrl,
                  actions: [
                    VWidgetsBottomSheetTile(
                        onTap: () async {
                          await ref
                              .read(followingListProvider.notifier)
                              .unfollowUser(userName: username);
                          if (context.mounted) goBack(context);
                        },
                        message: 'Unfollow')
                  ],
                  dialogMessage:
                      "You will not be able to see posts from $username after unfollowing them. Are you certain you want to proceed?",
                ));
          });
        });
  }
}
// class RecentlyViewedAll extends StatelessWidget {
//   const RecentlyViewedAll(this.viewedList, {super.key});
//   final List<VAppUser> viewedList;



// }
