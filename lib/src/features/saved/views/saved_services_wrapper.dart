import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vmodel/src/features/dashboard/new_profile/controller/gallery_controller.dart';
import 'package:vmodel/src/features/dashboard/new_profile/widgets/gallery_tabscreen_widget.dart';
import 'package:vmodel/src/features/dashboard/profile/controller/profile_controller.dart';
import 'package:vmodel/src/vmodel.dart';

import 'saved_services.dart';

class SavedServicesWrapper extends ConsumerStatefulWidget {
  const SavedServicesWrapper({super.key});

  @override
  SavedServicesWrapperState createState() => SavedServicesWrapperState();
}

class SavedServicesWrapperState extends ConsumerState<SavedServicesWrapper> {
  // GalleryModel? gallery;

  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: VWidgetsAppBar(
      //   leadingIcon:
      //       exlporePage.isSavedServicesWrapper ? null : const VWidgetsBackButton(),
      //   appbarTitle: "SavedServicesWrapper",
      //   // customBottom: ,
      // ),
      body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                pinned: true,

                floating: true,
                // expandedHeight: 117,
                title: Text(
                  "Saved Services",
                  style: Theme.of(context).textTheme.displayLarge!.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
                centerTitle: true,
                // flexibleSpace: FlexibleSpaceBar(
                //   centerTitle: true,
                //   background: _titleSearch(),
                // ),
                // leadingWidth: 15j,
                leading: const VWidgetsBackButton(),
                elevation: 0,
                actions: [],
              ),
              // SliverAppBar(
              //   leadingWidth: 130,
              //   leading: Padding(
              //     padding: const EdgeInsets.only(left: 16, top: 14),
              //     child: Text(
              //       // "Jobs & Services",
              //       "VMODEL",
              //       style: TextStyle(
              //         fontFamily: "SF",
              //         color: Theme.of(context).primaryColor,
              //         fontSize: 25,
              //         fontWeight: FontWeight.w800,
              //       ),
              //     ),
              //   ),

              //   pinned: true,
              //   floating: true,
              //   expandedHeight: 171.0,
              //   flexibleSpace: FlexibleSpaceBar(
              //     background: _titleSearch(textTheme, context),

              //     // FlutterLogo(),
              //   ),
              //   // leadingWidth: 150,
              //   // leading: const SizedBox.shrink(),

              //   elevation: 0,
              //   actions: [
              //     GestureDetector(
              //       onTap: () => navigateToRoute(
              //           context,
              //           UserOfferingsTabbedView(
              //             username: currentUser?.username,
              //           )),
              //       child: RenderSvg(
              //         svgPath: VIcons.servicesIcon,
              //         color: Theme.of(context)
              //             .buttonTheme
              //             .colorScheme
              //             ?.onSecondary,
              //       ),
              //     ),
              //     IconButton(
              //       color: Theme.of(context).iconTheme.color,
              //       splashRadius: 50,
              //       iconSize: 30,
              //       onPressed: () {
              //         navigateToRoute(
              //             context, const NotificationMain());
              //       },
              //       icon: Lottie.asset(
              //         LottieFiles.$63128_bell_icon,
              //         controller: _bellController,
              //         height: 30,
              //         fit: BoxFit.cover,
              //         delegates: LottieDelegates(
              //           values: [
              //             ValueDelegate.color(
              //               const ['**', 'wave_2 Outlines', '**'],
              //               value: Theme.of(context).primaryColor,
              //             ),
              //           ],
              //         ),
              //       ),
              //     ),
              //   ],
              // ),
            ];
          },
          body: SavedServicesHomepage()),
    );
  }

  // Widget _titleSearch() {
  //   return SafeArea(
  //     child: Column(
  //       mainAxisSize: MainAxisSize.min,
  //       children: [
  //         addVerticalSpacing(70),
  //         Container(
  //           padding: const VWidgetsPagePadding.horizontalSymmetric(18),
  //           alignment: Alignment.bottomCenter,
  //           child: SearchTextFieldWidget(
  //             hintText: "Search...",
  //             controller: _searchController,
  //             // onChanged: (val) {},

  //             onTapOutside: (event) {
  //               // ref.invalidate(showRecentViewProvider);
  //               // _searchController.clear();
  //               RenderBox? textBox = context.findRenderObject() as RenderBox?;
  //               Offset? offset = textBox?.localToGlobal(Offset.zero);
  //               double top = offset?.dy ?? 0;
  //               top += 200;
  //               double bottom = top + (textBox?.size.height ?? 0);
  //               if (event is PointerDownEvent) {
  //                 if (event.position.dy >= 140) {
  //                   // Tapped within the bounds of the ListTile, do nothing
  //                   return;
  //                 } else {}
  //               }
  //             },
  //             onTap: () {
  //               // if (_searchController.text.isNotEmpty) {
  //               //   ref
  //               //       .read(discoverProvider.notifier)
  //               //       .searchUsers(_searchController.text.trim());
  //               //   ref.read(showRecentViewProvider.notifier).state = true;
  //               // } else {
  //               //   ref.read(showRecentViewProvider.notifier).state = false;
  //               // }
  //             },
  //             // focusNode: myFocusNode,
  //             onCancel: () {
  //               _searchController.text = '';
  //               // showRecentSearches = false;
  //               // typingText = '';
  //               // myFocusNode.unfocus();
  //               setState(() {});
  //             },
  //             onChanged: (val) {
  //               _debounce(
  //                 () {},
  //               );
  //               // changeTypingState(typingText);
  //               setState(() {
  //                 // typingText = val;
  //               });
  //               // if (val.isNotEmpty) {
  //               //   ref.read(showRecentViewProvider.notifier).state = true;
  //               // } else {
  //               //   ref.read(showRecentViewProvider.notifier).state = false;
  //               // }
  //             },
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }
}
