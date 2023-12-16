// import 'package:flutter/material.dart';
// import 'package:vmodel/src/features/dashboard/content/widget/content_icons.dart';
// import 'package:vmodel/src/features/dashboard/content/widget/content_note.dart';
//
// class ContentPageItem extends StatefulWidget {
//   const ContentPageItem(
//       {Key? key,
//       required this.name,
//       required this.likes,
//       required this.rating,
//       required this.videoLink,
//       required this.shares})
//       : super(key: key);
//
//   final String name;
//   final String likes;
//   final String rating;
//   final String videoLink;
//   final String shares;
//
//
//   @override
//   State<ContentPageItem> createState() => _ContentPageItemState();
// }
//
// class _ContentPageItemState extends State<ContentPageItem> {
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       crossAxisAlignment: CrossAxisAlignment.end,
//       children: [
//         Expanded(
//             flex: 5,
//             child: ContentNote(
//               name: widget.name,
//               rating: widget.rating,
//             ),
//         ),
//         // Flexible(
//         //   child: RenderContentIcons(
//         //     likes: widget.likes,
//         //     shares: widget.shares,
//         //   ),
//         // ),
//       ],
//     );
//   }
// }
