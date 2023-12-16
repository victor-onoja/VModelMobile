import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vmodel/src/features/dashboard/new_profile/other_user_profile/other_user_profile_header_widget.dart';
import 'package:vmodel/src/res/icons.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/shared/buttons/primary_button.dart';
import 'package:vmodel/src/shared/rend_paint/render_svg.dart';
import 'package:vmodel/src/vmodel.dart';

import '../../../../core/utils/enum/album_type.dart';
import '../../../connection/controller/provider/connection_provider.dart';
import '../../profile/controller/profile_controller.dart';
import '../controller/gallery_controller.dart';

class VWidgetsOtherUserProfileButtons extends ConsumerStatefulWidget {
  final Future<void> Function()? bookNowOnPressed;
  final Future<void> Function()? polaroidOnPressed;
  final Future<void> Function()? messagesOnPressed;
  final Future<void> Function()? socialAccountsOnPressed;
  final Future<void> Function()? servicesOnPressed;
  final Future<void> Function()? connectOnPressed;
  final Future<void> Function()? removeOnPressed;
  final Future<void> Function()? requestConnectOnPressed;
  final Future<void> Function()? removeRequestOnPressed;
  final bool connected;
  final String username;
  final bool requestCnnection;
  final String? connectionStatus;
  final bool? enableSocialButton;
  final bool? isFollowing;

  const VWidgetsOtherUserProfileButtons({
    super.key,
    required this.username,
    required this.connectionStatus,
    required this.bookNowOnPressed,
    required this.polaroidOnPressed,
    required this.messagesOnPressed,
    required this.socialAccountsOnPressed,
    required this.servicesOnPressed,
    required this.connectOnPressed,
    required this.removeOnPressed,
    required this.requestConnectOnPressed,
    required this.removeRequestOnPressed,
    this.requestCnnection = false,
    this.connected = false,
    this.enableSocialButton,
    this.isFollowing,
  });

  @override
  ConsumerState<VWidgetsOtherUserProfileButtons> createState() =>
      _VWidgetsOtherUserProfileButtonsState();
}

class _VWidgetsOtherUserProfileButtonsState
    extends ConsumerState<VWidgetsOtherUserProfileButtons> {
  late final bool enableSocial;
  // final _isConnectButtonLoading = ValueNotifier(false);

  @override
  void initState() {
    super.initState();
    enableSocial = widget.enableSocialButton ?? false;
  }

  @override
  Widget build(BuildContext context) {
    final showConnect = ref.watch(showConnectProvider);
    final showRequest = ref.watch(showRequestConnectionProvider);
    final hasPolaroidWithContent = ref.watch(enableOtherUserPolaroidProvider);
    final galleryType = ref.watch(galleryTypeFilterProvider(widget.username));

    return SafeArea(
      bottom: true,
      child: Wrap(
        verticalDirection: VerticalDirection.down,
        crossAxisAlignment: WrapCrossAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: VWidgetsPrimaryButton(
                  onPressed: widget.bookNowOnPressed,
                  buttonTitle: "Book Now",
                  enableButton: true,
                  buttonColor:
                      Theme.of(context).buttonTheme.colorScheme?.background,
                ),
              ),
              addHorizontalSpacing(8),
              // if (showConnect == false)
              //   Expanded(
              //     child: VWidgetsPrimaryButton(
              //       onPressed: widget.connectOnPressed,
              //       buttonTitle: "Connect",
              //       enableButton: true,
              //     ),
              //   ),
              //   if (showConnect == true)
              //   Expanded(
              //     child: VWidgetsPrimaryButton(
              //       onPressed: widget.removeOnPressed,
              //       buttonTitle: "Remove",
              //       enableButton: true,
              //     ),
              //   ),

              connctionOrFollowButton,

              // widget.connectionStatus == 'connection_request_sent'
              // ? Expanded(
              //     child: VWidgetsPrimaryButton(
              //       onPressed: widget.removeRequestOnPressed,
              //       buttonTitle: "Requested",
              //     ),
              //   )
              // : widget.connectionStatus == 'connection_request_received'
              //     ? Expanded(
              //         child: VWidgetsPrimaryButton(
              //           onPressed: widget.connectOnPressed,
              //           buttonTitle: "Accept",
              //         ),
              //       )
              //     : widget.connectionStatus == 'connection_request_accepted'
              //         ? Expanded(
              //             child: VWidgetsPrimaryButton(
              //               onPressed: widget.removeRequestOnPressed,
              //               buttonTitle: "Connected",
              //               buttonColor: Theme.of(context)
              //                   .buttonTheme
              //                   .colorScheme
              //                   ?.background,
              //             ),
              //           )
              //         : widget.isFollowing!
              //             ? Expanded(
              //                 child: VWidgetsPrimaryButton(
              //                   onPressed: () {
              //                     ref
              //                         .read(profileProvider(widget.username)
              //                             .notifier)
              //                         .unFollowUser(widget.username);
              //                   },
              //                   buttonTitle: "Following",
              //                   buttonColor: Theme.of(context)
              //                       .buttonTheme
              //                       .colorScheme
              //                       ?.background,
              //                 ),
              //               )
              //             : Expanded(
              //                 child: VWidgetsPrimaryButton(
              //                   onPressed: widget.requestConnectOnPressed,
              //                   buttonTitle: "Connect",
              //                   buttonColor: Theme.of(context)
              //                       .buttonTheme
              //                       .colorScheme
              //                       ?.background,
              //                 ),
              //               ),
            ],
          ),
          addVerticalSpacing(4),
          Row(
            children: [
              Flexible(
                child: VWidgetsPrimaryButton(
                  onPressed: widget.polaroidOnPressed,
                  buttonTitle: galleryType == AlbumType.portfolio
                      ? "Polaroid"
                      : 'Portfolio',
                  enableButton: hasPolaroidWithContent,
                  buttonColor:
                      Theme.of(context).buttonTheme.colorScheme?.secondary,
                  buttonTitleTextStyle:
                      Theme.of(context).textTheme.displayMedium!.copyWith(
                            fontWeight: FontWeight.w600,
                            // color: Theme.of(context)
                            //     .buttonTheme
                            //     .colorScheme
                            //     ?.secondary,
                          ),
                ),
              ),
              addHorizontalSpacing(6),
              Flexible(
                child: VWidgetsPrimaryButton(
                  onPressed: widget.messagesOnPressed,
                  buttonTitle: "Message",
                  enableButton:
                      widget.connectionStatus == 'connection_request_accepted',
                  // buttonColor: VmodelColors.buttonBgColor,
                  buttonColor:
                      Theme.of(context).buttonTheme.colorScheme?.secondary,
                  buttonTitleTextStyle:
                      Theme.of(context).textTheme.displayMedium!.copyWith(
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).primaryColor,
                          ),
                ),
              ),
              addHorizontalSpacing(6),
              SizedBox(
                width: 35,
                height: 35,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor:
                          Theme.of(context).buttonTheme.colorScheme?.secondary,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      padding: EdgeInsets.zero),
                  onPressed:
                      enableSocial ? widget.socialAccountsOnPressed : null,
                  child: !enableSocial
                      ? RenderSvg(
                          svgHeight: 22,
                          svgPath: VIcons.cameraCaptureIcon,
                          color: Theme.of(context).disabledColor,
                        )
                      : RenderSvg(
                          svgHeight: 22,
                          svgPath: VIcons.cameraCaptureIcon,
                          color: Theme.of(context)
                              .buttonTheme
                              .colorScheme
                              ?.onSecondary,
                        ),
                ),
              ),
              addHorizontalSpacing(6),
              SizedBox(
                width: 35,
                height: 35,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor:
                          Theme.of(context).buttonTheme.colorScheme?.secondary,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      padding: EdgeInsets.zero),
                  onPressed: widget.servicesOnPressed,
                  child: RenderSvg(
                    svgPath: VIcons.servicesIcon,
                    color:
                        Theme.of(context).buttonTheme.colorScheme?.onSecondary,
                  ),
                ),
              ),
            ],
          ),
          // addVerticalSpacing(10),
        ],
      ),
    );
  }

  Widget get connctionOrFollowButton {
    if (widget.connectionStatus == 'connection_request_sent')
      return connectButton("Requested", widget.removeRequestOnPressed, null);
    else if (widget.connectionStatus == 'connection_request_received')
      return connectButton("Accept", widget.connectOnPressed, null);
    else if (widget.connectionStatus == 'connection_request_accepted')
      return connectButton("Connected", widget.removeRequestOnPressed, null);
    else if (widget.isFollowing!)
      return connectButton("Following", () async {
        ref.read(connectionProcessingProvider.notifier).state = true;
        await ref
            .read(profileProvider(widget.username).notifier)
            .unFollowUser(widget.username);
        ref.read(connectionProcessingProvider.notifier).state = false;
      }, null);

    return connectButton("Connect", widget.requestConnectOnPressed, null);
  }

  Widget connectButton(
      // String buttonText, FutureOr<void> Function() onTap, TextStyle? style) {
      String buttonText,
      Future<void> Function()? onTap,
      TextStyle? style) {
    return Consumer(
        // valueListenable: _isConnectButtonLoading,
        builder: (context, ref, _) {
      final isProcessing = ref.watch(connectionProcessingProvider);
      print('[dsd] For button $buttonText the $isProcessing');
      return Expanded(
        child: VWidgetsPrimaryButton(
          showLoadingIndicator: isProcessing,
          onPressed: () async {
            // _isConnectButtonLoading.value = true;
            await onTap?.call();
            // _isConnectButtonLoading.value = false;
          },
          buttonTitle: buttonText,
        ),
      );
    });
  }
}
