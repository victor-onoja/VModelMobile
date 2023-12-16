import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../res/res.dart';
import '../../../../shared/buttons/text_button.dart';
import '../../../../shared/shimmer/widgets/discover_connect_or_follow_tile_shimmer.dart';
import '../../../../vmodel.dart';
import '../controllers/follow_connect_controller.dart';
import 'discover_follow_user_tile.dart';

class DiscoverSuggestedVerifiedBottomSheet extends ConsumerStatefulWidget {
  const DiscoverSuggestedVerifiedBottomSheet({
    super.key,
    required this.title,
  });

  final String title;

  @override
  ConsumerState<DiscoverSuggestedVerifiedBottomSheet> createState() =>
      _DiscoverSuggestedVerifiedBottomSheetState();
}

class _DiscoverSuggestedVerifiedBottomSheetState
    extends ConsumerState<DiscoverSuggestedVerifiedBottomSheet> {
  final isLoading = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    final users = ref.watch(accountToFollowProvider);
    return Container(
      constraints: BoxConstraints(
        maxHeight: SizerUtil.height * 0.8,
        minHeight: SizerUtil.height * 0.2,
        minWidth: SizerUtil.width,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          addVerticalSpacing(24),
          Text(
            widget.title,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontWeight: FontWeight.w600,
                  // color: VmodelColors.primaryColor,
                  // fontSize: 12,
                ),
          ),
          addVerticalSpacing(16),
          Flexible(
            child: users.when(data: (items) {
              print('[oopl] items length is ${items.length}');
              return ListView.builder(
                itemCount: items.length + 1, // items.length,
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(horizontal: 13),
                itemBuilder: (context, index) {
                  if (index == items.length - 1) {
                    _handler();
                  }
                  if (true && index == items.length) {
                    return ValueListenableBuilder(
                        valueListenable: isLoading,
                        builder: (context, value, _) {
                          return value
                              ? ConnectOrFollowTileShimmer()
                              : SizedBox.shrink();
                        });
                  }
                  return DiscoverFollowUserTile(
                    displayName: items[index].displayName,
                    username: items[index].username,
                    title: '${items[index].username}',
                    subTitle: items[index].labelOrUserType,
                    blueTickVerified: items[index].blueTickVerified,
                    isVerified: items[index].isVerified,
                    isFollow: items[index].blueTickVerified ||
                        items[index].isBusinessAccount!,
                    profileImage: items[index].profilePictureUrl,
                    profileImageThumbnail: items[index].thumbnailUrl,
                  );
                },
              );
            }, error: (err, stackTrack) {
              return Center(child: Text('Error verified users'));
            }, loading: () {
              return Center(
                child: CircularProgressIndicator.adaptive(),
              );
            }),
          ),
          addVerticalSpacing(16),
          VWidgetsTextButton(
            text: 'Close',
            textStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontWeight: FontWeight.w600,
                  // color: VmodelColors.primaryColor,
                  // fontSize: 12,
                ),
            onPressed: () => goBack(context),
          ),
          addVerticalSpacing(24),
        ],
      ),
    );
  }

  Future<void> _handler() async {
    isLoading.value = true;
    await ref.read(accountToFollowProvider.notifier).fetchMoreHandler();
    isLoading.value = false;
  }
}
