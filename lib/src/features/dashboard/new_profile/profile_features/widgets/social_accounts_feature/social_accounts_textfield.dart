import 'package:flutter/material.dart';
import 'package:vmodel/src/res/icons.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/shared/rend_paint/render_svg.dart';

class SocialAccountsTextField extends StatefulWidget {
  final String? socialAccountName;
  final VoidCallback onTap;
  final VoidCallback onPressedSave;
  final Function(String)? onChanged;
  // final bool isAccountActive;
  final TextEditingController textController;

  const SocialAccountsTextField({
    super.key,
    required this.socialAccountName,
    required this.onTap,
    required this.textController,
    required this.onPressedSave,
    required this.onChanged,
    // this.isAccountActive = false ,
  });

  @override
  State<SocialAccountsTextField> createState() =>
      _SocialAccountsTextFieldState();
}

class _SocialAccountsTextFieldState extends State<SocialAccountsTextField> {
  var isVisible = true;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isVisible = !isVisible;
        });
      },
      child: Visibility(
        visible: isVisible,
        replacement: Column(
          children: [
            TextField(
              autofocus: true,
              decoration: InputDecoration(
                hintText: "${widget.socialAccountName} username",
                contentPadding: const EdgeInsets.all(0),
              ),
              controller: widget.textController,
              onChanged: widget.onChanged,
              onTapOutside: (value) {
                setState(() {
                  isVisible = true;
                });
              },
            ),
            addVerticalSpacing(6),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.socialAccountName!,
                style: Theme.of(context).textTheme.displayMedium!.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).primaryColor,
                    ),
              ),
              const Spacer(),
              Visibility(
                // visible: widget.isAccountActive,
                visible: widget.textController.text.isNotEmpty,
                replacement: RenderSvg(
                  svgPath: VIcons.verifiedIcon,
                  svgHeight: 18,
                  svgWidth: 18,
                  color: Theme.of(context).primaryColor.withOpacity(0.25),
                ),
                child: RenderSvg(
                  svgPath: VIcons.verifiedIcon,
                  color: Theme.of(context).primaryColor.withOpacity(0.15),
                  svgHeight: 18,
                  svgWidth: 18,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
