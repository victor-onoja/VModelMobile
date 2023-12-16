import 'package:either_option/either_option.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:vmodel/src/core/utils/exception_handler.dart';
import 'package:vmodel/src/features/jobs/job_market/views/search_field.dart';
import 'package:vmodel/src/features/messages/controller/messages_controller.dart';
import 'package:vmodel/src/features/messages/views/archived_messages.dart';
import 'package:vmodel/src/features/messages/views/messages_chat_screen.dart';
import 'package:vmodel/src/features/messages/widgets/date_time_message.dart';
import 'package:vmodel/src/features/messages/widgets/message_homepage_card.dart';
import 'package:vmodel/src/res/icons.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/shared/appbar/appbar.dart';
import 'package:vmodel/src/shared/bottom_sheets/picture_confirmation_bottom_sheet.dart';
import 'package:vmodel/src/shared/rend_paint/render_svg.dart';
import 'package:vmodel/src/vmodel.dart';

import '../../../shared/bottom_sheets/tile.dart';

class MessagingHomePage extends ConsumerStatefulWidget {
  const MessagingHomePage({super.key});

  @override
  ConsumerState<MessagingHomePage> createState() => _MessagingHomePageState();
}

class _MessagingHomePageState extends ConsumerState<MessagingHomePage>
    with SingleTickerProviderStateMixin {
  String selectedChip = "Model";
  bool isLiked = false;
  bool isLikedTemp = false;

  Future<void> reloadData() async {}
  SlidableController? slidableController;
  @override
  void initState() {
    slidableController = SlidableController(this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final previousMessages = ref.watch(getConversations);
    return Scaffold(
      appBar: VWidgetsAppBar(
        appbarTitle: "Messages",
        appBarHeight: 50,
        leadingIcon: const VWidgetsBackButton(),
        trailingIcon: [
          IconButton(
              onPressed: () {
                navigateToRoute(context, const ArchivedMessagesScreen());
              },
              icon: const RenderSvg(svgPath: VIcons.archiveIcon2)),
        ],
      ),
      body: RefreshIndicator.adaptive(
          onRefresh: () {
            HapticFeedback.lightImpact();
            return reloadData();
          },
          child: Column(
            children: [
              const Padding(
                padding: VWidgetsPagePadding.horizontalSymmetric(18),
                child: SearchTextFieldWidget(
                  hintText: 'Search',
                ),
              ),
              addVerticalSpacing(13),
              previousMessages.when(
                  data: (Either<CustomException, List<dynamic>> data) {
                    return data.fold((p0) => const SizedBox.shrink(), (p0) {
                      if (p0.isNotEmpty)
                        return Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Flexible(
                                fit: FlexFit.loose,
                                child: SlidableAutoCloseBehavior(
                                  closeWhenOpened: true,
                                  child: ListView.builder(
                                    // shrinkWrap: true,
                                    itemCount: p0.length,
                                    itemBuilder: (context, index) {
                                      var value = p0[index];
                                      print(
                                          "jhfiwehfi ${value['recipient']['userType']}");
                                      final String dateString =
                                          // value['createdAt'].toString();
                                          value['lastMessage']['createdAt']
                                              .toString();
                                      final DateTime date =
                                          DateTime.parse(dateString);
                                      return value['lastMessage'] == null
                                          ? const SizedBox.shrink()
                                          : GestureDetector(
                                              onTap: () async {
                                                await navigateToRoute(
                                                    context,
                                                    MessagesChatScreen(
                                                      label: value['recipient']
                                                          ['userType'],
                                                      id: int.parse(
                                                          value['id']),
                                                      profilePicture: value[
                                                              'recipient']
                                                          ['profilePictureUrl'],
                                                      username:
                                                          value['recipient']
                                                              ['username'],
                                                    ));
                                              },
                                              child: Container(
                                                color: Colors.transparent,
                                                padding:
                                                    const VWidgetsPagePadding
                                                        .horizontalSymmetric(
                                                        18),
                                                child: Slidable(
                                                  groupTag: "slider",
                                                  key: Key("item_$index"),
                                                  endActionPane: ActionPane(
                                                    extentRatio: 0.5,
                                                    motion:
                                                        const StretchMotion(),
                                                    dragDismissible:
                                                        index != index,
                                                    children: [
                                                      // SlidableAction(
                                                      //   onPressed: (context) {},
                                                      //   foregroundColor:
                                                      //       Colors.white,
                                                      //   backgroundColor:
                                                      //       Color.fromARGB(
                                                      //           255, 186, 186, 187),
                                                      //   label: 'Pin',
                                                      // ),
                                                      SlidableAction(
                                                        borderRadius: BorderRadius
                                                            .horizontal(
                                                                left: Radius
                                                                    .circular(
                                                                        5)),
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 10),
                                                        onPressed: (context) {},
                                                        foregroundColor:
                                                            Colors.white,
                                                        backgroundColor:
                                                            Color.fromARGB(255,
                                                                128, 128, 129),
                                                        label: 'Mute',
                                                      ),
                                                      SlidableAction(
                                                        borderRadius: BorderRadius
                                                            .horizontal(
                                                                right: Radius
                                                                    .circular(
                                                                        5)),
                                                        onPressed: (context) {
                                                          showModalBottomSheet<
                                                                  void>(
                                                              context: context,
                                                              backgroundColor:
                                                                  Colors
                                                                      .transparent,
                                                              builder:
                                                                  (BuildContext
                                                                      context) {
                                                                return Container(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .only(
                                                                          left:
                                                                              16,
                                                                          right:
                                                                              16),
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: Theme
                                                                        .of(
                                                                      context,
                                                                    ).scaffoldBackgroundColor,
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .only(
                                                                      topLeft: Radius
                                                                          .circular(
                                                                              13),
                                                                      topRight:
                                                                          Radius.circular(
                                                                              13),
                                                                    ),
                                                                  ),
                                                                  child: VWidgetsConfirmationWithPictureBottomSheet(
                                                                      username:
                                                                          value['recipient']
                                                                              [
                                                                              'username'],
                                                                      profilePictureUrl:
                                                                          value['recipient']
                                                                              [
                                                                              'profilePictureUrl'],
                                                                      profileThumbnailUrl:
                                                                          value['recipient']
                                                                              [
                                                                              'thumbnailUrl'],
                                                                      actions: [
                                                                        VWidgetsBottomSheetTile(
                                                                            message:
                                                                                'Yes',
                                                                            onTap:
                                                                                () {})
                                                                      ],
                                                                      dialogMessage:
                                                                          'Are you sure you want to delete your messages with ${value['recipient']['username']}? This action cannot be undone'),
                                                                );
                                                              });
                                                        },
                                                        foregroundColor:
                                                            Colors.white,
                                                        backgroundColor:
                                                            Colors.red,
                                                        label: 'Delete',
                                                      ),
                                                    ],
                                                  ),
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                right: 10),
                                                        child:
                                                            VWidgetsMessageCard(
                                                          profileImage: value[
                                                                  'recipient'][
                                                              'profilePictureUrl'],
                                                          titleText:
                                                              "${value['recipient']['username']}" ??
                                                                  '',
                                                          latestMessage: value[
                                                                      'lastMessage'] !=
                                                                  null
                                                              ? value['lastMessage']
                                                                  ['text']
                                                              : '',
                                                          latestMessageTime: date
                                                              .timeAgoMessage(),
                                                          onTapCard: () {
                                                            navigateToRoute(
                                                                context,
                                                                MessagesChatScreen(
                                                                  label: value[
                                                                          'recipient']
                                                                      [
                                                                      'userType'],
                                                                  id: int.parse(
                                                                      value[
                                                                          'id']),
                                                                  profilePicture:
                                                                      value['recipient']
                                                                          [
                                                                          'profilePictureUrl'],
                                                                  username: value[
                                                                          'recipient']
                                                                      [
                                                                      'username'],
                                                                ));
                                                          },
                                                          onPressedLike: () {
                                                            setState(() {
                                                              isLiked =
                                                                  !isLiked;
                                                            });
                                                          },
                                                        ),
                                                      ),
                                                      Divider(height: 5),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );

                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          addVerticalSpacing(300),
                          Text("No messages"),
                        ],
                      );
                    });
                  },
                  error: (Object error, StackTrace stackTrace) =>
                      Text(stackTrace.toString()),
                  loading: () => const Center(
                        child: CircularProgressIndicator.adaptive(),
                      ))
            
            ],
          )),
    );
  }
}

const String dateFormatter = 'MMM dd, y';

extension DateHelper on DateTime {
  String formatDateExtension() {
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
