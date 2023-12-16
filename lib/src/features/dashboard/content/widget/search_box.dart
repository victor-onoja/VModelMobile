import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:vmodel/src/res/colors.dart';


class SearchBox extends StatelessWidget {
  const SearchBox({Key? key, this.onChanged, required this.suffixIcon, required this.controller}) : super(key: key);
  final Function(String)? onChanged;
  final Widget suffixIcon;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: true,
      onChanged: onChanged,
      controller: controller,
      style: Theme.of(context).textTheme.displayMedium?.copyWith(color: Colors.white.withOpacity(0.8)),
      decoration: InputDecoration(
         isCollapsed: true,
                  suffixIcon: suffixIcon,
                  // prefixIcon: prefixIcon,
                  suffixStyle:
                      Theme.of(context).textTheme.displayMedium!.copyWith(
                            color: VmodelColors.boldGreyText,
                            fontWeight: FontWeight.w700,
                            fontSize: 12.sp,
                          ),
                  hintText: "#contentSearch",
                  hintStyle: 
                      Theme.of(context).textTheme.displayMedium!.copyWith(
                          color:
                          VmodelColors.searchOutlineColor,
                          fontSize: 12.sp,
                          height: 1.7),
                  contentPadding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: VmodelColors.searchOutlineColor,
                          width: 1.5),
                      borderRadius: const BorderRadius.all(Radius.circular(8))),
                  disabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color:
                              VmodelColors.searchOutlineColor,
                          width: 1.5),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(7.5))),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(
                          color:
                              VmodelColors.searchOutlineColor,
                          width: 1.5),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(7.5))),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color:
                            VmodelColors.searchOutlineColor.withOpacity(0.6),
                          width: 1.5),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(7.5))),
                  focusedErrorBorder: const OutlineInputBorder(borderSide: BorderSide(color: VmodelColors.bottomNavIndicatiorColor, width: 1.5), borderRadius: BorderRadius.all(Radius.circular(7.5))),
                  errorBorder: const OutlineInputBorder(borderSide: BorderSide(color: VmodelColors.bottomNavIndicatiorColor, width: 1.0), borderRadius: BorderRadius.all(Radius.circular(7.5)))

        // filled: true,
        //   fillColor: Colors.transparent,
        //   suffixIcon: suffixIcon,
        //   border: OutlineInputBorder(
        //       borderRadius: BorderRadius.circular(12),
        //       borderSide: BorderSide(color: VmodelColors.searchOutlineColor)
        //   ),

        //   enabledBorder: OutlineInputBorder(
        //       borderRadius: BorderRadius.circular(12),
        //       borderSide: BorderSide(color: VmodelColors.searchOutlineColor)
        //   ),

        //   focusedBorder: OutlineInputBorder(
        //       borderRadius: BorderRadius.circular(12),
        //       borderSide: BorderSide(color: VmodelColors.searchOutlineColor)
        //   ),

        //   hintStyle: Theme.of(context).textTheme.displayMedium?.copyWith(color: Colors.white.withOpacity(0.8)),
        //   hintText: " #contentsearch",
        //   constraints: const BoxConstraints(maxHeight: 40),
        //   contentPadding: const EdgeInsets.all(8)
        ),
    );
  }
}
