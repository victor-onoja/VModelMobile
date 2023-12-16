import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vmodel/src/core/routing/navigator_1.0.dart';
import 'package:vmodel/src/features/dashboard/feed/widgets/send.dart';
import 'package:vmodel/src/features/dashboard/feed/widgets/share.dart';
import 'package:vmodel/src/features/settings/widgets/settings_submenu_tile_widget.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/shared/modal_pill_widget.dart';

//ConsumerWidget
class VWidgetsPostMediaOptionsFunctionality extends StatefulWidget {
  const VWidgetsPostMediaOptionsFunctionality({
    super.key,
    required this.postId,
    required this.postItemsLength,
    this.onDeletePost,
    this.onEditPost,
  });

  final int postId;
  final int postItemsLength;
  final VoidCallback? onDeletePost;
  final VoidCallback? onEditPost;

  @override
  State<VWidgetsPostMediaOptionsFunctionality> createState() =>
      _VWidgetsPostMediaOptionsFunctionalityState();
}

class _VWidgetsPostMediaOptionsFunctionalityState
    extends State<VWidgetsPostMediaOptionsFunctionality> {
  String _boardText = "Add to Boards";

  @override
  Widget build(BuildContext context) {
    List postMediaOptionsItems = [
      VWidgetsSettingsSubMenuTileWidget(
          title: "Edit",
          onTap: () {
            widget.onEditPost?.call();
          }),
      VWidgetsSettingsSubMenuTileWidget(
          title: "Send",
          onTap: () {
            popSheet(context);
            showModalBottomSheet(
              isScrollControlled: true,
              isDismissible: true,
              useRootNavigator: true,
              backgroundColor: Colors.transparent,
              context: context,
              builder: (context) => Container(
                  constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height * .85,
                    // minHeight: MediaQuery.of(context).size.height * .10,
                  ),
                  child: const SendWidget()),
            );
          }),
      // VWidgetsSettingsSubMenuTileWidget(
      //     title: _boardText,
      //     onTap: () {
      //       if (_boardText.toLowerCase() == "Add to Boards".toLowerCase()) {
      //         _boardText = "Remove from Board";
      //       } else {
      //         _boardText = "Add to Boards";
      //       }
      //       setState(() {});
      //     }),
      VWidgetsSettingsSubMenuTileWidget(
          title: "Hide from profile", onTap: () {}),
      VWidgetsSettingsSubMenuTileWidget(title: "Copy Link", onTap: () {}),
      VWidgetsSettingsSubMenuTileWidget(
          title: "Share",
          onTap: () {
            popSheet(context);
            showModalBottomSheet(
              isScrollControlled: true,
              isDismissible: true,
              useRootNavigator: true,
              backgroundColor: Colors.transparent,
              context: context,
              builder: (context) => const ShareWidget(
                shareLabel: 'Share Post',
                shareTitle: 'Samantha\'s Post',
                shareImage: 'assets/images/doc/main-model.png',
                shareURL: 'Vmodel.app/post/samantha-post',
              ),
            );
          }),
      VWidgetsSettingsSubMenuTileWidget(
          title: "Delete",
          onTap: () {
            popSheet(context);
            deletePost(context);
          }),
    ];

    return Column(
      // mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        addVerticalSpacing(15),
        const Align(alignment: Alignment.center, child: VWidgetsModalPill()),
        addVerticalSpacing(25),
        // Flexible(
        //   child: SingleChildScrollView(
        //     child: Column(
        //       mainAxisSize: MainAxisSize.min,
        //       children: List.generate((postMediaOptionsItems.length * 2) - 1,
        //           (index) {
        //         if (index % 2 == 0) return postMediaOptionsItems[index ~/ 2];
        //         return const Divider();
        //       }),
        //     ),
        //   ),
        // ),
        Flexible(
          child: ListView.separated(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: ((context, index) => postMediaOptionsItems[index]),
              separatorBuilder: (context, index) => const Divider(),
              itemCount: postMediaOptionsItems.length),
        )
      ],
    );
  }

  Future<void> deletePost(BuildContext context) {
    return showModalBottomSheet<void>(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (BuildContext context) {
          return Consumer(
            builder: (BuildContext context, WidgetRef ref, Widget? child) {
              return Container(
                padding: const EdgeInsets.only(left: 16, right: 16),
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(13),
                    topRight: Radius.circular(13),
                  ),
                ),
                child: // VWidgetsReportAccount(username: widget.username));
                    Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    addVerticalSpacing(15),
                    const VWidgetsModalPill(),
                    addVerticalSpacing(25),
                    Center(
                      child: Text(
                          widget.postItemsLength > 1
                              ? 'Are you sure you want to delete this post? This action cannot be undone. '
                              : 'Are you sure you want to delete this picture? This action cannot be undone. ',
                          style: Theme.of(context)
                              .textTheme
                              .displaySmall!
                              .copyWith(
                                color: Theme.of(context).primaryColor,
                              )),
                    ),
                    addVerticalSpacing(30),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                      child: GestureDetector(
                        onTap: () {
                          if (widget.onDeletePost != null) {
                            widget.onDeletePost!();
                          }
                          // VLoader.changeLoadingState(true);
                          // final isSuccess = await ref
                          //     .read(galleryProvider(null).notifier)
                          //     .deletePost(postId: postId);
                          // VLoader.changeLoadingState(false);
                          // if (isSuccess && context.mounted) {
                          //   goBack(context);
                          // }
                        },
                        child: Text("Delete",
                            style: Theme.of(context)
                                .textTheme
                                .displayMedium!
                                .copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: Theme.of(context).primaryColor,
                                )),
                      ),
                    ),
                    const Divider(
                      thickness: 0.5,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 5, 0, 40),
                      child: GestureDetector(
                        onTap: () {
                          goBack(context);
                        },
                        child: Text('Cancel',
                            style: Theme.of(context)
                                .textTheme
                                .displayMedium!
                                .copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: Theme.of(context).primaryColor,
                                )),
                      ),
                    ),
                  ],
                ),
              );
            },
            // child:
          );
        });
  }
}
