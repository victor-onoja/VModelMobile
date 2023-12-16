import 'package:vmodel/src/res/icons.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/shared/buttons/primary_button.dart';
import 'package:vmodel/src/shared/rend_paint/render_svg.dart';
import 'package:vmodel/src/vmodel.dart';

class VWidgetsLocalBusinessProfileButtons extends StatelessWidget {
  final VoidCallback? bookNowOnPressed;
  final VoidCallback? topPicksOnPressed;
  final VoidCallback? messagesOnPressed;
  final VoidCallback? socialAccoutsOnPressed;
  final VoidCallback? socialAccoutsLongPressed;
  final VoidCallback? onNetworkPressed;

  const VWidgetsLocalBusinessProfileButtons({
    required this.bookNowOnPressed,
    required this.topPicksOnPressed,
    required this.messagesOnPressed,
    required this.onNetworkPressed,
    required this.socialAccoutsOnPressed,
    required this.socialAccoutsLongPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: true,
      child: Wrap(
        verticalDirection: VerticalDirection.down,
        crossAxisAlignment: WrapCrossAlignment.start,
        children: [
          Row(
            children: [
              Flexible(
                child: VWidgetsPrimaryButton(
                  onPressed: messagesOnPressed,
                  buttonTitle: "Messages",
                  enableButton: true,
                  // buttonColor: VmodelColors.buttonBgColor,
                  buttonColor:
                      Theme.of(context).buttonTheme.colorScheme?.secondary,
                  buttonTitleTextStyle: Theme.of(context)
                      .textTheme
                      .displayMedium!
                      .copyWith(
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).primaryColor.withOpacity(1),
                      ),
                ),
              ),
              addHorizontalSpacing(8),
              Expanded(
                child: VWidgetsPrimaryButton(
                  onPressed: onNetworkPressed,
                  buttonTitle: "My Network",
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
                  onLongPress: socialAccoutsLongPressed,
                  onPressed: socialAccoutsOnPressed,
                  child: const RenderSvg(
                    svgPath: VIcons.cameraCaptureIcon,
                  ),
                ),
              ),
            ],
          ),
          addVerticalSpacing(4),
        ],
      ),
    );
  }
}
