import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/shared/appbar/appbar.dart';
import 'package:vmodel/src/shared/shimmer/content_shimmer.dart';
import 'package:vmodel/src/vmodel.dart';

class ContentShimmerPage extends StatelessWidget {
  final bool shouldHaveAppBar;
  const ContentShimmerPage({super.key, this.shouldHaveAppBar = true});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: VmodelColors.blackColor,
      appBar: shouldHaveAppBar == false
          ? const VWidgetsAppBar(
              appBarHeight: 0,
              appbarTitle: "",
            )
          : const VWidgetsAppBar(
              appbarTitle: 'Content Shimmer',
              leadingIcon: VWidgetsBackButton(),
            ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          contentShimmer(context),
          addVerticalSpacing(25),
        ],
      ),
    );
  }
}
