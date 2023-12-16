import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/vmodel.dart';

import '../../../../core/utils/enum/discover_category_enum.dart';
import '../../../jobs/job_market/controller/all_jobs_controller.dart';
import '../../../jobs/job_market/controller/category_services_controller.dart';
import '../../../jobs/job_market/views/all_jobs.dart';
import '../../../jobs/job_market/views/category_services.dart';
import '../models/discover_item.dart';
import 'category_list_item.dart';

class CategorySection extends ConsumerStatefulWidget {
  const CategorySection({
    Key? key,
    required this.title,
    required this.items,
    required this.onTap,
    required this.onCategoryChanged,
    this.eachUserHasProfile = false,
    this.route,
  }) : super(key: key);

  final String title;
  final List<DiscoverItemObject> items;
  final bool? eachUserHasProfile;
  final Widget? route;
  final ValueChanged onTap;
  final ValueChanged onCategoryChanged;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CategorySectionState();
}

class _CategorySectionState extends ConsumerState<CategorySection> {
  DiscoverCategory? _discoverCategoryType = DiscoverCategory.values.first;

  bool _viewAll = false;

  @override
  Widget build(BuildContext context) {
    print('[mm]mm AAAQQQQZZZ ${widget.items.length}');
    TextTheme textTheme = Theme.of(context).textTheme;
    return Column(
      children: [
        addVerticalSpacing(10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 13),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            // mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // Text(
              //   title,
              //   style: textTheme.displayMedium!.copyWith(
              //     fontWeight: FontWeight.w600,
              //     color: VmodelColors.mainColor,
              //   ),
              // ),
              Flexible(
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<DiscoverCategory>(
                    padding: EdgeInsets.zero,
                    isExpanded: false,
                    menuMaxHeight: 200,
                    // isExpanded: true,
                    iconSize: 32,
                    iconDisabledColor: VmodelColors.greyColor,
                    // iconEnabledColor: VmodelColors.primaryColor,
                    iconEnabledColor: Theme.of(context).colorScheme.primary,
                    icon: Icon(
                      Icons.arrow_drop_down_rounded,
                      // color: Colors.pink,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                    borderRadius: BorderRadius.circular(12),
                    value: _discoverCategoryType,
                    isDense: true,
                    onTap: () {},
                    onChanged: (value) {
                      widget.onCategoryChanged(value);
                      _discoverCategoryType = value;
                      setState(() {});
                    },
                    items:
                        DiscoverCategory.values.map((DiscoverCategory value) {
                      return DropdownMenuItem<DiscoverCategory>(
                        value: value,
                        alignment: AlignmentDirectional.centerStart,
                        child: Text(
                          value.simpleName,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context)
                              .textTheme
                              .displayMedium!
                              .copyWith(
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                                // color: Theme.of(context)
                                //     .primaryColor
                                //     .withOpacity(1),
                              ),
                        ),
                        // Divider(),
                      );
                    }).toList(),
                  ),
                ),
              ),
              // Spacer(),
              // Expanded(child: addHorizontalSpacing(16)),
              Flexible(
                child: GestureDetector(
                  onTap: () {
                    // widget.route != null
                    //     ? navigateToRoute(context, widget.route)
                    //     : () {};

                    _viewAll = !_viewAll;

                    setState(() {});
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(
                      _viewAll
                          ? "View less".toUpperCase()
                          : "View all".toUpperCase(),
                      textAlign: TextAlign.right,
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          // fontWeight: FontWeight.w600,
                          // color: VmodelColors.mainColor.withOpacity(0.5),
                          // color: VmodelColors.mainColor.withOpacity(0.5),
                          ),
                    ),
                  ),
                ),
              ),
              // const RenderSvg(
              //   svgPath: VIcons.forwardIcon,
              //   svgWidth: 12.5,
              //   svgHeight: 12.5,
              // ),
            ],
          ),
        ),
        addVerticalSpacing(8),
        if (!_viewAll)
          SizedBox(
            height: SizerUtil.height * 0.18,
            child: GridView.builder(
                padding: EdgeInsets.symmetric(horizontal: 1),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 0,
                  childAspectRatio: .1,
                ),
                physics: NeverScrollableScrollPhysics(),
                itemCount: 3,
                itemBuilder: (context, index) {
                  return CategoryListItem(
                    onTap: () {
                      // VWidgetShowResponse.showToast(ResponseEnum.sucesss,
                      //     message: 'Tapped on ${widget.items[index].name}');
                      navigateCategoryServices(widget.items[index].name);
                    },
                    onLongPress: () {
                      // showDialog(
                      //     context: context,
                      //     builder: (context) {
                      //       return TapAndHold(item: items[index]);
                      //     });
                    },
                    isViewAll: true,
                    item: widget.items[index],
                    itemName: widget.items[index].name,
                  );
                }),
          ),
        if (_viewAll)
          Container(
            height: SizerUtil.height * .6,
            margin: EdgeInsets.only(bottom: 20),
            child: GridView.builder(
                padding: EdgeInsets.symmetric(horizontal: 1),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 0,
                  childAspectRatio: 0.8,
                ),
                physics: NeverScrollableScrollPhysics(),
                itemCount: widget.items.length,
                itemBuilder: (context, index) {
                  return CategoryListItem(
                    onTap: () {
                      // VWidgetShowResponse.showToast(ResponseEnum.sucesss,
                      //     message: 'Tapped on ${widget.items[index].name}');
                      navigateCategoryServices(widget.items[index].name);
                    },
                    onLongPress: () {
                      // showDialog(
                      //     context: context,
                      //     builder: (context) {
                      //       return TapAndHold(item: items[index]);
                      //     });
                    },
                    isViewAll: true,
                    item: widget.items[index],
                    itemName: widget.items[index].name,
                  );
                }),
          ),
      ],
    );
  }

  void navigateCategoryServices(String category) {
    switch (_discoverCategoryType) {
      case DiscoverCategory.job:
        ref.read(selectedJobsCategoryProvider.notifier).state = category;
        navigateToRoute(context, AllJobs(title: category));
        break;
      default:
        ref.read(selectedCategoryServiceProvider.notifier).state = category;
        navigateToRoute(context, CategoryServices(title: category));
        break;
    }
  }
}

// class CategorySection extends StatelessWidget {

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     TextTheme textTheme = Theme.of(context).textTheme;
//     return Column(
//       children: [
//         addVerticalSpacing(10),

//         GestureDetector(
//           onTap: () {
//             route != null ? navigateToRoute(context, route) : () {};
//           },
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 13),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 // Text(
//                 //   title,
//                 //   style: textTheme.displayMedium!.copyWith(
//                 //     fontWeight: FontWeight.w600,
//                 //     color: VmodelColors.mainColor,
//                 //   ),
//                 // ),
//                 Flexible(
//                   flex: 2,
//                   child: DropdownButtonHideUnderline(
//                     child: DropdownButton<DiscoverCategory>(
//                       isExpanded: true,
//                       menuMaxHeight: 200,
//                       // isExpanded: true,
//                       iconSize: 32,
//                       iconDisabledColor: VmodelColors.greyColor,
//                       iconEnabledColor: VmodelColors.primaryColor,
//                       icon: const Icon(Icons.arrow_drop_down_rounded),
//                       borderRadius: BorderRadius.circular(12),
//                       value: _,
//                       isDense: true,
//                       onTap: () {},
//                       onChanged: (text) {
//                         // if (onChanged != null) onChanged!(text as T);
//                       },
//                       items: DiscoverCategory.values.map((DiscoverCategory value) {
//                         return DropdownMenuItem<DiscoverCategory>(
//                           value: value,
//                           alignment: AlignmentDirectional.centerStart,
//                           child: Text(
//                             value.simpleName,
//                             maxLines: true ? 1 : null,
//                             overflow: true ? TextOverflow.ellipsis : null,
//                             style: Theme.of(context)
//                                 .textTheme
//                                 .displayMedium!
//                                 .copyWith(
//                                   fontWeight: FontWeight.w600,
//                                   fontSize: 14,
//                                   color: Theme.of(context)
//                                       .primaryColor
//                                       .withOpacity(1),
//                                 ),
//                           ),
//                           // Divider(),
//                         );
//                       }).toList(),
//                     ),
//                   ),
//                 ),
//                 Spacer(),
//                 Text(
//                   "View all".toUpperCase(),
//                   style: Theme.of(context).textTheme.bodySmall!.copyWith(
//                         // fontWeight: FontWeight.w600,
//                         color: VmodelColors.mainColor.withOpacity(0.5),
//                       ),
//                 ),
//                 // const RenderSvg(
//                 //   svgPath: VIcons.forwardIcon,
//                 //   svgWidth: 12.5,
//                 //   svgHeight: 12.5,
//                 // ),
//               ],
//             ),
//           ),
//         ),
//         addVerticalSpacing(9),
//         SizedBox(
//           height: SizerUtil.height * 0.21,
//           child: ListView.builder(
//               scrollDirection: Axis.horizontal,
//               padding: const EdgeInsets.symmetric(horizontal: 12),
//               // itemCount: items.length,
//               itemCount: items.length,
//               itemBuilder: (BuildContext context, int index) {
//                 return CategoryListItem(
//                   onTap: () {
//                     // final isCurrentUser = ref
//                     //     .read(appUserProvider.notifier)
//                     //     .isCurrentUser(items[index].username);
//                     // if (isCurrentUser) {
//                     //   ref.read(dashTabProvider.notifier).changeIndexState(3);
//                     // } else {
//                     //   navigateToRoute(
//                     //     context,
//                     //     OtherProfileRouter(username: items[index].username),
//                     //   );
//                     // }
//                     onTap(items[index].username);

//                     if (eachUserHasProfile == true) {
//                       // navigateToRoute(
//                       //     context,
//                       //     PhotographersPortfolioMainView(
//                       //       imgLink: items[index].image.toString(),
//                       //     ));
//                       // navigateToRoute(
//                       //     context,
//                       //     const ProfileMainView(
//                       //       profileTypeEnumConstructor:
//                       //           ProfileTypeEnum.photographer,
//                       //     ));
//                     }
//                   },
//                   onLongPress: () {
//                     // showDialog(
//                     //     context: context,
//                     //     builder: (context) {
//                     //       return TapAndHold(item: items[index]);
//                     //     });
//                   },
//                   item: items[index],
//                   itemName: VConstants.tempCategories[index],
//                 );
//               }),
//         ),
//         // addVerticalSpacing(10),
//         // SizedBox(
//         //   width: 100,
//         //   // width: SizerUtil.width * 0.3,
//         //   child: VWidgetsPrimaryButton(
//         //     onPressed: () {
//         //       route != null ? navigateToRoute(context, route) : () {};
//         //     },
//         //     buttonTitle: "Show all",
//         //     enableButton: true,
//         //     buttonColor: VmodelColors.buttonBgColor,
//         //     buttonTitleTextStyle:
//         //         Theme.of(context).textTheme.displayMedium!.copyWith(
//         //               fontWeight: FontWeight.w600,
//         //               color: Theme.of(context).primaryColor,
//         //             ),
//         //   ),
//         // ),
//       ],
//     );
//   }
// }





/**
old body: Delete if design is finalised
Column(
      children: [
        // addVerticalSpacing(10),

        // GestureDetector(
        //   onTap: () {
        //     route != null ? navigateToRoute(context, route) : () {};
        //   },
        //   child: Padding(
        //     padding: const EdgeInsets.symmetric(horizontal: 13),
        //     child: Row(
        //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //       children: [
        //         // Text(
        //         //   title,
        //         //   style: textTheme.displayMedium!.copyWith(
        //         //     fontWeight: FontWeight.w600,
        //         //     color: VmodelColors.mainColor,
        //         //   ),
        //         // ),
        //         Flexible(
        //           flex: 2,
        //           child: DropdownButtonHideUnderline(
        //             child: DropdownButton<String>(
        //               isExpanded: true,
        //               menuMaxHeight: 200,
        //               // isExpanded: true,
        //               iconSize: 32,
        //               iconDisabledColor: VmodelColors.greyColor,
        //               iconEnabledColor: VmodelColors.primaryColor,
        //               icon: const Icon(Icons.arrow_drop_down_rounded),
        //               borderRadius: BorderRadius.circular(12),
        //               value: "Service Categories",
        //               isDense: true,
        //               onTap: () {},
        //               onChanged: (text) {
        //                 // if (onChanged != null) onChanged!(text as T);
        //               },
        //               items: [
        //                 "Service Categories",
        //                 "Job Categories",
        //                 "Talent Categories",
        //               ].map((String value) {
        //                 return DropdownMenuItem<String>(
        //                   value: value,
        //                   alignment: AlignmentDirectional.centerStart,
        //                   child: Text(
        //                     value.toString(),
        //                     maxLines: true ? 1 : null,
        //                     overflow: true ? TextOverflow.ellipsis : null,
        //                     style: Theme.of(context)
        //                         .textTheme
        //                         .displayMedium!
        //                         .copyWith(
        //                           fontWeight: FontWeight.w600,
        //                           fontSize: 14,
        //                           color: Theme.of(context)
        //                               .primaryColor
        //                               .withOpacity(1),
        //                         ),
        //                   ),
        //                   // Divider(),
        //                 );
        //               }).toList(),
        //             ),
        //           ),
        //         ),
        //         // Flexible(
        //         //   child: VWidgetsDropDownTextField(
        //         //     prefixText: "test",
        //         //     hintText: "select",
        //         //     fieldLabel: "",

        //         //     options: ["On-Location", "Hybrid", "Remote", 'Seelect'],
        //         //     onChanged: (val) {
        //         //       // setState(() {
        //         //       //   jobType = val;
        //         //       //   print(jobType);
        //         //       //   if (!jobType.contains('Remote')) {
        //         //       //     Future.delayed(Duration(milliseconds: 2),
        //         //       //         () => jobDialog(context));
        //         //       //   }
        //         //       // });
        //         //     },
        //         //     value: "Hybrid",
        //         //     getLabel: (String value) => value,
        //         //     // heightForErrorText: 0,
        //         //   ),
        //         // ),
        //         Spacer(),
        //         Text(
        //           "View all".toUpperCase(),
        //           style: Theme.of(context).textTheme.bodySmall!.copyWith(
        //                 // fontWeight: FontWeight.w600,
        //                 color: VmodelColors.mainColor.withOpacity(0.5),
        //               ),
        //         ),
        //         // const RenderSvg(
        //         //   svgPath: VIcons.forwardIcon,
        //         //   svgWidth: 12.5,
        //         //   svgHeight: 12.5,
        //         // ),
        //       ],
        //     ),
        //   ),
        // ),
        addVerticalSpacing(9),
        SizedBox(
          height: SizerUtil.height * 0.21,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              // itemCount: items.length,
              itemCount: items.length,
              itemBuilder: (BuildContext context, int index) {
                return CategoryListItem(
                  onTap: () {
                    // final isCurrentUser = ref
                    //     .read(appUserProvider.notifier)
                    //     .isCurrentUser(items[index].username);
                    // if (isCurrentUser) {
                    //   ref.read(dashTabProvider.notifier).changeIndexState(3);
                    // } else {
                    //   navigateToRoute(
                    //     context,
                    //     OtherProfileRouter(username: items[index].username),
                    //   );
                    // }
                    onTap(items[index].username);

                    if (eachUserHasProfile == true) {
                      // navigateToRoute(
                      //     context,
                      //     PhotographersPortfolioMainView(
                      //       imgLink: items[index].image.toString(),
                      //     ));
                      // navigateToRoute(
                      //     context,
                      //     const ProfileMainView(
                      //       profileTypeEnumConstructor:
                      //           ProfileTypeEnum.photographer,
                      //     ));
                    }
                  },
                  onLongPress: () {
                    // showDialog(
                    //     context: context,
                    //     builder: (context) {
                    //       return TapAndHold(item: items[index]);
                    //     });
                  },
                  item: items[index],
                  itemName: VConstants.tempCategories[index],
                );
              }),
        ),
        // addVerticalSpacing(10),
        // SizedBox(
        //   width: 100,
        //   // width: SizerUtil.width * 0.3,
        //   child: VWidgetsPrimaryButton(
        //     onPressed: () {
        //       route != null ? navigateToRoute(context, route) : () {};
        //     },
        //     buttonTitle: "Show all",
        //     enableButton: true,
        //     buttonColor: VmodelColors.buttonBgColor,
        //     buttonTitleTextStyle:
        //         Theme.of(context).textTheme.displayMedium!.copyWith(
        //               fontWeight: FontWeight.w600,
        //               color: Theme.of(context).primaryColor,
        //             ),
        //   ),
        // ),
      ],
    )



 */