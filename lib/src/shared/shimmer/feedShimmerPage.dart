import 'package:vmodel/src/shared/pop_scope_to_background_wrapper.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/shared/appbar/appbar.dart';
import 'package:vmodel/src/shared/shimmer/feed_shimmer.dart';
import 'package:vmodel/src/vmodel.dart';

class FeedShimmerPage extends StatelessWidget {
  final bool shouldHaveAppBar;
  const FeedShimmerPage({super.key, this.shouldHaveAppBar = true});

  @override
  Widget build(BuildContext context) {
    return PopToBackgroundWrapper(
      child: Scaffold(
        appBar: shouldHaveAppBar == false
            ? const VWidgetsAppBar(
                appBarHeight: 0,
                appbarTitle: "",
              )
            : const VWidgetsAppBar(
                appbarTitle: 'Feed Shimmer',
                leadingIcon: VWidgetsBackButton(),
              ),
        body: SingleChildScrollView(
            child: Column(
          children: [
            feedShimmer(context),
            addVerticalSpacing(20),
            feedShimmer(context),
          ],
        )),
      ),
    );
  }
}
