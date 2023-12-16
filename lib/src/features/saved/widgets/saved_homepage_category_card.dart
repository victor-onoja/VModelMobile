import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/vmodel.dart';

class VWidgetsSavedHomepageCategoryCard extends StatelessWidget {
  final String? categoryName;
  final String? categoryImage;
  final VoidCallback? onTap;
  const VWidgetsSavedHomepageCategoryCard(
      {required this.categoryImage,
      required this.categoryName,
      required this.onTap,
      super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            height: 150,
            width: 150,
            decoration: BoxDecoration(
                color: VmodelColors.appBarBackgroundColor,
                borderRadius: const BorderRadius.all(
                  Radius.circular(12),
                ),
                image: DecorationImage(
                  image: AssetImage(
                    categoryImage!,
                  ),
                  fit: BoxFit.cover,
                )),
          ),
          addVerticalSpacing(8),
          Text(
            categoryName!,
            style: Theme.of(context).textTheme.displaySmall!.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          )
        ],
      ),
    );
  }
}
