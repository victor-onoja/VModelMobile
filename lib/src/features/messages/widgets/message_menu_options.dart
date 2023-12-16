import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vmodel/src/features/dashboard/new_profile/other_user_profile/widgets/block_user_widget.dart';
import 'package:vmodel/src/features/messages/controller/messages_controller.dart';

import '../../../res/gap.dart';
import '../../dashboard/new_profile/controller/block_user_controller.dart';
import '../../dashboard/new_profile/other_user_profile/widgets/report_account_popUp_widget.dart';
import '../../dashboard/profile/controller/profile_controller.dart';

class MessageMenuOptionsWidget extends ConsumerStatefulWidget {
  final String username;
  final int? conversationId;
  final String connectionStatus;
  const MessageMenuOptionsWidget({
    super.key,
    required this.username,
    this.conversationId,
    required this.connectionStatus,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _MessageMenuOptionsWidgetState();
}

class _MessageMenuOptionsWidgetState
    extends ConsumerState<MessageMenuOptionsWidget> {
  bool userBlock = false;

  @override
  Widget build(BuildContext context) {
    final userState = ref.watch(profileProvider(widget.username));
    final user = userState.valueOrNull;
    final blockedUsers = ref.watch(blockUserProvider);
    bool isBlocked = ref.watch(isUserBlockedProvider(widget.username));
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            addVerticalSpacing(30),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 6.0),
              child: GestureDetector(
                onTap: () async {
                  await ref.read(archiveConversation(widget.conversationId!));
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                child: Text('Archive',
                    style: Theme.of(context).textTheme.displayMedium!.copyWith(
                          fontWeight: FontWeight.w600,
                          // color: Theme.of(context).primaryColor,
                        )),
              ),
            ),
            addVerticalSpacing(5),
            const Divider(thickness: 0.5),
            addVerticalSpacing(5),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 6.0),
              child: isBlocked
                  ? GestureDetector(
                      onTap: () async {
                        Navigator.pop(context);
                        userBlock = await ref
                            .read(blockUserProvider.notifier)
                            .unBlockUser(userName: widget.username);
                        setState(() {});
                      },
                      child: Text('Un-Block',
                          style: Theme.of(context)
                              .textTheme
                              .displayMedium!
                              .copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: const Color.fromRGBO(224, 44, 35, 1))),
                    )
                  : GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                        blockUserFinalModal(context);
                      },
                      child: Text('Block',
                          style: Theme.of(context)
                              .textTheme
                              .displayMedium!
                              .copyWith(
                                fontWeight: FontWeight.w600,
                                // color: VmodelColors.primaryColor,
                              ))),
            ),
            addVerticalSpacing(5),
            const Divider(thickness: 0.5),
            addVerticalSpacing(5),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 6.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  reportUserFinalModal(context, user?.profilePictureUrl);
                },
                child: Text('Report account',
                    style: Theme.of(context).textTheme.displayMedium!.copyWith(
                          fontWeight: FontWeight.w600,
                          // color: Theme.of(context).primaryColor,
                        )),
              ),
            ),
            addVerticalSpacing(50),
          ],
        ),
      ),
    );
  }

  Future<void> blockUserFinalModal(BuildContext context) {
    return showModalBottomSheet<void>(
        context: context,
        backgroundColor: Colors.transparent,
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
              child: VWidgetsBlockUser(
                username: widget.username,
                connectionStatus: widget.connectionStatus,
                previousPage: "message",
              ));
        });
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
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(13),
                  topRight: Radius.circular(13),
                ),
              ),
              child: VWidgetsReportAccount(
                username: widget.username,
                previousPage: "message",
                connectionStatus: widget.connectionStatus,
              ));
        });
  }
}
