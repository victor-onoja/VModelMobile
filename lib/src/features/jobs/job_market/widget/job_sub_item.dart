import 'package:vmodel/src/core/utils/costants.dart';
import 'package:vmodel/src/res/icons.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/shared/picture_styles/rounded_square_avatar.dart';
import 'package:vmodel/src/shared/rend_paint/render_svg.dart';
import 'package:vmodel/src/vmodel.dart';

import '../../../messages/views/messages_homepage.dart';
import '../model/job_post_model.dart';

class JobSubItem extends StatelessWidget {
  final JobPostModel item;
  final VoidCallback? onTap;
  final bool isViewAll;
  final VoidCallback? onLongPress;
  const JobSubItem({
    Key? key,
    required this.item,
    required this.onTap,
    required this.onLongPress,
    this.isViewAll = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    int subFontSize = 10;
    int subGreyFontSize = 10;
    return Column(
      children: [
        Container(
          height: 150,
          width: SizerUtil.width * 0.40,
          margin: EdgeInsets.symmetric(horizontal: isViewAll ? 0 : 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
          ),
          child: GestureDetector(
            onTap: () {
              onTap!();
            },
            onLongPress: () {
              onLongPress!();
            },
            child: RoundedSquareAvatar(
              url: item.creator!.profilePictureUrl,
              thumbnail:
                  item.creator!.thumbnailUrl ?? item.creator!.thumbnailUrl,
            ),
          ),
        ),
        addVerticalSpacing(15),
        Column(
          children: [
            SizedBox(
              width: SizerUtil.width * 0.40,
              child: Text(
                item.jobTitle,
                style:
                    textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w400),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            addVerticalSpacing(5),
            SizedBox(
              width: SizerUtil.width * 0.4,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    item.priceOption.tileDisplayName,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w300,
                          // fontSize: subFontSize.sp,
                        ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    VConstants.noDecimalCurrencyFormatterGB
                        .format(item.priceValue),
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.w300,
                          // fontSize: subFontSize.sp,
                          // color: VmodelColors.primaryColor,
                        ),
                  ),
                ],
              ),
            ),
            addVerticalSpacing(5),
            SizedBox(
              width: SizerUtil.width * 0.4,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    item.jobType,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w300,
                        // fontSize: subGreyFontSize.sp,
                        color: Theme.of(context).primaryColor.withOpacity(0.5)),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Row(
                    children: [
                      RenderSvg(
                        svgPath: VIcons.star,
                        svgHeight: 12,
                        svgWidth: 12,
                        color: Theme.of(context).primaryColor.withOpacity(0.5),
                        // color: VmodelColors.primaryColor,
                      ),
                      addHorizontalSpacing(5),
                      Text(
                        '4.5',
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              fontWeight: FontWeight.w300,
                              // fontSize: subGreyFontSize.sp,
                              color: Theme.of(context)
                                  .primaryColor
                                  .withOpacity(0.5),
                            ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            addVerticalSpacing(5),
            SizedBox(
              width: SizerUtil.width * 0.4,
              child: Row(
                children: [
                  RenderSvg(
                    svgPath: VIcons.calendarTick,
                    svgHeight: 17,
                    svgWidth: 17,
                    color: Theme.of(context).primaryColor.withOpacity(0.5),
                  ),
                  addHorizontalSpacing(3),
                  Text(
                    "${item.jobDelivery[0].date.formatDateExtension()}",
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w300,
                          // fontSize: subGreyFontSize.sp,
                          color:
                              Theme.of(context).primaryColor.withOpacity(0.5),
                        ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
