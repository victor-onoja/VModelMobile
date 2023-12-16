import 'package:shimmer/shimmer.dart';

import '../../../res/res.dart';
import '../../../vmodel.dart';

class ConnectOrFollowTileShimmer extends StatelessWidget {
  const ConnectOrFollowTileShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      // baseColor: const Color(0xffD9D9D9),
      // highlightColor: const Color(0xffF0F1F5),
      baseColor: Theme.of(context).colorScheme.surfaceVariant,
      highlightColor: Theme.of(context).colorScheme.onSurfaceVariant,
      child: Row(
        children: [
          // CircleAvatar(),
          Container(
            height: 44,
            width: 44,
            decoration: const BoxDecoration(
              color: Color(0xFF303030),
              borderRadius: BorderRadius.all(Radius.circular(44)),
            ),
          ),
          addHorizontalSpacing(16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 14,
                  width: 35.w,
                  decoration: const BoxDecoration(
                    color: Color(0xFF303030),
                    borderRadius: BorderRadius.all(Radius.circular(44)),
                  ),
                ),
                addVerticalSpacing(4),
                Container(
                  height: 14,
                  width: 50.w,
                  decoration: const BoxDecoration(
                    color: Color(0xFF303030),
                    borderRadius: BorderRadius.all(Radius.circular(44)),
                  ),
                ),
              ],
            ),
          ),
          addHorizontalSpacing(16),
          Container(
            height: 32,
            width: 72,
            decoration: const BoxDecoration(
              color: Color(0xFF303030),
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
          ),
        ],
      ),
    );
  }
}
