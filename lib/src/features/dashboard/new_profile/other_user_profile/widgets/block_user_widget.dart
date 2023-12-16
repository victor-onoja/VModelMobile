import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vmodel/src/features/dashboard/new_profile/controller/block_user_controller.dart';
import 'package:vmodel/src/features/dashboard/new_profile/profile_features/widgets/profile_picture_widget.dart';
import 'package:vmodel/src/features/dashboard/profile/controller/profile_controller.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/shared/modal_pill_widget.dart';
import 'package:vmodel/src/vmodel.dart';

import '../../../../messages/widgets/message_menu_options.dart';
import 'other_user_profile_functionality_widget.dart';

class VWidgetsBlockUser extends ConsumerStatefulWidget {
  final String username;
  final String? previousPage;
  final String? connectionStatus;
  final bool? isPostNotificationOn;
  final bool? isJobNotificationOn;
  final bool? isCouponNotificationOn;
  const VWidgetsBlockUser({
    this.isPostNotificationOn,
    this.isJobNotificationOn,
    this.isCouponNotificationOn,
    super.key,
    required this.username,
    this.connectionStatus,
    this.previousPage,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _VWidgetsBlockUserState();
}

class _VWidgetsBlockUserState extends ConsumerState<VWidgetsBlockUser> {
  bool userBlock = false;
  @override
  Widget build(BuildContext context) {
    final blockedusers = ref.watch(blockUserProvider);
    final blockUsersList = blockedusers.valueOrNull;
    final userState = ref.watch(profileProvider(widget.username));
    final user = userState.valueOrNull;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        addVerticalSpacing(15),
        const VWidgetsModalPill(),
        addVerticalSpacing(25),
        ProfilePicture(
          showBorder: false,
          displayName: '${user?.displayName}',
          url: "${user?.profilePictureUrl}",
          headshotThumbnail: "${user?.thumbnailUrl}",
          size: 60,
        ),
        addVerticalSpacing(5),
        //! Put Full Name here
        Text(user!.username,
            style: Theme.of(context).textTheme.displayMedium!.copyWith(
                  fontWeight: FontWeight.w600,
                  // color: Theme.of(context).primaryColor,
                )),
        addVerticalSpacing(5),
        Center(
          child: Text(
              'Blocking this user will restrict your ability to communicate with them or view their profile. Are you certain you want to proceed with blocking them?',
              style: Theme.of(context).textTheme.displaySmall!.copyWith(
                  // color: Theme.of(context).primaryColor,
                  )),
        ),
        addVerticalSpacing(30),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
          child: GestureDetector(
            onTap: () async {
              userBlock = await ref.read(blockUserProvider.notifier).blockUser(
                  id: user.id ?? -1,
                  userName: widget.username,
                  firstName: user.username,
                  lastName: user.lastName,
                  userType: user.userType,
                  userTypeLabel: user.label,
                  isVerified: user.isVerified,
                  blueTickVerified: user.blueTickVerified,
                  profilePictureUrl: "${user.profilePictureUrl}");
              setState(() {});
              // Checking if screen is visible
              if (context.mounted) goBack(context);
            },
            child: Text("Block",
                style: Theme.of(context).textTheme.displayMedium!.copyWith(
                      fontWeight: FontWeight.w600,
                      // color: Theme.of(context).primaryColor,
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
              returnOtherUserFunction();
            },
            child: Text('Go back',
                style: Theme.of(context).textTheme.displayMedium!.copyWith(
                      fontWeight: FontWeight.w600,
                      // color: Theme.of(context).primaryColor,
                    )),
          ),
        ),
      ],
    );
  }

  Future<void> returnOtherUserFunction() {
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
            child: widget.previousPage == "message"
                ? MessageMenuOptionsWidget(
                    connectionStatus: widget.connectionStatus!,
                    username: widget.username,
                  )
                : VWidgetsOtherUserProfileFunctionality(
                    isCouponNotificationOn: widget.isCouponNotificationOn!,
                    isJobNotificationOn: widget.isJobNotificationOn!,
                    isPostNotificationOn: widget.isPostNotificationOn!,
                    connectionStatus: widget.connectionStatus,
                    username: widget.username),
          );
        });
  }
}
