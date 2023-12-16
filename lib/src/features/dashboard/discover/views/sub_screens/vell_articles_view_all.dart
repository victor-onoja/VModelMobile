import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/shared/appbar/appbar.dart';

import '../../../../../core/controller/app_user_controller.dart';
import '../../../../../vmodel.dart';
import '../../../dash/controller.dart';
import '../../../new_profile/views/other_profile_router.dart';
import '../../widget/vell_mag_article_card.dart';

const mockData = [
  'assets/images/models/model_2.png',
  'assets/images/models/model_4.png',
  'assets/images/models/model_5.png',
  'assets/images/models/model_6.png',
  'assets/images/models/model_4.png',
  'assets/images/models/model_1.png',
  'assets/images/models/model_2.png',
  'assets/images/models/model_5.png',
];

final vellArticlesViewAllDataProvider = StateProvider<List>((ref) {
  return [];
});

class VellArticlesViewAllScreen extends ConsumerStatefulWidget {
  static const routeName = 'discoverViewAll';

  const VellArticlesViewAllScreen({
    Key? key,
    required this.title,
    // required this.dataList,
    // required this.onItemTap,
    this.onItemTap,
    // required this.getList,
  }) : super(key: key);
  final String title;
  // final List dataList;
  // final Future Function(int pageCount, int pageNumber) getList;
  final ValueChanged? onItemTap;

  @override
  ConsumerState<VellArticlesViewAllScreen> createState() =>
      _VellArticlesViewAllScreenState();
}

class _VellArticlesViewAllScreenState
    extends ConsumerState<VellArticlesViewAllScreen> {
  ///
  int limit = 8;
  // int nextItems = 16;
  final controller = ScrollController();
  bool hasMore = true;

  @override
  initState() {
    super.initState();

    controller.addListener(() {
      if (controller.position.maxScrollExtent == controller.offset) {
        setState(() {
          limit *= 2;
        });
      }
    });
  }

  Future fetch() async {}

  @override
  Widget build(BuildContext context) {
    ref.listen(vellArticlesViewAllDataProvider, (p, n) {
      print("[occs] $p $n");
    });
    final dataList = ref.watch(vellArticlesViewAllDataProvider);

    return Scaffold(
      appBar: VWidgetsAppBar(
        appBarHeight: 50,
        leadingIcon: const VWidgetsBackButton(),
        // backgroundColor: Colors.white,
        appbarTitle: widget.title,
        // trailingIcon: [
        //   SizedBox(
        //     width: 80,
        //     child: Row(
        //       mainAxisAlignment: MainAxisAlignment.end,
        //       children: [
        //         // Flexible(
        //         //   child: IconButton(
        //         //     padding: const EdgeInsets.all(0),
        //         //     onPressed: () {
        //         //       navigateToRoute(context, const MessagingHomePage());
        //         //     },
        //         //     icon: const RenderSvg(
        //         //       svgPath: VIcons.sendWitoutNot,
        //         //       svgHeight: 24,
        //         //       svgWidth: 24,
        //         //     ),
        //         //   ),
        //         // ),
        //         Flexible(
        //           child: IconButton(
        //             padding: const EdgeInsets.only(right: 8),
        //             onPressed: () {
        //               //navigateToRoute(context, NotificationsView());
        //             },
        //             icon: const RenderSvg(
        //               svgPath: VIcons.videoFilmIcon,
        //               svgHeight: 24,
        //               svgWidth: 24,
        //             ),
        //           ),
        //         ),
        //         // Flexible(
        //         //   child: IconButton(
        //         //     padding: const EdgeInsets.all(0),
        //         //     onPressed: () {
        //         //       openVModelMenu(context, isNotTabScreen: true);
        //         //     },
        //         //     icon: const NormalRenderSvg(
        //         //       svgPath: VIcons.circleIcon,
        //         //     ),
        //         //   ),
        //         //),
        //       ],
        //     ),
        //   ),
        // ],
      ),
      body: Column(
        children: [
          addVerticalSpacing(2),
          Expanded(
            child: GridView.builder(
                controller: controller,
                physics: const BouncingScrollPhysics(),
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 25,
                    mainAxisSpacing: 29,
                    childAspectRatio: 1),
                itemCount: dataList.length,
                itemBuilder: (BuildContext context, int index) {
                  return VellMagazineArticleCard(
                    onTap: () {},
                    onLongPress: null,
                    item: dataList[index],
                  );
                }),
          ),
          addVerticalSpacing(10),
        ],
      ),
    );
  }

  void _navigateToUserProfile(String username, {bool isViewAll = false}) {
    final isCurrentUser =
        ref.read(appUserProvider.notifier).isCurrentUser(username);
    if (isCurrentUser) {
      if (isViewAll) goBack(context);
      ref.read(dashTabProvider.notifier).changeIndexState(3);
    } else {
      navigateToRoute(
        context,
        OtherProfileRouter(username: username),
      );
    }
  }
}
