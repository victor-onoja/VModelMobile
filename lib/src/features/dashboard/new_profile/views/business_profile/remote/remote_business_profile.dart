import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vmodel/src/core/cache/credentials.dart';
import 'package:vmodel/src/core/cache/local_storage.dart';
import 'package:vmodel/src/core/utils/helper_functions.dart';
import 'package:vmodel/src/features/authentication/login/views/sign_in.dart';
import 'package:vmodel/src/features/dashboard/new_profile/widgets/gallery_tabscreen_widget.dart';
import 'package:vmodel/src/res/icons.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/shared/appbar/appbar.dart';
import 'package:vmodel/src/shared/popup_dialogs/confirmation_popup.dart';
import 'package:vmodel/src/shared/rend_paint/render_svg.dart';
import 'package:vmodel/src/vmodel.dart';

import '../../../../../../shared/empty_page/empty_page.dart';
import '../../../../../../shared/pop_scope_to_background_wrapper.dart';
import '../../../../../../shared/shimmer/profileShimmerPage.dart';
import '../../../../../../shared/username_verification.dart';
import '../../../../../connection/controller/provider/connection_provider.dart';
import '../../../../feed/controller/feed_strip_depth.dart';
import '../../../../profile/controller/profile_controller.dart';
import '../../../controller/gallery_controller.dart';
import '../../../other_user_profile/widgets/other_user_profile_functionality_widget.dart';
import '../../../widgets/gallery_tabs_widget.dart';
import 'remote_business_profile_header_widget.dart';

class RemoteBusinessProfileBaseScreen extends ConsumerStatefulWidget {
  final bool isCurrentUser;
  final String username;

  const RemoteBusinessProfileBaseScreen({
    super.key,
    required this.username,
    this.isCurrentUser = false,
  });

  @override
  BusinessProfileBaseScreenState createState() =>
      BusinessProfileBaseScreenState();
}

class BusinessProfileBaseScreenState
    extends ConsumerState<RemoteBusinessProfileBaseScreen> {
  @override
  Widget build(BuildContext context) {
    // final userState = ref.watch(appUserProvider);
    // final user = userState.valueOrNull;
    final connections = ref.watch(getConnections);
    final galleries = ref.watch(filteredGalleryListProvider(widget.username));

    final userState = ref.watch(profileProvider(widget.username));
    final user = userState.valueOrNull;

    // return const PopToBackgroundWrapper(child: ProfileShimmerPage());
    return user == null
        ? const PopToBackgroundWrapper(child: ProfileShimmerPage())
        : WillPopScope(
            onWillPop: () async {
              if (widget.isCurrentUser) {
                logOutFunction();
                return false;
              }
              return true;
            },
            child: Scaffold(
              appBar: VWidgetsAppBar(
                leadingIcon: VWidgetsBackButton(
                  onTap: () {
                    ref.read(feedNavigationDepthProvider.notifier).decrement();
                    goBack(context);
                  },
                ),
                // appbarTitle: "Other businesss",
                // titleWidget: VerifiedUsernameWidget(username: user.username),
                titleWidget: VerifiedUsernameWidget(
                  username: user.username,
                  isVerified: user.isVerified,
                  blueTickVerified: user.blueTickVerified,
                ),
                elevation: 0,
                trailingIcon: [
                  IconButton(
                    icon: const RenderSvg(
                      svgPath: VIcons.viewOtherProfileMenu,
                    ),
                    onPressed: () {
                      //Menu settings
                      showModalBottomSheet<void>(
                          context: context,
                          backgroundColor: Colors.transparent,
                          builder: (BuildContext context) {
                            return Container(
                              padding:
                                  const EdgeInsets.only(left: 16, right: 16),
                              decoration: BoxDecoration(
                                // color: VmodelColors.appBarBackgroundColor,
                                color: Theme.of(context).colorScheme.surface,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(13),
                                  topRight: Radius.circular(13),
                                ),
                              ),
                              child: VWidgetsOtherUserProfileFunctionality(
                                  isCouponNotificationOn:
                                      user.couponNotification!,
                                  isJobNotificationOn: user.jobNotification!,
                                  isPostNotificationOn: user.postNotification!,
                                  connectionStatus: user.connectionStatus,
                                  username: widget.username),
                            );
                          });
                    },
                  ),
                ],
              ),
              body: DefaultTabController(
                length: galleries.valueOrNull != null
                    ? galleries.value?.length ?? 0
                    : 0,
                child: RefreshIndicator.adaptive(
                  displacement: 20,
                  edgeOffset: -20,
                  triggerMode: RefreshIndicatorTriggerMode.anywhere,
                  notificationPredicate: (notification) {
                    // with NestedScrollView local(depth == 2) OverscrollNotification are not sent
                    // notification.metrics.o
                    if (galleries.valueOrNull == null ||
                        (galleries.value!.isEmpty))
                      return notification.depth == 1;
                    return notification.depth == 2;
                  },
                  onRefresh: () async {
                    HapticFeedback.lightImpact();
                    ref.invalidate(galleryFeedDataProvider);

                    ref.invalidate(getConnections);
                    await ref.refresh(profileProvider(widget.username));
                    await ref.refresh(galleryProvider(widget.username).future);
                  },
                  child: NestedScrollView(
                    headerSliverBuilder: (context, _) {
                      return [
                        SliverList(
                          delegate: SliverChildListDelegate(
                            [
                              addVerticalSpacing(20),
                              // BusinessProfileHeaderWidget(
                              //   username: user.username,
                              // ),
                              RemoteBusinessProfileHeaderWidget(
                                username: widget.username,
                                profilePictureUrl: user.profilePictureUrl,
                                profilePictureUrlThumbnail: user.thumbnailUrl,
                                connectionStatus: user.connectionStatus,
                                connectionId: user.connectionId,
                              ),
                            ],
                          ),
                        ),
                      ];
                    },
                    body: galleries.when(data: (value) {
                      if (value.isEmpty) {
                        return const EmptyPage(
                          svgSize: 30,
                          svgPath: VIcons.gridIcon,
                          // title: 'No Galleries',
                          subtitle: 'No galleries.',
                        );
                      }
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          GalleryTabs(
                            tabs: value.map((e) => Tab(text: e.name)).toList(),
                          ),
                          // Material(
                          //   // color: Colors.white,
                          //   color: Theme.of(context).scaffoldBackgroundColor,
                          //   child: TabBar(
                          //     labelStyle: Theme.of(context)
                          //         .textTheme
                          //         .displayMedium
                          //         ?.copyWith(fontWeight: FontWeight.w600),
                          //     // labelColor: VmodelColors.primaryColor,
                          //     unselectedLabelColor: VmodelColors.unselectedText,
                          //     unselectedLabelStyle: Theme.of(context)
                          //         .textTheme
                          //         .displayMedium
                          //         ?.copyWith(fontWeight: FontWeight.w500),
                          //     indicatorColor: VmodelColors.mainColor,
                          //     isScrollable: true,
                          //     tabs: value.map((e) => Tab(text: e.name)).toList(),
                          //   ),
                          // ),
                          Expanded(
                            child: TabBarView(
                              children: value.map((e) {
                                // return EmptyPage(
                                //     title: "No posts yet", subtitle: 'Create a new post today');
                                // return Container(color: Colors.red,height: 100, width: 300,);
                                return Gallery(
                                  isSaved: false,
                                  albumID: e.id,
                                  photos: e.postSets,
                                  userProfilePictureUrl:
                                      '${user.profilePictureUrl}',
                                  userProfileThumbnailUrl:
                                      '${user.thumbnailUrl}',
                                  username: widget.username,
                                  gallery: e,
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      );
                    }, error: (err, stackTrace) {
                      return Text('There was an error showing galleries $err');
                    }, loading: () {
                      return const Center(child: CircularProgressIndicator());
                    }),
                  ),
                ),
              ),
              // body: DefaultTabController(
              //   length: 5,
              //   child: NestedScrollView(
              //     headerSliverBuilder: (context, _) {
              //       return [
              //         SliverList(
              //           delegate: SliverChildListDelegate(
              //             [
              //               addVerticalSpacing(20),
              //               BusinessProfileHeaderWidget(
              //                 username: user.username,
              //               ),
              //             ],
              //           ),
              //         ),
              //       ];
              //     },
              //     body: Column(
              //       crossAxisAlignment: CrossAxisAlignment.start,
              //       children: <Widget>[
              //         Material(
              //           color: Colors.white,
              //           child: TabBar(
              //             labelStyle: Theme.of(context)
              //                 .textTheme
              //                 .displayMedium
              //                 ?.copyWith(fontWeight: FontWeight.w600),
              //             labelColor: VmodelColors.primaryColor,
              //             unselectedLabelColor: VmodelColors.unselectedText,
              //             unselectedLabelStyle: Theme.of(context)
              //                 .textTheme
              //                 .displayMedium
              //                 ?.copyWith(fontWeight: FontWeight.w500),
              //             indicatorColor: VmodelColors.mainColor,
              //             isScrollable: true,
              //             tabs: const [
              //               Tab(text: "Features"),
              //             ],
              //           ),
              //         ),
              //         //Todo remove dummy data passed to Gallery widget
              //         Expanded(
              //           child: TabBarView(
              //             children: [
              //               Gallery(
              //                 isSaved: false,
              //                 photos: const [],
              //                 albumID: '1',
              //                 username: '',
              //                 userProfilePictureUrl: '',
              //                 gallery: const GalleryModel(
              //                     galleryType: AlbumType.portfolio,
              //                     id: '',
              //                     name: '',
              //                     postSets: []),
              //               ),
              //             ],
              //           ),
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
            ),
          );
  }

  /// User Log Out Function
  logOutFunction() {
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
                if (!mounted) return;
                navigateAndRemoveUntilRoute(context, LoginPage());
              },
              onPressedNo: () {
                Navigator.pop(context);
              },
            )));
  }
}
