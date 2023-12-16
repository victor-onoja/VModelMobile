import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/vmodel.dart';

class VWidgetsAppBarTitleText extends StatelessWidget {
  final String? titleText;
  final TextStyle? titleTextStyle;

  const VWidgetsAppBarTitleText({
    required this.titleText,
    this.titleTextStyle,
    
    super.key,

    
    });

  @override
  Widget build(BuildContext context) {
    return Text(
      titleText!,
      style: titleTextStyle ?? VModelTypography1.normalTextStyle.copyWith(
        color: Theme.of(context).primaryColor,
        fontWeight: FontWeight.w600,
        fontSize: 13.sp,
      ),
    );
  }
}


