import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vmodel/src/core/routing/navigator_1.0.dart';
import 'package:vmodel/src/core/utils/enum/upload_ratio_enum.dart';
import 'package:vmodel/src/core/utils/helper_functions.dart';
import 'package:vmodel/src/features/create_posts/views/create_post.dart';
import 'package:vmodel/src/features/create_posts/views/create_post_with_images.dart';
import 'package:vmodel/src/features/dashboard/dash/vmodel_main_button_widget.dart';
import 'package:vmodel/src/features/dashboard/feed/views/feed_main.dart';
import 'package:vmodel/src/features/dashboard/new_profile/views/new_profile_homepage.dart';
import 'package:vmodel/src/features/jobs/create_jobs/views/create_job_view_first.dart';
import 'package:vmodel/src/res/icons.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/shared/loader/full_screen_dialog_loader.dart';
import 'package:vmodel/src/shared/rend_paint/render_svg.dart';

import '../../../core/api/graphql_service.dart';
import '../../../core/controller/app_user_controller.dart';
import '../../../core/notification/notification.dart';
import '../../../core/utils/costants.dart';
import '../../jobs/job_market/controller/job_provider.dart';
import '../../jobs/job_market/views/business_user/market_place_simple.dart';
import '../discover/controllers/explore_provider.dart';
import '../discover/views/discover_main_screen.dart';
import '../feed/controller/feed_provider.dart';
import '../new_profile/controller/gallery_controller.dart';
import '../new_profile/profile_features/widgets/profile_picture_widget.dart';
import '../new_profile/views/business_profile/local/local_business_profile.dart';

// final isContentViewActive = st
// final isContentViewActiveProvider = StateProvider<bool>((ref) {
//   return false;
// });

final dashTabProvider = StateNotifierProvider<DashTabProvider, int>((ref) {
  return DashTabProvider(ref);
});

// final authProvider = StateNotifierProvider((ref) => ref.r(graphqlClientProvider)));
List<File> selectedImages = [];
final picker = ImagePicker();

class DashTabProvider extends StateNotifier<int> {
  // For users logging into the app for the first time
  final Ref ref;
  // bool _isBusinessAccount = false;

  DashTabProvider(this.ref) : super(0) {
    // final temp = ref.read(appUserProvider.notifier);
  }

  final mainPages = [
 
     const FeedMainUI(),
  
    const DiscoverView(),

   
    const BusinessMyJobsPageMarketplaceSimple(),
    Consumer(builder: (_, userRef, __) {
      final appUser = userRef.watch(appUserProvider);
      final isBusinessAccount = appUser.valueOrNull?.isBusinessAccount ?? false;

      if (isBusinessAccount) {
        return LocalBusinessProfileBaseScreen(
            username: appUser.valueOrNull!.username, isCurrentUser: true);
      } else {
        return const ProfileBaseScreen(isCurrentUser: true);
      }
    }),

    // const ProfileWidget(username: 'Me', isCurrentUser: true),
    // const ProfileMainView(
    //   shouldHaveBackButton: true,
    //   shouldPopToBackground: true,
    //   profileTypeEnumConstructor: ProfileTypeEnum.personal,
    // ),
  ];

  //
  void switchAndShowMainFeedPage() {
    //Make sure feed will be displayed even when discover was
    // visible before navigating to video content page
    ref.read(feedProvider.notifier).isFeedPage(isFeedOnly: true);
    //  final jobsState = ref.watch(jobsProvider);
    // show feed
    changeIndexState(0);
    //Change bottomNav colors
    colorsChangeBackGround(0);
  }

  // for normal users
  // DashTabProvider() : super(0);

  void increment() => state++;
  int get tabIndex => state;
  int get getPageIndex => state;
  void changeIndexState(int index) {
    ref.read(feedProvider.notifier).isFeedPage(isFeedOnly: true);
    state = index;
  }

  Widget returnSelected(BuildContext context) {
    return mainPages[state];
    // return pages(context)[state];
  }

  initFCM(BuildContext context, WidgetRef ref) async {
    FCM? firebaseMessaging;
    firebaseMessaging = FCM();
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    String? token = await messaging.getToken();
    final authNotifier = ref.read(authProvider.notifier);
    await authNotifier.updateFcmToken(fcmToken: token!);
    print('token ===============  $token');
    if (!mounted) return;
    firebaseMessaging.setNotifications(context);
  }

  bool activeCameraIcon = false;
  Color backgroundColor = Colors.white;
  Color iconColor = VmodelColors.primaryColor;
  colorsChangeBackGround(int index) {
    // final isContent = ref.watch(isContentViewActiveProvider);
    final isFeed = ref.watch(feedProvider.notifier).isFeed;
    // print('9999999999999999 changing color to $index');
    // if (state == 2) {
    // if (isContent) {
    if (!isFeed) {
      backgroundColor = VmodelColors.blackColor;
      activeCameraIcon = true;
      iconColor = VmodelColors.white;
    } else {
      backgroundColor = Colors.white;
      activeCameraIcon = false;
      iconColor = VmodelColors.primaryColor;
    }
  }

  void setState(Function() updateState) {
    updateState();
    // Tell Flutter that this widget needs to rebuild
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        setState(() {});
      }
    });
  }

  // List<Widget> pages(BuildContext context) {
  //   return [
  //     const DiscoverView(),
  //     const FeedMainUI(),
  //     // const DiscoverView(),
  //     const ContentView(),
  //     const ProfileBaseScreen(
  //       isCurrentUser: true,
  //     ),
  //     // const ProfileMainView(
  //     //   shouldHaveBackButton: true,
  //     //   shouldPopToBackground: true,
  //     //   profileTypeEnumConstructor: ProfileTypeEnum.personal,
  //     // ),
  //   ];
  // }

  returnContentIcon(
      {Widget? contentWidget,
      Widget? defaultIcon,
      int? index,
      Widget? indexRender}) {
    // final isContent = ref.watch(isContentViewActiveProvider);
    final isFeed = ref.watch(feedProvider.notifier).isFeed;
    // return state == 9
    return !isFeed
        ? contentWidget
        : state == index
            ? indexRender
            : defaultIcon;
  }

  List<UploadOptions> createptions(BuildContext context) {
    return [
      UploadOptions(
          label: "Create a post",
          onTap: () {
            popSheet(context);
            showCupertinoModalPopup(
              context: context,
              builder: (BuildContext context) => Padding(
                padding: const EdgeInsets.only(bottom: 90.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ..._uploadOptions(context).map((e) {
                      return Container(
                        decoration: BoxDecoration(
                          color: VmodelColors.white,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        width: double.infinity,
                        margin: const EdgeInsets.only(
                            left: 12, right: 12, bottom: 4),
                        height: 50,
                        child: MaterialButton(
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          onPressed: e.onTap,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                e.label.toString(),
                                style:
                                    Theme.of(context).textTheme.displayMedium,
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                  ],
                ),
              ),
            );
          }),
      UploadOptions(
          label: "Create a jobssss",
          onTap: () {
            navigateToRoute(context, const CreateJobFirstPage());
          }),
      UploadOptions(
          label: "Create a service package",
          onTap: () {
            navigateToRoute(context, const CreateJobFirstPage());
          }),
    ];
  }

  List<UploadOptions> _uploadOptions(BuildContext context) => [
        UploadOptions(
            label: "Gallery",
            onTap: () async {
              popSheet(context);
              // VLoader.changeLoadingState(true);
              // //Clear any previously selected images
              // selectedImages.clear();
              // await getImages(
              //     isGallary: true, isMultiple: true, isCamera: false);
              // VLoader.changeLoadingState(false);
              // print(selectedImages.length);
              // navigateToRoute(
              //     AppNavigatorKeys.instance.navigatorKey.currentContext!,
              //     const UniversalCropper());
              navigateToRoute(
                  AppNavigatorKeys.instance.navigatorKey.currentContext!,
                  const CreatePostWithImagesMediaPicker());

              // if (mounted) {

              //   // navigateToRoute(
              //   //     AppNavigatorKeys.instance.navigatorKey.currentContext!,
              //   //     CreatePostPage(images: selectedImages));
              // }
            }),
        UploadOptions(
            label: "Camera",
            onTap: () async {
              popSheet(context);
              VLoader.changeLoadingState(true);
              await getImages(
                  isCamera: true, isMultiple: false, isGallery: false);
              VLoader.changeLoadingState(false);
              if (mounted) {
                navigateToRoute(
                    AppNavigatorKeys.instance.navigatorKey.currentContext!,
                    // CreatePostPage(images: selectedImages));
                    const CreatePostPage(
                        images: [], aspectRatio: UploadAspectRatio.square));
              }
            }),
        // UploadOptions(
        //     label: "Album",
        //     onTap: () {
        //       popSheet(context);
        //       navigateToRoute(context, CreatePostPage(images: selectedImages));
        //     }),
        // UploadOptions(
        //     label: "Polaroid",
        //     onTap: () {
        //       popSheet(context);
        //       navigateToRoute(context, CreatePostPage(images: selectedImages));
        //     }),
      ];

  List<Widget> bottomNavItems(BuildContext context, Function() onFeedTap,
      {doesItNeedPopUp = false}) {
    return [
      GestureDetector(
        // splashColor: Colors.transparent,
        onDoubleTap: () {
          ref.read(feedProvider.notifier).isFeedPage();
        },
        onTap: () {
          HapticFeedback.lightImpact();

          print('nav 1 clicked');

          changeIndexState(0);
          colorsChangeBackGround(0);
          onFeedTap();
          if (doesItNeedPopUp) popSheet(context);
        },
        // iconSize: 28,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: returnContentIcon(
            contentWidget: RenderSvg(
              svgPath: VIcons.marketPlaceSelected,
              color: VmodelColors.white,
              svgHeight: activeHeight(0),
              svgWidth: activeWidth(0),
            ),
            defaultIcon: RenderSvg(
              svgPath: VIcons.marketPlaceUnselected,
              svgHeight: activeHeight(0),
              color: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
              svgWidth: activeWidth(0),
            ),
            index: 0,
            indexRender: RenderSvg(
              svgPath: VIcons.marketPlaceSelected,
              svgHeight: activeHeight(0),
              color: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
              svgWidth: activeWidth(0),
            ),
          ),
        ),
      ),
      GestureDetector(
        onLongPress: () {
          HapticFeedback.lightImpact();
          changeIndexState(1);
          // navigateToRoute(contexcontextt, AllJobs());
          ref.read(exploreProvider.notifier).isExplorePage(isExploreOnly: true);
          return;
        },
        onTap: () {
          ref
              .read(exploreProvider.notifier)
              .isExplorePage(isExploreOnly: false);
          changeIndexState(1);
          colorsChangeBackGround(1);
          // if (doesItNeedPopUp) popSheet(context);
        },
        child: Container(
          height: 42,
          width: 42,
          padding: const EdgeInsets.all(8),
          child: returnContentIcon(
            contentWidget: RenderSvg(
              // svgPath: VIcons.normalContent,
              svgPath: VIcons.discoverOutlinedIcon,
              color: VmodelColors.white,
              svgHeight: activeHeight(0, definedHeight: 4),
              svgWidth: activeWidth(0, definedWidth: 5),
            ),
            index: 1,
            indexRender: RenderSvg(
              svgPath: VIcons.discoverFilledIcon,
              svgHeight: activeHeight(0),
              // color: iconColor,
              color: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
              svgWidth: activeWidth(0),
            ),
            defaultIcon: RenderSvg(
              // svgPath: VIcons.normalContent,
              svgPath: VIcons.discoverOutlinedIcon,
              color: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
              // svgHeight: activeHeight(0, definedHeight: 1),
              // svgWidth: activeWidth(0, definedWidth: 1),
            ),
          ),
        ),
      ),
      GestureDetector(
        onTap: () {
          // showCupertinoModalPopup(
          //   context: context,
          //   builder: (BuildContext context) => Padding(
          //     padding: const EdgeInsets.only(bottom: 90.0),
          //     child: Column(
          //       mainAxisAlignment: MainAxisAlignment.end,
          //       children: [
          //         ...createOptions(context).map((e) {
          //           return Container(
          //             decoration: BoxDecoration(
          //               color: VmodelColors.white,
          //               borderRadius: const BorderRadius.all(
          //                 Radius.circular(10),
          //               ),
          //             ),
          //             width: double.infinity,
          //             margin:
          //                 const EdgeInsets.only(left: 12, right: 12, bottom: 4),
          //             height: 50,
          //             child: MaterialButton(
          //               shape: const RoundedRectangleBorder(
          //                 borderRadius: BorderRadius.all(
          //                   Radius.circular(10),
          //                 ),
          //               ),
          //               onPressed: e.onTap,
          //               child: Column(
          //                 crossAxisAlignment: CrossAxisAlignment.center,
          //                 mainAxisAlignment: MainAxisAlignment.center,
          //                 children: [
          //                   Text(
          //                     e.label.toString(),
          //                     style: Theme.of(context).textTheme.displayMedium,
          //                   ),
          //                 ],
          //               ),
          //             ),
          //           );
          //         }),
          //       ],
          //     ),
          //   ),
          // );

          showModalBottomSheet(
              context: context,
              backgroundColor: Colors.transparent,
              barrierColor: Colors.black.withOpacity(0.5),
              builder: (BuildContext context) {
                return Container(
                    // height: 265,
                    constraints: const BoxConstraints(
                      minHeight: 265,
                    ),
                    padding: const EdgeInsets.only(
                      left: 24,
                      right: 24,
                      bottom: VConstants.bottomPaddingForBottomSheets,
                    ),
                    decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(13),
                        topRight: Radius.circular(13),
                      ),
                    ),
                    child: const VWidgetsVModelMainButtonFunctionality());
              });
        },
        child:
            //     Theme.of(context).brightness == Brightness.light
            //         ?
            //     returnContentIcon(
            //   contentWidget: RenderSvgWithoutColor(
            //     svgPath: VIcons.vLogoIconLightMode,
            //     svgHeight: 50,
            //     svgWidth: 35,
            //     color: Theme.of(context).iconTheme.color,
            //   ),
            //   defaultIcon: RenderSvgWithoutColor(
            //     svgPath: VIcons.vLogoIconLightMode,
            //     svgHeight: 50,
            //     color: Theme.of(context).iconTheme.color,
            //     svgWidth: 35,
            //   ),
            // )
            // :
            returnContentIcon(
          contentWidget: RenderSvg(
            svgPath: VIcons.vModelLogoDarkMode,
            svgHeight: 50,
            svgWidth: 35,
            color: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
          ),
          defaultIcon: RenderSvg(
            svgPath: VIcons.vModelLogoDarkMode,
            svgHeight: 50,
            color: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
            svgWidth: 35,
          ),
        ),
      ),

      // Container(
      //   color: Colors.red.shade300,
      //   child: IconButton(
      //     onPressed: () {
      //       changeIndexState(2);
      //       colorsChangeBackGround(2);
      //       if (doesItNeedPopUp) popSheet(context);
      //     },
      //     iconSize: 30,
      //     icon: returnContentIcon(
      //       contentWidget: RenderSvg(
      //         svgPath: VIcons.normalContent,
      //         // svgHeight: activeHeight(2, definedHeight: 30),
      //         color: VmodelColors.white,
      //         // svgWidth: activeWidth(2, definedWidth: 15),
      //       ),
      //       index: 2,
      //       defaultIcon: RenderSvg(
      //         svgPath: VIcons.normalContent,
      //         // svgHeight: activeHeight(2, definedHeight: 30),
      //         color: iconColor,
      //         // svgWidth: activeWidth(2, definedWidth: 15),
      //       ),
      //     ),
      //   ),
      // ),
      GestureDetector(
        onDoubleTap: () {
          HapticFeedback.lightImpact();
          changeIndexState(2);
          // navigateToRoute(context, AllJobs());
          ref.read(jobSwitchProvider.notifier).isAllJobPage(isAllJobOnly: true);
          return;
        },
        child: IconButton(
          onPressed: () {
            changeIndexState(2);
            ref
                .read(jobSwitchProvider.notifier)
                .isAllJobPage(isAllJobOnly: false);
          },
          icon: returnContentIcon(
            contentWidget: NormalRenderSvgWithColor(
              // svgPath: VIcons.contentDiscoverIcon,
              svgPath: VIcons.job_market_content,
              // svgHeight: activeHeight(0),
              // svgWidth: activeWidth(0),
              color: VmodelColors.white,
              svgHeight: activeHeight(0, definedHeight: 28),
              svgWidth: activeWidth(0, definedWidth: 28),
            ),
            defaultIcon: RenderSvg(
              // svgPath: VIcons.contentDiscoverIcon,
              svgPath: VIcons.message_unselected,
              color: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
              svgHeight: activeHeight(0, definedHeight: 28),
              svgWidth: activeWidth(0, definedWidth: 28),
            ),
            index: 2,
            indexRender: RenderSvg(
              // svgPath: VIcons.selectedDiscover,
              svgPath: VIcons.message_selected,
              color: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
              svgHeight: activeHeight(0, definedHeight: 28),
              svgWidth: activeWidth(0, definedWidth: 28),
            ),
          ),
        ),
      ),
      // Container(
      //   color: Colors.red.shade300,
      //   child: GestureDetector(
      //     onTap: () {},
      //     onLongPress: () {
      //       // logOutFunction(onLogOut: () {
      //       // ref.invalidate(appUserProvider);
      //       // });
      //     },
      //     child: IconButton(
      //       onPressed: () {
      //         changeIndexState(3);
      //         colorsChangeBackGround(3);
      //       },
      //       iconSize: 30,
      //       icon: returnContentIcon(
      //           contentWidget: profileIcon(
      //             VIcons.emptyProfileIconDarkMode,
      //             isContent: true,
      //           ),
      //           index: 4,
      //           defaultIcon: profileIcon(VIcons.emptyProfileIconLightMode)),
      //     ),
      //   ),
      // ),

      Container(
        height: 48,
        width: 48,
        padding: const EdgeInsets.all(8),
        child: GestureDetector(
          onTap: () {
            HapticFeedback.lightImpact();
            if (state == 3) {
              ref.read(showCurrentUserProfileFeedProvider.notifier).state =
                  false;
            }
            changeIndexState(3);
            colorsChangeBackGround(3);
          },
          onLongPress: () {
            print("objectobjectobject");
            // logOutFunction(onLogOut: () {
            // ref.invalidate(appUserProvider);
            // });
          },
          child: Container(
            child: returnContentIcon(
                contentWidget: profileIcon(
                  context,
                  VIcons.emptyProfileIconDarkMode,
                  isContent: true,
                ),
                index: 4,
                defaultIcon:
                    profileIcon(context, VIcons.emptyProfileIconLightMode)),
          ),
        ),
      ),
    ];
  }

  double activeWidth(int index, {double? definedWidth}) {
    return state == index ? definedWidth ?? 18 : definedWidth ?? 18;
  }

  double activeHeight(int index, {double? definedHeight}) {
    return state == index ? definedHeight ?? 24 : definedHeight ?? 24;
  }

  profileIcon(BuildContext context, String customIcon,
      {bool isContent = false}) {
    return Consumer(
      builder: (_, ref, __) {
        // final authNotifier = ref.read(authProvider.notifier);
        final appUser = ref.watch(appUserProvider);
        final isFeed = ref.watch(feedProvider).isFeed;

        return ProfilePicture(
          showBorder: true,
          displayName: '${appUser.valueOrNull?.displayName}',
          url: '${appUser.valueOrNull?.profilePictureUrl}',
          headshotThumbnail: '${appUser.valueOrNull?.thumbnailUrl}',
          size: 80,
          // borderColor:
          //     state == 2 ? VmodelColors.white : VmodelColors.primaryColor,
          borderColor: !isFeed
              ? VmodelColors.white
              : Theme.of(context).bottomNavigationBarTheme.backgroundColor!,
        );
        // return  user?.profilePictureUrl != null
        //     ? _profilePicture(
        //     user!.profilePictureUrl!,
        //         customIcon,
        //         isContent: isContent)
        //     : StreamBuilder(
        //   //Todo (Ernest) undo getUser
        //   //   stream: authNotifier.getUser(globalUsername!),
        //     stream: Stream.value("value"),
        //         builder: ((context, userSnapshot) {
        //           if (userSnapshot.connectionState == ConnectionState.waiting) {
        //             return _profilePicture('', customIcon,
        //                 isContent: isContent);
        //           } else if (userSnapshot.hasError) {
        //             return _profilePicture('', customIcon,
        //                 isContent: isContent);
        //           } else if (userSnapshot.hasData) {
        //             return _profilePicture(
        //               //Todo (Ernest) reset this file
        //                 // VMString.pictureCall +
        //                 //     authNotifier.state.profilePicture!,
        //               "",
        //                 customIcon,
        //                 isContent: isContent);
        //           }
        //           return _profilePicture("", customIcon, isContent: isContent);
        //         }));
        // }
        // }));
      },
    );
  }

  // Widget _profilePicture(String url, String errorIconPath,
  //     {bool isContent = false}) {
  //   return Container(
  //     height: 80,
  //     width: 80,
  //     decoration: BoxDecoration(
  //       shape: BoxShape.circle,
  //       border: Border.all(
  //           width: 1,
  //           color: isContent ? VmodelColors.white : VmodelColors.primaryColor),
  //     ),
  //     child: Padding(
  //       padding: const EdgeInsets.all(2),
  //       child: ClipRRect(
  //         borderRadius: BorderRadius.circular(100),
  //         child: CachedNetworkImage(
  //             width: double.infinity,
  //             fit: BoxFit.cover,
  //             imageUrl: url,
  //             placeholder: (context, url) => RenderSvg(
  //                   svgPath: errorIconPath,
  //                   color: isContent
  //                       ? VmodelColors.white
  //                       : VmodelColors.primaryColor,
  //                 ),
  //             errorWidget: (context, url, error) => RenderSvg(
  //                 svgPath: errorIconPath,
  //                 color: isContent
  //                     ? VmodelColors.white
  //                     : VmodelColors.primaryColor)),
  //       ),
  //     ),
  //   );
  // }
}

class UploadOptions {
  String? label;
  Function()? onTap;
  UploadOptions({this.label, this.onTap});
}
