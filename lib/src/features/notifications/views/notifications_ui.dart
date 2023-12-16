import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:vmodel/src/features/dashboard/feed/controller/feed_controller.dart';
import 'package:vmodel/src/features/notifications/controller/provider/notification_provider.dart';
import 'package:vmodel/src/features/notifications/widgets/date_month_extension.dart';
import 'package:vmodel/src/features/notifications/widgets/date_text_header.dart';
import 'package:vmodel/src/features/notifications/widgets/notification_card.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/shared/empty_page/empty_page.dart';
import 'package:vmodel/src/vmodel.dart';
import 'package:vmodel/src/features/notifications/widgets/date_time_extension.dart';

import '../../../core/utils/debounce.dart';
import '../../../res/icons.dart';
import '../../../shared/shimmer/connections_shimmer.dart';
import '../../dashboard/feed/model/feed_model.dart';
import '../../dashboard/new_profile/views/other_profile_router.dart';
import '../widgets/single_post_view.dart';

class NotificationsView extends ConsumerStatefulWidget {
  const NotificationsView({super.key});

  static const route = '/notification-scree';

  @override
  ConsumerState<NotificationsView> createState() => _NotificationsViewState();
}

class _NotificationsViewState extends ConsumerState<NotificationsView> {
  final homeCtrl = Get.put<HomeController>(HomeController());

  Future<void> reloadData() async {}

  final _scrollController = ScrollController();
  final _debounce = Debounce();
  final _loadingMore = ValueNotifier(false);
  @override
  void initState() {
    _scrollController.addListener(loadMoreCallback);
    super.initState();
  }

  void loadMoreCallback() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    final delta = SizerUtil.height * 0.2;
    if (maxScroll - currentScroll <= delta) {
      print('Scroll listender fetching more items [[55]]');
      _debounce(() async {
        _loadingMore.value = true;
        await ref.read(getNotifications.notifier).fetchMoreHandler();
        _loadingMore.value = false;
      });
    }
  }

  @override
  dispose() {
    _scrollController.removeListener(loadMoreCallback);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final notifications = ref.watch(getNotifications);

    final message = ModalRoute.of(context)!.settings.arguments;

    print('------------notification');
    // print('Notification screen ${message.notification!.title}');
    // print('Notification screen ${message.notification!.body}');

    return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        // appBar: const VWidgetsAppBar(
        //   appBarHeight: 50,
        //   // backgroundColor: VmodelColors.appBarBackgroundColor,
        //   leadingIcon: VWidgetsBackButton(),

        //   appbarTitle: "Notifications",
        //   // trailingIcon: [
        //   //   Padding(
        //   //     padding: const EdgeInsets.only(top: 12),
        //   //     child: VWidgetsNotificationAppbarIcons(
        //   //       onPressedClip: () {
        //   //         navigateToRoute(context,  SavedView());
        //   //       },
        //   //       onPressedSend: () {
        //   //         navigateToRoute(context, const MessagingHomePage());
        //   //       },
        //   //     ),
        //   //   ),
        //   // ],
        // ),
        body: notifications.when(data: (List<dynamic> data) {
          // print(data);
          // if(data.isEmpty) {

          // }
          return Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: Column(
              children: [
                Expanded(
                  // child: data.fold((left) => Text(left.message), (right) {
                  child: RefreshIndicator.adaptive(
                    onRefresh: () async {
                      HapticFeedback.lightImpact();
                      ref.refresh(getNotifications.future);
                    },
                    child: data.isEmpty
                        ? const EmptyPage(
                            svgPath: VIcons.notificationIcon,
                            svgSize: 30,
                            // title: 'No Posts Yet',
                            subtitle: "You don't have any notifications yet",
                          )
                        : ListView.builder(
                            controller: _scrollController,
                            physics: const BouncingScrollPhysics(),
                            itemCount: data.length,
                            itemBuilder: (BuildContext context, int index) {
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

                              final String username = datum['message']
                                  .toString()
                                  .split(" ")
                                  .first
                                  .toLowerCase();

                              final String profilePictureUrl =
                                  datum['profilePictureUrl'] ?? '';
                              final String thumbnailUrl =
                                  datum['thumbnailUrl'] ?? '';

                              final postMap = datum['post'];

                              if (index == 0 || !(isSameDate)) {
                                return Column(children: [
                                  // ),
                                  addVerticalSpacing(15),
                                  Padding(
                                    padding: const VWidgetsPagePadding
                                        .horizontalSymmetric(5),
                                    child: VWidgetsDateHeader(
                                      dateAbbreviation: date.monthAgo(),
                                    ),
                                  ),

                                  addVerticalSpacing(8),
                                  GestureDetector(
                                    onTap: () {
                                      // navigateToRoute(
                                      //     context,
                                      //     OtherUserProfile(
                                      //       username: datum['message']
                                      //           .toString()
                                      //           .split(" ")
                                      //           .first
                                      //           .toLowerCase(),
                                      //     ));

                                      _showPostIfAny(
                                          username: username,
                                          profilePictureUrl: profilePictureUrl,
                                          postMap: postMap);
                                      // VWidgetShowResponse.showToast(
                                      //     ResponseEnum.sucesss,
                                      //     message: "Do something first");
                                    },
                                    child: VWidgetsNotificationCard(
                                      onUserTapped: () => navigateToRoute(
                                          context,
                                          OtherProfileRouter(
                                              username: username)),
                                      notificationText: '${datum['message']}',
                                      displayName:
                                          '${username[0].toUpperCase()}',
                                      profileImageUrl: profilePictureUrl,
                                      checkProfilePicture:
                                          datum['profilePictureUrl'] == null
                                              ? false
                                              : true,
                                      date: date.timeAgo(),
                                    ),
                                  )
                                ]);
                              }
                              return GestureDetector(
                                onTap: () {
                                  // navigateToRoute(
                                  //     context,
                                  //     OtherUserProfile(
                                  //       username: datum['message']
                                  //           .toString()
                                  //           .split(" ")
                                  //           .first,
                                  //     ));

                                  _showPostIfAny(
                                      username: username,
                                      profilePictureUrl: profilePictureUrl,
                                      postMap: postMap);
                                  // VWidgetShowResponse.showToast(
                                  //     ResponseEnum.sucesss,
                                  //     message: "${datum['post']}");
                                },
                                child: VWidgetsNotificationCard(
                                  onUserTapped: () => navigateToRoute(
                                      context,
                                      OtherProfileRouter(
                                        username: username,
                                      )),
                                  notificationText: datum['message'].toString(),
                                  // '${datum['id']} ${datum['message']}',
                                  displayName: '${username[0].toUpperCase()}',
                                  profileImageUrl: profilePictureUrl,
                                  checkProfilePicture:
                                      datum['profilePictureUrl'] == null
                                          ? false
                                          : true,
                                  date: date.timeAgo(),
                                ),
                              );
                            }),
                    // );
                  ),
                ),
              ],
            ),
          );
          // return ListView.builder(
          //   itemBuilder: (BuildContext context, int index) {
          //     bool isSameDate = true;
          //           final String dateString =
          //               data.data![index]!.createdAt.toString();
          //           final DateTime date = DateTime.parse(dateString);
          //           var datum = data.data![index];
          //           if (index == 0) {
          //             isSameDate = false;
          //           } else {
          //             final String prevDateString =
          //                 data.data![index - 1]!.createdAt.toString();
          //             final DateTime prevDate = DateTime.parse(prevDateString);
          //             isSameDate = date.isSameDate(prevDate);
          //           }
          //   }
          //   );
          // return SingleChildScrollView(
          //   padding: const VWidgetsPagePadding.horizontalSymmetric(10),
          //   child: Column(children: [
          //     // ),
          //     const Padding(
          //       padding: VWidgetsPagePadding.horizontalSymmetric(5),
          //       child: VWidgetsDateHeader(
          //         dateAbbreviation: 'This week',
          //       ),
          //     ),

          //     addVerticalSpacing(8),
          //     ...todayMessage.map((e) {
          //       return VWidgetsNotificationCard(
          //         notificationText: e.msg.toString(),
          //         profileImagePath: e.picPath,
          //         notificationType: e.notificationType.toString(),
          //       );
          //     }),
          //   ]),
          // );
        }, loading: () {
          return const ConnectionsShimmerPage();
        }, error: (Object error, StackTrace stackTrace) {
          print(stackTrace);
          return const Text("Error fetching notifications");
        }));
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
          context,
          SinglePostView(
            isCurrentUser: false,
            postSet: post,
          ));
    }
  }
}

const String dateFormatter = 'MMMM dd, y';

extension DateHelper on DateTime {
  String formatDate() {
    final formatter = DateFormat(dateFormatter);
    return formatter.format(this);
  }

  bool isSameDate(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }

  int getDifferenceInDaysWithNow() {
    final now = DateTime.now();
    return now.difference(this).inDays;
  }
}
