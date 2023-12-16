import 'package:vmodel/src/res/gap.dart';
import 'package:vmodel/src/vmodel.dart';

class VWidgetsRecentViewCard extends StatelessWidget {
  final String? image;
  final String? title;
  final int? count;
  final VoidCallback? onTap;
  const VWidgetsRecentViewCard(
      {required this.image,
      required this.title,
      required this.count,
      required this.onTap,
      super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child:  Column(
          children: [
            Row(
              children: [
                Image.asset(
                image!,
                width: 70,
                height: 70,
                fit: BoxFit.cover,),
                addHorizontalSpacing(10),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title!,
                      style: Theme.of(context).textTheme.displayMedium!.copyWith(
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).primaryColor,
                          fontSize: 12.sp),
                    ),
                    Text(
                      count.toString(),
                      style: Theme.of(context).textTheme.displayMedium!.copyWith(
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).primaryColor,
                          fontSize: 11.sp),
                    )
                  ],
                ),
           
              ],
            ),
          const Divider(
            thickness: 1,
           ), 
          ],
        ),
      
    );
  }
}
