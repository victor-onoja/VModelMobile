import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vmodel/src/core/utils/validators_mixins.dart';
import 'package:vmodel/src/features/jobs/job_market/views/search_field.dart';
import 'package:vmodel/src/shared/bottom_sheets/tile.dart';
import 'package:vmodel/src/shared/rend_paint/render_svg.dart';

import '../../../../../../core/routing/navigator_1.0.dart';
import '../../../../../../core/utils/costants.dart';
import '../../../../../../core/utils/shared.dart';
import '../../../../../../res/icons.dart';
import '../../../../../../res/res.dart';
import '../../../../../../shared/appbar/appbar.dart';
import '../../../../../../shared/bottom_sheets/picture_confirmation_bottom_sheet.dart';
import '../../../../../../shared/empty_page/empty_page.dart';
import '../../../../../../shared/modal_pill_widget.dart';
import '../../../../../../shared/shimmer/connections_shimmer.dart';
import '../../../../../connection/controller/provider/connection_provider.dart';
import '../../../../../dashboard/new_profile/views/other_profile_router.dart';
import '../../../../../dashboard/profile/widget/network_search_empty_widget.dart';
import '../../../blocked_list/blocked_list_card_widget.dart';
import '../../following_list/controller/following_list_controller.dart';

class FollowingListHomepage extends ConsumerWidget {
  const FollowingListHomepage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // bool userBlock = false;
    final followedUsers = ref.watch(followingListProvider);
    final debounce = ref.watch(debounceProvider);
    final searchQuery = ref.watch(connectionGeneralSearchProvider);

    return Scaffold(
      appBar: VWidgetsAppBar(
        appbarTitle: "Following",
        leadingIcon: VWidgetsBackButton(),
        trailingIcon: [
          IconButton(
              onPressed: () {
                showModalBottomSheet(
                    context: context,
                    backgroundColor: Colors.transparent,
                    builder: (BuildContext context) {
                      return Container(
                          padding: const EdgeInsets.only(
                            left: 16,
                            right: 16,
                            bottom: VConstants.bottomPaddingForBottomSheets,
                          ),
                          decoration: BoxDecoration(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(13),
                              topRight: Radius.circular(13),
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              addVerticalSpacing(15),
                              const Align(
                                  alignment: Alignment.center,
                                  child: VWidgetsModalPill()),
                              addVerticalSpacing(25),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 6.0),
                                child: GestureDetector(
                                  onTap: () {
                                    // ref.invalidate(getConnections);
                                    if (context.mounted) goBack(context);
                                  },
                                  child: Text('Most Recent',
                                      style: Theme.of(context)
                                          .textTheme
                                          .displayMedium!
                                          .copyWith(
                                              fontWeight: FontWeight.w600,
                                              color: Theme.of(context)
                                                  .primaryColor)),
                                ),
                              ),
                              const Divider(thickness: 0.5),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 6.0),
                                child: GestureDetector(
                                  onTap: () {
                                    // sortByLatestFirst = false;

                                    // ref.invalidate(getConnections);
                                    if (context.mounted) goBack(context);
                                  },
                                  child: Text('Earliest',
                                      style: Theme.of(context)
                                          .textTheme
                                          .displayMedium!
                                          .copyWith(
                                              fontWeight: FontWeight.w600,
                                              color: Theme.of(context)
                                                  .primaryColor)),
                                ),
                              ),
                              addVerticalSpacing(40),
                            ],
                          ));
                    });
              },
              icon: const RenderSvg(
                svgPath: VIcons.sort,
              ))
        ],
      ),
      body: RefreshIndicator.adaptive(
        onRefresh: () async {
          HapticFeedback.lightImpact();
          await ref.refresh(followingListProvider.future);
        },
        child: Column(
          children: [
            Padding(
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
                onChanged: (value) {
                  debounce(
                    () {
                      ref.read(connectionGeneralSearchProvider.notifier).state =
                          value;
                    },
                  );
                },
              ),
            ),
            followedUsers.when(data: (data) {
              if (data.isEmpty && !searchQuery.isEmptyOrNull) {
                return EmptySearchResultsWidget();
              }
              return data.isEmpty
                  ? Expanded(
                      child: const EmptyPage(
                        svgSize: 30,
                        svgPath: VIcons.documentLike,
                        subtitle: 'Connect with other users to see them'
                            ' in your following list.',
                      ),
                    )
                  : Expanded(
                      child: ListView.builder(
                          physics: AlwaysScrollableScrollPhysics(
                              parent: BouncingScrollPhysics()),
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            final item = data[index];
                            return VWidgetsSettingUsersListTile(
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
                          }),
                    );
            }, error: (err, stackTrace) {
              return const SafeArea(
                  child: Text("Error getting the following list"));
            }, loading: () {
              // return ConnectionsShimmerPage();
              return Expanded(child: ConnectionsShimmerPage());
              // return Expanded(
              //   child: ListView.separated(
              //       itemCount: 4,
              //       padding: EdgeInsets.symmetric(horizontal: 18),
              //       shrinkWrap: true,
              //       separatorBuilder: (context, index) {
              //         return addVerticalSpacing(16);
              //       },
              //       itemBuilder: (context, index) {
              //         return CircleAvatarTwoLineTileShimmer();
              //       }),
              // );
            }),
          ],
        ),
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
