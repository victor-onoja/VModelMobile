import 'package:vmodel/src/features/dashboard/new_profile/profile_features/widgets/profile_picture_widget.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/vmodel.dart';

class VWidgetsMessageCard extends StatelessWidget {
  final String? titleText;
  final String? profileImage;
  final String? latestMessage;
  final String? latestMessageTime;
  final VoidCallback? onPressedLike;
  final VoidCallback? onTapCard;

  const VWidgetsMessageCard({
    required this.titleText,
    required this.profileImage,
    this.latestMessage,
    this.latestMessageTime,
    this.onPressedLike,
    required this.onTapCard,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(3.0),
            child: ProfilePicture(
              showBorder: false,
              url: profileImage,
              headshotThumbnail: profileImage,
              size: 50,
            ),
          ),
          addHorizontalSpacing(10),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      titleText!,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            // color: VmodelColors.primaryColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 12.sp,
                          ),
                    ),
                    Expanded(child: addHorizontalSpacing(10)),
                    Text(
                      latestMessageTime!,
                      style: Theme.of(context)
                          .textTheme
                          .displayMedium!
                          .copyWith(
                            color:
                                Theme.of(context).primaryColor.withOpacity(0.5),
                            fontSize: 10.sp,
                            overflow: TextOverflow.clip,
                          ),
                    ),
                    // Text(
                    //   starRating!,
                    //   style: VModelTypography1.normalTextStyle.copyWith(
                    //     color: VmodelColors.primaryColor,
                    //     fontWeight: FontWeight.w600,
                    //     fontSize: 12.sp,
                    //   ),
                    // ),
                    //Not used VIcons here because its not matching the figma UI
                    //     const Icon(
                    //       Icons.star_rounded,
                    //       color: VmodelColors.primaryColor,
                    //       size: 16,
                    //     )
                  ],
                ),
                addVerticalSpacing(4),
                //second row
                Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        latestMessage!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style:
                            Theme.of(context).textTheme.displayMedium!.copyWith(
                                  color: Theme.of(context)
                                      .primaryColor
                                      .withOpacity(0.5),
                                  fontSize: 10.sp,
                                  overflow: TextOverflow.clip,
                                ),
                      ),
                    ),
                    addHorizontalSpacing(10),
                    // Text(
                    //   latestMessageTime!,
                    //   style:
                    //       Theme.of(context).textTheme.displayMedium!.copyWith(
                    //             color: Theme.of(context)
                    //                 .primaryColor
                    //                 .withOpacity(0.5),
                    //             fontSize: 10.sp,
                    //             overflow: TextOverflow.clip,
                    //           ),
                    // ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
