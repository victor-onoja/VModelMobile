import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vmodel/src/features/dashboard/new_profile/other_user_profile/report_account_options_page.dart';
import 'package:vmodel/src/features/dashboard/new_profile/profile_features/widgets/profile_picture_widget.dart';
import 'package:vmodel/src/features/dashboard/profile/controller/profile_controller.dart';
import 'package:vmodel/src/features/messages/widgets/message_menu_options.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/shared/modal_pill_widget.dart';
import 'package:vmodel/src/vmodel.dart';

import 'other_user_profile_functionality_widget.dart';

class VWidgetsReportAccount extends ConsumerStatefulWidget {
  // final Function()? retutnOtherUserFuntionModal;
  final String username;
  final String? previousPage;
  final String? connectionStatus;
  final bool? isPostNotificationOn;
  final bool? isJobNotificationOn;
  final bool? isCouponNotificationOn;
  const VWidgetsReportAccount({
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
      _VWidgetsReportAccountState();
}

class _VWidgetsReportAccountState extends ConsumerState<VWidgetsReportAccount> {
  bool isReported = false;
  @override
  Widget build(BuildContext context) {
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
        Text(widget.username,
            style: Theme.of(context).textTheme.displayMedium!.copyWith(
                  fontWeight: FontWeight.w600,
                  // color: Theme.of(context).primaryColor,
                )),
        addVerticalSpacing(5),
        Center(
          child: Text(
              'Reporting misconduct helps us maintain a safe and professional community for all users. Please ensure that the reported behaviuor is inappropriate or against our terms of service.',
              style: Theme.of(context).textTheme.displaySmall!.copyWith(
                  // color: Theme.of(context).primaryColor,
                  )),
        ),
        addVerticalSpacing(30),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
          child: GestureDetector(
            onTap: () async {
              // navigateToRoute(
              //     context,
              //     ReportAccountHomepage(
              //         username: widget.username,
              //         profilePictureUrl:  "${user?.profilePictureUrl}",));
              popSheet(context);
              navigateToRoute(
                  context, ReportAccountOptionsPage(username: widget.username));
            },
            child: Text(isReported ? 'Reported' : "Report",
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
            child: Text('Cancel',
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
                    isPostNotificationOn: widget.isPostNotificationOn!,
                    isCouponNotificationOn: widget.isCouponNotificationOn!,
                    isJobNotificationOn: widget.isJobNotificationOn!,
                    connectionStatus: widget.connectionStatus,
                    username: widget.username),
          );
        });
  }
}
