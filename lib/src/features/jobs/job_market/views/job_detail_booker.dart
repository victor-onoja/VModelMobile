import 'package:vmodel/src/features/jobs/job_market/views/job_booker_applications_homepage.dart';
import 'package:vmodel/src/res/gap.dart';
import 'package:vmodel/src/vmodel.dart';

import '../../../../res/colors.dart';
import '../../../../res/icons.dart';
import '../../../../shared/buttons/primary_button.dart';
import '../../../../shared/rend_paint/render_svg.dart';
import 'filter_bottom_sheet.dart';

class BookerJobDetailsPage extends StatefulWidget {
  // var description;

  const BookerJobDetailsPage({
    Key? key,
    // required this.description,
  }) : super(key: key);

  @override
  State<BookerJobDetailsPage> createState() => _BookerJobDetailsPageState();
}

class _BookerJobDetailsPageState extends State<BookerJobDetailsPage> {
  bool? liked = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: VmodelColors.white,
          centerTitle: true,
          title: Text(
            'Job Details',
            style: Theme.of(context).textTheme.displayMedium!.copyWith(
                fontWeight: FontWeight.w600,
                color: Theme.of(context).primaryColor),
          ),
          leading: IconButton(
            onPressed: () {
              goBack(context);
            },
            icon: const RotatedBox(
              quarterTurns: 2,
              child: RenderSvg(
                svgPath: VIcons.forwardIcon,
                svgWidth: 13,
                svgHeight: 13,
              ),
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const RenderSvg(
                svgPath: VIcons.jobDetailApplicants,
                svgHeight: 18,
                svgWidth: 18,
              ),
            )
          ],
        ),
        body: SingleChildScrollView(
          padding: const VWidgetsPagePadding.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(color: Colors.blue),
              Text(
                'Photographer wanted for minimal restaurant shoot',
                style: Theme.of(context)
                    .textTheme
                    .displayLarge!
                    .copyWith(fontWeight: FontWeight.w600),
              ),
              addVerticalSpacing(16),
              Row(
                children: [
                  Text(
                    '1 day ago',
                    style: Theme.of(context).textTheme.displaySmall!.copyWith(
                          fontWeight: FontWeight.w500,
                          fontSize: 13,
                          color: VmodelColors.primaryColor.withOpacity(0.5),
                        ),
                  ),
                  addHorizontalSpacing(32),
                  const RenderSvg(
                    svgPath: VIcons.jobDetailApplicants,
                    svgHeight: 20,
                    svgWidth: 20,
                  ),
                  addHorizontalSpacing(8),
                  GestureDetector(
                    onTap: () {
                      // navigateToRoute(
                      //     context, const JobBookerApplicationsHomepage());
                    },
                    child: Text(
                      '3 Offers',
                      style: Theme.of(context)
                          .textTheme
                          .displayMedium!
                          .copyWith(
                              fontWeight: FontWeight.w500,
                              color: VmodelColors.primaryColor),
                    ),
                  ),
                ],
              ),
              addVerticalSpacing(16),
              iconText(assetIcon: VIcons.jobDetailPricePer, text: '£200/hr'),
              addVerticalSpacing(8),
              iconText(assetIcon: VIcons.jobDetailUserCategory, text: 'Model'),
              addVerticalSpacing(8),
              iconText(assetIcon: VIcons.jobDetailGender, text: 'Male'),
              addVerticalSpacing(8),
              iconText(assetIcon: VIcons.jobDetailSize, text: 'XL'),
              addVerticalSpacing(8),
              iconText(
                  assetIcon: VIcons.jobDetailDate,
                  text: '15 Dec 2022 - 18 Dec 2022'),
              addVerticalSpacing(8),
              iconText(
                  assetIcon: VIcons.jobDetailUsageType, text: 'Commercial'),
              addVerticalSpacing(8),
              iconText(
                  assetIcon: VIcons.jobDetailMap,
                  text: '200 Leighman Close, Brentford BL32AA'),
              addVerticalSpacing(8),
              iconText(assetIcon: VIcons.jobDetailLevel, text: 'Entry Level'),
              addVerticalSpacing(8),
              iconText(assetIcon: VIcons.jobDetailEthnicity, text: 'Caucasian'),
              addVerticalSpacing(8),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkResponse(
                    onTap: () {},
                    radius: 20,
                    child: const RenderSvg(
                      svgPath: VIcons.unsavedPostsIcon,
                      svgHeight: 18,
                      svgWidth: 18,
                    ),
                  ),
                  addHorizontalSpacing(20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkResponse(
                        onTap: () {},
                        radius: 20,
                        child: const RenderSvg(
                          svgPath: VIcons.shareFilled,
                          svgHeight: 16,
                          svgWidth: 16,
                        ),
                      ),
                      // addHorizontalSpacing(8),
                    ],
                  ),
                ],
              ),
              const Divider(),
              addVerticalSpacing(16),
              Text(
                'Job Description'.toUpperCase(),
                style: Theme.of(context).textTheme.displayMedium!.copyWith(
                    fontWeight: FontWeight.w400,
                    color: VmodelColors.primaryColor),
              ),
              addVerticalSpacing(16),
              Text(
                'We are seeking talented and professional models to '
                'collaborate with our team of expert chefs.\n\n'
                "As a model ‘chef’ at Jimmy’s, you'll have the opportunity to "
                "showcase your culinary skills in a variety of settings, "
                "from photo shoots to live events.\n\n"
                "We're looking for models who can bring life and style to our "
                "delectable creations, creating captivating food "
                "experiences for our upcoming campaign.\n\n"
                "• Arrive to set on time. (9:00am)\n\n"
                "• Costumes will be provided\n\n"
                "• Apply only if you have worked in similar roles previously\n\n"
                "If you have a passion for food and a knack for striking "
                "poses, join us on VModel and be a part of our "
                "mouthwatering culinary adventures.",
                style: Theme.of(context).textTheme.displaySmall!.copyWith(
                    fontWeight: FontWeight.w500,
                    color: VmodelColors.primaryColor),
              ),
              addVerticalSpacing(16),
              const Divider(),
              addVerticalSpacing(4),
              Text(
                'About the booker'.toUpperCase(),
                style: Theme.of(context).textTheme.displayMedium!.copyWith(
                    fontWeight: FontWeight.w400,
                    color: VmodelColors.primaryColor),
              ),
              addVerticalSpacing(16),
              Row(
                //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                    radius: 28,
                    backgroundColor: Colors.white,
                    foregroundImage: Image.asset(
                      assets['models']!.first,
                    ).image,
                  ),
                  addHorizontalSpacing(10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Jimmy’s Kafé",
                        style: Theme.of(context)
                            .textTheme
                            .displayMedium!
                            .copyWith(
                                fontWeight: FontWeight.w600,
                                color: VmodelColors.primaryColor),
                      ),
                      addVerticalSpacing(4),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const RenderSvg(
                            svgPath: VIcons.star,
                            svgHeight: 20,
                            svgWidth: 20,
                            color: VmodelColors.primaryColor,
                          ),
                          Text(
                            '4.5',
                            style: Theme.of(context)
                                .textTheme
                                .displaySmall!
                                .copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: VmodelColors.primaryColor),
                          ),
                          addHorizontalSpacing(4),
                          Text(
                            '(25)',
                            style: Theme.of(context)
                                .textTheme
                                .displaySmall!
                                .copyWith(color: VmodelColors.primaryColor),
                          ),
                        ],
                      ),
                      addVerticalSpacing(4),
                      Text(
                        "London, UK",
                        style: Theme.of(context)
                            .textTheme
                            .displaySmall!
                            .copyWith(
                                fontWeight: FontWeight.w500,
                                color:
                                    VmodelColors.primaryColor.withOpacity(0.5)),
                      ),
                    ],
                  ),
                ],
              ),
              addVerticalSpacing(32),
              Text(
                "A dynamic and trendy cafe offering a fusion of "
                "flavours and a cozy atmosphere. We're passionate about "
                "curating unforgettable dining experiences and connecting with "
                "talented individuals in the culinary world. Join us at Jimmy's "
                "Cafe for a taste sensation that will leave you craving more.",
                style: Theme.of(context).textTheme.displaySmall!.copyWith(
                    fontWeight: FontWeight.w500,
                    color: VmodelColors.primaryColor),
              ),
              addVerticalSpacing(32),
              Row(
                children: [
                  Expanded(
                    child: VWidgetsPrimaryButton(
                      butttonWidth: MediaQuery.of(context).size.width * 0.3,
                      onPressed: () {
                        showModalBottomSheet(
                          isScrollControlled: true,
                          isDismissible: true,
                          useRootNavigator: true,
                          backgroundColor: Colors.transparent,
                          context: context,
                          builder: (context) => Container(
                            // height: 500,
                            decoration: BoxDecoration(
                              color: VmodelColors.background,
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(13),
                                topRight: Radius.circular(13),
                              ),
                            ),
                            color: VmodelColors.white,
                            child: const JobMarketFilterBottomSheet(),
                          ),
                        );
                      },
                      buttonTitle: 'Close Job',
                      enableButton: true,
                    ),
                  ),
                  addHorizontalSpacing(16),
                  Expanded(
                    child: VWidgetsPrimaryButton(
                      butttonWidth: MediaQuery.of(context).size.width * 0.3,
                      onPressed: () {
                        showModalBottomSheet(
                          isScrollControlled: true,
                          isDismissible: true,
                          useRootNavigator: true,
                          backgroundColor: Colors.transparent,
                          context: context,
                          builder: (context) => Container(
                            height: 500,
                            color: VmodelColors.white,
                            child: const JobMarketFilterBottomSheet(),
                          ),
                        );
                      },
                      buttonTitle: 'Edit Job',
                      enableButton: true,
                    ),
                  ),
                ],
              ),
              addVerticalSpacing(32),
            ],
          ),
        ));
  }

  Widget iconText({required String assetIcon, required String text}) {
    return Row(
      children: [
        RenderSvg(svgPath: assetIcon, svgHeight: 16, svgWidth: 16),
        addHorizontalSpacing(8),
        Text(
          text,
          style: Theme.of(context).textTheme.displaySmall!.copyWith(
                fontWeight: FontWeight.w500,
                height: 1.7,
                color: VmodelColors.primaryColor,
                // fontSize: 12,
              ),
        ),
      ],
    );
  }
}
