import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vmodel/src/features/dashboard/new_profile/controller/gallery_controller.dart';
import 'package:vmodel/src/features/dashboard/new_profile/widgets/gallery_tabscreen_widget.dart';
import 'package:vmodel/src/features/dashboard/profile/controller/profile_controller.dart';
import 'package:vmodel/src/vmodel.dart';

import '../../../../core/utils/debounce.dart';
import '../../../../res/icons.dart';
import '../../../../res/res.dart';
import '../../../../shared/empty_page/empty_page.dart';
import '../../../authentication/register/provider/user_types_controller.dart';
import '../../../jobs/job_market/views/search_field.dart';
import '../controllers/explore_provider.dart';
import '../controllers/hash_tag_search_controller.dart';
import 'discover_user_search.dart/views/discover_hashtag_search_grid.dart';

class Explore extends ConsumerStatefulWidget {
  const Explore({super.key});

  @override
  ExploreState createState() => ExploreState();
}

class ExploreState extends ConsumerState<Explore> {
  // GalleryModel? gallery;
  final TextEditingController _searchController = TextEditingController();
  late final Debounce _debounce;

  @override
  initState() {
    super.initState();
    _searchController.text =
        ref.read(hashTagSearchProvider.notifier).state ?? '';
    _debounce = Debounce(delay: Duration(milliseconds: 300));
  }

  @override
  dispose() {
    ref.invalidate(hashTagSearchProvider);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final galleries = ref.watch(filteredGalleryListProvider("smitham"));
    // final userState = ref.watch(profileProvider("smitham"));
    // final user = userState.valueOrNull;
    // final exlporePage = ref.watch(exploreProvider.notifier);

    // final userTypes = ref.watch(accountTypesProvider);
    final searchHashList = ref.watch(hashTagProvider);

    // final searchTerm = ref.watch(hashTagSearchProvider);

    return Scaffold(
        // appBar: VWidgetsAppBar(
        //   leadingIcon:
        //       exlporePage.isExplore ? null : const VWidgetsBackButton(),
        //   appbarTitle: "Explore",
        //   // customBottom: ,
        // ),
        body: NestedScrollView(
      headerSliverBuilder: (context, innerBoxIsScrolled) {
        return [
          SliverAppBar(
            pinned: true,

            floating: true,
            expandedHeight: SizerUtil.height * .15,
            title: Text(
              // "Explore",
              "Trending",
              style: Theme.of(context).textTheme.displayLarge!.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            centerTitle: true,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              background: _titleSearch(),
            ),
            // leadingWidth: 15j,
            leading: const VWidgetsBackButton(),
            elevation: 0,
            actions: [],
          ),
        ];
      },
      body: searchHashList.when(
          data: (data) {
            return HashtagSearchGridPage(
              // posts: searchHashList,
              title: ref.watch(hashTagSearchProvider)!,
            );
            // return GridView.builder(
            //   itemCount: data.length,
            //   padding:
            //       const EdgeInsets.only(top: 20, bottom: 300),
            //   gridDelegate:
            //       SliverGridDelegateWithFixedCrossAxisCount(
            //     crossAxisCount: 2,
            //     crossAxisSpacing: 20,
            //     mainAxisSpacing: 20,
            //     childAspectRatio: .85,
            //   ),
            //   itemBuilder: (context, index) {
            //     return HashTagView(
            //         image: data[index].photos[0].url,
            //         title: "");
            //   },
            // );
          },
          error: (error, stackStace) {
            return Text(error.toString());
          },
          loading: () => Center(child: CircularProgressIndicator.adaptive())),
      // HashtagSearchGridPage(),

      // galleries.when(data: (value) {
      //   if (value.isEmpty) {
      //     return const EmptyPage(
      //       svgSize: 30,
      //       svgPath: VIcons.gridIcon,
      //       // title: 'No Galleries',
      //       subtitle: 'Upload media to see content here.',
      //     );
      //   }

      //   final e = value.first;

      //   return Gallery(
      //     isSaved: false,
      //     isCurrentUser: true,
      //     albumID: e.id,
      //     photos: e.postSets,
      //     username: "user!.username",
      //     userProfilePictureUrl: "${user?.profilePictureUrl}",
      //     userProfileThumbnailUrl: '${user?.thumbnailUrl}',
      //     gallery: e,
      //   );
      // }, error: (err, stackTrace) {
      //   return Text('There was an error showing albums $err');
      // }, loading: () {
      //   return const Center(child: CircularProgressIndicator.adaptive());
      // }),
    ));
  }

  Widget _titleSearch() {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          addVerticalSpacing(70),
          Container(
            padding: const VWidgetsPagePadding.horizontalSymmetric(18),
            alignment: Alignment.bottomCenter,
            child: SearchTextFieldWidget(
              hintText: "Search...",
              controller: _searchController,
              // onChanged: (val) {},

              onTapOutside: (event) {
                // ref.invalidate(showRecentViewProvider);
                // _searchController.clear();
                RenderBox? textBox = context.findRenderObject() as RenderBox?;
                Offset? offset = textBox?.localToGlobal(Offset.zero);
                double top = offset?.dy ?? 0;
                top += 200;
                double bottom = top + (textBox?.size.height ?? 0);
                if (event is PointerDownEvent) {
                  if (event.position.dy >= 140) {
                    // Tapped within the bounds of the ListTile, do nothing
                    return;
                  } else {}
                }
              },
              onTap: () {
                // if (_searchController.text.isNotEmpty) {
                //   ref
                //       .read(discoverProvider.notifier)
                //       .searchUsers(_searchController.text.trim());
                //   ref.read(showRecentViewProvider.notifier).state = true;
                // } else {
                //   ref.read(showRecentViewProvider.notifier).state = false;
                // }
              },
              // focusNode: myFocusNode,
              onCancel: () {
                _searchController.text = '';

                // showRecentSearches = false;
                // typingText = '';
                // myFocusNode.unfocus();
                setState(() {});
                ref.read(hashTagSearchProvider.notifier).state =
                    _searchController.text;
              },
              onChanged: (val) {
                _debounce(
                  () {
                    ref.read(hashTagSearchProvider.notifier).state = val;
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
