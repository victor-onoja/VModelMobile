import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../res/res.dart';
import '../../../../shared/shimmer/discover_connect_or_follow_section_shimmer.dart';
import '../../../../shared/shimmer/widgets/discover_connect_or_follow_tile_shimmer.dart';
import '../../../../vmodel.dart';
import '../controllers/follow_connect_controller.dart';
import '../widget/discover_follow_user_tile.dart';
import '../widget/discover_verified_users_section_bottom_sheet.dart';

class DiscoverVerifiedSection extends ConsumerStatefulWidget {
  const DiscoverVerifiedSection({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _DiscoverVerifiedSectionState();
}

class _DiscoverVerifiedSectionState
    extends ConsumerState<DiscoverVerifiedSection> {
  @override
  Widget build(BuildContext context) {
    final users = ref.watch(accountToFollowProvider);
    return users.when(data: (items) {
      if (items.isNotEmpty)
        return Column(
          // shrinkWrap: true,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 13),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Follow or Connect',
                    style: Theme.of(context).textTheme.displayMedium!.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  GestureDetector(
                    onTap: () {
                      // DiscoverSuggestedVerifiedBottomSheet()
                      showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          builder: (context) {
                            return DiscoverSuggestedVerifiedBottomSheet(
                              title: 'Follow or Connect',
                              // content: '${user?.bio}',
                            );
                          });
                    },
                    child: Container(
                      color: Colors.transparent,
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Text("View all".toUpperCase(),
                          style: Theme.of(context).textTheme.bodySmall!),
                    ),
                  ),
                  // const RenderSvg(
                  //   svgPath: VIcons.forwardIcon,
                  //   svgWidth: 12.5,
                  //   svgHeight: 12.5,
                  // ),
                ],
              ),
            ),
            ListView.builder(
              // itemCount: items.length,
              itemCount: 5,
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(horizontal: 13),
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final vfUser = items[index];
                return DiscoverFollowUserTile(
                  displayName: vfUser.displayName,
                  username: vfUser.username,
                  title: vfUser.username,
                  subTitle: vfUser.labelOrUserType,
                  blueTickVerified: vfUser.blueTickVerified,
                  isVerified: vfUser.isVerified,
                  isFollow:
                      vfUser.blueTickVerified || vfUser.isBusinessAccount!,
                  profileImage: vfUser.profilePictureUrl,
                  profileImageThumbnail: vfUser.thumbnailUrl,
                );
              },
            ),
          ],
        );
      return SizedBox.shrink();
    }, error: (err, stackTrack) {
      return Center(child: Text('Error verified users'));
      // return SliverToBoxAdapter(
      //   child: Center(child: Text('Error verified users')),
      // );
    }, loading: () {
      return ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(horizontal: 13),
        children: [
          ConnectOrFollowSectionShimmer(),
          addVerticalSpacing(24),
          ConnectOrFollowTileShimmer(),
          addVerticalSpacing(10),
          ConnectOrFollowTileShimmer(),
          addVerticalSpacing(10),
          ConnectOrFollowTileShimmer(),
          addVerticalSpacing(10),
          ConnectOrFollowTileShimmer(),
        ],
      );
      // return SliverPadding(
      //   padding: const EdgeInsets.symmetric(horizontal: 13),
      //   sliver: SliverList.list(
      //     children: [
      //       ConnectOrFollowSectionShimmer(),
      //       addVerticalSpacing(24),
      //       ConnectOrFollowTileShimmer(),
      //       addVerticalSpacing(10),
      //       ConnectOrFollowTileShimmer(),
      //       addVerticalSpacing(10),
      //       ConnectOrFollowTileShimmer(),
      //       addVerticalSpacing(10),
      //       ConnectOrFollowTileShimmer(),
      //     ],
      //   ),
      // );
    });
  }
}
