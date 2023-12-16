import 'package:flutter/services.dart';
import 'package:vmodel/src/vmodel.dart';

class VWidgetsTextFieldWithMultipleIcons extends StatelessWidget {
  final List<TextInputFormatter>? inputFormatters;
  final TextEditingController? controller;
  final String hintText;
  final TextAlign? textAlign;
  final Widget? prefixIcon;
  final String? Function(String?)? validator;
  final Function(String?)? onChanged;
  final Function(String?)? onSaved;
  final Function() onSend;
  final Function(String?)? onFieldSubmitted;
  final VoidCallback? onPressedSuffixFirst;
  final VoidCallback? onPressedSuffixSecond;
  final VoidCallback? onPressedSuffixThird;
  final VoidCallback? onTapPlus;
  final bool? isTyping;
  final bool showSend;
  final Widget? suffixIcon;
  final TextCapitalization? textCapitalization;
  const VWidgetsTextFieldWithMultipleIcons({
    super.key,
    this.inputFormatters,
    required this.showSend,
    this.controller,
    this.prefixIcon,
    required this.hintText,
    this.onTapPlus,
    this.validator,
    this.onChanged,
    this.onSaved,
    this.onFieldSubmitted,
    this.textAlign,
    this.isTyping = false,
    this.suffixIcon,
    required this.onPressedSuffixFirst,
    required this.onPressedSuffixSecond,
    required this.onPressedSuffixThird,
    this.textCapitalization,
    required this.onSend,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
          child: GestureDetector(
            onTap: onTapPlus,
            child: Icon(
              Icons.add,
              color: Theme.of(context).iconTheme.color,
            ),
          ),
        ),
        Expanded(
          child: TextFormField(
            minLines: 1,
            maxLines: 100,
            validator: validator,
            inputFormatters: inputFormatters,
            controller: controller,
            onSaved: onSaved,
            onChanged: onChanged,
            onFieldSubmitted: onFieldSubmitted,
            textCapitalization: textCapitalization == null
                ? TextCapitalization.none
                : textCapitalization!,
            style: Theme.of(context).textTheme.displayMedium,
            decoration: InputDecoration(
              fillColor: Theme.of(context).buttonTheme.colorScheme!.secondary,
              filled: true,
              focusColor: Theme.of(context).scaffoldBackgroundColor,
              hoverColor: Theme.of(context).scaffoldBackgroundColor,
              hintText: hintText,
              suffixIcon: GestureDetector(
                onTap: () {
                  onTapImojie();
                },
                child: suffixIcon,
              ),
              contentPadding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
              hintStyle: Theme.of(context).textTheme.displayMedium!.copyWith(
                    color: Theme.of(context).primaryColor.withOpacity(0.5),
                    fontSize: 12.sp,
                  ),
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Theme.of(context).buttonTheme.colorScheme!.secondary,
                  width: 0,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              constraints: const BoxConstraints(maxHeight: 40),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  width: 0,
                  color: Theme.of(context).buttonTheme.colorScheme!.secondary,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  width: 0,
                  color: Theme.of(context).buttonTheme.colorScheme!.secondary,
                ),
              ),
            ),
          ),
        ),
        AnimatedContainer(
          width: showSend ? 50 : 0,
          duration: Duration(milliseconds: 150),
          padding: showSend ? EdgeInsets.fromLTRB(5, 0, 0, 0) : EdgeInsets.zero,
          child: GestureDetector(
            onTap: () {
              onSend();
            },
            child: OverflowBox(
              maxWidth: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (showSend)
                    Text(
                      "Send",
                      style: Theme.of(context)
                          .textTheme
                          .displaySmall!
                          .copyWith(fontWeight: FontWeight.w600),
                    ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  void onTapImojie() {}
}
