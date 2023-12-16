import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vmodel/src/features/dashboard/discover/models/discover_item.dart';
import 'package:vmodel/src/features/dashboard/discover/models/mock_data.dart';
import 'package:vmodel/src/features/dashboard/discover/views/discover_user_search.dart/views/dis_search_main_screen.dart';
import 'package:vmodel/src/features/jobs/job_market/views/search_field.dart';
// import 'package:vmodel/src/features/dashboard/discover/views/discover_photo_search/discover_photo_search.dart';
// import 'package:vmodel/src/features/vmagazine/views/vMagzine_view.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/vmodel.dart';

import '../../../../core/controller/app_user_controller.dart';
import '../../../../core/utils/costants.dart';
import '../../../../shared/buttons/primary_button.dart';
import '../../dash/controller.dart';
import '../../new_profile/views/other_profile_router.dart';
import '../controllers/discover_controller.dart';
import '../widget/category_list_item.dart';
import '../../../jobs/job_market/widget/carousel_with_close.dart';

class CategoryDiscoverDetail extends ConsumerStatefulWidget {
  const CategoryDiscoverDetail({
    super.key,
    required this.title,
  });
  final String title;

  @override
  ConsumerState<CategoryDiscoverDetail> createState() =>
      _CategoryDiscoverDetailState();
}

class _CategoryDiscoverDetailState
    extends ConsumerState<CategoryDiscoverDetail> {
  String typingText = "";
  bool isLoading = true;
  bool showRecentSearches = false;

  FocusNode myFocusNode = FocusNode();
  late Future getFeaturedTalents;
  late Future getRisingTalents;
  late Future getPhotgraphers;
  late Future getPetModels;

  final TextEditingController _searchController = TextEditingController();

  final CarouselController _controller = CarouselController();
  int _currentIndex = 0;
  bool _showCarousel = true;

  changeTypingState(String val) {
    typingText = val;
    setState(() {});
  }

  // Future getFeaturedTalent ()async{

  // }

  late final List<DiscoverItemObject> _categoryItems;

  @override
  void initState() {
    super.initState();

    _categoryItems = List.generate(VConstants.tempCategories.length, (index) {
      return DiscoverItemObject(
          name: VConstants.tempCategories[index],
          image: mockDiscoverCategoryAssets[index],
          userType: '',
          label: '',
          username: '');
    });

    ref
        .read(discoverProvider.notifier)
        .updateSearchController(_searchController);
    myFocusNode.addListener(() {
      if (myFocusNode.hasFocus) {
        showRecentSearches = true;
      } else {
        showRecentSearches = false;
      }
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    myFocusNode.dispose();
    super.dispose();
  }

  String selectedChip = "Models";
  @override
  Widget build(BuildContext context) {
    // return DiscoverPageTest();
    final discoverProviderState = ref.watch(discoverProvider);
    // final _risingTalentsData = ref.watch(risingTalentsProvider);

    // final discoverItems = _risingTalentsData.valueOrNull ?? [];

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            // snap: _snap,
            floating: true,
            expandedHeight: 190.0,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              background: _titleSearch(),
            ),
            // leadingWidth: 150,
            // leading: const SizedBox.shrink(),
            leading: const VWidgetsBackButton(),
            elevation: 1,
            // backgroundColor: Colors.white,
            // actions: [
            //   Padding(
            //     padding: const EdgeInsets.only(top: 0, right: 0),
            //     child: Row(
            //       children: [
            //         IconButton(
            //           onPressed: () {
            //             navigateToRoute(context, const NotificationsView());
            //           },
            //           icon: const RenderSvg(
            //             svgPath: VIcons.notification,
            //           ),
            //         ),
            //       ],
            //     ),
            //     // child: ,
            //   ),
            // ],
          ),

          SliverToBoxAdapter(child: const CarouselWithClose()),
          // if (_showCarousel)
          //   SliverList.list(
          //     children: [
          //       Stack(
          //         children: [
          //           Padding(
          //             padding: const EdgeInsets.all(16),
          //             child: ClipRRect(
          //                 // height: SizerUtil.height * 0.25,
          //                 // margin: const EdgeInsets.all(16),
          //                 // decoration: BoxDecoration(
          //                 borderRadius: BorderRadius.circular(20),
          //                 //   color: Colors.grey.shade300,
          //                 // ),
          //                 child: CarouselSlider(
          //                   disableGesture: true,
          //                   items: List.generate(
          //                     mockDiscoverCarouselPrefix.length,
          //                     (index) {
          //                       return Image.asset(
          //                         mockDiscoverCarouselPrefix[index],
          //                         width: double.maxFinite,
          //                         scale: 0.5,
          //                         fit: BoxFit.cover,
          //                       );
          //                       // return CachedNetworkImage(
          //                       //   imageUrl: myCarouselItems[index].image,
          //                       //   fadeInDuration: Duration.zero,
          //                       //   fadeOutDuration: Duration.zero,
          //                       //   width: double.maxFinite,
          //                       //   height: double.maxFinite,
          //                       //   filterQuality: FilterQuality.medium,
          //                       //   fit: BoxFit.cover,
          //                       //   // fit: BoxFit.contain,
          //                       //   placeholder: (context, url) {
          //                       //     return const PostShimmerPage();
          //                       //   },
          //                       //   errorWidget: (context, url, error) =>
          //                       //       const Icon(Icons.error),
          //                       // );
          //                     },
          //                   ),
          //                   carouselController: _controller,
          //                   options: CarouselOptions(
          //                     padEnds: false,
          //                     autoPlay: true,
          //                     viewportFraction: 1,
          //                     // aspectRatio: UploadAspectRatio.wide.ratio,
          //                     initialPage: 0,
          //                     enableInfiniteScroll: false,
          //                     // myItems.length > 1 ? true : false,
          //                     onPageChanged: (index, reason) {
          //                       _currentIndex = index;
          //                       setState(() {});
          //                       // widget.onPageChanged(index, reason);
          //                     },
          //                     // scrollPhysics:
          //                     //     isPinchToZoom ? NeverScrollableScrollPhysics() : null,
          //                     // height: 300,
          //                   ),

          //                   // options: CarouselOptions(
          //                   //     autoPlay: true,
          //                   //     enlargeCenterPage: true,
          //                   //     aspectRatio: 2.0,
          //                   //     onPageChanged: (index, reason) {
          //                   //       setState(() {
          //                   //         _current = index;
          //                   //       });
          //                   //     }),
          //                 )),
          //           ),
          //           Positioned(
          //             top: 20,
          //             right: 20,
          //             child: GestureDetector(
          //               onTap: () {
          //                 _showCarousel = !_showCarousel;
          //                 setState(() {});
          //               },
          //               child: Container(
          //                 padding: const EdgeInsets.all(2.5),
          //                 decoration: BoxDecoration(
          //                   shape: BoxShape.circle,
          //                   color: VmodelColors.black.withOpacity(0.3),
          //                 ),
          //                 child: const Icon(
          //                   Icons.close,
          //                   color: Colors.white,
          //                 ),
          //               ),
          //             ),

          //             // IconButton(
          //             //   icon: Icon(Icons.close),
          //             //   color: Colors.white,
          //             //   onPressed: () {},
          //             // ),
          //           ),
          //         ],
          //       ),
          //       VWidgetsCarouselIndicator(
          //         currentIndex: _currentIndex,
          //         totalIndicators: mockDiscoverCarouselPrefix.length,
          //       ),
          //     ],
          //   ),
          discoverProviderState.when(data: (data) {
            if (showRecentSearches) {
              return DiscoverUserSearchMainView();
            }

            return SliverPadding(
              padding: const EdgeInsets.all(16),
              sliver: SliverGrid.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    // childAspectRatio: 0.65,
                  ),
                  itemCount: _categoryItems.length,
                  itemBuilder: (context, index) {
                    return CategoryListItem(
                      onTap: () {},
                      onLongPress: () {
                        // showDialog(
                        //     context: context,
                        //     builder: (context) {
                        //       return TapAndHold(item: items[index]);
                        //     });
                      },
                      isViewAll: true,
                      item: _categoryItems[index],
                      itemName: VConstants.tempCategories[index],
                    );
                  }),
            );

            // if (!showRecentSearches)
          }, error: (err, st) {
            return const Text('Error');
          }, loading: () {
            return const Text('Error');
          }),
          SliverToBoxAdapter(
            child: Column(
              children: [
                addVerticalSpacing(6),
                Text(
                  'VModel will only display services near you',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).primaryColor.withOpacity(0.5)),
                ),
                addVerticalSpacing(4),
                Text(
                  'Search to display more services',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).primaryColor.withOpacity(0.5)),
                ),
                addVerticalSpacing(16),
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
              child: VWidgetsPrimaryButton(
                buttonTitle: 'Show all services',
                onPressed: () {},
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _titleSearch() {
    return SafeArea(
      child: Column(
        children: [
          // addVerticalSpacing(8),
          // Row(
          //   children: [
          //     VWidgetsBackButton(),
          //   ],
          // ),
          Expanded(
            child: addVerticalSpacing(42),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 13),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.title,
                  style: Theme.of(context).textTheme.displayLarge!.copyWith(
                        fontWeight: FontWeight.w600,
                        // color: VmodelColors.mainColor,
                        fontSize: 16.sp,
                      ),
                ),
              ],
            ),
          ),
          addVerticalSpacing(10),
          Padding(
            padding: const VWidgetsPagePadding.horizontalSymmetric(18),
            child: SearchTextFieldWidget(
              hintText: "Search services",
              controller: _searchController,
              // onChanged: (val) {},

              onTapOutside: (event) {
                RenderBox? textBox = context.findRenderObject() as RenderBox?;
                Offset? offset = textBox?.localToGlobal(Offset.zero);
                double top = offset?.dy ?? 0;
                top += 200;
                double bottom = top + (textBox?.size.height ?? 0);
                ref.read(showRecentViewProvider.notifier).state = false;
                if (event is PointerDownEvent) {
                  if (event.position.dy >= 140) {
                    // Tapped within the bounds of the ListTile, do nothing
                    return;
                  } else {}
                }

                // Tapped outside the ListTile, unfocus the text field and reset the displayed users
                // setState(() {
                //   textFieldFocus.unfocus();
                //   displayedUsers = allUsers;
                // });
                myFocusNode.unfocus();
                // setState(() {
                //   showRecentSearches = false;
                // });
              },
              onTap: () {
                if (_searchController.text.isNotEmpty) {
                  ref
                      .read(discoverProvider.notifier)
                      .searchUsers(_searchController.text.trim());
                }
                setState(() {
                  // showRecentSearches = true;
                });
              },
              focusNode: myFocusNode,
              onChanged: (val) {
                ref.read(discoverProvider.notifier).searchUsers(val);
                // changeTypingState(typingText);
                setState(() {
                  typingText = val;
                });
              },
            ),
          ),
          const SizedBox(height: 5),
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

/**

  */
}
