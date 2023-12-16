import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:vmodel/src/core/utils/debounce.dart';
import 'package:vmodel/src/features/connection/controller/provider/connection_provider.dart';
import 'package:vmodel/src/features/messages/views/messages_homepage.dart';
import 'package:vmodel/src/features/notifications/widgets/date_time_extension.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/shared/buttons/primary_button.dart';
import 'package:vmodel/src/shared/shimmer/connections_shimmer.dart';

import '../../../core/routing/navigator_1.0.dart';
import '../../dashboard/feed/controller/feed_controller.dart';
import '../../dashboard/feed/model/feed_model.dart';
import '../../dashboard/new_profile/views/other_profile_router.dart';
import '../../notifications/controller/provider/notification_provider.dart';
import '../../notifications/widgets/notification_card.dart';
import '../../notifications/widgets/single_post_view.dart';
import '../widgets/notification_end_widget.dart';

class VMCNotifications extends ConsumerStatefulWidget {
  const VMCNotifications({super.key});
   static const route = '/notification-scree';

  @override
  ConsumerState<VMCNotifications> createState() => _VMCNotificationsState();
}

class _VMCNotificationsState extends ConsumerState<VMCNotifications> {
  final homeCtrl = Get.put<HomeController>(HomeController());
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  Future<void> reloadData() async {}

  final _scrollController = ScrollController();
  final _debounce = Debounce();
  final _loadingMore = ValueNotifier(false);
  bool _showLoadingIndicator = false;
  @override
  void initState() {
    _scrollController.addListener(() {
      final maxScroll = _scrollController.position.maxScrollExtent;
      final currentScroll = _scrollController.position.pixels;
      final delta = SizerUtil.height * 0.2;
      if (maxScroll - currentScroll <= delta) {
        _debounce(() {
          ref.read(getNotifications.notifier).fetchMoreHandler();
        });
      }
    });
    super.initState();
  }

  // void loadMoreCallback() {
  //   final maxScroll = _scrollController.position.maxScrollExtent;
  //   final currentScroll = _scrollController.position.pixels;
  //   final delta = SizerUtil.height * 0.2;
  //   if (maxScroll - currentScroll <= delta) {
  //     print('Scroll listender fetching more items [[55]]');
  //     _debounce(() async {
  //       _loadingMore.value = true;
  //       await ref.read(getNotifications.notifier).fetchMoreHandler();
  //       _loadingMore.value = false;
  //     });
  //   }
  // }
  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
    _debounce.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final notifications = ref.watch(getNotifications);
    return Scaffold(
      // appBar: VWidgetsAppBar(
      //   leadingIcon: VWidgetsBackButton(),
      //   appbarTitle: "Notification",
      // ),
      body: RefreshIndicator.adaptive(
        key: _refreshIndicatorKey,
        onRefresh: () async {
          HapticFeedback.lightImpact();
          await ref.refresh(getNotifications);
        },
        child: CustomScrollView(
          controller: _scrollController,
          physics: const BouncingScrollPhysics(),
          slivers: [
            notifications.when(
                data: (data) {
                  return SliverPadding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                    sliver: SliverList.separated(
                        itemCount: data.length,
                        separatorBuilder: (context, index) =>
                            addVerticalSpacing(10),
                        itemBuilder: (context, index) {
                          var datum = data[index];

                          bool isSameDate = true;
                          final String dateString =
                              datum['createdAt'].toString();
                          final DateTime date = DateTime.parse(dateString);
                          if (index == 0) {
                            isSameDate = false;
                          } else {
                            final String prevDateString =
                                datum['createdAt'].toString();
                            final DateTime prevDate =
                                DateTime.parse(prevDateString);
                            isSameDate = date.isSameDate(prevDate);
                          }
                          var connectionId;
                          var meta = jsonDecode(datum['meta']);
                          print("metaaa ${meta == null}");
                          if (datum['modelGroup'].toLowerCase() ==
                                  'connection' &&
                              meta['connection_id'] != null) {
                            connectionId = meta['connection_id'];
                            print("fwenj $connectionId");
                          }
                          final String username = datum['message']
                              .toString()
                              .split(" ")
                              .first
                              .toLowerCase();

                          final String profilePictureUrl =
                              datum['profilePictureUrl'] ?? '';

                          final postMap = datum['post'];
                          return _listItemWidget(
                            url: profilePictureUrl,
                            profileThumbnailUrl: profilePictureUrl,
                            notificationText: "${datum['message']}",
                            username: username,
                            context: context,
                            date: date.timeAgo(),
                            postMap: postMap,
                            onUserTapped: () => navigateToRoute(
                                context,
                                OtherProfileRouter(
                                  username: username,
                                )),
                            trailing: datum['meta'] == null
                                ? null
                                : datum['isConnectionRequest']
                                    ? datum['connected']
                                        ? SizedBox(
                                            width: 100,
                                            child: VWidgetsPrimaryButton(
                                              buttonHeight: 35,
                                              buttonTitleTextStyle: Theme.of(
                                                      context)
                                                  .textTheme
                                                  .displayLarge
                                                  ?.copyWith(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: Theme.of(context)
                                                          .scaffoldBackgroundColor),
                                              onPressed: null,

                                              buttonTitle:
                                                  "Accepted", //widget.trailingButtonText,
                                            ),
                                          )
                                        : SizedBox(
                                            width: 100,
                                            child: VWidgetsPrimaryButton(
                                              buttonHeight: 35,
                                              showLoadingIndicator:
                                                  _showLoadingIndicator
                                                      ? true
                                                      : false,
                                              buttonTitleTextStyle:
                                                  Theme.of(context)
                                                      .textTheme
                                                      .displayLarge
                                                      ?.copyWith(
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color:
                                                              Theme.of(context)
                                                                  .buttonTheme
                                                                  .colorScheme
                                                                  ?.onPrimary),
                                              onPressed: () async {
                                                // var data = json.decode(source)
                                                setState(() =>
                                                    _showLoadingIndicator =
                                                        true);
                                                await ref
                                                    .read(connectionProvider)
                                                    .updateConnection(
                                                        true,
                                                        int.parse(connectionId
                                                            .toString()));
                                                setState(() =>
                                                    _showLoadingIndicator =
                                                        false);
                                                await _refreshIndicatorKey
                                                    .currentState!
                                                    .show();
                                              },
                                              buttonTitle:
                                                  "Accept", //widget.trailingButtonText,
                                            ),
                                          )
                                    : null,
                          );
                        }),
                  );
                },
                error: (error, stack) => SliverFillRemaining(
                      child: Center(
                        child: Text(error.toString()),
                      ),
                    ),
                loading: () =>
                    SliverFillRemaining(child: ConnectionsShimmerPage())),
            SliverPadding(
                padding: EdgeInsets.only(bottom: 10),
                sliver: SliverList.list(
                  children: [
                  notifications.when(data: (data) {
                     return  NotificationEndWidget(
                      message: data.isEmpty ? "You have no new notifications" : 
                        "End of Notifications"
                      ,
                    );
                  },   error: (error, stack) => SliverFillRemaining(
                      child: Center(
                        child: Text(error.toString()),
                      ),
                    ),
                loading: () =>
                    SliverFillRemaining(child: ConnectionsShimmerPage())),
                  ],
                )),
          ],
        ),
      ),
    );
  }
  // NotificationEndWidget(),

  Widget _listItemWidget({
    String? url,
    required String notificationText,
    Widget? trailing,
    required BuildContext context,
    required String profileThumbnailUrl,
    String? date,
    required Function() onUserTapped,
    required String username,
    required Map<String, dynamic>? postMap,
  }) {
    return GestureDetector(
      onTap: () {
        _showPostIfAny(
            username: username,
            profilePictureUrl: profileThumbnailUrl,
            postMap: postMap);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 3,
            child: VWidgetsNotificationCard(
              onUserTapped: () => navigateToRoute(
                  context,
                  OtherProfileRouter(
                    username: username,
                  )),
              displayName: username[0].toUpperCase(),
              notificationText: notificationText,
              profileImageUrl: url,
              // profileThumbnailUrl: profileThumbnailUrl,
              checkProfilePicture: url == null ? false : true,
              date: date,
            ),
          ),
          if (trailing != null) Flexible(child: trailing),
        ],
      ),
    );
  }

  void _showPostIfAny({
    required String username,
    required String profilePictureUrl,
    required Map<String, dynamic>? postMap,
  }) {
    if (postMap == null) {
      navigateToRoute(context, OtherProfileRouter(username: username));
    } else {
      final post = FeedPostSetModel.fromMap(postMap);
      navigateToRoute(
          context, SinglePostView(isCurrentUser: false, postSet: post));
    }
  }
}

//  _listItemWidget(
//                     context: context,
//                     url: "dd",
//                     text: "Samantha wants to connect",
//                     date: "3d",
//                     trailing: SizedBox(
//                       width: 100,
//                       child: VWidgetsPrimaryButton(
//                         buttonHeight: 35,
//                         buttonTitleTextStyle: Theme.of(context)
//                             .textTheme
//                             .displayLarge
//                             ?.copyWith(
//                                 fontWeight: FontWeight.w400,
//                                 color:
//                                     Theme.of(context).scaffoldBackgroundColor),
//                         onPressed: () async {},
//                         buttonTitle: "Accept", //widget.trailingButtonText,
//                       ),
//                     ),
//                   ),
