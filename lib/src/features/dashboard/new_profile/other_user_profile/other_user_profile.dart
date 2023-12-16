import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vmodel/src/features/connection/controller/provider/connection_provider.dart';
import 'package:vmodel/src/features/dashboard/new_profile/other_user_profile/widgets/other_user_profile_functionality_widget.dart';
import 'package:vmodel/src/res/icons.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/shared/appbar/appbar.dart';
import 'package:vmodel/src/shared/rend_paint/render_svg.dart';
import 'package:vmodel/src/vmodel.dart';
import '../../../../shared/empty_page/empty_page.dart';
import '../../../../shared/shimmer/profileShimmerPage.dart';
import '../../../../shared/username_verification.dart';
import '../../../print/controller/print_gallery_controller.dart';
import '../../feed/controller/feed_strip_depth.dart';
import '../controller/gallery_controller.dart';
import '../../profile/controller/profile_controller.dart';
import '../widgets/gallery_tabscreen_widget.dart';
import 'other_user_profile_header_widget.dart';

class OtherUserProfile extends ConsumerStatefulWidget {
  final String username;

  const OtherUserProfile({
    super.key,
    required this.username,
  });

  @override
  OtherUserProfileState createState() => OtherUserProfileState();
}

class OtherUserProfileState extends ConsumerState<OtherUserProfile> {
  bool userBlock = false;
  @override
  Widget build(BuildContext context) {
    // ref.watch(profileProvider);
    // final photoSet = ref.watch(postSetProvider('81'));
    // final galleries = ref.watch(galleryProvider(widget.username));
    final ooy = ref.watch(connectionProcessingProvider);
    ref.listen(connectionProcessingProvider, (p, n) {
      print('[dsd] other main $p <--> $n (watch is $ooy)');
    });
    final connections = ref.watch(getConnections);
    final galleries = ref.watch(filteredGalleryListProvider(widget.username));
    // final albums = ref.watch(albumsProvider(widget.username));
    final userState = ref.watch(profileProvider(widget.username));
    final user = userState.valueOrNull;
    ref.watch(printGalleryTypeFilterProvider("${widget.username}"));

    print("isPostNotificationOn ${user?.username}");

    return user == null
        ? const ProfileShimmerPage(isPopToBackground: true)
        : Scaffold(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            appBar: VWidgetsAppBar(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              leadingIcon: VWidgetsBackButton(
                buttonColor: Theme.of(context).iconTheme.color,
                onTap: () {
                  ref.read(feedNavigationDepthProvider.notifier).decrement();
                  goBack(context);
                },
              ),
              // appbarTitle:  user.username,
              // titleWidget: VerifiedUsernameWidget(username: user.username),
              titleWidget: VerifiedUsernameWidget(
                username: user.username,
                isVerified: user.isVerified,
                blueTickVerified: user.blueTickVerified,
              ),
              elevation: 0,
              trailingIcon: [
                IconButton(
                  icon: NormalRenderSvgWithColor(
                    svgPath: VIcons.viewOtherProfileMenu,
                    color: Theme.of(context).iconTheme.color,
                  ),
                  onPressed: () {
                    //Menu settings
                    showModalBottomSheet<void>(
                        context: context,
                        backgroundColor: Colors.transparent,
                        isScrollControlled: true,
                        builder: (BuildContext context) {
                          return Container(
                            padding: const EdgeInsets.only(left: 16, right: 16),
                            decoration: BoxDecoration(
                              color: Theme.of(context).scaffoldBackgroundColor,
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(13),
                                topRight: Radius.circular(13),
                              ),
                            ),
                            child: VWidgetsOtherUserProfileFunctionality(
                                isPostNotificationOn: user.postNotification!,
                                isCouponNotificationOn:
                                    user.couponNotification!,
                                isJobNotificationOn: user.couponNotification!,
                                connectionStatus: user.connectionStatus,
                                username: widget.username),
                          );
                        });
                  },
                ),
              ],
            ),

            // body: Container(height: 150, width: 300, color: Colors.blue,)
            /**/
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
                  physics: BouncingScrollPhysics(),
                  headerSliverBuilder: (context, _) {
                    return [
                      SliverList(
                        delegate: SliverChildListDelegate(
                          [
                            addVerticalSpacing(20),
                            OtherUserProfileHeaderWidget(
                              username: widget.username,
                              profilePictureUrl: user.profilePictureUrl,
                              profilePictureUrlThumbnail: user.thumbnailUrl,
                              connectionStatus: user.connectionStatus,
                              connectionId: user.connectionId,
                            ),
                            // const ProfileHeaderWidget(),
                          ],
                        ),
                      ),
                    ];
                  },
                  body: galleries.when(data: (value) {
                    if (value.isEmpty) {
                      return const EmptyPage(
                        // shouldCenter: true,
                        svgSize: 30,
                        svgPath: VIcons.gridIcon,
                        // title: 'No Galleries',
                        subtitle: 'No galleries.',
                      );
                    }
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Material(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          child: TabBar(
                            labelStyle: Theme.of(context)
                                .textTheme
                                .displayMedium
                                ?.copyWith(fontWeight: FontWeight.w600),
                            labelColor:
                                Theme.of(context).tabBarTheme.labelColor,
                            unselectedLabelColor: Theme.of(context)
                                .tabBarTheme
                                .unselectedLabelColor,
                            unselectedLabelStyle: Theme.of(context)
                                .textTheme
                                .displayMedium
                                ?.copyWith(fontWeight: FontWeight.w500),
                            indicatorColor: Theme.of(context).indicatorColor,
                            isScrollable: true,
                            tabs: value.map((e) => Tab(text: e.name)).toList(),
                          ),
                        ),
                        addVerticalSpacing(5),
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
                                userProfileThumbnailUrl: '${user.thumbnailUrl}',
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
                    return const Center(
                        child: CircularProgressIndicator.adaptive());
                  }),
                ),
              ),
            ),
          );
  }
}
