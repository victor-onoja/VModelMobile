import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vmodel/src/core/cache/credentials.dart';
import 'package:vmodel/src/core/cache/local_storage.dart';
import 'package:vmodel/src/core/utils/helper_functions.dart';
import 'package:vmodel/src/features/authentication/login/views/sign_in.dart';
import 'package:vmodel/src/features/dashboard/new_profile/widgets/profile_header_widget.dart';
import 'package:vmodel/src/features/dashboard/new_profile/widgets/gallery_tabscreen_widget.dart';
import 'package:vmodel/src/res/icons.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/shared/appbar/appbar.dart';
import 'package:vmodel/src/shared/popup_dialogs/confirmation_popup.dart';
import 'package:vmodel/src/shared/rend_paint/render_svg.dart';
import 'package:vmodel/src/vmodel.dart';

import '../../../../core/controller/app_user_controller.dart';
import '../../../../shared/empty_page/empty_page.dart';
import '../../../../shared/shimmer/profileShimmerPage.dart';
import '../../../../shared/username_verification.dart';
import '../../feed/views/gallery_feed_view_homepage.dart';
import '../controller/gallery_controller.dart';
import '../model/gallery_model.dart';

class MyBusinessProfile extends ConsumerStatefulWidget {
  final bool isCurrentUser;

  const MyBusinessProfile({
    this.isCurrentUser = false,
    super.key,
  });

  @override
  MyBusinessProfileState createState() => MyBusinessProfileState();
}

class MyBusinessProfileState extends ConsumerState<MyBusinessProfile> {
  // final String albumId;
  GalleryModel? gallery;

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
        ? const ProfileShimmerPage()
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
                ? Scaffold(
                    // backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    appBar: VWidgetsAppBar(
                      leadingWidth: 28,
                      leadingIcon: const SizedBox(),
                      // appbarTitle:  user.username,
                      // titleWidget: VerifiedUsernameWidget(
                      //   username: user.username,
                      // ),
                      titleWidget: VerifiedUsernameWidget(
                        username: user.username,
                        isVerified: user.isVerified,
                        blueTickVerified: user.blueTickVerified,
                      ),
                      elevation: 0,
                      trailingIcon: [
                        IconButton(
                          icon: const NormalRenderSvg(
                            svgPath: VIcons.circleIcon,
                          ),
                          onPressed: () {
                            //Menu settings
                            openVModelMenu(context);
                          },
                        ),
                      ],
                    ),
                    body:
                        // showPolaroid
                        //     ? galleryView(galleries, context)
                        //     :
                        galleryView(
                      context,
                      user.username,
                      user.profilePictureUrl,
                      user.thumbnailUrl,
                      galleries,
                    ),
                  )
                : GalleryFeedViewHomepage(
                    // isSaved: widget.isSaved,
                    // items: e.photos,
                    // isCurrentUser: widget.isCurrentUser,
                    // postTime: widget.gallery,
                    galleryId: gallerySimple?.galleryId ?? '-1',
                    galleryName: gallerySimple?.galleryName ?? '',
                    username: user.username,
                    profilePictureUrl: '${user.profilePictureUrl}',
                    profileThumbnailUrl: '${user.thumbnailUrl}',
                    tappedIndex: gallerySimple?.selectedIndex ?? -1,
                  ),
          );
  }

  DefaultTabController galleryView(
      BuildContext context,
      String username,
      String? profilePictureUrl,
      String? thumbnailUrl,
      AsyncValue<List<GalleryModel>> galleries) {
    return DefaultTabController(
      length: galleries.valueOrNull != null ? galleries.value?.length ?? 0 : 0,
      child: NestedScrollView(
        headerSliverBuilder: (context, _) {
          return [
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  addVerticalSpacing(20),
                  const ProfileHeaderWidget(),
                ],
              ),
            ),
          ];
        },
        body: galleries.when(data: (value) {
          if (value.isEmpty) {
            return Center(
              child: Container(
                  // color: VmodelColors.white,
                  color: Theme.of(context).scaffoldBackgroundColor,
                  child: const EmptyPage(
                    svgSize: 30,
                    svgPath: VIcons.gridIcon,
                    // title: 'No Galleries',
                    subtitle: 'Upload media to see content here.',
                  )),
            );
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Material(
                color: Colors.white,
                child: TabBar(
                  labelStyle: Theme.of(context)
                      .textTheme
                      .displayMedium
                      ?.copyWith(fontWeight: FontWeight.w600),
                  labelColor: VmodelColors.primaryColor,
                  unselectedLabelColor: VmodelColors.unselectedText,
                  unselectedLabelStyle: Theme.of(context)
                      .textTheme
                      .displayMedium
                      ?.copyWith(fontWeight: FontWeight.w500),
                  indicatorColor: VmodelColors.mainColor,
                  isScrollable: true,
                  tabs: value.map((e) => Tab(text: e.name)).toList(),
                ),
              ),
              Expanded(
                child: TabBarView(
                  children: value.map((e) {
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
        }, error: (err, stackTrace) {
          return Text('There was an error showing albums $err');
        }, loading: () {
          return const Center(child: CircularProgressIndicator.adaptive());
        }),
      ),
    );
  }

  /// User Log Out Function
  logOutFunction({required VoidCallback onLogOut}) {
    closeAnySnack();

    showDialog(
        context: context,
        builder: ((context) => VWidgetsConfirmationPopUp(
              popupTitle: "Logout Confirmation",
              popupDescription:
                  "Are you sure you want to logout from your account?",
              onPressedYes: () async {
                Navigator.pop(context);
                await VModelSharedPrefStorage()
                    .clearObject(VSecureKeys.userTokenKey);
                // await VModelSharedPrefStorage().clearObject('pk');
                await VModelSharedPrefStorage()
                    .clearObject(VSecureKeys.username);
                // await VModelSharedPrefStorage()
                //     .clearObject(VSecureKeys.restTokenKey);
                // VCredentials.inst.stroage .deleteKeyStoreData(VSecureKeys.restTokenKey);
                onLogOut();
                if (!mounted) return;
                navigateAndRemoveUntilRoute(context, LoginPage());
              },
              onPressedNo: () {
                Navigator.pop(context);
              },
            )));
  }
}
