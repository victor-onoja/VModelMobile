import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/vmodel.dart';

import '../models/vell_article.dart';
import 'vell_mag_article_card.dart';

class VellMagazineArticlesSection extends ConsumerWidget {
  final String title;
  final List<VellArticle> articles;
  final bool? eachUserHasProfile;
  final Widget? route;
  final ValueChanged onTap;
  final VoidCallback? onViewAllTap;
  const VellMagazineArticlesSection({
    Key? key,
    required this.title,
    required this.articles,
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
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: textTheme.displayMedium!.copyWith(
                    fontWeight: FontWeight.w600,
                    // color: VmodelColors.mainColor,
                    // color: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
              ],
            ),
          ),
        ),
        addVerticalSpacing(9),
        SizedBox(
          height: SizerUtil.height * 0.21,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              // itemCount: items.length,
              itemCount: articles.length,
              itemBuilder: (BuildContext context, int index) {
                return VellMagazineArticleCard(
                  onTap: () {
                    // onTap(items[index].username);

                    if (eachUserHasProfile == true) {}
                  },
                  onLongPress: () {
                    // showDialog(
                    //     context: context,
                    //     builder: (context) {
                    //       return TapAndHold(item: items[index]);
                    //     });
                  },
                  item: articles[index],
                );
              }),
        ),
        addVerticalSpacing(5),
      ],
    );
  }
}
