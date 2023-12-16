import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vmodel/src/shared/pop_scope_to_background_wrapper.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/shared/shimmer/profile_shimmer.dart';
import 'package:vmodel/src/vmodel.dart';

class ConnectionShimmerPage extends ConsumerStatefulWidget {
  const ConnectionShimmerPage({super.key, this.onTap, this.isPopToBackground = true});

  final bool isPopToBackground;
  final Function? onTap;

  @override
  ConsumerState<ConnectionShimmerPage> createState() => _ConnectionShimmerPageState();
}

class _ConnectionShimmerPageState extends ConsumerState<ConnectionShimmerPage> {
  @override
  Widget build(BuildContext context) {
    return PopToBackgroundWrapper(
      child: Scaffold(
        body: SingleChildScrollView(
            child: Column(
          children: [
            profileShimmer(context),
            addVerticalSpacing(20),
          ],
        )),
      ),
    );
  }
}
