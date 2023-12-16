import 'package:vmodel/src/vmodel.dart';

class VWidgetsMagazineCoverCard extends StatelessWidget {
   final String? image;
   final VoidCallback? onTap;
  const VWidgetsMagazineCoverCard({
    required this.image,
    required this.onTap,
    super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const VWidgetsPagePadding.horizontalSymmetric(10),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 220,
          width: 160,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.6),
                blurRadius: 6.0,
                offset: const Offset(0.0, 0.75),
              ),
            ],
            image: DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage(image!),
            ),
          ),
        ),
      ),
    );
  }
}
