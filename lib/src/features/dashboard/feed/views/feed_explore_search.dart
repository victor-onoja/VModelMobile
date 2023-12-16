import 'package:vmodel/src/core/cache/local_storage.dart';
import 'package:vmodel/src/features/dashboard/discover/views/discover_user_search.dart/models/list_of_users.dart';
import 'package:vmodel/src/features/dashboard/discover/views/discover_user_search.dart/widgets/dis_user_search_tile.dart';
import 'package:vmodel/src/features/jobs/job_market/views/job_market_homepage.dart';
// import 'package:vmodel/src/features/vmagazine/views/vMagzine_view.dart';
import 'package:vmodel/src/res/icons.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/shared/appbar/appbar.dart';
import 'package:vmodel/src/shared/buttons/text_button.dart';
import 'package:vmodel/src/shared/rend_paint/render_svg.dart';
import 'package:vmodel/src/shared/text_fields/primary_text_field.dart';
import 'package:vmodel/src/vmodel.dart';

import '../../../vmagazine/views/vmagzine_view.dart';

const String discoverStoaregKey = 'discoverKey';

class FeedExploreSearchView extends StatefulWidget {
  const FeedExploreSearchView({super.key});

  @override
  State<FeedExploreSearchView> createState() => _FeedExploreSearchViewState();
}

class _FeedExploreSearchViewState extends State<FeedExploreSearchView> {
  @override
  void initState() {
    super.initState();
    checkStorageData();
  }

  String storeValue = '';
  bool shouldShowRecent = true;
  checkStorageData() async {
    final getStoreData =
        await VModelSharedPrefStorage().getObject(discoverStoaregKey);
    // setState(() {
    //   storeValue = getStoreData;
    //
    //   if (storeValue.isEmpty) {
    //     // changeShouldShowRCENTSTATE(false);
    //   }
    // });
  }

  final TextEditingController searchController = TextEditingController();

  Iterable<UserData> filteredUserList = userDataList();
  Iterable<UserData> popular = userDataList();
  Iterable<UserData> recent = userDataList();

  filterUserData(String searchText) {
    setState(() {
      if (searchText.isNotEmpty) {
        Iterable<UserData> searchList = userDataList().where((element) =>
            element.name
                .toLowerCase()
                .toString()
                .contains(searchText.toLowerCase().toString()));

        filteredUserList = searchList;
        shouldShowRecent = false;
      } else {
        filteredUserList = userDataList();
        shouldShowRecent = true;
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

  // bool shouldShowRecent = true;
  // changeShouldShowRCENTSTATE(bool state) {
  //   setState(() {
  //     shouldShowRecent = state;
  //   });
  // }

  clearRecent() {
    setState(() {
      VModelSharedPrefStorage().clearObject(discoverStoaregKey);
      // changeShouldShowRCENTSTATE(false);
    });
  }

  Widget renderBasedOnSearchResults() {
    setState(() {});

    return Expanded(
      child: ListView(
        padding: const VWidgetsPagePadding.horizontalSymmetric(18),
        children: [
          if (storeValue.isNotEmpty)
            if (filteredUserList.isEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Search Completed",
                    style: Theme.of(context).textTheme.displayMedium!.copyWith(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w600,
                          color: VmodelColors.primaryColor,
                        ),
                  ),
                  addVerticalSpacing(3),
                  //
                  Text(
                    "No matched found",
                    style: Theme.of(context).textTheme.displayMedium!.copyWith(
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w300,
                          color: VmodelColors.primaryColor,
                        ),
                  ),
                ],
              )
            else
              ...filteredUserList.map((e) {
                return VWidgetDiscoverUserTile(
                  onPressedRemove: () {
                    removeUserFromList(e);
                  },
                  onPressedProfile: () {},
                  shouldHaveRemoveButton: false,
                  userImage: e.imgPath,
                  userImageThumbnail: e.imgPath,
                  isVerified: false,
                  blueTickVerified: false,
                  userName: e.name.toString(),
                  userNickName: e.name.toString(),
                );
              })
          else
            Column(
              children: [
                if (shouldShowRecent == true)
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Recent",
                            style: Theme.of(context)
                                .textTheme
                                .displayMedium!
                                .copyWith(
                                  fontWeight: FontWeight.w600,
                                  // color: VmodelColors.primaryColor,
                                  fontSize: 13.sp,
                                ),
                          ),
                          TextButton(
                            onPressed: () {
                              clearRecent();
                            },
                            child: Text(
                              "Clear",
                              style: Theme.of(context)
                                  .textTheme
                                  .displayMedium!
                                  .copyWith(
                                    // color: VmodelColors.primaryColor,
                                    fontSize: 12.sp,
                                  ),
                            ),
                          ),
                        ],
                      ),
                      addVerticalSpacing(15),
                      ...filteredUserList.map((e) {
                        return VWidgetDiscoverUserTile(
                          onPressedRemove: () {
                            removeUserFromList(e);
                          },
                          onPressedProfile: () {},
                          shouldHaveRemoveButton: true,
                          userImage: e.imgPath,
                          userImageThumbnail: e.imgPath,
                          userName: e.name.toString(),
                          userNickName: e.name.toString(),
                          isVerified: false,
                          blueTickVerified: false,
                        );
                      }),
                      addVerticalSpacing(24),
                    ],
                  ),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Popular",
                          style: Theme.of(context)
                              .textTheme
                              .displayMedium!
                              .copyWith(
                                fontWeight: FontWeight.w600,
                                color: VmodelColors.primaryColor,
                                fontSize: 13.sp,
                              ),
                        ),
                      ],
                    ),
                    addVerticalSpacing(18),
                    ...filteredUserList.map((e) {
                      return VWidgetDiscoverUserTile(
                        onPressedRemove: () {
                          removeUserFromList(e);
                        },
                        onPressedProfile: () {},
                        shouldHaveRemoveButton: false,
                        userImage: e.imgPath,
                        userImageThumbnail: e.imgPath,
                        userName: e.name.toString(),
                        userNickName: e.name.toString(),
                        isVerified: false,
                        blueTickVerified: false,
                      );
                    })
                  ],
                )
              ],
            )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: VWidgetsAppBar(
        appbarTitle: "Explore",
        appBarHeight: 50,
        leadingIcon: const VWidgetsBackButton(),
        trailingIcon: [
          SizedBox(
            // height: 30,
            width: 80,
            child: Row(
              children: [
                Flexible(
                  child: IconButton(
                    padding: const EdgeInsets.all(0),
                    onPressed: () {
                      navigateToRoute(context, const VMagazineView());
                    },
                    icon: const RenderSvg(
                      svgPath: VIcons.vMagaZineIcon,
                    ),
                  ),
                ),
                Flexible(
                  child: IconButton(
                    padding: const EdgeInsets.all(0),
                    onPressed: () {
                      navigateToRoute(context, const JobMarketHomepage());
                    },
                    icon: const RenderSvg(
                      svgPath: VIcons.jobMarketIcon,
                    ),
                  ),
                ),
                addHorizontalSpacing(5),
              ],
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const VWidgetsPagePadding.horizontalSymmetric(18),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                    child: VWidgetsPrimaryTextFieldWithTitle(
                  autofocus: true,
                  hintText: "Search",
                  onChanged: (String val) {
                    setState(() {
                      filterUserData(val);
                      storeValue = val;
                    });
                  },
                  controller: searchController,
                  suffixIcon: IconButton(
                      onPressed: () {
                        searchController.clear();
                        setState(() {
                          storeValue = "";
                        });
                      },
                      icon: const RenderSvg(
                        svgPath: VIcons.darkCancel,
                        svgHeight: 20,
                        svgWidth: 20,
                      )),
                )),
                Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: VWidgetsTextButton(
                    onPressed: () {
                      popSheet(context);
                    },
                    text: "Cancel",
                  ),
                ),
              ],
            ),
          ),
          addVerticalSpacing(20),
          renderBasedOnSearchResults()
        ],
      ),
    );
  }
}
