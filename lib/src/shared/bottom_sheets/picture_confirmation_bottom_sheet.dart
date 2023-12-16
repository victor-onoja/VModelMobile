import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vmodel/src/features/dashboard/new_profile/profile_features/widgets/profile_picture_widget.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/shared/modal_pill_widget.dart';
import 'package:vmodel/src/vmodel.dart';

class VWidgetsConfirmationWithPictureBottomSheet
    extends ConsumerStatefulWidget {
  final String username;
  final String? profilePictureUrl;
  final String? profileThumbnailUrl;
  final String dialogMessage;
  final List<Widget>? actions;
  final String? finalButtonText;
  final VoidCallback? finalButtonPressed;
  const VWidgetsConfirmationWithPictureBottomSheet({
    super.key,
    required this.username,
    required this.profilePictureUrl,
    required this.profileThumbnailUrl,
    required this.dialogMessage,
    this.actions,
    this.finalButtonText,
    this.finalButtonPressed,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _VWidgetsUnblockUserState();
}

class _VWidgetsUnblockUserState
    extends ConsumerState<VWidgetsConfirmationWithPictureBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        addVerticalSpacing(15),
        const Align(alignment: Alignment.center, child: VWidgetsModalPill()),
        addVerticalSpacing(25),

        ProfilePicture(
          showBorder: false,
          url: widget.profilePictureUrl,
          headshotThumbnail: widget.profileThumbnailUrl,
          size: 60,
        ),
        addVerticalSpacing(5),
        //! Put Full Name here
        Text(widget.username,
            style: Theme.of(context).textTheme.displayMedium!.copyWith(
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).primaryColor,
                )),
        addVerticalSpacing(5),
        Center(
          child: Text(widget.dialogMessage,
              style: Theme.of(context).textTheme.displaySmall!.copyWith(
                    color: Theme.of(context).primaryColor,
                  )),
        ),
        addVerticalSpacing(30),
        ...?widget.actions,
        // Padding(
        //   padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
        //   child: GestureDetector(
        //     onTap: widget.primaryButtonPressed,
        //     child: Text(widget.primaryButtonText,
        //         style: Theme.of(context).textTheme.displayMedium!.copyWith(
        //               fontWeight: FontWeight.w600,
        //               color: Theme.of(context).primaryColor,
        //             )),
        //   ),
        // ),
        const Divider(
          thickness: 0.5,
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 5, 0, 40),
          child: GestureDetector(
            onTap: () => widget.finalButtonPressed ?? goBack(context),
            child: Text(widget.finalButtonText ?? 'Cancel',
                style: Theme.of(context).textTheme.displayMedium!.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).primaryColor,
                    )),
          ),
        ),
        addVerticalSpacing(30),
      ],
    );
  }
}
