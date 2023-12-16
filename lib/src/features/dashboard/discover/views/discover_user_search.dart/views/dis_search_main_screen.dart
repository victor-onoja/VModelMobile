import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vmodel/src/core/cache/hive_provider.dart';
import 'package:vmodel/src/core/cache/local_storage.dart';
import 'package:vmodel/src/core/utils/helper_functions.dart';
import 'package:vmodel/src/features/dashboard/discover/controllers/discover_controller.dart';
import 'package:vmodel/src/features/dashboard/discover/views/discover_user_search.dart/models/list_of_users.dart';
import 'package:vmodel/src/features/dashboard/discover/views/discover_user_search.dart/widgets/dis_user_search_tile.dart';
import 'package:vmodel/src/features/dashboard/new_profile/views/business_profile/remote/remote_business_profile.dart';

import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/vmodel.dart';

import '../../../../../../core/controller/app_user_controller.dart';
import '../../../../../../core/models/app_user.dart';
import '../../../../../../core/utils/enum/discover_search_tabs_enum.dart';
import '../../../../dash/controller.dart';
import '../../../../new_profile/other_user_profile/other_user_profile.dart';
import '../../../controllers/composite_search_controller.dart';
import '../../../controllers/hash_tag_search_controller.dart';
import '../widgets/hash_tag_view.dart';
import 'discover_hashtag_search_grid.dart';

const String discoverStoaregKey = 'discoverKey';

final showRecentViewProvider = StateProvider((ref) => false);
final searchTabProvider =
    StateProvider((ref) => DiscoverSearchTab.members.index);

class DiscoverUserSearchMainView extends ConsumerStatefulWidget {
  const DiscoverUserSearchMainView({
    super.key,
    this.initialSearchPageIndex = 0,
  });
  final int? initialSearchPageIndex;

  @override
  ConsumerState<DiscoverUserSearchMainView> createState() =>
      _DiscoverUserSearchMainViewState();
}

class _DiscoverUserSearchMainViewState
    extends ConsumerState<DiscoverUserSearchMainView>
    with SingleTickerProviderStateMixin {
  String storeValue = '';
  bool shouldShowRecent = true;
  FocusNode searchFieldFocus = FocusNode();
  late TabController controller;
  // List _tabs = ["Members", "Hashtags"];

  @override
  void initState() {
    super.initState();
    checkStorageData();
    final searchTabIndex = ref.read(searchTabProvider);
    controller = TabController(
        // length: _tabs.length,
        length: DiscoverSearchTab.values.length,
        vsync: this,
        initialIndex: searchTabIndex ?? widget.initialSearchPageIndex!);
  }

  checkStorageData() async {}

  Iterable<UserData> filteredUserList = userDataList();
  Iterable<UserData> popular = userDataList();
  Iterable<UserData> recent = userDataList();

  void _onTabSwitched() {
    ref.read(searchTabProvider.notifier).state = controller.index;
    if (widget.initialSearchPageIndex == 1) {
      ref.invalidate(hashTagProvider);
    } else {
      ref.invalidate(searchUsersProvider);
    }

    ref.read(compositeSearchProvider.notifier).updateState(
          activeTab: DiscoverSearchTab.values[controller.index],
        );
  }

  filterUserData(String searchText) {
    setState(() {
      if (searchText.isNotEmpty) {
        Iterable<UserData> searchList = userDataList().where((element) =>
            element.name
                .toLowerCase()
                .toString()
                .contains(searchText.toLowerCase().toString()));

        filteredUserList = searchList;
        ref.read(showRecentViewProvider.notifier).state = false;
      } else {
        filteredUserList = userDataList();
        if (filteredUserList.isNotEmpty) {
          ref.read(showRecentViewProvider.notifier).state = true;
        } else {
          ref.read(showRecentViewProvider.notifier).state = false;
        }
      }
    });

    VModelSharedPrefStorage().putObject(
        discoverStoaregKey, {'userDataSavedList': filteredUserList}.toString());
  }

  removeUserFromList(UserData userToBeRemoved) {
    List<UserData> removeList = [];
    setState(() {
      for (var element in filteredUserList) {
        removeList.add(element);
      }
      removeList.removeWhere((element) => element == userToBeRemoved);
    });
  }

  clearRecent() {
    setState(() {
      VModelSharedPrefStorage().clearObject(discoverStoaregKey);
    });
  }

  @override
  void dispose() {
    ref.invalidate(showRecentViewProvider);
    ref.invalidate(showRecentViewProvider);
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final searchList = ref.watch(searchUsersProvider);

    final searchHashList = ref.watch(hashTagProvider);
    final recentlyViewedProfileList = ref.watch(hiveStoreProvider.notifier);
    final recents = recentlyViewedProfileList.getRecentlyViewedList();
    final currentUsername = ref.watch(appUserProvider).valueOrNull?.username;
    return SliverList.list(
      children: [
        Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TabBar(
                controller: controller,
                // tabs: _tabs.map((e) => Tab(child: Text(e))).toList(),
                tabs: DiscoverSearchTab.values
                    .map((e) => Tab(child: Text(e.name.capitalizeFirstVExt)))
                    .toList(),
                onTap: (value) async {
                  _onTabSwitched();
                  // ref.read(searchTabProvider.notifier).state = value;
                  // if (widget.initialSearchPageIndex == 1) {
                  //   ref.invalidate(hashTagProvider);
                  // } else {
                  //   ref.invalidate(searchUsersProvider);
                  // }
                },
              ),
              SizedBox(
                width: SizerUtil.width * .99,
                height: SizerUtil.height * .9,
                child: TabBarView(
                  controller: controller,
                  children: [
                    SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (shouldShowRecent == true &&
                              ref
                                  .watch(discoverProvider.notifier)
                                  .searchController
                                  .text
                                  .isEmpty &&
                              recents.isNotEmpty)
                            Column(
                              children: [
                                _headingText(
                                    mainText: "Recent",
                                    trailingButtonText: "Clear"),
                                ...recents.map((e) {
                                  return VWidgetDiscoverUserTile(
                                    onPressedRemove: () {},
                                    onPressedProfile: () {
                                      _navigateToUserProfile(
                                          currentUsername, e);
                                    },
                                    userImage: e.profilePictureUrl,
                                    userImageThumbnail: e.thumbnailUrl,
                                    userName: e.username,
                                    userType: e.labelOrUserType,
                                    userNickName: e.displayName,
                                    isVerified: e.isVerified,
                                    blueTickVerified: e.blueTickVerified,
                                  );
                                }),
                                addVerticalSpacing(24),
                              ],
                            ),
                          _searchListCol(
                              searchList, recents.toList(), currentUsername),
                          addVerticalSpacing(300)
                        ],
                      ),
                    ),
                    searchHashList.when(
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
                          print('$error, $stackStace');
                          return Text('An error occoured');
                        },
                        loading: () => Center(
                            child: CircularProgressIndicator.adaptive())),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _navigateToUserProfile(String? currentUsername, VAppUser e) {
    if (currentUsername != null && currentUsername == e.username) {
      ref.read(dashTabProvider.notifier).changeIndexState(3);
      // goBack(context);
    } else if (e.isBusinessAccount ?? false) {
      navigateToRoute(
          context, RemoteBusinessProfileBaseScreen(username: e.username));
    } else {
      navigateToRoute(context, OtherUserProfile(username: e.username));
    }
  }

  Widget _searchListCol(AsyncValue<List<VAppUser>> searchList,
      List<VAppUser> recents, String? username) {
    final controller = ref.watch(discoverProvider.notifier).searchController;
    return searchList.when(data: (value) {
      print('VVVVVVVVVV is empty ${value.isEmpty}');
      print('SERRRRCHHHHH is not empty ${controller.text}');
      if (value.isEmpty) {
        // && controller.text.isNotEmpty) {
        return const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text('No users found'),
        );
      }

      return Column(
        children: [
          // _headingText(mainText: "Result", trailingButtonText: "Clear"),
          addVerticalSpacing(16),
          // ...filteredUserList.map((e) {
          ...value.map((e) {
            return Consumer(
              builder: (BuildContext context, WidgetRef ref, Widget? child) {
                return VWidgetDiscoverUserTile(
                  onPressedRemove: () {
                    // removeUserFromList(e);
                  },
                  onPressedProfile: () {
                    // ref.invalidate(profileProvider(e.username));
                    final bool isUserInRecentList = recents
                        .any((element) => element.username == e.username);
                    if (!isUserInRecentList) {
                      ref.read(hiveStoreProvider.notifier).storeRecentEntry(e);
                    }

                    _navigateToUserProfile(username, e);
                    // if (username != null && username == e.username) {
                    //   ref.read(dashTabProvider.notifier).changeIndexState(3);
                    //   // goBack(context);
                    // } else {
                    //   navigateToRoute(
                    //       context,
                    //       OtherUserProfile(
                    //         username: e.username,
                    //       ));
                    // }
                  },
                  // shouldHaveRemoveButton: false,
                  // userImage: e.imgPath,
                  userImage: e.profilePictureUrl,
                  userImageThumbnail: e.thumbnailUrl,
                  userName: e.username,
                  userType: '${e.userType}',
                  userNickName: e.displayName,
                  isVerified: e.isVerified,
                  blueTickVerified: e.blueTickVerified,
                  // userNickName: "${e.fullName}",
                );
              },
            );
          }),
          addVerticalSpacing(24),
        ],
      );
    }, error: (error, stackTrace) {
      return const Text('Error fetching search results');
    }, loading: () {
      // return CircPro
      return Container(
        height: 20,
        width: 20,
        margin: const EdgeInsets.all(8.0),
        child: const CircularProgressIndicator.adaptive(strokeWidth: 2),
      );
    });
  }

  Widget _headingText({required String mainText, String? trailingButtonText}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          mainText,
          style: Theme.of(context).textTheme.displayMedium!.copyWith(
                fontWeight: FontWeight.w600,
                // color: VmodelColors.primaryColor,
                fontSize: 13.sp,
              ),
        ),
        if (trailingButtonText != null)
          TextButton(
            onPressed: () {
              ref.read(hiveStoreProvider.notifier).searchesBox.clear();

              clearRecent();
            },
            child: Text(
              trailingButtonText,
              style: Theme.of(context).textTheme.displayMedium!.copyWith(
                    // color: VmodelColors.primaryColor,
                    fontSize: 12.sp,
                  ),
            ),
          ),
      ],
    );
  }
}
