import 'package:flutter/material.dart';

import '../res/icons.dart';
import '../res/res.dart';
import 'rend_paint/render_svg.dart';

class VerifiedUsernameWidget extends StatelessWidget {
  const VerifiedUsernameWidget({
    super.key,
    required this.username,
    required this.isVerified,
    required this.blueTickVerified,
    this.useFlexible = false,
    this.showDisplayName = false,
    this.displayName,
    this.textStyle,
    this.rowMainAxisAlignment = MainAxisAlignment.center,
    this.rowMainAxisSize,
    this.spaceSeparatorWidth = 4.0,
    this.iconSize = 12.0,
  });
  final double spaceSeparatorWidth;
  final double iconSize;
  final bool? isVerified;
  final bool? blueTickVerified;
  final bool useFlexible;
  final bool showDisplayName;
  final String username;
  final String? displayName;
  final TextStyle? textStyle;
  final MainAxisAlignment rowMainAxisAlignment;
  final MainAxisSize? rowMainAxisSize;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: rowMainAxisAlignment,
      mainAxisSize: rowMainAxisSize ?? MainAxisSize.max,
      children: [
        useFlexible
            ? Flexible(
                child: Text(
                showDisplayName ? displayName ?? username : username,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: textStyle ??
                    Theme.of(context).textTheme.displayLarge!.copyWith(
                       
                          fontWeight: FontWeight.w600,
                        ),
              ))
            : Text(
                // username,
                showDisplayName ? displayName ?? username : username,
                style: textStyle ??
                    Theme.of(context).textTheme.displayLarge!.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
              ),
        addHorizontalSpacing(spaceSeparatorWidth),
        // getUserVerificationIcon(username),
        _getUserVerificationIcon(
          isVerified: isVerified ?? false,
          blueTickVerified: blueTickVerified ?? false,
          size: iconSize,
        ),
      ],
    );
  }

  Widget _getUserVerificationIcon({
    required bool isVerified,
    required bool blueTickVerified,
    required double size,
  }) {
    if (blueTickVerified) {
      return RenderSvgWithoutColor(
        svgPath: VIcons.verifiedIcon,
        svgHeight: size,
        svgWidth: size,
      );
    } else if (isVerified) {
      return RenderSvg(
        svgPath: VIcons.verifiedIcon,
        svgHeight: size,
        svgWidth: size,
        color: Color(0xFFC2C2C2),
      );
    }
    // return VerificationType.none;
    return const SizedBox.shrink();
  }
}
