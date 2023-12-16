import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:vmodel/src/res/res.dart';

class SearchTextFieldWidget extends StatefulWidget {
  final String? label;
  final int? minLines;
  final TextInputType? keyboardType;
  final bool obscureText;
  final String? hintText;
  final TextInputFormatter? formatter;
  final TextCapitalization? textCapitalization;
  final Function(String)? onChanged;
  final Function(String?)? onSaved;
  final Function()? onTap;
  final int? maxLength;
  final TextEditingController? controller;
  final dynamic validator;
  final bool shouldReadOnly;
  final double? minWidth;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final TextStyle? labelStyle;
  final bool enabled;
  final TextStyle? hintStyle;
  final FocusNode? focusNode;
  final ValueChanged? onTapOutside;
  final InputBorder? enabledBorder;
  final bool showInputBorder;
  final bool autofocus;
  final VoidCallback? onCancel;
  final ValueChanged<bool>? onFocused;

  const SearchTextFieldWidget({
    super.key,
    this.label,
    this.minLines,
    this.onChanged,
    this.onTap,
    this.keyboardType,
    this.formatter,
    this.onSaved,
    this.obscureText = false,
    this.hintText,
    this.maxLength,
    this.controller,
    this.validator,
    this.textCapitalization,
    this.shouldReadOnly = false,
    trailing,
    this.suffixIcon,
    this.enabled = true,
    this.minWidth,
    this.prefixIcon,
    this.labelStyle,
    this.hintStyle,
    this.focusNode,
    this.showInputBorder = true,
    this.autofocus = false,
    this.onTapOutside,
    this.enabledBorder,
    this.onCancel,
    this.onFocused,
  });

  @override
  State<SearchTextFieldWidget> createState() => _SearchTextFieldWidgetState();
}

class _SearchTextFieldWidgetState extends State<SearchTextFieldWidget> {
  late final Widget suffixIconII;
  FocusNode? focusNodeZZZ;
  late final TextEditingController mController;
  bool _hasText = false;
  bool showCancel = false;
  bool showText = false;

  initState() {
    super.initState();
    mController = widget.controller ?? TextEditingController();
    suffixIconII = widget.suffixIcon ??
        InkResponse(
          onTap: () {},
          child: Container(
              color: Colors.amber,
              padding: EdgeInsets.all(5),
              child: Icon(Icons.close_rounded)),
        );

    if (widget.focusNode == null) {
      focusNodeZZZ = FocusNode();
      focusNodeZZZ?.addListener(addListenerToFocusNode);
    } else {
      widget.focusNode?.addListener(addListenerToFocusNodeWidget);
    }
  }

  void clearText() {
    widget.controller?.clear();
    _hasText = false;
    mController.text = '';
    widget.onChanged?.call('');
    setState(() {});
  }

  void addListenerToFocusNode() async {
    if (focusNodeZZZ!.hasFocus) {
      showCancel = true;
    } else {
      showCancel = false;
    }

    widget.onFocused?.call(focusNodeZZZ!.hasFocus);

    print("objectdwfs");
    setState(() {});
    if (focusNodeZZZ!.hasFocus) {
      Future.delayed(Duration(milliseconds: 302), () {
        showText = true;
        setState(() {});
      });
    } else {
      showText = false;
      setState(() {});
    }
  }

  void addListenerToFocusNodeWidget() async {
    if (widget.focusNode!.hasFocus) {
      showCancel = true;
    } else {
      showCancel = false;
    }

    setState(() {});
    if (widget.focusNode!.hasFocus) {
      await Future.delayed(Duration(milliseconds: 302), () {
        showText = true;
        setState(() {});
      });
    } else {
      showText = false;
      setState(() {});
    }
  }

  dispose() {
    super.dispose();
    widget.focusNode?.removeListener(addListenerToFocusNodeWidget);
    focusNodeZZZ?.removeListener(addListenerToFocusNode);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Container(
            height: widget.maxLength != null ? 7.h : 5.h,
            width: widget.minWidth ?? 100.0.w,
            child: TextFormField(
              autofocus: widget.autofocus,
              autocorrect: false,
              enableSuggestions: false,
              minLines: widget.minLines ?? 1,
              controller: mController,
              maxLength: widget.maxLength,
              onSaved: widget.onSaved,
              enabled: widget.enabled,
              textCapitalization:
                  widget.textCapitalization ?? TextCapitalization.none,
              onTap: widget.onTap,
              onTapOutside: widget.onTapOutside,
              focusNode: widget.focusNode ?? focusNodeZZZ,
              onChanged: (text) {
                if (widget.onChanged != null) widget.onChanged!(text);
                _hasText = text.isNotEmpty;
                print("_hasText $_hasText");
                setState(() {});
              },
              cursorColor: Theme.of(context).primaryColor,
              keyboardType: widget.keyboardType,
              obscureText: widget.obscureText,
              obscuringCharacter: '●',
              inputFormatters: [
                widget.formatter ??
                    FilteringTextInputFormatter.singleLineFormatter
              ],
              maxLengthEnforcement: MaxLengthEnforcement.enforced,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: widget.validator,
              style: Theme.of(context).textTheme.displayMedium!.copyWith(
                    color: Theme.of(context).primaryColor.withOpacity(1),
                  ),
              readOnly: widget.shouldReadOnly,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    // color: VmodelColors.primaryColor,
                    color: Theme.of(context).buttonTheme.colorScheme!.secondary,
                    width: 0,
                  ),
                ),
                filled: true,
                fillColor: Theme.of(context).buttonTheme.colorScheme!.secondary,
                //Ternary switch is important. It prevents a subtle bug where
                // sometimes after tapping on cancel and tapping again the
                // field is not activated
                suffix: _hasText
                    ? InkResponse(
                        onTap: () {
                          if (showCancel) clearText();
                        },
                        child: Container(
                            decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.3),
                                borderRadius: BorderRadius.circular(100)),
                            padding: EdgeInsets.all(3),
                            child: Icon(
                              Icons.close_rounded,
                              color: Colors.white,
                              size: 12,
                            )),
                      )
                    : SizedBox.shrink(),
                // suffixIcon: _hasText ? suffixIconII : null,
                suffixIconConstraints:
                    const BoxConstraints(maxHeight: 20, maxWidth: 24),
                prefixIcon: widget.prefixIcon,
                suffixStyle:
                    Theme.of(context).textTheme.displayMedium!.copyWith(
                          color: VmodelColors.boldGreyText,
                          fontWeight: FontWeight.w700,
                          fontSize: 12.sp,
                        ),
                isDense: true,
                counterText: "",
                hintText: widget.hintText,
                hintStyle: widget.hintStyle ??
                    Theme.of(context).textTheme.displayMedium!.copyWith(
                        color: Theme.of(context).primaryColor.withOpacity(0.5),
                        fontSize: 11.sp,
                        overflow: TextOverflow.clip),
                contentPadding: const EdgeInsets.fromLTRB(10, 12, 14.5, 8),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    // color: VmodelColors.primaryColor,
                    color: Theme.of(context).buttonTheme.colorScheme!.secondary,
                    width: 0,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    // color: VmodelColors.primaryColor,
                    color: Theme.of(context).buttonTheme.colorScheme!.secondary,
                    width: 0,
                  ),
                ),
              ),
            ),
          ),
        ),
        // if (showCancel)
        AnimatedContainer(
          width: showCancel ? 70 : 0,
          height: showCancel ? 30 : 0,
          color: Colors.transparent,
          alignment: Alignment.centerRight,
          duration: Duration(milliseconds: 150),
          padding:
              showCancel ? EdgeInsets.fromLTRB(15, 0, 0, 0) : EdgeInsets.zero,
          // margin: const EdgeInsets.only(bottom: 10),
          child: GestureDetector(
            onTap: () {
              clearText();
              widget.onCancel?.call();
              // widget.focusNode?.unfocus();
              if (widget.focusNode == null) {
                focusNodeZZZ?.unfocus();
              }
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (showText)
                  Expanded(
                    child: Text(
                      "Cancel",
                      style: context.textTheme.displayMedium!.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        )
        // : SizedBox.shrink(),
      ],
    );
  }
}
