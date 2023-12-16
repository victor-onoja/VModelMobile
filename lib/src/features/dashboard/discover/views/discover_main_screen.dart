import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vmodel/src/core/network/urls.dart';
import 'package:vmodel/src/shared/shimmer/discoverShimmerPage.dart';
import 'package:vmodel/src/vmodel.dart';

import '../../../../core/controller/app_user_controller.dart';
import '../controllers/discover_controller.dart';
import '../controllers/discover_recommended_business.dart';
import '../controllers/discover_talents_near_your.dart';
import '../controllers/recent_hash_tags_controller.dart';
import 'discover_view_v3.dart';

class DiscoverView extends ConsumerStatefulWidget {
  const DiscoverView({Key? key}) : super(key: key);
  static const routeName = 'discover';

  @override
  ConsumerState<DiscoverView> createState() => _DiscoverViewState();
}

class _DiscoverViewState extends ConsumerState<DiscoverView> {
  String selectedChip = "Models";
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  Future<void> reloadData() async {}
  bool isLoading = VUrls.shouldLoadSomefeatures;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userState = ref.watch(appUserProvider);

    return Scaffold(
      body: RefreshIndicator.adaptive(
        key: _refreshIndicatorKey,
        onRefresh: () async {
          // return reloadData();
          HapticFeedback.lightImpact();

          ref.refresh(recommendedBusinessesProvider.future);
          ref.refresh(talentsNearYouProvider.future);
          ref.refresh(discoverProvider.future);
          ref.refresh(recentHashTagsProvider.future);
        },
        child: isLoading
            // child: true
            ? const DiscoverShimmerPage(
                shouldHaveAppBar: false,
              )
            // : const DiscoverDummyList(),
            : DiscoverViewV3(refreshIndicatorKey: _refreshIndicatorKey),
      ),
    );
  }
}
