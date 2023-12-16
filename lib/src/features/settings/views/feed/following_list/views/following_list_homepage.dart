import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vmodel/src/features/jobs/job_market/views/search_field.dart';
import 'package:vmodel/src/shared/bottom_sheets/tile.dart';

import '../../../../../../core/routing/navigator_1.0.dart';
import '../../../../../../core/utils/shared.dart';
import '../../../../../../res/icons.dart';
import '../../../../../../res/res.dart';
import '../../../../../../shared/appbar/appbar.dart';
import '../../../../../../shared/bottom_sheets/picture_confirmation_bottom_sheet.dart';
import '../../../../../../shared/empty_page/empty_page.dart';
import '../../../blocked_list/blocked_list_card_widget.dart';
import '../controller/following_list_controller.dart';

class FollowingListHomepage extends ConsumerWidget {
  const FollowingListHomepage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool userBlock = false;
    final blockedUsers = ref.watch(followingListProvider);

    return Scaffold(
        appBar: const VWidgetsAppBar(
          appbarTitle: "Following",
          leadingIcon: VWidgetsBackButton(),
        ),
        body: blockedUsers.when(data: (data) {
          return data.isEmpty
              ? SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Center(
                          child: Container(
                              padding: const EdgeInsets.all(32),
                              color: VmodelColors.white,
                              child: const EmptyPage(
                                svgSize: 30,
                                svgPath: VIcons.noBlocked,
                                subtitle:
                                    'Connect with other users to see them in your following list.',
                              )),
                        ),
                      ),
                    ],
                  ),
                )
              : Column(
                  children: [
                    const Padding(
                      padding: VWidgetsPagePadding.horizontalSymmetric(18),
                      child: SearchTextFieldWidget(
                        hintText: 'Search',
                        // suffixIcon: IconButton(
                        //   onPressed: () {},
                        //   icon: const RenderSvgWithoutColor(
                        //     svgPath: VIcons.searchNormal,
                        //     svgHeight: 20,
                        //     svgWidth: 20,
                        //   ),
                        // )
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            final item = data[index];
                            return VWidgetsSettingUsersListTile(
                              displayName: "${item.displayName}",
                              title: "${item.username}",
                              profileImage: "${item.profilePictureUrl}",
                              profileImageThumbnail: "${item.thumbnailUrl}",
                              subTitle: item.labelOrUserType,
                              isVerified: item.isVerified,
                              blueTickVerified: item.blueTickVerified,
                              trailingButtonText: 'Remove',
                              onPressedDelete: () async {
                                _confirmationBottomSheet(
                                  context,
                                  username: item.username,
                                  pictureUrl: item.profilePictureUrl,
                                  thumbnailUrl: item.thumbnailUrl,
                                );
                              },
                            );
                          }),
                    ),
                  ],
                );
        }, error: (err, stackTrace) {
          return const SafeArea(
              child: Text("Error getting the following list"));
        }, loading: () {
          return const Center(child: CircularProgressIndicator.adaptive());
        }));
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
                decoration: const BoxDecoration(
                  color: VmodelColors.appBarBackgroundColor,
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
