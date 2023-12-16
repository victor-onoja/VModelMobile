import 'package:vmodel/src/features/dashboard/discover/widget/recent_screen_card.dart';
import 'package:vmodel/src/res/assets/app_asset.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/vmodel.dart';




class DiscoverRecentPage extends StatelessWidget {
  const DiscoverRecentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const VWidgetsPagePadding.horizontalSymmetric(12),
        child:  Column(
           
           children: [
            addVerticalSpacing(15),
            VWidgetsRecentViewCard(
              image: VmodelAssets2.imageContainer,
              title: "Recents",
              count: 6645,
              onTap: () { },
            ),
             VWidgetsRecentViewCard(
              image: VmodelAssets2.imageContainer,
              title: "Live Photos",
              count: 2413,
              onTap: () { },
            ),
             VWidgetsRecentViewCard(
              image: VmodelAssets2.imageContainer,
              title: "Videos",
              count: 756,
              onTap: () { },
            ),
             VWidgetsRecentViewCard(
              image: VmodelAssets2.imageContainer,
              title: "Recently Added",
              count: 543,
              onTap: () { },
            ),
             VWidgetsRecentViewCard(
              image: VmodelAssets2.imageContainer,
              title: "Screenshots",
              count: 443,
              onTap: () { },
            ),
             VWidgetsRecentViewCard(
              image: VmodelAssets2.imageContainer,
              title: "Selfies",
              count: 403,
              onTap: () { },
            ),
             VWidgetsRecentViewCard(
              image: VmodelAssets2.imageContainer,
              title: "Favorites",
              count: 513,
              onTap: () { },
            ),
           ],
        ),
      ),
    );
  }

}