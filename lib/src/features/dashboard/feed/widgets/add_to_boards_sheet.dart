import 'dart:math';

import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vmodel/src/core/network/checkConnection.dart';
import 'package:vmodel/src/features/dashboard/feed/controller/new_feed_provider.dart';
import 'package:vmodel/src/features/dashboard/feed/widgets/comment/create_new_board_dialogue.dart';
import 'package:vmodel/src/features/saved/views/saved_user_post.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/shared/popup_dialogs/response_dialogue.dart';

import '../../../../core/utils/enum/upload_ratio_enum.dart';
import '../../../../shared/modal_pill_widget.dart';
import '../../../../shared/picture_styles/rounded_square_avatar.dart';
import '../../../../vmodel.dart';
import '../../../saved/controller/provider/user_boards_controller.dart';
import '../../discover/models/mock_data.dart';

@Deprecated("Use AddToBoardsSheetV2 instead")
class AddToBoardsSheet extends ConsumerStatefulWidget {
  const AddToBoardsSheet({
    Key? key,
    required this.postId,
    required this.saveBool,
    required this.savePost,
    required this.showLoader,
  }) : super(key: key);
  final int postId;
  final bool saveBool;
  final void Function() savePost;
  final ValueNotifier<bool> showLoader;

  @override
  ConsumerState<AddToBoardsSheet> createState() => _AddToBoardsSheetState();
}

class _AddToBoardsSheetState extends ConsumerState<AddToBoardsSheet> {
  final mockBoardTitles = ["Photography", "Modelling"];
  @override
  Widget build(BuildContext context) {
    final userCreatedBoards = ref.watch(userPostBoardsProvider);

    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.vertical(top: Radius.circular(10))),
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            addVerticalSpacing(15),
            const Align(
                alignment: Alignment.center, child: VWidgetsModalPill()),
            addVerticalSpacing(25),
            GestureDetector(
              onTap: () async {
                // Navigator.pop(context);
                final connected = await checkConnection();
                if (connected) {
                  HapticFeedback.lightImpact();
                  responseDialog(context, "Saved to boards");
                  widget.savePost();
                  final result = await ref
                      .read(mainFeedProvider.notifier)
                      .onSavePost(
                          postId: widget.postId,
                          currentValue: !widget.saveBool);
                  if (!result) {
                    widget.savePost();
                  }
                  ref.read(showSavedProvider.notifier).state =
                      !ref.read(showSavedProvider.notifier).state;
                } else {
                  responseDialog(context, "No connection", body: "Try again");
                }
                await Future.delayed(Duration(seconds: 2));
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        widget.saveBool
                            ? "Remove from boards"
                            : "Save to boards",
                        style: Theme.of(context)
                            .textTheme
                            .displayMedium
                            ?.copyWith(fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  addHorizontalSpacing(16),
                  countText(254),
                ],
              ),
            ),
            Divider(thickness: 0.5, height: 20),
            GestureDetector(
              onTap: () {
                HapticFeedback.lightImpact();
                showDialog(
                    context: context,
                    builder: (context) {
                      return CreateNewBoardDialog(
                        controller: TextEditingController(),
                        onSave: (title) async {
                          final success = await ref
                              .read(userPostBoardsProvider.notifier)
                              .createPostBoard(title);
                          if (success && context.mounted) {
                            goBack(context);
                            responseDialog(context, "Board created");
                          }
                        },
                      );
                    });
              },
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  "Add to new board",
                  style: Theme.of(context)
                      .textTheme
                      .displayMedium
                      ?.copyWith(fontWeight: FontWeight.w600),
                ),
              ),
            ),
            Divider(thickness: 0.5, height: 20),
            Padding(
              padding: EdgeInsets.only(bottom: 20, top: 10),
              child: Text(
                "Existing Boards",
                style: Theme.of(context)
                    .textTheme
                    .displayMedium
                    ?.copyWith(fontWeight: FontWeight.w700),
              ),
            ),
            ListView.separated(
              shrinkWrap: true,
              // padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              physics: NeverScrollableScrollPhysics(),
              itemCount: fewBoards(userCreatedBoards.valueOrNull?.length),
              separatorBuilder: (context, index) {
                return Divider(thickness: 0.5, height: 20);
              },
              itemBuilder: (context, index) {
                // if (index == 0)
                //   return GestureDetector(
                //     onTap: () async {
                //       // Navigator.pop(context);
                //       final connected = await checkConnection();
                //       if (connected) {
                //         HapticFeedback.lightImpact();
                //         responseDialog(context, "Saved to boards");
                //         widget.savePost();
                //         final result = await ref
                //             .read(mainFeedProvider.notifier)
                //             .onSavePost(
                //                 postId: widget.postId,
                //                 currentValue: !widget.saveBool);
                //         if (!result) {
                //           widget.savePost();
                //         }
                //         ref.read(showSavedProvider.notifier).state =
                //             !ref.read(showSavedProvider.notifier).state;
                //       } else {
                //         responseDialog(context, "No connection",
                //             body: "Try again");
                //       }
                //       await Future.delayed(Duration(seconds: 2));
                //       Navigator.pop(context);
                //       Navigator.pop(context);
                //     },
                //     child: Row(
                //       children: [
                //         Expanded(
                //           child: Padding(
                //             padding: EdgeInsets.symmetric(vertical: 10),
                //             child: Text(
                //               widget.saveBool
                //                   ? "Remove from boards"
                //                   : "Save to boards",
                //               style: Theme.of(context)
                //                   .textTheme
                //                   .displayMedium
                //                   ?.copyWith(fontWeight: FontWeight.w600),
                //             ),
                //           ),
                //         ),
                //         addHorizontalSpacing(16),
                //         countText(254),
                //       ],
                //     ),
                //   );

                // if (index == 1)
                //   return GestureDetector(
                //     onTap: () {
                //       showDialog(
                //           context: context,
                //           builder: (context) {
                //             return CreateNewBoardDialog(
                //               controller: TextEditingController(),
                //               onSave: (title) async {
                //                 final success = await ref
                //                     .read(userPostBoardsProvider.notifier)
                //                     .createPostBoard(title);
                //                 if (success && context.mounted) {
                //                   goBack(context);
                //                   responseDialog(context, "Board created");
                //                 }
                //               },
                //             );
                //           });
                //     },
                //     child: Padding(
                //       padding: EdgeInsets.symmetric(vertical: 10),
                //       child: Text(
                //         "Add to new board",
                //         style: Theme.of(context)
                //             .textTheme
                //             .displayMedium
                //             ?.copyWith(fontWeight: FontWeight.w600),
                //       ),
                //     ),
                //   );
                // Divider(thickness: 0.5, height: 20),
                // if (index == 2)
                //   return Padding(
                //     padding: EdgeInsets.only(bottom: 20, top: 10),
                //     child: Text(
                //       "Existing Boards",
                //       style: Theme.of(context)
                //           .textTheme
                //           .displayMedium
                //           ?.copyWith(fontWeight: FontWeight.w700),
                //     ),
                //   );
                // ListView.separated(
                //   itemBuilder: (context, index) {},
                //   separatorBuilder: (context, index) {
                //     return Divider(thickness: 0.5, height: 20);
                //   },
                //   itemCount: mockBoardTitles.length,
                // ),

                return userCreatedBoards.when(data: (items) {
                  if (items.isEmpty) return SizedBox.shrink();
                  return Row(
                    children: [
                      RoundedSquareAvatar(
                        url: '',
                        thumbnail: '',
                        radius: 3,
                        size: UploadAspectRatio.portrait.sizeFromX(30),
                        imageWidget: Image.asset(
                          userTypesMockImages.first,
                          fit: BoxFit.cover,
                        ),
                      ),
                      addHorizontalSpacing(16),
                      Expanded(
                        flex: 2,
                        child: Text(
                          items[index].title,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context)
                              .textTheme
                              .displayMedium
                              ?.copyWith(fontWeight: FontWeight.w600),
                        ),
                      ),
                      addHorizontalSpacing(16),
                      countText(14),
                    ],
                  );
                }, error: (error, stackTrace) {
                  return Text('Error');
                }, loading: () {
                  return CircularProgressIndicator.adaptive();
                });
                // ...mockBoardTitles.map((e) {
                //   return Padding(
                //     padding: EdgeInsets.only(top: 10),
                //     child: Column(
                //       mainAxisSize: MainAxisSize.min,
                //       children: [
                //         Row(
                //           children: [
                //             RoundedSquareAvatar(
                //               url: '',
                //               thumbnail: '',
                //               radius: 3,
                //               size: UploadAspectRatio.portrait.sizeFromX(30),
                //               imageWidget: Image.asset(
                //                 userTypesMockImages.first,
                //                 fit: BoxFit.cover,
                //               ),
                //             ),
                //             addHorizontalSpacing(16),
                //             Expanded(
                //               flex: 2,
                //               child: Text(
                //                 e,
                //                 overflow: TextOverflow.ellipsis,
                //                 style: Theme.of(context)
                //                     .textTheme
                //                     .displayMedium
                //                     ?.copyWith(fontWeight: FontWeight.w600),
                //               ),
                //             ),
                //             addHorizontalSpacing(16),
                //             countText(14),
                //           ],
                //         ),
                //         addVerticalSpacing(10),
                //         Divider(thickness: 0.5, height: 20),
                //       ],
                //     ),
                //   );
                // }).toList(),
              },
            ),
          ],
        ),
      ),
    );
  }

  int fewBoards(int? total) {
    if (total == null) return 0;
    return min(total, 5);
  }

  Widget countText(int count) {
    return Text(
      "${VMString.bullet} $count Posts",
      style: Theme.of(context).textTheme.displaySmall?.copyWith(
            // fontWeight: FontWeight.w600,
            color: Theme.of(context)
                .textTheme
                .displaySmall
                ?.color
                ?.withOpacity(0.5),
          ),
    );
  }
}
