import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/shared/appbar/appbar.dart';
import 'package:vmodel/src/shared/shimmer/contentShimmerPage.dart';
import 'package:vmodel/src/shared/shimmer/discoverShimmerPage.dart';
import 'package:vmodel/src/shared/shimmer/feedShimmerPage.dart';
import 'package:vmodel/src/shared/shimmer/profileShimmerPage.dart';
import 'package:vmodel/src/vmodel.dart';

class ShimmerDemoPage extends StatelessWidget {
  const ShimmerDemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const VWidgetsAppBar(
        leadingIcon: VWidgetsBackButton(),
        appbarTitle: "Shimmer Demo",
      ),
      body: SingleChildScrollView(
        padding: const VWidgetsPagePadding.horizontalSymmetric(18),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            addVerticalSpacing(40),
            ElevatedButton(
                onPressed: () {
                  navigateToRoute(context, const FeedShimmerPage());
                },
                child: const Text('Feed Shimmer')),
            addVerticalSpacing(10),
            ElevatedButton(
                onPressed: () {
                  navigateToRoute(context, const DiscoverShimmerPage());
                },
                child: const Text('Discover Shimmer')),
            addVerticalSpacing(10),
            ElevatedButton(
                onPressed: () {
                  navigateToRoute(context, const ContentShimmerPage());
                },
                child: const Text('Content Shimmer')),
            addVerticalSpacing(10),
            ElevatedButton(
                onPressed: () {
                  navigateToRoute(context, const ProfileShimmerPage());
                },
                child: const Text('Profle Shimmer')),
            addVerticalSpacing(10),
          ],
        ),
      ),
    );
  }
}
