// import 'package:vmodel/src/features/dashboard/discover/views/discover_photo_search/discover_photo_search.dart';
// import 'package:vmodel/src/features/vmagazine/views/vMagzine_view.dart';


/***Old Discover widget not being used

class DiscoverDummyList extends ConsumerStatefulWidget {
  const DiscoverDummyList({super.key});

  @override
  ConsumerState<DiscoverDummyList> createState() => _DiscoverDummyListState();
}

class _DiscoverDummyListState extends ConsumerState<DiscoverDummyList> {
  String typingText = "";
  bool isLoading = true;
  bool showRecentSearches = false;

  FocusNode myFocusNode = FocusNode();

  final TextEditingController _searchController = TextEditingController();

  changeTypingState(String val) {
    typingText = val;
    setState(() {});
  }

  @override
  void initState() {
    // startLoading();
    super.initState();
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

  // startLoading() {
  //   Future.delayed(const Duration(seconds: 3), () {
  //     setState(() {
  //       isLoading = false;
  //     });
  //   });
  // }

  String selectedChip = "Models";
  @override
  Widget build(BuildContext context) {
    // return DiscoverPageTest();
    final discoverProviderState = ref.watch(discoverProvider);

    return discoverProviderState.when(data: (data) {
      return ListView(
        shrinkWrap: true,
        children: [
          addVerticalSpacing(0),
          Padding(
            padding: const VWidgetsPagePadding.horizontalSymmetric(18),
            child: VWidgetsPrimaryTextFieldWithTitle(
              controller: _searchController,
              onTapOutside: (event) {
                // Check if the tap event occurred within the bounds of the ListTile
                RenderBox? textBox = context.findRenderObject() as RenderBox?;
                Offset? offset = textBox?.localToGlobal(Offset.zero);
                double top = offset?.dy ?? 0;
                double bottom = top + (textBox?.size.height ?? 0);

                if (event is PointerDownEvent) {
                  if (event.position.dy >= top && event.position.dy <= bottom) {
                    // Tapped within the bounds of the ListTile, do nothing
                    return;
                  }
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
                print(
                    '+++++++++////////////++++++++++ ${_searchController.text}');
                if (_searchController.text.isNotEmpty) {
                  ref
                      .read(discoverProvider.notifier)
                      .searchUsers(_searchController.text.trim());
                }
                setState(() {
                  showRecentSearches = true;
                });
              },
              focusNode: myFocusNode,
              hintText: "vicki",
              onChanged: (val) {
                ref.read(discoverProvider.notifier).searchUsers(val);
                // changeTypingState(typingText);
                setState(() {
                  typingText = val;
                });
              },

              //!Switching photo functionality with map search till photo search is ready
              prefixIcon: null,

              // IconButton(
              //   onPressed: () async {
              //     // var x = await determinePosition();
              //     if (!mounted) return;
              //     navigateToRoute(context, const MapSearchView());
              //   },
              //   padding: const EdgeInsets.only(right: 0),
              //   icon: const RenderSvgWithoutColor(
              //     svgPath: VIcons.directionIcon,
              //     svgHeight: 24,
              //     svgWidth: 24,
              //   ),
              // ),
              // suffixIcon: IconButton(
              //   onPressed: () {
              //     if (typingText.isNotEmpty) {
              //       changeTypingState(typingText);
              //     } else {
              //       typingText = "na";
              //     }
              //   } = false,
              //   padding: const EdgeInsets.only(right: 0),
              //   icon: const RenderSvgWithoutColor(
              //     svgPath: VIcons.searchNormal,
              //     svgHeight: 24,
              //     svgWidth: 24,
              //   ),
              // ),
            ),
          ),
          if (!showRecentSearches)
            Column(
              children: [
                //
                // SizedBox(
                //   height: 56,
                //   child: ListView.builder(
                //     padding: const EdgeInsets.symmetric(horizontal: 14),
                //     scrollDirection: Axis.horizontal,
                //     itemCount: categories.length,
                //     itemBuilder: (BuildContext context, int index) {
                //       return CategoryButton(
                //         isSelected: selectedChip == categories[index],
                //         text: categories[index],
                //         onPressed: () => setState(
                //             () => selectedChip = categories[index]),
                //       );
                //     },
                //   ),
                // ),
                //! Experimental tries
                addVerticalSpacing(25),
                VWidgetsRecentlyViewedWidget(
                  profileUrl: '',
                  onTapTitle: () {},
                  onTapProfile: () {},
                ),
                //!
                addVerticalSpacing(10),
                DiscoverSubList(
                  title: 'Explore more',
                  items: recentlyViewed,
                  route: ViewAllScreen(
                    title: "Recently Viewed",
                    dataList: recentlyViewed,
                  ),
                ),
                addVerticalSpacing(10),
                DiscoverSubList(
                  title: 'Most popular',
                  items: mostPopular,
                  route: ViewAllScreen(
                    title: "Most popular",
                    dataList: mostPopular,
                  ),
                ),
                // GestureDetector(
                //   onTap: () {
                //     navigateToRoute(context, const VMagazineView());
                //   },
                //   child: Padding(
                //     padding: const EdgeInsets.only(top: 15, bottom: 10),
                //     child: Image.asset(
                //       'assets/images/models/vmagazine.png',
                //       fit: BoxFit.cover,
                //       width: double.infinity,
                //       height: 150,
                //     ),
                //   ),
                // ),
                addVerticalSpacing(10),
                DiscoverSubList(
                  title: 'Local',
                  items: locals,
                  route: ViewAllScreen(
                    title: "Local",
                    dataList: locals,
                  ),
                ),
                const VMagazineRow(
                  title: "How to create the perfect looking VModel Portfolio",
                  subTitle:
                      "Read our article on “How to perfect your profile before clients see it”",
                ),
                DiscoverSubList(
                    title: 'Browse models',
                    items: petModels,
                    route: ViewAllScreen(
                      title: "Browse models",
                      dataList: petModels,
                    )),
                DiscoverSubList(
                  title: 'Photographers',
                  items: photoModels,
                  eachUserHasProfile: true,
                  route: ViewAllScreen(
                    title: "Photographers",
                    dataList: photoModels,
                  ),
                ),
                //
                GestureDetector(
                  child: const VMagazineRow(
                    title: "Verification Simplified!",
                    subTitle:
                        "Check out the guide on how to correctly verify your profile",
                  ),
                  onTap: () {
                    navigateToRoute(context, const VerificationSettingPage());
                  },
                ),
                InkWell(
                  onTap: () {
                    // navigateAndReplaceRoute(context, const TutorialMainView());
                  },
                  child: const VMagazineRow(
                    title: "Need some help? Read our FAQ",
                    subTitle:
                        "Get answers to common questions and troubleshooting tips.",
                  ),
                ),
              ],
            ),
          if (showRecentSearches)
            Column(
              children: const [
                DiscoverUserSearchMainView(),
              ],
            ),
        ],
      );
    }, error: (error, stackTrace) {
      return Container(height: 100, width: 300, color: Colors.red);
    }, loading: () {
      return const DiscoverShimmerPage(shouldHaveAppBar: false);
    });

/**
        ? const DiscoverShimmerPage(
            shouldHaveAppBar: false,
          )
        : ListView(
            shrinkWrap: true,
            children: [
              addVerticalSpacing(0),
              Padding(
                padding: const VWidgetsPagePadding.horizontalSymmetric(18),
                child: VWidgetsPrimaryTextFieldWithTitle(
                  onTapOutside: (pointerEvent) {
                    myFocusNode.unfocus();
                    setState(() {
                      showRecentSearches = false;
                    });
                  },
                  onTap: () {
                    setState(() {
                      showRecentSearches = true;
                    });
                  },
                  focusNode: myFocusNode,
                  hintText: "vicki",
                  onChanged: (val) {
                    changeTypingState(typingText);
                    setState(() {
                      typingText = val;
                    });
                  },

                  //!Switching photo functionality with map search till photo search is ready
                  prefixIcon: IconButton(
                    onPressed: () async {
                      // var x = await determinePosition();
                      if (!mounted) return;
                      navigateToRoute(context, const MapSearchView());
                    },
                    padding: const EdgeInsets.only(right: 0),
                    icon: const RenderSvgWithoutColor(
                      svgPath: VIcons.directionIcon,
                      svgHeight: 24,
                      svgWidth: 24,
                    ),
                  ),
                  // suffixIcon: IconButton(
                  //   onPressed: () {
                  //     if (typingText.isNotEmpty) {
                  //       changeTypingState(typingText);
                  //     } else {
                  //       typingText = "na";
                  //     }
                  //   },
                  //   padding: const EdgeInsets.only(right: 0),
                  //   icon: const RenderSvgWithoutColor(
                  //     svgPath: VIcons.searchNormal,
                  //     svgHeight: 24,
                  //     svgWidth: 24,
                  //   ),
                  // ),
                ),
              ),
              if (!showRecentSearches)
                Column(
                  children: [
                    //
                    // SizedBox(
                    //   height: 56,
                    //   child: ListView.builder(
                    //     padding: const EdgeInsets.symmetric(horizontal: 14),
                    //     scrollDirection: Axis.horizontal,
                    //     itemCount: categories.length,
                    //     itemBuilder: (BuildContext context, int index) {
                    //       return CategoryButton(
                    //         isSelected: selectedChip == categories[index],
                    //         text: categories[index],
                    //         onPressed: () => setState(
                    //             () => selectedChip = categories[index]),
                    //       );
                    //     },
                    //   ),
                    // ),
                    addVerticalSpacing(10),
                    DiscoverSubList(
                      title: 'Recently Viewed',
                      items: recentlyViewed,
                      route: ViewAllScreen(
                        title: "Recently Viewed",
                        dataList: recentlyViewed,
                      ),
                    ),
                    addVerticalSpacing(10),
                    DiscoverSubList(
                      title: 'Most Popular',
                      items: mostPopular,
                      route: ViewAllScreen(
                        title: "Most Popular",
                        dataList: mostPopular,
                      ),
                    ),
                    // GestureDetector(
                    //   onTap: () {
                    //     navigateToRoute(context, const VMagazineView());
                    //   },
                    //   child: Padding(
                    //     padding: const EdgeInsets.only(top: 15, bottom: 10),
                    //     child: Image.asset(
                    //       'assets/images/models/vmagazine.png',
                    //       fit: BoxFit.cover,
                    //       width: double.infinity,
                    //       height: 150,
                    //     ),
                    //   ),
                    // ),
                    addVerticalSpacing(10),
                    DiscoverSubList(
                      title: 'Local',
                      items: locals,
                      route: ViewAllScreen(
                        title: "Local",
                        dataList: locals,
                      ),
                    ),
                    const VMagazineRow(
                      image: 'assets/images/models/listTile_3.png',
                      title:
                          "How to create the perfect looking VModel Portfolio",
                      subTitle:
                          "Read our article on “How to perfect your profile before clients see it”",
                    ),
                    DiscoverSubList(
                        title: 'Browse models',
                        items: petModels,
                        route: ViewAllScreen(
                          title: "Browse models",
                          dataList: petModels,
                        )),
                    DiscoverSubList(
                      title: 'Photographers',
                      items: photoModels,
                      eachUserHasProfile: true,
                      route: ViewAllScreen(
                        title: "Photographers",
                        dataList: photoModels,
                      ),
                    ),
                    //
                    GestureDetector(
                      child: const VMagazineRow(
                        image: 'assets/images/models/listTile_1.png',
                        title: "Verification Simplified!",
                        subTitle:
                            "Check out the guide on how to correctly verify your profile",
                      ),
                      onTap: () {
                        navigateToRoute(
                            context, const VerificationSettingPage());
                      },
                    ),
                    InkWell(
                      onTap: () {
                        navigateAndReplaceRoute(context, TutorialMainView());
                      },
                      child: const VMagazineRow(
                        image: 'assets/images/models/listTile_2.png',
                        title: "Need some help? Read our FAQ",
                        subTitle:
                            "Get answers to common questions and troubleshooting tips.",
                      ),
                    ),
                  ],
                ),
              if (showRecentSearches)
                Column(
                  children:  const [
                  DiscoverUserSearchMainView(),
                  ],

                ),
            ],
          );
    */
  }
}

// class DiscoverPageTest extends StatefulWidget {
//   const DiscoverPageTest({Key? key}) : super(key: key);
//
//   @override
//   State<DiscoverPageTest> createState() => _DiscoverPageTestState();
// }
//
// class _DiscoverPageTestState extends State<DiscoverPageTest> {
//   List<UserData> allUsers = [];
//   List<UserData> displayedUsers = [];
//   List<UserData> filteredUsers = [];
//   FocusNode textFieldFocus = FocusNode();
//   bool isTextFieldTapped = false;
//   bool isTyping = false;
//   DiscoverController discoverController = DiscoverController();
//
//   @override
//   void initState() {
//     super.initState();
//     allUsers = userDataList();
//     displayedUsers = allUsers;
//     filteredUsers = allUsers;
//     textFieldFocus.addListener(handleTextFieldFocus);
//   }
//
//   void handleTextFieldFocus() {
//     setState(() {
//       isTextFieldTapped = textFieldFocus.hasFocus;
//       isTyping = false;
//     });
//   }
//
//   void _searchUsers(String query) async {
//     if (query.isEmpty) {
//       setState(() htop{
//         displayedUsers = allUsers;
//         isTyping = false;
//       });
//     } else {
//       // final List<Map<String, dynamic>> searchResult =
//       //     await discoverController.searchUsers(query);
//       final searchResult = [];
//       await discoverController.searchUsers(query);
//       setState(() {
//         displayedUsers = searchResult
//             .map((userData) => UserData(
//                   id: userData['username'],
//                   name: '${userData['firstName']} ${userData['lastName']}',
//                   subName: '',
//                   imgPath: userData['profilePictureUrl'] ?? '',
//
//           // height: 216,
//           // width: 216,
//
//                 ))
//             .toList();
//         isTyping = true;
//       });
//     }
//   }
//
//   void _clearSearch() {
//     setState(() {
//       displayedUsers = allUsers;
//       isTyping = false; // Update the class-level variable
//     });
//   }
//
//   void _onTapOutsideTextField(dynamic event) {
//     // Check if the tap event occurred within the bounds of the ListTile
//     RenderBox? textBox = context.findRenderObject() as RenderBox?;
//     Offset? offset = textBox?.localToGlobal(Offset.zero);
//     double top = offset?.dy ?? 0;
//     double bottom = top + (textBox?.size.height ?? 0);
//
//     if (event is PointerDownEvent) {
//       if (event.position.dy >= top && event.position.dy <= bottom) {
//         // Tapped within the bounds of the ListTile, do nothing
//         return;
//       }
//     }
//
//     // Tapped outside the ListTile, unfocus the text field and reset the displayed users
//     setState(() {
//       textFieldFocus.unfocus();
//       displayedUsers = allUsers;
//     });
//   }
//
//   void _removeUser(UserData user) {
//     setState(() {
//       displayedUsers.remove(user);
//     });
//   }
//
//   @override
//   void dispose() {
//     textFieldFocus.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         padding: const EdgeInsets.all(10),
//         child: ListView(
//           // shrinkWrap: true,
//           children: [
//             VWidgetsPrimaryTextFieldWithTitle(
//               onTapOutside: _onTapOutsideTextField,
//               onTap: () {
//                 setState(() {
//                   textFieldFocus.requestFocus();
//                 });
//               },
//               focusNode: textFieldFocus,
//               hintText: "Search",
//               // onChanged: _searchUsers,
//               onChanged: (value) {
//                 if(value.isEmpty) {
//
//                 } else {
//                   // ref.read()
//                 }
//
//               },
//               prefixIcon: IconButton(
//                 onPressed: () async {
//                   if (!mounted) return;
//                   navigateToRoute(context, const MapSearchView());
//                 },
//                 padding: const EdgeInsets.only(right: 0),
//                 icon: const RenderSvgWithoutColor(
//                   svgPath: VIcons.directionIcon,
//                   svgHeight: 24,
//                   svgWidth: 24,
//                 ),
//               ),
//             ),
//             if (isTextFieldTapped)
//               Column(
//                 children: [
//                   if (!isTyping)
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           'Recent',
//                           style: Theme.of(context)
//                               .textTheme
//                               .displayMedium!
//                               .copyWith(
//                                 fontWeight: FontWeight.w600,
//                                 color: VmodelColors.primaryColor,
//                                 fontSize: 13.sp,
//                               ),
//                         ),
//                         TextButton(
//                           onPressed: _clearSearch,
//                           child: Text(
//                             'Clear',
//                             style: Theme.of(context)
//                                 .textTheme
//                                 .displayMedium!
//                                 .copyWith(
//                                   color: VmodelColors.primaryColor,
//                                   fontSize: 12.sp,
//                                 ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   displayedUsers.isNotEmpty
//                       ? ListView.builder(
//                           scrollDirection: Axis.vertical,
//                           shrinkWrap: true,
//                           itemCount: displayedUsers.length,
//                           itemBuilder: (context, index) {
//                             final user = displayedUsers[index];
//                             return ListTile(
//                               leading: ProfilePicture(
//                                 size: 50,
//                                 url: user.imgPath,
//                               ),
//                               title: Text(user.name),
//                               subtitle: Text(user.subName),
//                               // trailing: GestureDetector(
//                               //   onTap: () {
//                               //     _removeUser(user);
//                               //   },
//                               //   child:
//                               //       const RenderSvg(svgPath: VIcons.cancelTile),
//                               // ),
//                             );
//                           },
//                         )
//                       : Padding(
//                         padding: const EdgeInsets.all(10.0),
//                         child: Text(
//                             "No matched found",
//                             style: Theme.of(context)
//                                 .textTheme
//                                 .displayMedium!
//                                 .copyWith(
//                                   fontSize: 10.sp,
//                                   fontWeight: FontWeight.w300,
//                                   color: VmodelColors.primaryColor,
//                                 ),
//                           ),
//                       ),
//                 ],
//               ),
//             if (!isTextFieldTapped)
//               Column(
//                 children: [
//                   addVerticalSpacing(10),
//                   DiscoverSubList(
//                     title: 'Recently Viewed',
//                     items: recentlyViewed,
//                     route: ViewAllScreen(
//                       title: "Recently Viewed",
//                       dataList: recentlyViewed,
//                     ),
//                   ),
//                   addVerticalSpacing(10),
//                   DiscoverSubList(
//                     title: 'Most Popular',
//                     items: mostPopular,
//                     route: ViewAllScreen(
//                       title: "Most Popular",
//                       dataList: mostPopular,
//                     ),
//                   ),
//                   addVerticalSpacing(10),
//                   DiscoverSubList(
//                     title: 'Local',
//                     items: locals,
//                     route: ViewAllScreen(
//                       title: "Local",
//                       dataList: locals,
//                     ),
//                   ),
//                   const VMagazineRow(
//                     image: 'assets/images/models/listTile_3.png',
//                     title: "How to create the perfect looking VModel Portfolio",
//                     subTitle:
//                         "Read our article on “How to perfect your profile before clients see it”",
//                   ),
//                   DiscoverSubList(
//                     title: 'Browse models',
//                     items: petModels,
//                     route: ViewAllScreen(
//                       title: "Browse models",
//                       dataList: petModels,
//                     ),
//                   ),
//                   DiscoverSubList(
//                     title: 'Photographers',
//                     items: photoModels,
//                     eachUserHasProfile: true,
//                     route: ViewAllScreen(
//                       title: "Photographers",
//                       dataList: photoModels,
//                     ),
//                   ),
//                   GestureDetector(
//                     child: const VMagazineRow(
//                       image: 'assets/images/models/listTile_1.png',
//                       title: "Verification Simplified!",
//                       subTitle:
//                           "Check out the guide on how to correctly verify your profile",
//                     ),
//                     onTap: () {
//                       navigateToRoute(context, const VerificationSettingPage());
//                     },
//                   ),
//                   InkWell(
//                     onTap: () {
//                       navigateAndReplaceRoute(context, TutorialMainView());
//                     },
//                     child: const VMagazineRow(
//                       image: 'assets/images/models/listTile_2.png',
//                       title: "Need some help? Read our FAQ",
//                       subTitle:
//                           "Get answers to common questions and troubleshooting tips.",
//                     ),
//                   ),
//                 ],
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }

class NewUserData {
  final String id;
  final String name;
  final String subName;
  final String imgPath;

  NewUserData({
    required this.id,
    required this.name,
    required this.subName,
    required this.imgPath,
  });
}

List<NewUserData> userDataList() {
  // Dummy user data list
  return [
    NewUserData(
      id: '1',
      name: 'John Doe',
      subName: 'Model',
      imgPath: 'assets/images/users/john_doe.png',
    ),
    NewUserData(
      id: '2',
      name: 'Jane Smith',
      subName: 'Photographer',
      imgPath: 'assets/images/users/jane_smith.png',
    ),
    NewUserData(
      id: '3',
      name: 'Mike Johnson',
      subName: 'Model',
      imgPath: 'assets/images/users/mike_johnson.png',
    ),
    // Add more users here
  ];
}

class UserSearch {
  static List<NewUserData> searchUsers(String query, List<NewUserData> users) {
    // Perform search based on query and return filtered users
    final filteredUsers = users.where((user) =>
        user.name.toLowerCase().contains(query.toLowerCase()) ||
        user.subName.toLowerCase().contains(query.toLowerCase()));
    return filteredUsers.toList();
  }
}

**/