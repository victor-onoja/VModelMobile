import 'package:flutter_html/flutter_html.dart';
import 'package:vmodel/src/res/icons.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/shared/rend_paint/render_svg.dart';
import 'package:vmodel/src/vmodel.dart';

import '../../../../../shared/picture_styles/rounded_square_avatar.dart';

class VWidgetsBusinessMyJobsCard extends StatelessWidget {
  final String jobPriceOption;
  final String? profileImage;
  final String? jobTitle;
  final String? jobDescription;
  final String? location;
  final String? date;
  final String? appliedCandidateCount;
  final String? jobBudget;
  final String? candidateType;
  final VoidCallback? shareJobOnPressed;
  final VoidCallback onItemTap;
  final bool enableDescription;
  final Color? statusColor;
  final int? noOfApplicants;

  const VWidgetsBusinessMyJobsCard(
      {required this.profileImage,
      required this.jobTitle,
      required this.jobDescription,
      required this.location,
      this.noOfApplicants = 0,
      required this.date,
      required this.appliedCandidateCount,
      required this.jobBudget,
      required this.candidateType,
      required this.shareJobOnPressed,
      required this.jobPriceOption,
      required this.onItemTap,
      this.statusColor,
      this.enableDescription = false,
      super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // navigateToRoute(context, const JobDetailPage());
        onItemTap();
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          // boxShadow: [
          //   BoxShadow(
          //     color: Colors.black.withOpacity(.2),
          //     blurRadius: 5.0, // soften the shadow
          //     spreadRadius: -3, //extend the shadow
          //     offset: const Offset(0.0, 0.0),
          //   ),
          // ],
        ),
        // child: Card(
        //   elevation: 0,
        //   shape:
        //       RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  RoundedSquareAvatar(
                    url: profileImage,
                    thumbnail: profileImage,
                  ),
                  // SizedBox(
                  //   width: 50,
                  //   height: 50,
                  //   child: Container(
                  //     decoration: const BoxDecoration(
                  //       color: VmodelColors.appBarBackgroundColor,
                  //       borderRadius: BorderRadius.all(
                  //         Radius.circular(8),
                  //       ),
                  //       // image: DecorationImage(
                  //       //   image: AssetImage(
                  //       //     profileImage!,
                  //       //   ),
                  //       //   fit: BoxFit.cover,
                  //       // )
                  //     ),
                  //     child: SvgPicture.asset(
                  //       "assets/images/svg_images/unsplash_m9pzwmxm2rk.svg",
                  //       fit: BoxFit.cover,
                  //     ),
                  //   ),
                  // ),
                  addHorizontalSpacing(10),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(jobTitle!, // e.msg.toString(),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context)
                                      .textTheme
                                      .displayMedium!
                                      .copyWith(
                                        fontWeight: FontWeight.w500,
                                      )),
                            ),
                            if (statusColor != null)
                              Container(
                                height: 7,
                                width: 7,
                                decoration: BoxDecoration(
                                  color: statusColor,
                                  borderRadius: BorderRadius.circular(14),
                                ),
                              ),
                            // addHorizontalSpacing(10),
                          ],
                        ),
                        addVerticalSpacing(10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ///location Icon
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                // RenderSvg(
                                //   svgPath: VIcons.locationIcon,
                                //   svgHeight: 20,
                                //   svgWidth: 20,
                                //   color: Theme.of(context).iconTheme.color,
                                // ),
                                // addHorizontalSpacing(6),
                                Text(
                                  '${VMString.bullet} ${date}',
                                  // location!,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context)
                                      .textTheme
                                      // .displaySmall //!
                                      .bodyMedium //!
                                      ?.copyWith(
                                          // color: Theme.of(context).primaryColor,
                                          // color: Colors.pink,
                                          ),
                                ),
                              ],
                            ),
                            addHorizontalSpacing(15),

                            ///time Icon
                            // Row(
                            //   crossAxisAlignment:
                            //       CrossAxisAlignment.start,
                            //   children: [
                            //     const RenderSvg(
                            //       svgPath: VIcons.clockIcon,
                            //       svgHeight: 16,
                            //       svgWidth: 16,
                            //       color: VmodelColors.primaryColor,
                            //     ),
                            //     addHorizontalSpacing(6),
                            //     Text(
                            //       time!,
                            //       maxLines: 1,
                            //       overflow: TextOverflow.ellipsis,
                            //       style: Theme.of(context)
                            //           .textTheme
                            //           .displaySmall!
                            //           .copyWith(
                            //             color: Theme.of(context)
                            //                 .primaryColor,
                            //           ),
                            //     ),
                            //   ],
                            // ),
                            Expanded(
                              child: addHorizontalSpacing(15),
                            ),
                            //budget icon
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // RenderSvg(
                                //   svgPath: VIcons.walletIcon,
                                //   svgHeight: 15,
                                //   svgWidth: 15,
                                //   color: Theme.of(context).iconTheme.color,
                                // ),
                                // addHorizontalSpacing(6),
                                Text(
                                  // "${VMString.poundSymbol} $jobBudget",
                                  "$jobBudget",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                          // fontWeight: FontWeight.w500,
                                          // color: Theme.of(context).primaryColor,
                                          // color: Colors.pink,
                                          ),
                                ),
                              ],
                            ),
                            addHorizontalSpacing(4),
                            // Row(
                            //   children: [
                            //     const NormalRenderSvg(
                            //       svgPath: VIcons.humanIcon,
                            //     ),
                            //     addHorizontalSpacing(5),
                            //     Text(
                            //       candidateType!,
                            //       maxLines: 1,
                            //       overflow: TextOverflow.ellipsis,
                            //       style: Theme.of(context)
                            //           .textTheme
                            //           .displaySmall!
                            //           .copyWith(
                            //             fontWeight: FontWeight.w500,
                            //             color: Theme.of(context).primaryColor,
                            //           ),
                            //     ),
                            //   ],
                            // ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              addVerticalSpacing(12),
              if (enableDescription)
                Flexible(
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 500),
                    height: enableDescription ? null : 0,
                    child: Html(
                      data: parseString(
                          context,
                          TextStyle(
                            overflow: TextOverflow.ellipsis,
                          ),
                          jobDescription!),
                      onlyRenderTheseTags: const {
                        'em',
                        'b',
                        'br',
                        'html',
                        'head',
                        'body'
                      },
                      style: {
                        "*": Style(
                          color: Theme.of(context).primaryColor,
                          maxLines: 3,
                          textOverflow: TextOverflow.ellipsis,
                        ),
                      },
                    ),
                  ),
                ),
              if (enableDescription) addVerticalSpacing(12),
              Row(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        '${VMString.bullet} $location', // e.msg.toString(),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              fontWeight: FontWeight.w500,
                              color: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.color
                                  ?.withOpacity(0.5),
                              // color: Colors.pink,
                            ),
                      ),
                    ],
                  ),
                  Expanded(child: SizedBox(width: 16)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        '${VMString.bullet} $jobPriceOption', // e.msg.toString(),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              fontWeight: FontWeight.w500,
                              color: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.color
                                  ?.withOpacity(0.5),
                              // color: Colors.pink,
                            ),
                      ),
                    ],
                  ),
                  if (noOfApplicants != null)
                    Expanded(child: SizedBox(width: 16)),
                  if (noOfApplicants != null)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        RenderSvg(
                          svgPath: VIcons.jobDetailApplicants,
                          svgHeight: 16,
                          svgWidth: 16,
                          color: Theme.of(context)
                              .iconTheme
                              .color
                              ?.withOpacity(0.5),
                        ),
                        addHorizontalSpacing(8),
                        Text(
                          noOfApplicants.toString(), // e.msg.toString(),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    fontWeight: FontWeight.w500,
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.color
                                        ?.withOpacity(0.5),
                                    // color: Colors.pink,
                                  ),
                        ),
                      ],
                    ),
                ],
              ),
            ],
          ),
        ),
        // ),
      ),
    );
  }

  String parseString(
      BuildContext context, TextStyle baseStyle, String rawString) {
    const String boldPattern = r'\*\*([^*]+)\*\*';
    final RegExp linkRegExp = RegExp(boldPattern, caseSensitive: false);
    final RegExp italicRegExp = RegExp(r'\*([^*]+)\*', caseSensitive: false);

    //Todo add formatting for tokens between **
    String newString = rawString.replaceAllMapped(linkRegExp, (match) {
      return '<b>${match.group(1)}</b>';
    }).replaceAll(RegExp(r"(\r\n|\r|\n)"), '<br>');

    newString = newString.replaceAllMapped(italicRegExp, (match) {
      return '<em>${match.group(1)}</em>';
    });

    final htmlDocBoilerplate = """
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8">
  </head>
  <body>
  $newString
  </body>
</html>
""";
    return htmlDocBoilerplate;
  }
}
