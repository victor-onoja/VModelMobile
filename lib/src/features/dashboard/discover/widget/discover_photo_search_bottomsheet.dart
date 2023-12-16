import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/vmodel.dart';

class VWidgetsPhotoSearchCard extends StatelessWidget {
  final String? image;
  final String? profileImage;
  final String? profileName;
  final List<String>? hashtags;
  final VoidCallback? onTap;

  const VWidgetsPhotoSearchCard(
      {required this.image,
      required this.profileImage,
      required this.profileName,
      required this.hashtags,
      required this.onTap,
      super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
              Container(
            width: 164,
            height: 219,
            decoration: BoxDecoration(
              color: VmodelColors.primaryColor,
              borderRadius: const BorderRadius.all(
                Radius.circular(12),
              ),
              image: DecorationImage(
                image: AssetImage(image!),
                fit: BoxFit.cover,
              ),
            ),
          ),
            addVerticalSpacing(10),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //Sender Profile
                Container(
                  width: 25,
                  height: 25,
                  decoration: BoxDecoration(
                    color: VmodelColors.primaryColor,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(100),
                    ),
                    image: DecorationImage(
                      image: AssetImage(profileImage!),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                addHorizontalSpacing(10),
                //Sender Text
                Flexible(
                  child: Text(
                    profileName!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.displayMedium!.copyWith(
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).primaryColor,
                        fontSize: 11.sp),
                  ),
                ),
                
              ],
            ),
            addVerticalSpacing(6),
             Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  ...hashtags!.map(
                    (e) {
                      return Flexible(  
                        child: Text(
                            e,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
                                .textTheme
                                .displayMedium!
                                .copyWith(
                                    fontWeight: FontWeight.w500,
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 10.sp),
                          
                        ),
                      );
                    },
                  )
                ],
              ),
        
          ],
        ),
      
    );
  }
}
