import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/vmodel.dart';

class LogoDropDownObject {
  Widget? logo;
  String? logoValue;
  LogoDropDownObject({this.logoValue, this.logo});
}

class VWidgetsDropDownTextFieldWithLogos extends StatelessWidget {
  final String? fieldLabel;
  final String hintText;
  final List<LogoDropDownObject> options;
  final String? value;
  final Widget? logo;
  final String? logoValue;

  final Function(dynamic)? onChanged;
  // final VoidCallback? onChanged;
  final VoidCallback? onTap;
  final double? minWidth;
  final int? maxLength;
  final Widget? suffix;
  final Widget? prefix;
  final Widget? fieldLabelWidget;

  const VWidgetsDropDownTextFieldWithLogos({
    this.fieldLabel,
    this.hintText = 'Please select an Option',
    this.options = const [],
    this.value,
    this.onChanged,
    this.onTap,
    this.fieldLabelWidget,
    this.minWidth,
    this.maxLength,
    this.suffix,
    this.logo,
    this.logoValue,
    super.key,
    this.prefix,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: minWidth ?? 100.0.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          fieldLabelWidget ??
              Text(
                fieldLabel ?? "",
                style: Theme.of(context).textTheme.displayMedium!.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).primaryColor.withOpacity(1),
                    ),
              ),
          SizedBox(height: 0.5.h),
          SizedBox(
            height: maxLength != null ? 6.h : 6.h,
            width: minWidth ?? 100.0.w,
            child: FormField<dynamic>(
              builder: (FormFieldState<dynamic> state) {
                return InputDecorator(
                  decoration: InputDecoration(
                    // suffixIcon: suffix ?? const Icon(Icons.arrow_drop_down_rounded),
                    isDense: true,
                    
                    prefixIcon: prefix,
                    contentPadding:
                        const EdgeInsets.fromLTRB(14.5, 10, 14.5, 10),
                    labelText: hintText,
                    labelStyle:
                        Theme.of(context).textTheme.displayMedium!.copyWith(
                              color: VmodelColors.unselectedText,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color:
                                Theme.of(context).primaryColor.withOpacity(1),
                            width: 1.5),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8))),
                    disabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color:
                                Theme.of(context).primaryColor.withOpacity(0.4),
                            width: 1.5),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(7.5))),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                            color:
                                Theme.of(context).primaryColor.withOpacity(0.4),
                            width: 1.5),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(7.5))),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color:
                                Theme.of(context).primaryColor.withOpacity(0.4),
                            width: 1.5),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(7.5))),
                    focusedErrorBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                            color: VmodelColors.bottomNavIndicatiorColor,
                            width: 1.5),
                        borderRadius: BorderRadius.all(Radius.circular(7.5))),
                    errorBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                            color: VmodelColors.bottomNavIndicatiorColor,
                            width: 1.0),
                        borderRadius: BorderRadius.all(Radius.circular(7.5))),
                  ),
                  isEmpty: value == null || value == '',
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<dynamic>(
                      iconSize: 32,
                      iconDisabledColor: VmodelColors.greyColor,
                      iconEnabledColor: VmodelColors.primaryColor,
                      icon: suffix ??
                          const Icon(
                            Icons.arrow_drop_down_rounded,
                          ),
                      borderRadius: BorderRadius.circular(12),
                      value: value,
                      isDense: true,
                      onTap: onTap,
                      onChanged: (text) {
                        if (onChanged != null) onChanged!(text);
                      },
                      items: options.map((LogoDropDownObject value) {
                        return DropdownMenuItem<dynamic>(
                          value: value.logoValue,
                          alignment: AlignmentDirectional.centerStart,
                          child: Row(
                            children: [
                              value.logo!,
                              addHorizontalSpacing(15),
                              Text(
                                value.logoValue!,
                                style: Theme.of(context)
                                    .textTheme
                                    .displayMedium!
                                    .copyWith(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w500,
                                        color: VmodelColors.unselectedText),
                              ),
                            ],
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
