import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/vmodel.dart';

import '../models/discover_item.dart';
import 'discover_sub_item.dart';

class DiscoverSubList extends ConsumerWidget {
  final String title;
  final List<DiscoverItemObject> items;
  final bool? eachUserHasProfile;
  final Widget? route;
  final ValueChanged onTap;
  final VoidCallback? onViewAllTap;
  const DiscoverSubList({
    Key? key,
    required this.title,
    required this.items,
    required this.onTap,
    this.onViewAllTap,
    this.eachUserHasProfile = false,
    this.route,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Column(
      children: [
        addVerticalSpacing(10),
        GestureDetector(
          onTap: () {
            // route != null ? navigateToRoute(context, route) : () {};

            // uncomment for go_router
            onViewAllTap?.call();
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 13),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: textTheme.displayMedium!.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  "View all".toUpperCase(),
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      ),
                ),
              ],
            ),
          ),
        ),
        addVerticalSpacing(9),
        SizedBox(
          height: SizerUtil.height * 0.20,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              itemCount: items.length,
              itemBuilder: (BuildContext context, int index) {
                return DiscoverSubItem(
                  onTap: () {
                    onTap(items[index].username);

                    if (eachUserHasProfile == true) {
                    }
                  },
                  onLongPress: () {
                  },
                  item: items[index],
                );
              }),
        ),
        addVerticalSpacing(5),
      ],
    );
  }
}
