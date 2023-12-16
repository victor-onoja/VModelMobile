// import 'package:vmodel/src/res/res.dart';
// import 'package:vmodel/src/vmodel.dart';

// import '../../../../core/utils/costants.dart';
// import '../../../../shared/vwidget_radio_tile.dart';

// class SelectJobServiceBottomsheet extends StatelessWidget {
//   const SelectJobServiceBottomsheet({
//     required this.onJobsTap,
//     required this.onServicesTap,
//     required this.selected,
//     super.key,
//   });

//   final VoidCallback onJobsTap;
//   final VoidCallback onServicesTap;
//   final String selected;

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       child: Padding(
//         padding: const EdgeInsets.only(
//           left: 5,
//           right: 5,
//           bottom: VConstants.bottomPaddingForBottomSheets,
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           mainAxisSize: MainAxisSize.min,
//           children: <Widget>[
//             addVerticalSpacing(25),
//             // Padding(
//             //   padding: const EdgeInsets.symmetric(vertical: 6.0),
//             //   child: GestureDetector(
//             //       onTap: () {
//             //         onJobsTap();
//             //         goBack(context);
//             //       },
//             //       child: Text('Jobs',
//             //           style:
//             //               Theme.of(context).textTheme.displayMedium!.copyWith(
//             //                     fontWeight: FontWeight.normal,
//             //                     // color: VmodelColors.primaryColor,
//             //                   ))),
//             // ),
//             VWidgetsRadioTile(
//               title: "Jobs",
//               isSelected: selected.toLowerCase() == 'jobs',
//               onTap: () {
//                 onJobsTap();
//                 goBack(context);
//                 // setState(() {
//                 //   isSelected = true;
//                 // });
//               },
//             ),
//             addVerticalSpacing(5),
//             const Divider(thickness: 0.5),
//             addVerticalSpacing(5),
//             VWidgetsRadioTile(
//               title: "Services",
//               isSelected: selected.toLowerCase() == 'services',
//               onTap: () {
//                 // setState(() {
//                 //   isSelected = true;
//                 // });

//                 onServicesTap();
//                 goBack(context);
//               },
//             ),
//             // Padding(
//             //   padding: const EdgeInsets.symmetric(vertical: 6.0),
//             //   child: GestureDetector(
//             //     onTap: () {
//             //       onServicesTap();
//             //       goBack(context);
//             //     },
//             //     child: Text('Services',
//             //         style: Theme.of(context).textTheme.displayMedium!.copyWith(
//             //               fontWeight: FontWeight.normal,
//             //               // color: Theme.of(context).primaryColor,
//             //             )),
//             //   ),
//             // ),
//             addVerticalSpacing(25),
//           ],
//         ),
//       ),
//     );
//   }
// }
