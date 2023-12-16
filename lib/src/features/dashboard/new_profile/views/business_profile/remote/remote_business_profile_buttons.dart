import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vmodel/src/features/dashboard/new_profile/other_user_profile/other_user_profile_header_widget.dart';
import 'package:vmodel/src/res/icons.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/shared/buttons/primary_button.dart';
import 'package:vmodel/src/shared/rend_paint/render_svg.dart';
import 'package:vmodel/src/vmodel.dart';

class VWidgetsOtherBusinessProfileButtons extends ConsumerStatefulWidget {
  final VoidCallback? messagesOnPressed;
  final VoidCallback? socialAccountsOnPressed;
  final VoidCallback? servicesOnPressed;
  final VoidCallback? connectOnPressed;
  final VoidCallback? removeOnPressed;
  final VoidCallback? requestConnectOnPressed;
  final VoidCallback? removeRequestOnPressed;
  final bool connected;
  final String username;
  final bool requestCnnection;
  final String? connectionStatus;
  final bool? enableSocialButton;

  const VWidgetsOtherBusinessProfileButtons({
    super.key,
    required this.username,
    required this.connectionStatus,
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
  });

  @override
  ConsumerState<VWidgetsOtherBusinessProfileButtons> createState() =>
      _VWidgetsOtherBusinessProfileButtonsState();
}

class _VWidgetsOtherBusinessProfileButtonsState
    extends ConsumerState<VWidgetsOtherBusinessProfileButtons> {
  late final bool enableSocial;

  @override
  void initState() {
    super.initState();
    enableSocial = widget.enableSocialButton ?? false;
  }

  @override
  Widget build(BuildContext context) {
    final showConnect = ref.watch(showConnectProvider);
    final showRequest = ref.watch(showRequestConnectionProvider);

    return SafeArea(
      bottom: true,
      child: Wrap(
        verticalDirection: VerticalDirection.down,
        crossAxisAlignment: WrapCrossAlignment.start,
        children: [
          // addVerticalSpacing(4),
          Row(
            children: [
              Flexible(
                child: VWidgetsPrimaryButton(
                  onPressed: widget.messagesOnPressed,
                  buttonTitle: "Message",
                  enableButton:
                      widget.connectionStatus == 'connection_request_accepted'
                          ? true
                          : false,
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
              widget.connectionStatus == 'connection_request_sent'
                  ? Expanded(
                      child: VWidgetsPrimaryButton(
                        onPressed: widget.removeRequestOnPressed,
                        buttonTitle: "Requested",
                        enableButton: true,
                      ),
                    )
                  : widget.connectionStatus == 'connection_request_received'
                      ? Expanded(
                          child: VWidgetsPrimaryButton(
                            onPressed: widget.connectOnPressed,
                            buttonTitle: "Accept",
                            enableButton: true,
                          ),
                        )
                      : widget.connectionStatus == 'connection_request_accepted'
                          ? Expanded(
                              child: VWidgetsPrimaryButton(
                                onPressed: widget.removeRequestOnPressed,
                                buttonTitle: "Connected",
                                enableButton: true,
                              ),
                            )
                          : Expanded(
                              child: VWidgetsPrimaryButton(
                                onPressed: widget.requestConnectOnPressed,
                                buttonTitle: "Connect",
                                enableButton: true,
                              ),
                            ),
              addHorizontalSpacing(6),
              SizedBox(
                width: 35,
                height: 35,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      elevation: 0,
                      // backgroundColor: VmodelColors.buttonBgColor,
                      backgroundColor:
                          Theme.of(context).buttonTheme.colorScheme?.secondary,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      padding: EdgeInsets.zero),
                  onPressed:
                      enableSocial ? widget.socialAccountsOnPressed : null,
                  child: enableSocial
                      ? const RenderSvg(
                          svgHeight: 22,
                          svgPath: VIcons.cameraCaptureIcon,
                        )
                      : RenderSvg(
                          svgHeight: 22,
                          svgPath: VIcons.cameraCaptureIcon,
                          color:
                              Theme.of(context).primaryColor.withOpacity(0.2),
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
}
