import 'package:flutter/material.dart';
import 'package:vmodel/src/res/icons.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/shared/picture_styles/network_profile_pic.dart';

class VWidgetsRecentlyViewedWidget extends StatelessWidget {
  final VoidCallback onTapTitle;
  final VoidCallback onTapProfile;
  final String? profileUrl;
  const VWidgetsRecentlyViewedWidget({
    super.key,
    required this.profileUrl,
    required this.onTapTitle,
    required this.onTapProfile,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // GestureDetector(
        //   onTap: onTapTitle,
        //   child: Padding(
        //     padding: const VWidgetsPagePadding.horizontalSymmetric(14.0),
        //     child: Row(
        //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //       children: [
        //         Text(
        //           "Recently Viewed",
        //           style: Theme.of(context).textTheme.displayMedium!.copyWith(
        //                 color: VmodelColors.primaryColor,
        //                 fontWeight: FontWeight.w600,
        //               ),
        //         ),
        //         const RenderSvg(
        //           svgPath: VIcons.forwardIcon,
        //           svgHeight: 14,
        //           svgWidth: 14,
        //         ),
        //       ],
        //     ),
        //   ),
        // ),
        addVerticalSpacing(12),
        SizedBox(
          height: 80,
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(left: 12),
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                //! Remove Dummy data on the time of Integration
                //! put "profileUrl" in dummy url and remove the extra columns
                GestureDetector(
                  onTap: onTapProfile,
                  child: Column(
                    children: [
                      deprecatedProfilePicture(
                          height: 60,
                          width: 60,
                          "https://images.pexels.com/photos/17131654/pexels-photo-17131654.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
                          VIcons.vModelProfile),
                      addVerticalSpacing(3),
                      Text(
                        "Samantha",
                        style:
                            Theme.of(context).textTheme.displaySmall!.copyWith(
                                  color: VmodelColors.primaryColor,
                                ),
                      ),
                    ],
                  ),
                ),
                addHorizontalSpacing(16),
                Column(
                  children: [
                    deprecatedProfilePicture(
                        height: 60,
                        width: 60,
                        "https://images.pexels.com/photos/2065200/pexels-photo-2065200.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
                        VIcons.vModelProfile),
                    addVerticalSpacing(3),
                    Text(
                      "Tom",
                      style: Theme.of(context).textTheme.displaySmall!.copyWith(
                            color: VmodelColors.primaryColor,
                          ),
                    ),
                  ],
                ),
                addHorizontalSpacing(16),
                Column(
                  children: [
                    deprecatedProfilePicture(
                        height: 60,
                        width: 60,
                        "https://images.pexels.com/photos/1164674/pexels-photo-1164674.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
                        VIcons.vModelProfile),
                    addVerticalSpacing(3),
                    Text(
                      "Michael",
                      style: Theme.of(context).textTheme.displaySmall!.copyWith(
                            color: VmodelColors.primaryColor,
                          ),
                    ),
                  ],
                ),
                addHorizontalSpacing(16),
                Column(
                  children: [
                    deprecatedProfilePicture(
                        height: 60,
                        width: 60,
                        "https://images.pexels.com/photos/219550/pexels-photo-219550.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
                        VIcons.vModelProfile),
                    addVerticalSpacing(3),
                    Text(
                      "Dwight",
                      style: Theme.of(context).textTheme.displaySmall!.copyWith(
                            color: VmodelColors.primaryColor,
                          ),
                    ),
                  ],
                ),
                addHorizontalSpacing(16),
                Column(
                  children: [
                    deprecatedProfilePicture(
                        height: 60,
                        width: 60,
                        "https://images.pexels.com/photos/12698490/pexels-photo-12698490.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
                        VIcons.vModelProfile),
                    addVerticalSpacing(3),
                    Text(
                      "Ernest",
                      style: Theme.of(context).textTheme.displaySmall!.copyWith(
                            color: VmodelColors.primaryColor,
                          ),
                    ),
                  ],
                ),
                addHorizontalSpacing(16),
                Column(
                  children: [
                    deprecatedProfilePicture(
                        height: 60,
                        width: 60,
                        "https://images.pexels.com/photos/4667774/pexels-photo-4667774.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
                        VIcons.vModelProfile),
                    addVerticalSpacing(3),
                    Text(
                      "Jeremy",
                      style: Theme.of(context).textTheme.displaySmall!.copyWith(
                            color: VmodelColors.primaryColor,
                          ),
                    ),
                  ],
                ),
                addHorizontalSpacing(16),
                Column(
                  children: [
                    deprecatedProfilePicture(
                        height: 60,
                        width: 60,
                        "https://images.pexels.com/photos/4667813/pexels-photo-4667813.jpeg?auto=compress&cs=tinysrgb&w=1200",
                        VIcons.vModelProfile),
                    addVerticalSpacing(3),
                    Text(
                      "Samantha",
                      style: Theme.of(context).textTheme.displaySmall!.copyWith(
                            color: VmodelColors.primaryColor,
                          ),
                    ),
                  ],
                ),
                addHorizontalSpacing(16),
                Column(
                  children: [
                    deprecatedProfilePicture(
                        height: 60,
                        width: 60,
                        "https://images.pexels.com/photos/6311615/pexels-photo-6311615.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
                        VIcons.vModelProfile),
                    addVerticalSpacing(3),
                    Text(
                      "Juliet",
                      style: Theme.of(context).textTheme.displaySmall!.copyWith(
                            color: VmodelColors.primaryColor,
                          ),
                    ),
                  ],
                ),
                addHorizontalSpacing(20),
              ],
            ),
          ),
        )
      ],
    );
  }
}
