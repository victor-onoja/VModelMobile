import '../../res/colors.dart';
import '../../res/ui_constants.dart';
import '../../vmodel.dart';

@Deprecated("Use VWidgetsDropdownNormal instead")
class VWidgetsDropDownTextField<T> extends StatelessWidget {
  final String? fieldLabel;
  final String hintText;
  final List<T> options;
  final T? value;
  final String Function(T)? getLabel;
  final Function(T)? onChanged;
  final bool isIncreaseHeightForErrorText;
  final double? heightForErrorText;
  // final VoidCallback? onChanged;
  final VoidCallback? onTap;
  final int? maxLength;
  final double? minWidth;
  final Widget? suffix;
  final Widget? prefix;
  final String? prefixText;
  final bool? havePrefix;
  final bool isExpanded;
  final bool isOneLineEllipsize;
  final bool isDisabled;

  var labelStyle;

  var hintStyle;

  final dynamic validator;
  final String Function(T)? customDisplay;

  VWidgetsDropDownTextField({
    this.validator,
    this.labelStyle,
    this.hintStyle,
    this.fieldLabel,
    this.hintText = 'Please select an Option',
    this.options = const [],
    this.getLabel,
    this.value,
    this.onChanged,
    this.onTap,
    this.maxLength,
    this.minWidth,
    this.suffix,
    super.key,
    this.havePrefix = false,
    this.prefix,
    this.prefixText,
    this.isIncreaseHeightForErrorText = false,
    this.heightForErrorText,
    this.isExpanded = false,
    this.isOneLineEllipsize = false,
    this.isDisabled = false,
    this.customDisplay,
  });

  @override
  Widget build(BuildContext context) {
    return havePrefix == true
        ? SizedBox(
            width: minWidth ?? 100.0.w,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
              
                  SizedBox(height: 0.5.h),
                  SizedBox(
                    height: maxLength != null
                        ? 6.h
                        : isIncreaseHeightForErrorText
                            ? heightForErrorText ?? 10.h
                            : 6.h,
                    width: minWidth ?? 100.0.w,
                    child: FormField<T>(
                      builder: (FormFieldState<T> state) {
                        return InputDecorator(
                          decoration: UIConstants.instance.inputDecoration(
                            context,
                            prefixIcon: prefix,
                            suffixIcon: suffix ??
                                const Icon(Icons.arrow_drop_down_rounded),
                            hintText: hintText,
                            helperText: null,
                            hintStyle: hintStyle,
                          ),
                          // InputDecoration(
                          //   // suffixIcon: suffix ?? const Icon(Icons.arrow_drop_down_rounded),
                          //   isDense: false,
                          //   prefixIcon: prefix,
                          //   prefixText: prefixText,
                          //   prefixStyle: Theme.of(context)
                          //       .textTheme
                          //       .displayMedium
                          //       ?.copyWith(
                          //           fontSize: 14,
                          //           fontWeight: FontWeight.w500,
                          //           color: VmodelColors.text3,
                          //           height: 1.7),
                          //   contentPadding: EdgeInsets.zero,
                          //   // const EdgeInsets.fromLTRB(12, 5, 12, 5),
                          //   labelText: hintText,
                          //   labelStyle: Theme.of(context)
                          //       .textTheme
                          //       .displayMedium!
                          //       .copyWith(
                          //         color: Theme.of(context)
                          //             .primaryColor
                          //             .withOpacity(0.5),
                          //         fontSize: 12.sp,
                          //       ),
                          //   focusedBorder: OutlineInputBorder(
                          //       borderSide: BorderSide(
                          //           color: Theme.of(context)
                          //               .primaryColor
                          //               .withOpacity(1),
                          //           width: 1.5),
                          //       borderRadius:
                          //           const BorderRadius.all(Radius.circular(8))),
                          //   disabledBorder: OutlineInputBorder(
                          //       borderSide: BorderSide(
                          //           color: Theme.of(context)
                          //               .primaryColor
                          //               .withOpacity(0.4),
                          //           width: 1.5),
                          //       borderRadius: const BorderRadius.all(
                          //           Radius.circular(7.5))),
                          //   border: OutlineInputBorder(
                          //       borderSide: BorderSide(
                          //           color: Theme.of(context)
                          //               .primaryColor
                          //               .withOpacity(0.4),
                          //           width: 1.5),
                          //       borderRadius: const BorderRadius.all(
                          //           Radius.circular(7.5))),
                          //   enabledBorder: OutlineInputBorder(
                          //       borderSide: BorderSide(
                          //           color: Theme.of(context)
                          //               .primaryColor
                          //               .withOpacity(0.4),
                          //           width: 1.5),
                          //       borderRadius: const BorderRadius.all(
                          //           Radius.circular(7.5))),
                          //   focusedErrorBorder: const OutlineInputBorder(
                          //       borderSide: BorderSide(
                          //           color:
                          //               VmodelColors.bottomNavIndicatiorColor,
                          //           width: 1.5),
                          //       borderRadius:
                          //           BorderRadius.all(Radius.circular(7.5))),
                          //   errorBorder: const OutlineInputBorder(
                          //       borderSide: BorderSide(
                          //           color:
                          //               VmodelColors.bottomNavIndicatiorColor,
                          //           width: 1.0),
                          //       borderRadius:
                          //           BorderRadius.all(Radius.circular(7.5))),
                          // ),
                          isEmpty: isValueEmptyOrNull,
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<T>(
                              isExpanded: isExpanded,
                              menuMaxHeight: 200,
                              // isExpanded: true,
                              iconSize: 32,
                              iconDisabledColor: VmodelColors.greyColor,
                              iconEnabledColor:
                                  Theme.of(context).iconTheme.color,
                              icon: suffix ??
                                  const Icon(Icons.arrow_drop_down_rounded),
                              borderRadius: BorderRadius.circular(12),
                              value: value,
                              isDense: true,
                              onTap: onTap,
                              onChanged: isDisabled
                                  ? null
                                  : (text) {
                                      if (onChanged != null)
                                        onChanged!(text as T);
                                    },
                              items: options.map((T value) {
                                return DropdownMenuItem<T>(
                                  value: value,
                                  alignment: AlignmentDirectional.centerStart,
                                  child: Text(
                                    customDisplay != null
                                        ? customDisplay!(value)
                                        : value.toString(),
                                    maxLines: isOneLineEllipsize ? 1 : null,
                                    overflow: isOneLineEllipsize
                                        ? TextOverflow.ellipsis
                                        : null,
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayMedium!
                                        .copyWith(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14,
                                          color: Theme.of(context)
                                              .primaryColor
                                              .withOpacity(1),
                                        ),
                                  ),
                                  // Divider(),
                                );
                              }).toList(),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          )
        : SizedBox(
            width: minWidth ?? 100.0.w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (fieldLabel != null) ...[
                  Text(
                    fieldLabel ?? "",
                    style: Theme.of(context).textTheme.displayMedium!.copyWith(
                          fontWeight: FontWeight.w600,
                          color: isDisabled
                              ? Theme.of(context).primaryColor.withOpacity(.5)
                              : Theme.of(context).primaryColor.withOpacity(1),
                        ),
                  ),
                  SizedBox(height: 10),
                ],
                SizedBox(
                  height: maxLength != null ? 10.h : 10.h,
                  width: minWidth ?? 100.0.w,
                  child: FormField<T>(
                    builder: (FormFieldState<T> state) {
                      return InputDecorator(
                        decoration: UIConstants.instance.inputDecoration(
                          context,
                          prefixIcon: prefix,
                          suffixIcon: null,
                          hintText: hintText,
                          helperText: null,
                          hintStyle: hintStyle,
                          contentPadding:
                              const EdgeInsets.fromLTRB(12, 5, 12, 5),
                        ),

                        // decoration:
                        // InputDecoration(
                        //   isDense: true,
                        //   prefixIcon: prefix,
                        //   contentPadding:
                        //       const EdgeInsets.fromLTRB(12, 5, 12, 5),
                        //   labelText: hintText,
                        //   labelStyle: Theme.of(context)
                        //       .textTheme
                        //       .displayMedium!
                        //       .copyWith(
                        //         color: Theme.of(context)
                        //             .primaryColor
                        //             .withOpacity(0.5),
                        //         fontSize: 12.sp,
                        //       ),
                        //   focusedBorder: OutlineInputBorder(
                        //       borderSide: BorderSide(
                        //           color: Theme.of(context)
                        //               .primaryColor
                        //               .withOpacity(1),
                        //           width: 1.5),
                        //       borderRadius:
                        //           const BorderRadius.all(Radius.circular(8))),
                        //   disabledBorder: OutlineInputBorder(
                        //       borderSide: BorderSide(
                        //           color: Theme.of(context)
                        //               .primaryColor
                        //               .withOpacity(0.4),
                        //           width: 1.5),
                        //       borderRadius:
                        //           const BorderRadius.all(Radius.circular(7.5))),
                        //   border: OutlineInputBorder(
                        //       borderSide: BorderSide(
                        //           color: Theme.of(context)
                        //               .primaryColor
                        //               .withOpacity(0.4),
                        //           width: 1.5),
                        //       borderRadius:
                        //           const BorderRadius.all(Radius.circular(7.5))),
                        //   enabledBorder: OutlineInputBorder(
                        //       borderSide: BorderSide(
                        //           color: Theme.of(context)
                        //               .primaryColor
                        //               .withOpacity(0.4),
                        //           width: 1.5),
                        //       borderRadius:
                        //           const BorderRadius.all(Radius.circular(7.5))),
                        //   focusedErrorBorder: const OutlineInputBorder(
                        //       borderSide: BorderSide(
                        //           color: VmodelColors.bottomNavIndicatiorColor,
                        //           width: 1.5),
                        //       borderRadius:
                        //           BorderRadius.all(Radius.circular(7.5))),
                        //   errorBorder: const OutlineInputBorder(
                        //       borderSide: BorderSide(
                        //           color: VmodelColors.bottomNavIndicatiorColor,
                        //           width: 1.0),
                        //       borderRadius:
                        //           BorderRadius.all(Radius.circular(7.5))),
                        // ),
                        isEmpty: isValueEmptyOrNull,
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<T>(
                            menuMaxHeight: 200,
                            isExpanded: isExpanded,
                            iconSize: 32,

                            iconDisabledColor: VmodelColors.greyColor,
                            iconEnabledColor: isDisabled
                                ? Theme.of(context)
                                    .iconTheme
                                    .color
                                    ?.withOpacity(.5)
                                : Theme.of(context).iconTheme.color,
                            icon: suffix ??
                                const Icon(Icons.arrow_drop_down_rounded),
                            borderRadius: BorderRadius.circular(12),
                            value: value,
                            isDense: true,
                            onTap: onTap,
                            onChanged: isDisabled
                                ? null
                                : (text) {
                                    if (onChanged != null)
                                      onChanged!(text as T);
                                  },
                            // onChanged: (text) {
                            //   if (onChanged != null) onChanged!(text as T);
                            // },
                            items: options.map((T value) {
                              return DropdownMenuItem<T>(
                                value: value,
                                alignment: AlignmentDirectional.centerStart,
                                child: Text(
                                  customDisplay != null
                                      ? customDisplay!(value)
                                      : value.toString(),
                                  // value.toString(),
                                  maxLines: isOneLineEllipsize ? 1 : null,
                                  overflow: isOneLineEllipsize
                                      ? TextOverflow.ellipsis
                                      : null,
                                  style: Theme.of(context)
                                      .textTheme
                                      .displayMedium!
                                      .copyWith(
                                        fontWeight: FontWeight.w500,
                                        color: isDisabled
                                            ? Theme.of(context)
                                                .primaryColor
                                                .withOpacity(.5)
                                            : Theme.of(context)
                                                .primaryColor
                                                .withOpacity(1),
                                      ),
                                ),
                                // Divider(),
                              );
                            }).toList(),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
  }

  bool get isValueEmptyOrNull {
    if (value is String) return value == null || value == '';
    return value == null;
  }
}
