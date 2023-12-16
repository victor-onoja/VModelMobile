import 'package:either_option/either_option.dart';
import 'package:either_option/either_option.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:vmodel/src/core/utils/exception_handler.dart';
import 'package:vmodel/src/features/jobs/job_market/views/search_field.dart';
import 'package:vmodel/src/features/messages/controller/messages_controller.dart';
import 'package:vmodel/src/features/messages/views/messages_chat_screen.dart';
import 'package:vmodel/src/features/messages/widgets/date_time_message.dart';
import 'package:vmodel/src/features/messages/widgets/message_homepage_card.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/shared/bottom_sheets/picture_confirmation_bottom_sheet.dart';
import 'package:vmodel/src/shared/bottom_sheets/tile.dart';
import 'package:vmodel/src/vmodel.dart';

class ArchivedMessagesScreen extends ConsumerStatefulWidget {
  const ArchivedMessagesScreen({super.key});

  @override
  ConsumerState<ArchivedMessagesScreen> createState() =>
      _ArchivedMessagesScreenState();
}

class _ArchivedMessagesScreenState
    extends ConsumerState<ArchivedMessagesScreen> {
  String selectedChip = "Model";
  bool isLiked = false;
  bool isLikedTemp = false;

  Future<void> reloadData() async {
    await ref.refresh(getArchivedConversations);
  }

  @override
  Widget build(BuildContext context) {
    final archivedMessages = ref.watch(getArchivedConversations);
    return Scaffold(
      body: RefreshIndicator.adaptive(
        onRefresh: () async {
          HapticFeedback.lightImpact();
          return reloadData();
        },
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              pinned: true,
              // snap: _snap,
              floating: true,
              title: Text(
                "Archived",
                style: Theme.of(context).textTheme.displayLarge!.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
              centerTitle: true,
              expandedHeight: 100.0,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                background: _titleSearch(),
              ),
              // leadingWidth: 150,
              leading: const VWidgetsBackButton(),
              elevation: 1,
              // backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              // actions: [
              // ],
            ),
            archivedMessages.when(
                data: (Either<CustomException, List<dynamic>> data) {
                  return data.fold((p0) => const SizedBox.shrink(), (p0) {
                    if (p0.isNotEmpty)
                      return SliverList.builder(
                        // shrinkWrap: true,
                        itemCount: p0.length,
                        itemBuilder: (context, index) {
                          var value = p0[index];
                          print("jhfiwehfi ${value['recipient']['userType']}");
                          final String dateString =
                              // value['createdAt'].toString();
                              value['lastMessage']['createdAt'].toString();
                          final DateTime date = DateTime.parse(dateString);
                          return value['lastMessage'] == null
                              ? const SizedBox.shrink()
                              : GestureDetector(
                                  onTap: () async {
                                    await navigateToRoute(
                                        context,
                                        MessagesChatScreen(
                                          label: value['recipient']['userType'],
                                          id: int.parse(value['id']),
                                          profilePicture: value['recipient']
                                              ['profilePictureUrl'],
                                          username: value['recipient']
                                              ['username'],
                                        ));
                                  },
                                  child: Container(
                                    color: Colors.transparent,
                                    padding: const VWidgetsPagePadding
                                        .horizontalSymmetric(18),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 10),
                                          child: VWidgetsMessageCard(
                                            profileImage: value['recipient']
                                                ['profilePictureUrl'],
                                            titleText:
                                                "${value['recipient']['username']}" ??
                                                    '',
                                            latestMessage:
                                                value['lastMessage'] != null
                                                    ? value['lastMessage']
                                                        ['text']
                                                    : '',
                                            latestMessageTime:
                                                date.timeAgoMessage(),
                                            onTapCard: () {
                                              navigateToRoute(
                                                  context,
                                                  MessagesChatScreen(
                                                    label: value['recipient']
                                                        ['userType'],
                                                    id: int.parse(value['id']),
                                                    profilePicture: value[
                                                            'recipient']
                                                        ['profilePictureUrl'],
                                                    username: value['recipient']
                                                        ['username'],
                                                  ));
                                            },
                                            onPressedLike: () {
                                              setState(() {
                                                isLiked = !isLiked;
                                              });
                                            },
                                          ),
                                        ),
                                        Divider(height: 5),
                                      ],
                                    ),
                                  ),
                                );
                        },
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
                    )),
          ],
        ),
      ),
      // appBar: VWidgetsAppBar(
      //   backgroundColor: VmodelColors.white,
      //   appbarTitle: "Archived",
      //   appBarHeight: 50,
      //   leadingIcon: const VWidgetsBackButton(),
      // ),
      // body:
    );
  }

  Widget _titleSearch() {
    return SafeArea(
      child: Column(
        children: [
          Expanded(child: addVerticalSpacing(20)),
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 13),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: [
          //       Text(
          //         "Discover",
          //         style: Theme.of(context).textTheme.displayLarge!.copyWith(
          //               fontWeight: FontWeight.w600,
          //               // color: VmodelColors.mainColor,
          //               fontSize: 16.sp,
          //             ),
          //       ),
          //     ],
          //   ),
          // ),
          addVerticalSpacing(10),
          Padding(
            padding: const VWidgetsPagePadding.horizontalSymmetric(18),
            child: SearchTextFieldWidget(
              hintText: "Search...",
              // controller: _searchController,
              // onChanged: (val) {},

              onTapOutside: (event) {},
              onTap: () {},
              // focusNode: myFocusNode,
              onChanged: (val) {},
            ),
          ),
          const SizedBox(height: 5),

          // Padding(
          //   padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 12),
          //   child: Container(
          //     padding: const EdgeInsets.all(15),
          //     decoration: BoxDecoration(
          //         color: const Color(0xFFD9D9D9),
          //         borderRadius: BorderRadius.circular(8)),
          //     child: Container(
          //       padding: const EdgeInsets.all(2),
          //       decoration: BoxDecoration(
          //           color: VmodelColors.white,
          //           borderRadius: BorderRadius.circular(8)),
          //       child: Padding(
          //         padding: const EdgeInsets.symmetric(horizontal: 15),
          //         child: Row(
          //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //           children: [
          //             IconButton(
          //               onPressed: () {
          //                 // navigateToRoute(context, const LocalServices());
          //               },
          //               icon: const RenderSvg(
          //                 svgPath: VIcons.addServiceOutline,
          //               ),
          //             ),
          //             IconButton(
          //               onPressed: () {
          //                 // navigateToRoute(context, AllJobs(job: job));
          //               },
          //               icon: const RenderSvg(
          //                 svgPath: VIcons.alignVerticalIcon,
          //               ),
          //             ),
          //             IconButton(
          //               onPressed: () {
          //                 navigateToRoute(context, const Explore());
          //               },
          //               icon: const RenderSvg(
          //                 svgPath: VIcons.searchIcon,
          //               ),
          //             ),
          //           ],
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
          // const SizedBox(height: 10),
        ],
      ),
    );
  }
}
