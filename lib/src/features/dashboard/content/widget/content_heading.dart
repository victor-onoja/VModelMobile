// import 'package:flutter/material.dart';
// import 'package:vmodel/src/res/res.dart';
//
// class ContentHeading extends StatelessWidget {
//   const ContentHeading({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         addVerticalSpacing(10),
//         SizedBox(
//           height: 19,
//           child: ListView(
//             shrinkWrap: true,
//             scrollDirection: Axis.horizontal,
//             children: const [
//               HeadingText(
//                 title: '#commercial',
//               ),
//               HeadingText(
//                 title: '#glamour',
//               ),
//               HeadingText(
//                 title: '#food',
//               ),
//               HeadingText(
//                 title: '#plussize',
//               ),
//               HeadingText(
//                 title: '#parts',
//               ),
//               HeadingText(
//                 title: '#commercial',
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }
//
// class HeadingText extends StatelessWidget {
//   const HeadingText({Key? key, required this.title}) : super(key: key);
//   final String title;
//
//   @override
//   Widget build(BuildContext context) {
//     TextTheme textTheme = Theme.of(context).textTheme;
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 4),
//       child: Text(title,
//           style: textTheme.displayMedium!.copyWith(
//               fontWeight: FontWeight.w400,
//               color: Colors.white.withOpacity(0.5))),
//     );
//   }
// }
