import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vmodel/src/features/dashboard/discover/widget/discover_sub_item_view_all.dart';
import 'package:vmodel/src/features/dashboard/discover/widget/tapandhold/tap_and_hold.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/shared/appbar/appbar.dart';

import '../../../../../core/controller/app_user_controller.dart';
import '../../../../../vmodel.dart';
import '../../../dash/controller.dart';
import '../../../new_profile/views/other_profile_router.dart';

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

final viewAllDataProvider = StateProvider<List>((ref) {
  return [];
});

class ViewAllScreen extends ConsumerStatefulWidget {
  static const routeName = 'discoverViewAll';

  const ViewAllScreen({
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
  ConsumerState<ViewAllScreen> createState() => _ViewAllScreenState();
}

class _ViewAllScreenState extends ConsumerState<ViewAllScreen> {
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
    ref.listen(viewAllDataProvider, (p, n) {
      print("[occs] $p $n");
    });
    final dataList = ref.watch(viewAllDataProvider);

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
                    childAspectRatio: 0.7),
                itemCount: dataList.length,
                itemBuilder: (BuildContext context, int index) {
                  return DiscoverSubItemViewAll(
                    onTap: () {
                      widget.onItemTap?.call(dataList[index].username);
                      // navigateToRoute(
                      //   context,
                      //   OtherUserProfile(username: rv[index].username),
                      // );
                      _navigateToUserProfile(dataList[index].username,
                          isViewAll: true);
                    },
                    onLongPress: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return TapAndHold(
                              item: dataList[index],
                            );
                          });
                    },
                    item: dataList[index],
                  );
                }),
          ),

          // Expanded(
          //   child: FutureBuilder(
          //     future: widget.getList(limit, 1),
          //     builder: (context, snapshot) {
          //       if (snapshot.hasData) {
          //         List newList = snapshot.data;
          //         List<DiscoverItemObject> rv = [];

          //         print('------data -------view all');
          //         print('------- $snapshot.data -----');

          //         newList.forEach((e) {
          //           rv.add(DiscoverItemObject.fromMap(e)
          //               // DiscoverItemObject(
          //               //   e['firstName'],
          //               //   e['profilePictureUrl'],
          //               //   '4.9',
          //               //   e['bio'] ?? "",
          //               //   e['age'] ?? "",
          //               //   e['ethnicity'] ?? "",
          //               //   e['height']?['value'] ?? "",
          //               //   e['gender'] ?? "",
          //               //   e['label'] ?? "",
          //               //   e['price'] ?? "",
          //               //   e['location']?['locationName'] ?? "",
          //               //   e['hair'] ?? "",
          //               //   e['username'],
          //               // ),
          //               );
          //         });

          //         if (snapshot.data.length < limit) {
          //           hasMore = false;
          //         }

          //         return GridView.builder(
          //             controller: controller,
          //             physics: const BouncingScrollPhysics(),
          //             padding: const EdgeInsets.symmetric(
          //                 horizontal: 14, vertical: 10),
          //             gridDelegate:
          //                 const SliverGridDelegateWithFixedCrossAxisCount(
          //                     crossAxisCount: 2,
          //                     crossAxisSpacing: 25,
          //                     mainAxisSpacing: 29,
          //                     childAspectRatio: 0.7),
          //             itemCount: snapshot.data.length + 1,
          //             itemBuilder: (BuildContext context, int index) {
          //               if (index < snapshot.data.length) {
          //                 print('------ list ----');
          //                 print(snapshot.data.length);
          //                 print(' -va--- $snapshot.data.length -----');
          //                 return DiscoverSubItemViewAll(
          //                   onTap: () {
          //                     widget.onItemTap(rv[index].username);
          //                     // navigateToRoute(
          //                     //   context,
          //                     //   OtherUserProfile(username: rv[index].username),
          //                     // );
          //                   },
          //                   onLongPress: () {
          //                     showDialog(
          //                         context: context,
          //                         builder: (context) {
          //                           return TapAndHold(
          //                             item: rv[index],
          //                           );
          //                         });
          //                   },
          //                   item: rv[index],
          //                 );
          //               } else {
          //                 return Padding(
          //                   padding: EdgeInsets.symmetric(vertical: 32),
          //                   child: Center(
          //                     child: hasMore
          //                         ? CircularProgressIndicator()
          //                         : Container(),
          //                   ),
          //                 );
          //               }
          //             });
          //       }

          //       return GridView.builder(
          //           padding: const EdgeInsets.symmetric(
          //               horizontal: 14, vertical: 10),
          //           gridDelegate:
          //               const SliverGridDelegateWithFixedCrossAxisCount(
          //                   crossAxisCount: 2,
          //                   crossAxisSpacing: 25,
          //                   mainAxisSpacing: 29,
          //                   childAspectRatio: 0.7),
          //           itemCount: widget.dataList.length,
          //           itemBuilder: (BuildContext context, int index) {
          //             return DiscoverSubItemViewAll(
          //               onTap: () {},
          //               onLongPress: () {
          //                 showDialog(
          //                     context: context,
          //                     builder: (context) {
          //                       return TapAndHold(item: widget.dataList[index]);
          //                     });
          //               },
          //               item: widget.dataList[index],
          //             );
          //           });
          //     },
          //   ),
          // ),
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
