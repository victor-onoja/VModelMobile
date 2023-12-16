import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vmodel/src/features/dashboard/new_profile/widgets/profile_header_widget.dart';
import 'package:vmodel/src/features/dashboard/new_profile/widgets/gallery_tabscreen_widget.dart';
import 'package:vmodel/src/res/icons.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/shared/appbar/appbar.dart';
import 'package:vmodel/src/shared/hint_dilaogue.dart';
import 'package:vmodel/src/shared/rend_paint/render_svg.dart';
import 'package:vmodel/src/vmodel.dart';

import '../../../../core/controller/app_user_controller.dart';
import '../../../../shared/empty_page/empty_page.dart';
import '../../../../shared/shimmer/profileShimmerPage.dart';
import '../../../../shared/text_fields/profile_input_field.dart';
import '../../../../shared/username_verification.dart';
import '../../../create_posts/controller/create_post_controller.dart';
import '../../feed/views/gallery_feed_view_homepage.dart';
import '../controller/gallery_controller.dart';
import '../model/gallery_model.dart';
import '../widgets/gallery_tabs_widget.dart';

class ProfileBaseScreen extends ConsumerStatefulWidget {
  final bool isCurrentUser;
  static const routeName = 'profile';

  const ProfileBaseScreen({
    this.isCurrentUser = false,
    super.key,
  });

  @override
  ProfileBaseScreenState createState() => ProfileBaseScreenState();
}

class ProfileBaseScreenState extends ConsumerState<ProfileBaseScreen> {
  // final String albumId;
  GalleryModel? gallery;
  bool showHint = false;
  void hideHint() async {
    if (!showHint) {
      await Future.delayed(Duration(seconds: 2));
      setState(() => showHint = true);
      await Future.delayed(Duration(seconds: 4));
      setState(() => showHint = false);
    }
  }

  @override
  void initState() {
    super.initState();
    hideHint();
  }

  @override
  Widget build(BuildContext context) {
    // ref.watch(profileProvider(null));

    // final photoSet = ref.watch(postSetProvider('81'));
    // final galleries = ref.watch(galleryProvider(null));
    final galleries = ref.watch(filteredGalleryListProvider(null));
    final userState = ref.watch(appUserProvider);

    final user = userState.valueOrNull;

    final showGalleryFeed = ref.watch(showCurrentUserProfileFeedProvider);
    final gallerySimple = ref.watch(galleryFeedDataProvider);

    // ref.listen(gallerFeedDataProvider, (p, n) {
    //   print('FFFFFFFTTTTTTT ${n?.selectedIndex}');
    // });
    // final showPolaroid = ref.watch(showPolaroidProvider);
    // print('Show the jfldsajfjfjs')

    return user == null
        ? ProfileShimmerPage(
            onRefresh: () async {
              // ref.invalidate(filteredGalleryListProvider(null));
              //  ref.refresh(showCurrentUserProfileFeedProvider);
              HapticFeedback.lightImpact();
              ref.invalidate(isInitialOrRefreshGalleriesLoad);

              ref.invalidate(galleryFeedDataProvider);
              await ref.refresh(appUserProvider.future);
              await ref.refresh(galleryProvider(null).future);
            },
          )
        : WillPopScope(
            onWillPop: () async {
              // if (widget.isCurrentUser) {
              //   logOutFunction(onLogOut: () {
              // ref.read(appUserProvider.notifier).onLogOut();
              // ref.invalidate(appUserProvider);
              // });
              // } else {
              moveAppToBackGround();
              // }
              return false;
            },
            child: !showGalleryFeed
                ? Stack(
                    children: [
                      Scaffold(
                        appBar: VWidgetsAppBar(
                          backgroundColor:
                              Theme.of(context).scaffoldBackgroundColor,
                          // leadingWidth: 28,
                          leadingIcon: SizedBox.shrink(),

                          // appBarHeight: 42,
                          // appbarTitle:  user.username,
                          titleWidget: GestureDetector(
                            onLongPress: () {
                              HapticFeedback.lightImpact();
                              navigateToRoute(
                                  context,
                                  ProfileInputField(
                                    title: "Username",
                                    value: user.username,
                                    // isBio: true,
                                    onSave: (newValue) async {
                                      await ref
                                          .read(appUserProvider.notifier)
                                          .updateUsername(username: newValue);
                                    },
                                  ));
                            },
                            child: VerifiedUsernameWidget(
                              username: user.username,
                              isVerified: user.isVerified,
                              blueTickVerified: user.blueTickVerified,
                            ),
                          ),

                          elevation: 0,
                          trailingIcon: [
                            IconButton(
                              icon: NormalRenderSvgWithColor(
                                svgPath: VIcons.circleIcon,
                                color: Theme.of(context).iconTheme.color,
                              ),
                              onPressed: () {
                                //Menu settings

                                openVModelMenu(context);
                              },
                            ),
                          ],
                        ),
                        body: galleryView(
                          context,
                          user.username,
                          user.profilePictureUrl,
                          user.thumbnailUrl,
                          galleries,
                        ),
                      ),
                      if (showHint)
                        HintDialogue(
                          onTapDialogue: () => setState(() => showHint = false),
                          text: "Tap here to access menu",
                        )
                    ],
                  )
                : GalleryFeedViewHomepage(
                    galleryId: gallerySimple?.galleryId ?? '-1',
                    galleryName: gallerySimple?.galleryName ?? '',
                    username: user.username,
                    profilePictureUrl: '${user.profilePictureUrl}',
                    profileThumbnailUrl: '${user.thumbnailUrl}',
                    tappedIndex: gallerySimple?.selectedIndex ?? -1,
                  ),
          );
  }

  Widget galleryView(
      BuildContext context,
      String username,
      String? profilePictureUrl,
      String? thumbnailUrl,
      AsyncValue<List<GalleryModel>> galleries) {
    return DefaultTabController(
      length:
          galleries.valueOrNull != null ? (galleries.value?.length ?? 0) : 0,
      child: RefreshIndicator.adaptive(
        displacement: 20,
        edgeOffset: -20,
        triggerMode: RefreshIndicatorTriggerMode.anywhere,
        notificationPredicate: (notification) {
          // with NestedScrollView local(depth == 2) OverscrollNotification are not sent
          // notification.metrics.o
          // print(
          //     '[qqw] ${galleries.value?.length} depthA ${notification.depth} ');
          if (galleries.valueOrNull == null || (galleries.value!.isEmpty))
            return notification.depth == 1;
          return notification.depth == 2;
        },
        onRefresh: () async {
          // ref.invalidate(filteredGalleryListProvider(null));
          //  ref.refresh(showCurrentUserProfileFeedProvider);
          HapticFeedback.lightImpact();
          ref.invalidate(isInitialOrRefreshGalleriesLoad);

          ref.invalidate(galleryFeedDataProvider);
          await ref.refresh(appUserProvider.future);
          await ref.refresh(galleryProvider(null).future);
        },
        child: NestedScrollView(
          floatHeaderSlivers: true,
          headerSliverBuilder: (context, _) {
            return [
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    const ProfileHeaderWidget(),
                  ],
                ),
              ),
            ];
          },
          body: galleries.when(
            data: (value) {
              if (value.isEmpty) {
                return
                    // TabBarView(
                    //   children: [
                    const EmptyPage(
                  svgSize: 30,
                  svgPath: VIcons.gridIcon,
                  // title: 'No Galleries',
                  subtitle: 'Upload media to see content here.',
                  //   ),
                  // ],
                );
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  GalleryTabs(
                    key: ValueKey(value.first.id),
                    tabs: value.map((e) => Tab(text: e.name)).toList(),
                  ),
                  // addVerticalSpacing(5),
                  Expanded(
                    child: TabBarView(
                      key: ValueKey(value.first.id),
                      children: value.map((e) {
                        // return EmptyPage(
                        //     title: "No posts yet", subtitle: 'Create a new post today');
                        // return Container(color: Colors.red,height: 100, width: 300,);
                        return Gallery(
                          isSaved: false,
                          isCurrentUser: true,
                          albumID: e.id,
                          photos: e.postSets,
                          username: username,
                          userProfilePictureUrl: '$profilePictureUrl',
                          userProfileThumbnailUrl: '$thumbnailUrl',
                          gallery: e,
                        );
                      }).toList(),
                    ),
                  ),
                ],
              );
            },
            error: (err, stackTrace) {
              return Text('There was an error showing albums $err');
            },
            loading: () {
              return const Center(child: CircularProgressIndicator.adaptive());
            },
          ),
        ),
      ),
    );
  }

  // DefaultTabController polaroidView(
  //     List<GalleryModel> galleries, BuildContext context) {
  //   return DefaultTabController(
  //     length: galleries.length,
  //     child: NestedScrollView(
  //       headerSliverBuilder: (context, _) {
  //         return [
  //           SliverList(
  //             delegate: SliverChildListDelegate(
  //               [
  //                 addVerticalSpacing(20),
  //                 const ProfileHeaderWidget(),
  //               ],
  //             ),
  //           ),
  //         ];
  //       },
  //       body: Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: <Widget>[
  //             Material(
  //               color: Colors.white,
  //               child: TabBar(
  //                 labelStyle: Theme.of(context)
  //                     .textTheme
  //                     .displayMedium
  //                     ?.copyWith(fontWeight: FontWeight.w600),
  //                 labelColor: VmodelColors.primaryColor,
  //                 unselectedLabelColor: VmodelColors.unselectedText,
  //                 unselectedLabelStyle: Theme.of(context)
  //                     .textTheme
  //                     .displayMedium
  //                     ?.copyWith(fontWeight: FontWeight.w500),
  //                 indicatorColor: VmodelColors.mainColor,
  //                 isScrollable: true,
  //                 tabs: galleries.map((e) => Tab(text: e.name)).toList(),
  //               //   tabs: const [
  //               //     //! Dummy Data
  //               //     Tab(text: "Polaroid 1"),
  //               //     Tab(text: "Polaroid 2"),
  //               //   ],
  //               ),
  //             ),
  //              Expanded(
  //               child: TabBarView(
  //                 children:
  //                 galleries.map((e) {
  //                   // return EmptyPage(
  //                   //     title: "No posts yet", subtitle: 'Create a new post today');
  //                   // return Container(color: Colors.red,height: 100, width: 300,);
  //                   return Gallery(albumID: e.id, photos: e.postSets);
  //                 }).toList(),
  //
  //               ),
  //             ),
  //           ]),
  //     ),
  //   );
  // }

  /// User Log Out Function
  // logOutFunction({required VoidCallback onLogOut}) {
  //   closeAnySnack();

  //   showDialog(
  //       context: context,
  //       builder: ((context) => VWidgetsConfirmationPopUp(
  //             popupTitle: "Logout Confirmation",
  //             popupDescription:
  //                 "Are you sure you want to logout from your account?",
  //             onPressedYes: () async {
  //               Navigator.pop(context);
  //               await VModelSharedPrefStorage()
  //                   .clearObject(VSecureKeys.userTokenKey);
  //               // await VModelSharedPrefStorage().clearObject('pk');
  //               await VModelSharedPrefStorage()
  //                   .clearObject(VSecureKeys.username);
  //               // await VModelSharedPrefStorage()
  //               //     .clearObject(VSecureKeys.restTokenKey);
  //               // VCredentials.inst.stroage .deleteKeyStoreData(VSecureKeys.restTokenKey);
  //               onLogOut();
  //               if (!mounted) return;
  //               navigateAndRemoveUntilRoute(context, LoginPage());
  //             },
  //             onPressedNo: () {
  //               Navigator.pop(context);
  //             },
  //           )));
  // }
}
