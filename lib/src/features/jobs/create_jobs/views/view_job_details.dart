import 'package:vmodel/src/res/gap.dart';
import 'package:vmodel/src/vmodel.dart';

import '../../../../res/colors.dart';
import '../../../../res/icons.dart';
import '../../../../shared/buttons/icon_button.dart';
import '../../../../shared/buttons/primary_button.dart';
import '../../../../shared/rend_paint/render_svg.dart';
import '../../job_market/views/business_user/market_place.dart';

class ViewJobDescription extends StatefulWidget {
  var description;
  final String? profileImage;
  final String? profileName;
  final String? jobDescription;
  final String? location;
  final String? time;
  final String? appliedCandidateCount;
  final String? jobBudget;
  final String? candidateType;
  final VoidCallback? shareJobOnPressed;

  ViewJobDescription(
      {Key? key,
      required this.description,
      required this.profileImage,
      required this.profileName,
      required this.jobDescription,
      required this.location,
      required this.time,
      required this.appliedCandidateCount,
      required this.jobBudget,
      required this.candidateType,
      required this.shareJobOnPressed})
      : super(key: key);

  @override
  State<ViewJobDescription> createState() => _ViewJobDescriptionState();
}

class _ViewJobDescriptionState extends State<ViewJobDescription> {
  bool? liked = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: VmodelColors.white,
          centerTitle: true,
          title: Text(
            'Job DetailsA',
            style: Theme.of(context).textTheme.displayMedium!.copyWith(
                fontWeight: FontWeight.w600,
                color: Theme.of(context).primaryColor),
          ),
          leading: IconButton(
            onPressed: () {
              navigateToRoute(context, const BusinessMyJobsPageMarketplace());
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
            liked == false
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        liked = !liked!;
                      });
                    },
                    icon: const RenderSvg(
                      svgPath: VIcons.unlikedIcon,
                      svgWidth: 13,
                      svgHeight: 13,
                    ),
                  )
                : IconButton(
                    onPressed: () {
                      setState(() {
                        liked = !liked!;
                      });
                    },
                    icon: const RenderSvg(
                      svgPath: VIcons.likedIcon,
                      svgWidth: 13,
                      svgHeight: 13,
                    ),
                  )
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                alignment: Alignment.bottomCenter,
                children: <Widget>[
                  Container(
                    height: 200, // set the height of the container
                    width: double.infinity,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(widget
                            .profileImage!), // replace with your image path
                        fit: BoxFit
                            .cover, // adjust the image size to cover the container
                      ),
                    ),
                  ),
                  FractionalTranslation(
                    translation: const Offset(0.0, 0.5),
                    child: Container(
                      height: MediaQuery.of(context).size.width / 6.0,
                      width: MediaQuery.of(context).size.width /
                          6.0, // set the width of the container to the maximum available space
                      // add a semi-transparent black color to create a visual overlay
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.white,
                        ),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(12)),
                        color: Colors.transparent,
                        image: DecorationImage(
                          image: AssetImage(
                              '${widget.profileImage}'), // replace with your image path
                          fit: BoxFit
                              .cover, // adjust the image size to cover the container
                        ),
                      ),
                    ),
                  )
                ],
              ),
              addVerticalSpacing(50),
              Text('${widget.profileName}',
                  style: Theme.of(context).textTheme.displayLarge!.copyWith(
                        color: VmodelColors.primaryColor,
                        fontWeight: FontWeight.w800,
                      )),
              Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 1,
                            child: Padding(
                              padding: const EdgeInsets.all(3),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(6, 0, 6, 0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Flexible(
                                            child: Text(
                                          '1 day ago',
                                          style: Theme.of(context)
                                              .textTheme
                                              .displaySmall!
                                              .copyWith(
                                                  fontWeight: FontWeight.w500,
                                                  color: Theme.of(context)
                                                      .unselectedWidgetColor),
                                        )),
                                      ],
                                    ),
                                  ),
                                  addVerticalSpacing(10),
                                  Row(
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Container(
                                          height:
                                              40, // set the height of the container
                                          width:
                                              120, // set the width of the container
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                                25), // set the border radius to create a rounded container
                                            color: Colors.grey[
                                                300], // set the background color of the container
                                          ),
                                          child: Center(
                                            child: Text(
                                                'Photographer', // add your text here
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .displayMedium!
                                                    .copyWith(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: Theme.of(context)
                                                            .unselectedWidgetColor)),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Padding(
                              padding: const EdgeInsets.all(3),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(9, 0, 3, 0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        const Flexible(
                                          child: Icon(
                                            Icons
                                                .people_alt, // set the icon to display
                                            color: VmodelColors
                                                .primaryColor, // set the color of the icon
                                            size:
                                                17, // set the size of the icon
                                          ),
                                        ),
                                        Text(
                                            '${widget.appliedCandidateCount} applicants',
                                            style: Theme.of(context)
                                                .textTheme
                                                .displaySmall!
                                                .copyWith(
                                                    fontWeight: FontWeight.w600,
                                                    color: Theme.of(context)
                                                        .unselectedWidgetColor))
                                      ],
                                    ),
                                  ),
                                  addVerticalSpacing(10),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Container(
                                          height:
                                              40, // set the height of the container
                                          width:
                                              120, // set the width of the container
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                                25), // set the border radius to create a rounded container
                                            color: Colors.grey[300], // se
                                          ),
                                          child: Center(
                                            child: Text(
                                                'Commercial', // add your text here
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .displayMedium!
                                                    .copyWith(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: Theme.of(context)
                                                            .unselectedWidgetColor)),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      addVerticalSpacing(12),
                      Container(
                        padding: const EdgeInsets.all(
                            16), // add some padding to the container
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Flexible(
                                          child: Text('Location',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .displayMedium!
                                                  .copyWith(
                                                      fontWeight:
                                                          FontWeight.w800,
                                                      color: Theme.of(context)
                                                          .unselectedWidgetColor))),
                                    ],
                                  ),
                                  addVerticalSpacing(10),
                                  Row(
                                    children: [
                                      Flexible(
                                          child: Text('Gender',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .displayMedium!
                                                  .copyWith(
                                                      fontWeight:
                                                          FontWeight.w800,
                                                      color: Theme.of(context)
                                                          .unselectedWidgetColor))),
                                    ],
                                  ),
                                  addVerticalSpacing(10),
                                  Row(
                                    children: [
                                      Flexible(
                                          child: Text('Duration',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .displayMedium!
                                                  .copyWith(
                                                      fontWeight:
                                                          FontWeight.w800,
                                                      color: Theme.of(context)
                                                          .unselectedWidgetColor))),
                                    ],
                                  ),
                                  addVerticalSpacing(10),
                                  Row(
                                    children: [
                                      Flexible(
                                          child: Text('Budget',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .displayMedium!
                                                  .copyWith(
                                                      fontWeight:
                                                          FontWeight.w800,
                                                      color: Theme.of(context)
                                                          .unselectedWidgetColor))),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Flexible(
                                          child: Text(
                                        '${widget.location}',
                                        maxLines: 500,
                                        overflow: TextOverflow.ellipsis,
                                        style: Theme.of(context)
                                            .textTheme
                                            .displayMedium!
                                            .copyWith(
                                              fontWeight: FontWeight.w500,
                                              color: VmodelColors.primaryColor,
                                            ),
                                      )),
                                    ],
                                  ),
                                  addVerticalSpacing(10),
                                  Row(
                                    children: [
                                      Flexible(
                                          child: Text(
                                        '${widget.candidateType}',
                                        maxLines: 500,
                                        overflow: TextOverflow.ellipsis,
                                        style: Theme.of(context)
                                            .textTheme
                                            .displayMedium!
                                            .copyWith(
                                              fontWeight: FontWeight.w500,
                                              color: VmodelColors.primaryColor,
                                            ),
                                      )),
                                    ],
                                  ),
                                  addVerticalSpacing(10),
                                  Row(
                                    children: [
                                      Flexible(
                                          child: Text(
                                        '${widget.time}',
                                        maxLines: 500,
                                        overflow: TextOverflow.ellipsis,
                                        style: Theme.of(context)
                                            .textTheme
                                            .displayMedium!
                                            .copyWith(
                                              fontWeight: FontWeight.w500,
                                              color: VmodelColors.primaryColor,
                                            ),
                                      )),
                                    ],
                                  ),
                                  addVerticalSpacing(10),
                                  Row(
                                    children: [
                                      Flexible(
                                          child: Text(
                                        '${widget.jobBudget}',
                                        maxLines: 500,
                                        overflow: TextOverflow.ellipsis,
                                        style: Theme.of(context)
                                            .textTheme
                                            .displayMedium!
                                            .copyWith(
                                              fontWeight: FontWeight.w500,
                                              color: VmodelColors.primaryColor,
                                            ),
                                      )),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Divider(
                        color: VmodelColors.divideColor,
                      ),
                      addVerticalSpacing(20),
                      Text('Job Description',
                          style: Theme.of(context)
                              .textTheme
                              .displayLarge!
                              .copyWith(
                                color: VmodelColors.vModelprimarySwatch,
                                fontWeight: FontWeight.w800,
                              )),
                      addVerticalSpacing(20),
                      Text(
                        '${widget.description} Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet, consectetur adipiscing elit.Lorem ipsum dolor sit amet, consectetur adipiscing elit.Lorem ipsum dolor sit amet, consectetur adipiscing elit.Lorem ipsum dolor sit amet, consectetur adipiscing elit.Lorem ipsum dolor sit amet, consectetur adipiscing elit.Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
                        maxLines: 500,
                        overflow: TextOverflow.ellipsis,
                        style:
                            Theme.of(context).textTheme.displayMedium!.copyWith(
                                  fontWeight: FontWeight.w500,
                                  color: VmodelColors.primaryColor,
                                ),
                      ),
                      addVerticalSpacing(25),
                      Row(
                        children: [
                          Expanded(
                            child: VWidgetsIconButton(
                              onPressed: () {},
                              enableButton: true,
                              buttonTitle: 'Ask a question',
                              buttonTitleTextStyle: Theme.of(context)
                                  .textTheme
                                  .displayMedium!
                                  .copyWith(
                                    color: VmodelColors.vModelprimarySwatch,
                                    fontWeight: FontWeight.w800,
                                  ),
                            ),
                          ),
                          addHorizontalSpacing(10),
                          Expanded(
                              child: VWidgetsPrimaryButton(
                                  onPressed: () {},
                                  enableButton: true,
                                  buttonTitle: 'Apply now',
                                  buttonTitleTextStyle: Theme.of(context)
                                      .textTheme
                                      .displayMedium!
                                      .copyWith(
                                        color: VmodelColors.white,
                                        fontWeight: FontWeight.w800,
                                      )))
                        ],
                      ),
                      addVerticalSpacing(25),
                    ]),
              ),
            ],
          ),
        ));
  }
}
