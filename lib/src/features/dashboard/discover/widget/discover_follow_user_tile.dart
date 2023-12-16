import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vmodel/src/features/dashboard/new_profile/profile_features/widgets/profile_picture_widget.dart';
import 'package:vmodel/src/features/dashboard/new_profile/views/other_profile_router.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/shared/buttons/primary_button.dart';
import 'package:vmodel/src/vmodel.dart';

import '../../../../shared/username_verification.dart';
import '../controllers/follow_connect_controller.dart';

class DiscoverFollowUserTile extends ConsumerStatefulWidget {
  final String displayName;
  final String username;
  final String title;
  final String? profileImage;
  final String? profileImageThumbnail;
  final String subTitle;
  final String? trailingButtonText;
  final Widget? trailingIcon;
  final bool showTrailingIcon;
  final bool? isVerified;
  final bool? blueTickVerified;
  final bool isFollow;

  const DiscoverFollowUserTile({
    super.key,
    required this.displayName,
    required this.username,
    required this.title,
    required this.profileImage,
    required this.profileImageThumbnail,
    required this.subTitle,
    required this.isVerified,
    required this.blueTickVerified,
    this.trailingButtonText,
    this.trailingIcon,
    this.showTrailingIcon = true,
    this.isFollow = true,
  });

  @override
  ConsumerState<DiscoverFollowUserTile> createState() =>
      _DiscoverFollowUserTileState();
}

class _DiscoverFollowUserTileState
    extends ConsumerState<DiscoverFollowUserTile> {
  final showButtonLoading = ValueNotifier(false);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          flex: 2,
          child: GestureDetector(
            onTap: () {
              navigateToRoute(
                  context, OtherProfileRouter(username: widget.username));
            },
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 5),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: ProfilePicture(
                        showBorder: false,
                        displayName: widget.displayName,
                        url: widget.profileImage,
                        headshotThumbnail: widget.profileImageThumbnail,
                        size: 45,
                      )),
                  addHorizontalSpacing(10),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        VerifiedUsernameWidget(
                          username: widget.title,
                          // displayName: profileFullName,
                          isVerified: widget.isVerified,

                          blueTickVerified: widget.blueTickVerified,
                          rowMainAxisAlignment: MainAxisAlignment.start,
                          textStyle: Theme.of(context)
                              .textTheme
                              .displayMedium!
                              .copyWith(fontWeight: FontWeight.w600),
                          useFlexible: true,
                        ),
                        // Text(
                        //   mainText,
                        //   overflow: TextOverflow.ellipsis,
                        //   maxLines: 1,
                        //   style: Theme.of(context)
                        //       .textTheme
                        //       .displayMedium!
                        //       .copyWith(
                        //         color: Theme.of(context).primaryColor,
                        //         fontWeight: FontWeight.w600,
                        //       ),
                        // ),

                        addVerticalSpacing(4),
                        //second row
                        Text(
                          widget.subTitle,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: Theme.of(context)
                              .textTheme
                              .displaySmall!
                              .copyWith(
                                color: Theme.of(context)
                                    .primaryColor
                                    .withOpacity(0.5),
                                // fontWeight: FontWeight.w500,
                              ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        addHorizontalSpacing(16),
        if (widget.showTrailingIcon)
          Flexible(
            // width: 30.w,
            child: ValueListenableBuilder(
                valueListenable: showButtonLoading,
                builder: (context, value, _) {
                  return VWidgetsPrimaryButton(
                    buttonHeight: 35,
                    showLoadingIndicator: value,
                    onPressed: () async {
                      showButtonLoading.value = true;
                      await ref
                          .read(accountToFollowProvider.notifier)
                          .onFollowUser(widget.username,
                              isFollow: widget.isFollow);
                      showButtonLoading.value = false;
                    },
                    buttonTitle: widget.isFollow
                        ? "Follow"
                        : "Connect", //widget.trailingButtonText,
                  );
                }),
          )
      ],
    );
  }
}
