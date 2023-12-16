import 'package:vmodel/src/res/colors.dart';
import 'package:vmodel/src/vmodel.dart';

import '../../../res/ui_constants.dart';

class VWidgetsDropDownTextFieldWithTrailingIcon<T> extends StatelessWidget {
  final String? fieldLabel;
  final String hintText;
  final List<T> options;
  final T? value;
  final String Function(T)? getLabel;
  final Function(T)? onChanged;
  //final VoidCallback? onChanged;
  final VoidCallback? onTap;
  final double? minWidth;
  final int? maxLength;
  final Widget? trailingIcon;
  final Widget? suffix;
  final VoidCallback? onPressedIcon;

  const VWidgetsDropDownTextFieldWithTrailingIcon({
    this.fieldLabel,
    this.hintText = 'Please select an Option',
    this.options = const [],
    this.getLabel,
    this.value,
    this.onChanged,
    this.onTap,
    this.minWidth,
    this.maxLength,
    this.suffix,
    this.trailingIcon,
    this.onPressedIcon,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: minWidth ?? 100.0.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                fieldLabel ?? "",
                style: Theme.of(context).textTheme.displayMedium!.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).primaryColor.withOpacity(1),
                    ),
              ),

              /// add VIcon for add_icon
              IconButton(
                padding: const EdgeInsets.all(0),
                alignment: Alignment.bottomRight,
                onPressed: onPressedIcon,
                icon: trailingIcon ??
                    const Icon(
                      Icons.add,
                      color: VmodelColors.primaryColor,
                    ),
              ),
            ],
          ),
          SizedBox(height: 0.5.h),
          SizedBox(
            height: maxLength != null ? 6.h : 6.h,
            width: minWidth ?? 100.0.w,
            child: FormField<T>(
              builder: (FormFieldState<T> state) {
                return InputDecorator(
                  decoration: UIConstants.instance.inputDecoration(
                    context,
                    suffixIcon: null,
                    prefixIcon: null,
                    hintText: hintText,
                    helperText: null,
                    hintStyle: null,
                    contentPadding: const EdgeInsets.fromLTRB(10, 5, 10, 7),
                  ),
                  // decoration: InputDecoration(
                  //   // suffixIcon: suffix ?? const Icon(Icons.arrow_drop_down_rounded),
                  //   contentPadding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  //   labelText: hintText,
                  //   labelStyle: Theme.of(context)
                  //       .textTheme
                  //       .displayMedium!
                  //       .copyWith(
                  //         color: Theme.of(context).primaryColor.withOpacity(1),
                  //         fontSize: 12.sp,
                  //       ),
                  //   focusedBorder: OutlineInputBorder(
                  //       borderSide: BorderSide(
                  //           color:
                  //               Theme.of(context).primaryColor.withOpacity(1),
                  //           width: 1.5),
                  //       borderRadius:
                  //           const BorderRadius.all(Radius.circular(8))),
                  //   disabledBorder: OutlineInputBorder(
                  //       borderSide: BorderSide(
                  //           color:
                  //               Theme.of(context).primaryColor.withOpacity(0.4),
                  //           width: 1.5),
                  //       borderRadius:
                  //           const BorderRadius.all(Radius.circular(7.5))),
                  //   border: OutlineInputBorder(
                  //       borderSide: BorderSide(
                  //           color:
                  //               Theme.of(context).primaryColor.withOpacity(0.4),
                  //           width: 1.5),
                  //       borderRadius:
                  //           const BorderRadius.all(Radius.circular(7.5))),
                  //   enabledBorder: OutlineInputBorder(
                  //       borderSide: BorderSide(
                  //           color:
                  //               Theme.of(context).primaryColor.withOpacity(0.4),
                  //           width: 1.5),
                  //       borderRadius:
                  //           const BorderRadius.all(Radius.circular(7.5))),
                  //   focusedErrorBorder: const OutlineInputBorder(
                  //       borderSide: BorderSide(
                  //           color: VmodelColors.bottomNavIndicatiorColor,
                  //           width: 1.0),
                  //       borderRadius: BorderRadius.all(Radius.circular(7.5))),
                  //   errorBorder: const OutlineInputBorder(
                  //       borderSide: BorderSide(
                  //           color: VmodelColors.bottomNavIndicatiorColor,
                  //           width: 1.0),
                  //       borderRadius: BorderRadius.all(Radius.circular(7.5))),
                  // ),
                  isEmpty: value == null || value == '',
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<T>(
                      iconSize: 32,
                      iconDisabledColor: VmodelColors.greyColor,
                      iconEnabledColor: VmodelColors.primaryColor,
                      icon: suffix ?? const Icon(Icons.arrow_drop_down_rounded),
                      borderRadius: BorderRadius.circular(12),
                      value: value,
                      isDense: true,
                      onTap: onTap,
                      onChanged: (text) {
                        if (onChanged != null) onChanged!(text as T);
                      },
                      items: options.map((T value) {
                        return DropdownMenuItem<T>(
                          value: value,
                          alignment: AlignmentDirectional.centerStart,
                          child: Text(
                            getLabel!(value),
                            style: Theme.of(context).textTheme.displayMedium,
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
}
