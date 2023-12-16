import '../../../../vmodel.dart';

class DarkGradientOverlay extends StatelessWidget {
  const DarkGradientOverlay(
      {super.key,
      this.gradientTopStart = 0.6,
      this.gradientTopStartBottomEnd = 1,
      this.borderRadiusValue,
      this.topColor = Colors.transparent,
      this.bottomColor = Colors.black87});
  final double gradientTopStart;
  final double gradientTopStartBottomEnd;
  final BorderRadius? borderRadiusValue;
  final Color topColor;
  final Color bottomColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        // color: Colors.amber,
        borderRadius: borderRadiusValue ??
            BorderRadius.vertical(bottom: Radius.circular(10)),
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [gradientTopStart, gradientTopStartBottomEnd],
            colors: [topColor, bottomColor]),
      ),
    );
  }
}
