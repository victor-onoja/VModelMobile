import 'package:vmodel/src/shared/shimmer/discover_shimmer.dart';
import 'package:vmodel/src/vmodel.dart';

class DiscoverShimmerPage extends StatelessWidget {
  final bool shouldHaveAppBar;
  const DiscoverShimmerPage({super.key, this.shouldHaveAppBar = true});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: shouldHaveAppBar == false
      //     ? const VWidgetsAppBar(
      //         appBarHeight: 0,
      //         appbarTitle: "",
      //       )
      //     : const VWidgetsAppBar(
      //         appbarTitle: 'Discover Shimmer',
      //         leadingIcon: VWidgetsBackButton(),
      //       ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          discoverShimmer(context),
        ],
      )),
    );
  }
}
