import 'package:vmodel/src/features/jobs/job_market/data/list_model.dart';
import 'package:vmodel/src/features/reviews/views/review_page_content.dart';
import 'package:vmodel/src/res/assets/app_asset.dart';
import 'package:vmodel/src/res/gap.dart';
import 'package:vmodel/src/res/icons.dart';
import 'package:vmodel/src/shared/rend_paint/render_svg.dart';
import 'package:vmodel/src/vmodel.dart';

class DemoListTile extends StatelessWidget {
  List<ListModel> titles = [
    ListModel(
        title: "Georgina Powell",
        subtitle: "Oct 23, 2022",
        image: VmodelAssets2.reviewCircleImage,
        icon: VmodelAssets2.ratingStarIcon,
        text: "2 weeks ago",
        comment:
            "I’m very happy working with you guys, I’m so happy  i got invited into this app and have got a booking  just under 24hrs! thanks so much guys for the nomin… ",
        number: "4.9",
        locationNumber: "5",
        jobQualityNumber: "4.5",
        timingNumber: "5",
        workEnergyNumber: "4.9"),
    ListModel(
        title: "Georgina Powell",
        subtitle: "Oct 23, 2022",
        image: VmodelAssets2.reviewCircleImage,
        icon: VmodelAssets2.ratingStarIcon,
        text: "2 weeks ago",
        comment:
            "I’m very happy working with you guys, I’m so happy  i got invited into this app and have got a booking  just under 24hrs! thanks so much guys for the nomin… ",
        number: "4.9",
        locationNumber: "5",
        jobQualityNumber: "4.5",
        timingNumber: "5",
        workEnergyNumber: "4.9"),
    ListModel(
        title: "Georgina Powell",
        subtitle: "Oct 23, 2022",
        image: VmodelAssets2.reviewCircleImage,
        icon: VmodelAssets2.ratingStarIcon,
        text: "2 weeks ago",
        comment:
            "I’m very happy working with you guys, I’m so happy  i got invited into this app and have got a booking  just under 24hrs! thanks so much guys for the nomin… ",
        number: "4.9",
        locationNumber: "5",
        jobQualityNumber: "4.5",
        timingNumber: "5",
        workEnergyNumber: "4.9"),
    ListModel(
        title: "Georgina Powell",
        subtitle: "Oct 23, 2022",
        image: VmodelAssets2.reviewCircleImage,
        icon: VmodelAssets2.ratingStarIcon,
        text: "2 weeks ago",
        comment:
            "I’m very happy working with you guys, I’m so happy  i got invited into this app and have got a booking  just under 24hrs! thanks so much guys for the nomin… ",
        number: "4.9",
        locationNumber: "5",
        jobQualityNumber: "4.5",
        timingNumber: "5",
        workEnergyNumber: "4.9"),
    ListModel(
        title: "Georgina Powell",
        subtitle: "Oct 23, 2022",
        image: VmodelAssets2.reviewCircleImage,
        icon: VmodelAssets2.ratingStarIcon,
        text: "2 weeks ago",
        comment:
            "I’m very happy working with you guys, I’m so happy  i got invited into this app and have got a booking  just under 24hrs! thanks so much guys for the nomin… ",
        number: "4.9",
        locationNumber: "5",
        jobQualityNumber: "4.5",
        timingNumber: "5",
        workEnergyNumber: "4.9"),
    ListModel(
        title: "Georgina Powell",
        subtitle: "Oct 23, 2022",
        image: VmodelAssets2.reviewCircleImage,
        icon: VmodelAssets2.ratingStarIcon,
        text: "2 weeks ago",
        comment:
            "I’m very happy working with you guys, I’m so happy  i got invited into this app and have got a booking  just under 24hrs! thanks so much guys for the nomin… ",
        number: "4.9",
        locationNumber: "5",
        jobQualityNumber: "4.5",
        timingNumber: "5",
        workEnergyNumber: "4.9"),
  ];
  DemoListTile({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (var index = 0; index < titles.length; index++) ...[
          GestureDetector(
            onTap: () {
              navigateToRoute(context, const ReviewsPageContent());
            },
            child: Column(children: [
              Row(
                //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 44,
                    width: 44,
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Image.asset(titles[index].image!),
                    ),
                  ),
                  addHorizontalSpacing(10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        titles[index].title!,
                        style: Theme.of(context)
                            .textTheme
                            .displayMedium!
                            .copyWith(fontWeight: FontWeight.w600),
                      ),
                      addVerticalSpacing(4),
                      Row(
                        children: [
                          Text(
                            titles[index].subtitle!,
                            style: Theme.of(context)
                                .textTheme
                                .displaySmall!
                                .copyWith(fontWeight: FontWeight.w500),
                          ),
                          addHorizontalSpacing(10),
                          Text(
                            titles[index].text!,
                            style: Theme.of(context)
                                .textTheme
                                .displaySmall!
                                .copyWith(
                                    fontWeight: FontWeight.w500,
                                    color: Theme.of(context)
                                        .primaryColor
                                        .withOpacity(0.5)),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            titles[index].number!,
                            style: Theme.of(context)
                                .textTheme
                                .displayMedium!
                                .copyWith(fontWeight: FontWeight.w600),
                          ),
                          addHorizontalSpacing(3),
                          RenderSvg(
                            svgPath: VIcons.star,
                            svgHeight: 14,
                            svgWidth: 14,
                            color: Theme.of(context).iconTheme.color,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              addVerticalSpacing(15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            titles[index].locationNumber!,
                            style: Theme.of(context)
                                .textTheme
                                .displayMedium!
                                .copyWith(fontWeight: FontWeight.w600),
                          ),
                          addHorizontalSpacing(3),
                          RenderSvg(
                            svgPath: VIcons.star,
                            svgHeight: 14,
                            svgWidth: 14,
                            color: Theme.of(context).iconTheme.color,
                          ),
                        ],
                      ),
                      addVerticalSpacing(4),
                      Text(
                        'Likely to recommend',
                        style: Theme.of(context)
                            .textTheme
                            .displaySmall!
                            .copyWith(
                                fontWeight: FontWeight.w600,
                                color: Theme.of(context)
                                    .primaryColor
                                    .withOpacity(0.5)),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            titles[index].jobQualityNumber!,
                            style: Theme.of(context)
                                .textTheme
                                .displayMedium!
                                .copyWith(fontWeight: FontWeight.w600),
                          ),
                          addHorizontalSpacing(3),
                          RenderSvg(
                            svgPath: VIcons.star,
                            svgHeight: 14,
                            svgWidth: 14,
                            color: Theme.of(context).iconTheme.color,
                          ),
                        ],
                      ),
                      addVerticalSpacing(4),
                      Text(
                        'Job Quality',
                        style: Theme.of(context)
                            .textTheme
                            .displaySmall!
                            .copyWith(
                                fontWeight: FontWeight.w600,
                                color: Theme.of(context)
                                    .primaryColor
                                    .withOpacity(0.5)),

                        /* Theme.of(context).textTheme.titleMedium!.copyWith(
                              fontSize: 11.sp,
                              color: VmodelColors.mainColor,
                              letterSpacing: -0.3,
                              fontWeight:  FontWeight.w500,
                            ), */
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            titles[index].timingNumber!,
                            style: Theme.of(context)
                                .textTheme
                                .displayMedium!
                                .copyWith(fontWeight: FontWeight.w600),
                          ),
                          addHorizontalSpacing(3),
                          RenderSvg(
                            svgPath: VIcons.star,
                            svgHeight: 14,
                            svgWidth: 14,
                            color: Theme.of(context).iconTheme.color,
                          ),
                        ],
                      ),
                      addVerticalSpacing(4),
                      Text(
                        'Timing',
                        style: Theme.of(context)
                            .textTheme
                            .displaySmall!
                            .copyWith(fontWeight: FontWeight.w600),
                      )
                    ],
                  ),
                  // Column(
                  //   children: [
                  //     Row(
                  //       children: [
                  //         Text(
                  //           titles[index].workEnergyNumber!,
                  //         style:Theme.of(context).textTheme.displayMedium!.copyWith(
                  //         fontWeight: FontWeight.w600,
                  //         color: VmodelColors.primaryColor
                  //       ),
                  //         ),
                  //         RenderSvg(
                  //         svgPath: VIcons.star,
                  //         svgHeight: 18,
                  //         svgWidth: 18,
                  //         color: VmodelColors.primaryColor,
                  //         ),
                  //       ],
                  //     ),
                  //    addVerticalSpacing(4),
                  //     Text(
                  //       'Work Energy',
                  //       style:Theme.of(context).textTheme.displaySmall!.copyWith(
                  //         fontWeight: FontWeight.w600,
                  //         color:  VmodelColors.primaryColor.withOpacity(0.5)
                  //       ),
                  //     )
                  //   ],
                  // ),
                ],
              ),
              addVerticalSpacing(10),
              Text(
                titles[index].comment!,
                textAlign: TextAlign.start,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                //style: VmodelTypography2.kCommentTextStyle,
                style: Theme.of(context)
                    .textTheme
                    .displaySmall!
                    .copyWith(fontWeight: FontWeight.w500),
              )
            ]),
          ),
          addVerticalSpacing(20),
          Divider(),
          addVerticalSpacing(20),
        ]
      ],
    );
  }
}
