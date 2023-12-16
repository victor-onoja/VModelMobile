import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vmodel/src/shared/empty_page/empty_page.dart';

import '../../../../../core/controller/app_user_controller.dart';
import '../../../../../res/icons.dart';
import '../../../../../res/res.dart';
import '../../../../../shared/modal_pill_widget.dart';
import '../../../../../shared/rend_paint/render_svg.dart';
import '../../../../../vmodel.dart';
import '../../../../dashboard/new_profile/profile_features/widgets/profile_picture_widget.dart';
import '../controller/business_open_times_controller.dart';

import 'closed_or_open_now_text.dart';

class OpeningHoursBottomSheet extends ConsumerWidget {
  OpeningHoursBottomSheet({
    super.key,
    required this.username,
    required this.displayName,
    required this.label,
    this.profilePictureThumbnail,
    // required this.username,
  });

  final String username;
  final String displayName;
  final String label;
  final String? profilePictureThumbnail;
  final openText = 'open';

  // final List<String> titles = [
  //   'Sundays',
  //   'Mondays',
  //   'Tuesdays',
  //   'Wednesdays',
  //   'Thursdays',
  //   // 'Fridays',
  //   'Today',
  //   'Saturdays',
  // ];
  // final List<String> times = [
  //   'Always Open',
  //   '17:15 - 23:00',
  //   '17:15 - 23:00',
  //   '17:15 - 23:00',
  //   '17:15 - 23:00',
  //   'Open',
  //   '17:15 - 23:00',
  // ];
  // final List<String> extras = [
  //   'Live Band',
  //   "Children's Playground",
  //   "Parking",
  //   "Free WiFi",
  // ];
  // final List<String> safety = [
  //   'Employees wear masks',
  //   "Appointment only, no walk-ins",
  //   "Disinfected surfaces and venue",
  // ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final String couponCode = 'Welcometonikediscount'.toUpperCase();

    // final requrestUsername = ref.watch(userNameForApiRequestProvider(username));
    // final appUser = requrestUsername == null
    //     ? ref.watch(appUserProvider)
    //     : ref.watch(profileProvider(requrestUsername));
    // final user = appUser.valueOrNull;
    // final userSocials = user?.socials;
    final fadedTextColor =
        Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.5);

    final requestUsername =
        ref.watch(userNameForApiRequestProvider('$username'));
    final openTimes = ref.watch(businessOpenTimesProvider(requestUsername));

    return Container(
        constraints: BoxConstraints(
          maxHeight: SizerUtil.height * 0.9,
          minHeight: SizerUtil.height * 0.2,
          minWidth: SizerUtil.width,
        ),
        decoration: BoxDecoration(
          // color: VmodelColors.white,
          color: Theme.of(context).colorScheme.surface,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
        ),
        child: openTimes.when(data: (data) {
          if (data == null || data.openingTimes.isEmpty) {
            return const EmptyPage(
              svgSize: 30,
              svgPath: VIcons.gridIcon,
              subtitle: 'Opening times unavailable',
            );
          }
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              addVerticalSpacing(15),
              const Align(
                  alignment: Alignment.center, child: VWidgetsModalPill()),
              addVerticalSpacing(8),
              Expanded(
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // addVerticalSpacing(15),
                      // const Align(
                      //     alignment: Alignment.center, child: VWidgetsModalPill()),
                      addVerticalSpacing(16),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              flex: 2,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  ProfilePicture(
                                    url: '',
                                    displayName: displayName,
                                    headshotThumbnail: profilePictureThumbnail,
                                  ),
                                  addHorizontalSpacing(8),
                                  Flexible(
                                    flex: 2,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          displayName,
                                          style: Theme.of(context)
                                              .textTheme
                                              .displayMedium!
                                              .copyWith(
                                                fontWeight: FontWeight.w600,
                                                // color: VmodelColors.primaryColor,
                                                // fontSize: 12,
                                              ),
                                        ),
                                        RichText(
                                            text: TextSpan(text: '', children: [
                                          TextSpan(
                                            text: '${VMString.bullet} ',
                                            style: Theme.of(context)
                                                .textTheme
                                                .displayMedium!
                                                .copyWith(
                                                  // fontWeight: FontWeight.w600,
                                                  color: fadedTextColor,
                                                  // fontSize: 12,
                                                ),
                                          ),
                                          TextSpan(
                                            text: label,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium!
                                                .copyWith(
                                                  // fontWeight: FontWeight.w600,
                                                  color: fadedTextColor,
                                                  fontSize: 12,
                                                ),
                                          ),
                                        ])),
                                        OpenNowOrClosedText(
                                            isOpen: data.isOpen),
                                        // RichText(
                                        //     text: TextSpan(text: '', children: [
                                        //   TextSpan(
                                        //     text: '${VMString.bullet} ',
                                        //     style: Theme.of(context)
                                        //         .textTheme
                                        //         .displayMedium!
                                        //         .copyWith(
                                        //           // fontWeight: FontWeight.w600,
                                        //           color: data.isOpen
                                        //               ? Colors.green
                                        //               : fadedTextColor,
                                        //           // fontSize: 12,
                                        //         ),
                                        //   ),
                                        //   TextSpan(
                                        //     text: data.isOpen
                                        //         ? "Open now"
                                        //         : "Closed",
                                        //     style: Theme.of(context)
                                        //         .textTheme
                                        //         .bodyMedium!
                                        //         .copyWith(
                                        //           // fontWeight: FontWeight.w600,
                                        //           color: fadedTextColor,
                                        //           fontSize: 12,
                                        //         ),
                                        //   ),
                                        // ])),
                                        // Text("${VMString.bullet} Restaurant"),
                                        // Text("${VMString.bullet} Open now"),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // Flexible(child: addHorizontalSpacing(8)),
                            addHorizontalSpacing(8),
                            Flexible(
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.end,
                                // crossAxisAlignment: CrossAxisAlignment.end,
                                textBaseline: TextBaseline.alphabetic,
                                children: [
                                  // RenderSvg(),
                                  // Icon(Icons.star),
                                  RenderSvg(
                                    svgPath: VIcons.star,
                                    svgHeight: 14,
                                    svgWidth: 14,
                                  ),
                                  Text(
                                    '4.9',
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayMedium!
                                        .copyWith(
                                          fontWeight: FontWeight.w600,
                                          // color: VmodelColors.primaryColor,
                                          fontSize: 32,
                                        ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      addVerticalSpacing(16),
                      Flexible(
                        child: Container(
                          width: double.maxFinite,
                          margin: const EdgeInsets.symmetric(horizontal: 24),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            color: VmodelColors.jobDetailGrey.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: RawScrollbar(
                            mainAxisMargin: 4,
                            crossAxisMargin: -8,
                            thumbVisibility: true,
                            thumbColor: Theme.of(context)
                                .colorScheme
                                .primary
                                .withOpacity(0.3),
                            thickness: 4,
                            radius: const Radius.circular(10),
                            child: ListView(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              children: List.generate(data.openingTimes.length,
                                  (index) {
                                final item = data.openingTimes[index];
                                return _itemTile(
                                  context,
                                  title: item.day,
                                  value: item.allDay
                                      ? 'Always open'
                                      : '${item.open} - ${item.close}',
                                );
                                // return const SizedBox.shrink();
                              }).toList(),
                            ),
                          ),
                        ),
                      ),
                      addVerticalSpacing(16),
                      if (data.extrasInfo.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "Extras",
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                          fontWeight: FontWeight.w600,
                                          // color: VmodelColors.primaryColor,
                                        ),
                                  ),
                                ],
                              ),
                              addVerticalSpacing(4),
                              ...List.generate(
                                data.extrasInfo.length,
                                (index) {
                                  final item = data.extrasInfo[index];
                                  return iconTextTile(
                                    context,
                                    icon: RenderSvg(
                                      svgPath: VIcons.businessExtras,
                                      svgHeight: 10,
                                      svgWidth: 10,
                                    ),
                                    title: item.title,
                                  );
                                },
                              ).toList(),
                            ],
                          ),
                        ),
                      addVerticalSpacing(16),
                      if (data.safetyInfo.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Health and safety rules".toUpperCase(),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                      fontWeight: FontWeight.w600,
                                      // color: VmodelColors.primaryColor,
                                    ),
                              ),
                              addVerticalSpacing(4),
                              ...List.generate(
                                data.safetyInfo.length,
                                (index) {
                                  final item = data.safetyInfo[index];
                                  return iconTextTile(
                                    context,
                                    title: item.title,
                                    icon: RenderSvgWithoutColor(
                                      svgPath: VIcons.businessSafety,
                                      svgHeight: 14,
                                      svgWidth: 14,
                                    ),
                                  );
                                },
                              ).toList(),
                            ],
                          ),
                        ),
                      // VWidgetsTextButton(
                      //   text: 'Close',
                      //   onPressed: () => goBack(context),
                      // ),
                      addVerticalSpacing(24),
                    ],
                  ),
                ),
              )
              // addVerticalSpacing(24),
            ],
          );
        }, error: ((error, stackTrace) {
          return const EmptyPage(
            svgSize: 30,
            svgPath: VIcons.gridIcon,
            subtitle: 'An error occurred',
          );
        }), loading: () {
          return Center(child: CircularProgressIndicator.adaptive());
        }));
  }

  Row iconTextTile(
    BuildContext context, {
    required String title,
    required Widget icon,
    // required double iconSize,
  }) {
    return Row(
      children: [
        icon,
        addHorizontalSpacing(6),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Text(
            title,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontWeight: FontWeight.w400,
                  // color: VmodelColors.primaryColor,
                  fontSize: 12,
                ),
          ),
        )
      ],
    );
  }

  MapEntry<bool, String> _getIsSocialAvailable(int index) {
    return MapEntry(true, "Hello");
    // switch (index) {
    //   case 0:
    //     return MapEntry(_isUsernameAvailable(userSocials.instagram),
    //         userSocials.instagram?.username ?? '');
    //   case 1:
    //     return MapEntry(_isUsernameAvailable(userSocials.tiktok),
    //         userSocials.tiktok?.username ?? '');
    //   case 2:
    //     return MapEntry(_isUsernameAvailable(userSocials.youtube),
    //         userSocials.youtube?.username ?? '');
    //   case 3:
    //     return MapEntry(_isUsernameAvailable(userSocials.twitter),
    //         userSocials.twitter?.username ?? '');
    //   case 4:
    //     return MapEntry(_isUsernameAvailable(userSocials.facebook),
    //         userSocials.facebook?.username ?? '');
    //   case 5:
    //     return MapEntry(_isUsernameAvailable(userSocials.pinterest),
    //         userSocials.pinterest?.username ?? '');
    //   default:
    //     return const MapEntry(false, '');
    // }
  }

  Widget _itemTile(BuildContext context,
      {required String title, required String value}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: double.maxFinite,
          child: TextButton(
            style: TextButton.styleFrom(
              // backgroundColor: VmodelColors.white,
              backgroundColor:
                  Theme.of(context).colorScheme.surface.withOpacity(0.5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () {},
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                    addHorizontalSpacing(4),
                    Text(
                      value,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontWeight: FontWeight.w400,
                            color: value.toLowerCase() == openText
                                ? Colors.green
                                : null,
                          ),
                    ),
                    // addHorizontalSpacing(8),
                    // const RenderSvgWithoutColor(
                    //   svgPath: VIcons.copyCouponIcon,
                    //   svgHeight: 14,
                    //   svgWidth: 14,
                    // ),
                  ],
                ),
              ],
            ),
          ),
        ),
        addVerticalSpacing(8),
      ],
    );
  }
}


//OldBody

            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 16),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       Flexible(
            //         flex: 2,
            //         child: Row(
            //           mainAxisSize: MainAxisSize.min,
            //           mainAxisAlignment: MainAxisAlignment.start,
            //           children: [
            //             ProfilePicture(
            //               url: VMString.testImageUrl,
            //               headshotThumbnail: null,
            //             ),
            //             addHorizontalSpacing(8),
            //             Flexible(
            //               flex: 2,
            //               child: Column(
            //                 mainAxisSize: MainAxisSize.min,
            //                 crossAxisAlignment: CrossAxisAlignment.start,
            //                 children: [
            //                   Text(
            //                     '${appUser?.displayName}',
            //                     style: Theme.of(context)
            //                         .textTheme
            //                         .displayMedium!
            //                         .copyWith(
            //                           fontWeight: FontWeight.w600,
            //                           // color: VmodelColors.primaryColor,
            //                           // fontSize: 12,
            //                         ),
            //                   ),
            //                   Text("${VMString.bullet} Restuarant"),
            //                   Text("${VMString.bullet} Open now"),
            //                 ],
            //               ),
            //             ),
            //           ],
            //         ),
            //       ),
            //       // Flexible(child: addHorizontalSpacing(8)),
            //       addHorizontalSpacing(8),
            //       Flexible(
            //         child: Row(
            //           mainAxisSize: MainAxisSize.min,
            //           mainAxisAlignment: MainAxisAlignment.end,
            //           children: [
            //             // RenderSvg(),
            //             Icon(Icons.star),

            //             Text(
            //               '4.9',
            //               style: Theme.of(context)
            //                   .textTheme
            //                   .displayMedium!
            //                   .copyWith(
            //                     fontWeight: FontWeight.w600,
            //                     // color: VmodelColors.primaryColor,
            //                     fontSize: 32,
            //                   ),
            //             ),
            //           ],
            //         ),
            //       )
            //     ],
            //   ),
            // ),
            // addVerticalSpacing(16),
            // Flexible(
            //   child: Container(
            //     width: double.maxFinite,
            //     margin: const EdgeInsets.symmetric(horizontal: 24),
            //     padding:
            //         const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            //     decoration: BoxDecoration(
            //       color: VmodelColors.jobDetailGrey.withOpacity(0.3),
            //       borderRadius: BorderRadius.circular(16),
            //     ),
            //     child: RawScrollbar(
            //       mainAxisMargin: 4,
            //       crossAxisMargin: -8,
            //       thumbVisibility: true,
            //       thumbColor: VmodelColors.primaryColor.withOpacity(0.3),
            //       thickness: 4,
            //       radius: const Radius.circular(10),
            //       child: ListView(
            //         shrinkWrap: true,
            //         physics: NeverScrollableScrollPhysics(),
            //         children: List.generate(titles.length, (index) {
            //           final item = _getIsSocialAvailable(index);
            //           if (item.key) {
            //             return _itemTile(
            //               context,
            //               title: titles[index],
            //               value: times[index],
            //             );
            //           }
            //           return const SizedBox.shrink();
            //         }).toList(),
            //       ),
            //     ),
            //   ),
            // ),
            // addVerticalSpacing(16),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 16),
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       Text(
            //         "Extras",
            //         overflow: TextOverflow.ellipsis,
            //         maxLines: 1,
            //         style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            //               fontWeight: FontWeight.w600,
            //               // color: VmodelColors.primaryColor,
            //             ),
            //       ),
            //       addVerticalSpacing(2),
            //       ...List.generate(
            //         extras.length,
            //         (index) => Row(
            //           children: [
            //             Icon(Icons.masks),
            //             Text(
            //               extras[index],
            //               overflow: TextOverflow.ellipsis,
            //               maxLines: 1,
            //               style:
            //                   Theme.of(context).textTheme.bodyMedium!.copyWith(
            //                         fontWeight: FontWeight.w400,
            //                         // color: VmodelColors.primaryColor,
            //                         fontSize: 12,
            //                       ),
            //             )
            //           ],
            //         ),
            //       ).toList(),
            //     ],
            //   ),
            // ),
            // addVerticalSpacing(16),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 16),
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       Text(
            //         "Health and safety rules".toUpperCase(),
            //         overflow: TextOverflow.ellipsis,
            //         maxLines: 1,
            //         style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            //               fontWeight: FontWeight.w600,
            //               // color: VmodelColors.primaryColor,
            //             ),
            //       ),
            //       addVerticalSpacing(2),
            //       ...List.generate(
            //         safety.length,
            //         (index) => Row(
            //           children: [
            //             Icon(Icons.shield),
            //             Text(
            //               safety[index],
            //               overflow: TextOverflow.ellipsis,
            //               maxLines: 1,
            //               style:
            //                   Theme.of(context).textTheme.bodyMedium!.copyWith(
            //                         fontWeight: FontWeight.w400,
            //                         // color: VmodelColors.primaryColor,
            //                         fontSize: 12,
            //                       ),
            //             )
            //           ],
            //         ),
            //       ).toList(),
            //     ],
            //   ),
            // ),
            // VWidgetsTextButton(
            //   text: 'Close',
            //   onPressed: () => goBack(context),
            // ),
            // addVerticalSpacing(24),