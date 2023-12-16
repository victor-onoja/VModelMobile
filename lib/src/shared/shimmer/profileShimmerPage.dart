import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/shared/shimmer/profile_shimmer.dart';
import 'package:vmodel/src/vmodel.dart';

class ProfileShimmerPage extends StatelessWidget {
  const ProfileShimmerPage(
      {super.key, this.onTap, this.isPopToBackground = true, this.onRefresh});

  final bool isPopToBackground;
  final Function? onTap;
  final Future<void> Function()? onRefresh;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator.adaptive(
          onRefresh: () async {
            await onRefresh?.call();
          },
          child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(
                  parent: BouncingScrollPhysics()),
              child: Column(
                children: [
                  profileShimmer(context),
                  addVerticalSpacing(20),
                ],
              )),
        ),
      ),
    );
  }
}
