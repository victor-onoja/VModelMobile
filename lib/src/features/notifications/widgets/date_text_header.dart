import 'package:vmodel/src/vmodel.dart';

class VWidgetsDateHeader extends StatelessWidget {
  // final String? date;
  final String? dateAbbreviation;
  const VWidgetsDateHeader({required this.dateAbbreviation, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          dateAbbreviation!,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              // color: VmodelColors.primaryColor,
              fontWeight: FontWeight.w600,
              fontSize: 14.sp),
        ),
        // Text(
        //   date!,
        //   style: VModelTypography1.normalTextStyle.copyWith(
        //     fontSize: 10.sp,
        //     color: VmodelColors.primaryColor.withOpacity(0.5),
        //   ),
        // ),
      ],
    );
  }
}
