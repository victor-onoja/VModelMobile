import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vmodel/src/core/routing/navigator_1.0.dart';
import 'package:vmodel/src/features/dashboard/feed/widgets/send.dart';
import 'package:vmodel/src/features/dashboard/feed/widgets/share.dart';
import 'package:vmodel/src/features/dashboard/new_profile/other_user_profile/widgets/report_account_popUp_widget.dart';
import 'package:vmodel/src/features/dashboard/profile/controller/profile_controller.dart';
import 'package:vmodel/src/features/settings/widgets/settings_submenu_tile_widget.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/shared/modal_pill_widget.dart';

import 'add_to_boards_sheet_v2.dart';

class VWidgetsOtherUserPostMediaOptionsFunctionality
    extends ConsumerStatefulWidget {
  final String username;
  final int postId;
  final bool currentSavedValue;
  final ValueChanged<bool> onSavedResult;

  const VWidgetsOtherUserPostMediaOptionsFunctionality({
    super.key,
    required this.username,
    required this.postId,
    required this.currentSavedValue,
    required this.onSavedResult,
  });

  @override
  ConsumerState<VWidgetsOtherUserPostMediaOptionsFunctionality> createState() =>
      _VWidgetsOtherUserPostMediaOptionsFunctionalityState();
}

class _VWidgetsOtherUserPostMediaOptionsFunctionalityState
    extends ConsumerState<VWidgetsOtherUserPostMediaOptionsFunctionality> {
  String _boardText = "Add to Boards";
  final isFollowing = ValueNotifier(true);

  @override
  Widget build(BuildContext context) {
    final userState = ref.watch(profileProvider(widget.username));
    final user = userState.valueOrNull;
    List postMediaOptionsItems = [
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
      //     onTap: () async {
      //       await showModalBottomSheet(
      //         context: context,
      //         isScrollControlled: true,
      //         useSafeArea: true,
      //         backgroundColor: Colors.transparent,
      //         builder: (context) {
      //           return AddToBoardsSheetV2(
      //             postId: widget.postId,
      //             currentSavedValue: widget.currentSavedValue,
      //             onSaveToggle: widget.onSavedResult,
      //             // saveBool: saveBool,
      //             // savePost: () {
      //             //   savePost();
      //             // },
      //             // showLoader: showLoader,
      //           );
      //         },
      //       );
      //       // AddToBoardsSheetV2(
      //       //   postId: widget.postId,
      //       //   currentSavedValue: widget.currentSavedValue,
      //       // );
      //       if (_boardText.toLowerCase() == "Add to Boards".toLowerCase()) {
      //         _boardText = "Remove from Board";
      //       } else {
      //         _boardText = "Add to Boards";
      //       }
      //       setState(() {});
      //     }),
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
      ValueListenableBuilder(
          valueListenable: isFollowing,
          builder: (context, value, _) {
            return VWidgetsSettingsSubMenuTileWidget(
                title: value ? "Unfollow" : "Follow",
                onTap: () {
                  HapticFeedback.lightImpact();
                  isFollowing.value = !isFollowing.value;
                });
          }),
      VWidgetsSettingsSubMenuTileWidget(
          title: "Report Account",
          onTap: () {
            popSheet(context);
            reportUserFinalModal(context, user?.profilePictureUrl);
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

  Future<void> reportUserFinalModal(
    BuildContext context,
    String? url,
  ) {
    return showModalBottomSheet<void>(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (BuildContext context) {
          return Container(
              padding: const EdgeInsets.only(left: 16, right: 16),
              decoration: BoxDecoration(
                // color: VmodelColors.appBarBackgroundColor,
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(13),
                  topRight: Radius.circular(13),
                ),
              ),
              child: VWidgetsReportAccount(username: widget.username));
        });
  }
}
