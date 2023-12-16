import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/vmodel.dart';

import '../models/discover_item.dart';

class CategoryListItem extends StatelessWidget {
  const CategoryListItem({
    Key? key,
    required this.item,
    required this.onTap,
    required this.onLongPress,
    required this.itemName,
    this.isViewAll = false,
  }) : super(key: key);

  final DiscoverItemObject item;
  final VoidCallback? onTap;
  final bool isViewAll;
  final VoidCallback? onLongPress;
  final String itemName;

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return
        // isViewAll
        // ? Container(
        //     height: 200,
        //     width: SizerUtil.width * 0.42,
        //     margin: EdgeInsets.symmetric(horizontal: isViewAll ? 0 : 5),
        //     decoration: BoxDecoration(
        //       borderRadius: BorderRadius.circular(8),
        //       image: DecorationImage(
        //         // image: CachedNetworkImageProvider(item.image), fit: BoxFit.cover),
        //         image: AssetImage(item.image),
        //         fit: BoxFit.cover,
        //       ),
        //     ),
        //     child: GestureDetector(
        //       onTap: () {
        //         onTap!();
        //       },
        //       onLongPress: () {
        //         onLongPress!();
        //       },
        //       child: Container(
        //         padding: const EdgeInsets.fromLTRB(8, 0, 10, 3),
        //         decoration: BoxDecoration(
        //             borderRadius: BorderRadius.circular(8),
        //             gradient: const LinearGradient(
        //                 begin: Alignment.topCenter,
        //                 end: Alignment.bottomCenter,
        //                 stops: [0.6, 1],
        //                 colors: [Colors.transparent, Colors.black87])),
        //         child: Column(
        //           mainAxisAlignment: MainAxisAlignment.end,
        //           children: [
        //             Row(
        //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //               crossAxisAlignment: CrossAxisAlignment.end,
        //               children: [
        //                 Flexible(
        //                   child: Text(
        //                     itemName,
        //                     style: textTheme.displaySmall?.copyWith(
        //                         fontSize: 12.sp,
        //                         color: VmodelColors.white,
        //                         fontWeight: FontWeight.w500),
        //                     maxLines: 1,
        //                     overflow: TextOverflow.ellipsis,
        //                   ),
        //                 ),
        //               ],
        //             ),
        //             // addVerticalSpacing(3),
        //             // Row(
        //             //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //             //   children: [
        //             //     Flexible(
        //             //       child: Text(
        //             //         item.label.toUpperCase(),
        //             //         style: textTheme.displaySmall?.copyWith(
        //             //           fontSize: 10.sp,
        //             //           color: VmodelColors.white,
        //             //           // fontWeight: FontWeight.w600,
        //             //         ),
        //             //         maxLines: 1,
        //             //         overflow: TextOverflow.ellipsis,
        //             //       ),
        //             //     ),
        //             //     Row(
        //             //       crossAxisAlignment: CrossAxisAlignment.start,
        //             //       children: [
        //             //         RenderSvg(
        //             //           svgPath: VIcons.stars,
        //             //           color: VmodelColors.white,
        //             //           svgWidth: 12,
        //             //           svgHeight: 12,
        //             //         ),
        //             //         addHorizontalSpacing(2),
        //             //         Text(
        //             //           item.points,
        //             //           style: textTheme.displaySmall?.copyWith(
        //             //               fontSize: 10.sp,
        //             //               fontWeight: FontWeight.w500,
        //             //               color: Colors.white),
        //             //         ),
        //             //       ],
        //             //     )
        //             //   ],
        //             // ),
        //             addVerticalSpacing(4),
        //             // item.categories!=null?   Text(
        //             //      item.categories!,
        //             //      style: textTheme.displaySmall
        //             //          ?.copyWith(fontSize: 8.sp, color: VmodelColors.white),
        //             //      maxLines: 1,
        //             //      overflow: TextOverflow.ellipsis,
        //             //    ): Text(
        //             //  "",
        //             //   style: textTheme.displaySmall
        //             //       ?.copyWith(fontSize: 8.sp, color: VmodelColors.white),
        //             //   maxLines: 1,
        //             //   overflow: TextOverflow.ellipsis,
        //             // ),
        //           ],
        //         ),
        //       ),
        //     ),
        //   )
        // :
        GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            height: 86,
            width: 86,
            margin: EdgeInsets.symmetric(horizontal: isViewAll ? 0 : 20),
            decoration: BoxDecoration(
              // borderRadius: BorderRadius.circular(8),
              shape: BoxShape.circle,
              border: Border.all(
                  color: Theme.of(context).colorScheme.primary, width: 4),
              image: DecorationImage(
                // image: CachedNetworkImageProvider(item.image), fit: BoxFit.cover),
                image: AssetImage(item.image),
                fit: BoxFit.cover,
              ),
            ),
            // child: GestureDetector(
            //   onTap: () {
            //     onTap!();
            //   },
            //   onLongPress: () {
            //     onLongPress!();
            //   },
            //   child: Container(
            //     padding: const EdgeInsets.fromLTRB(8, 0, 10, 3),
            //     decoration: BoxDecoration(
            //         borderRadius: BorderRadius.circular(8),
            //         gradient: const LinearGradient(
            //             begin: Alignment.topCenter,
            //             end: Alignment.bottomCenter,
            //             stops: [0.6, 1],
            //             colors: [Colors.transparent, Colors.black87])),
            //     child: Column(
            //       mainAxisAlignment: MainAxisAlignment.end,
            //       children: [
            //         Row(
            //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //           crossAxisAlignment: CrossAxisAlignment.end,
            //           children: [
            //             Flexible(
            //               child: Text(
            //                 itemName,
            //                 style: textTheme.displaySmall?.copyWith(
            //                     fontSize: 12.sp,
            //                     color: VmodelColors.white,
            //                     fontWeight: FontWeight.w500),
            //                 maxLines: 1,
            //                 overflow: TextOverflow.ellipsis,
            //               ),
            //             ),
            //           ],
            //         ),
            //         // addVerticalSpacing(3),
            //         // Row(
            //         //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //         //   children: [
            //         //     Flexible(
            //         //       child: Text(
            //         //         item.label.toUpperCase(),
            //         //         style: textTheme.displaySmall?.copyWith(
            //         //           fontSize: 10.sp,
            //         //           color: VmodelColors.white,
            //         //           // fontWeight: FontWeight.w600,
            //         //         ),
            //         //         maxLines: 1,
            //         //         overflow: TextOverflow.ellipsis,
            //         //       ),
            //         //     ),
            //         //     Row(
            //         //       crossAxisAlignment: CrossAxisAlignment.start,
            //         //       children: [
            //         //         RenderSvg(
            //         //           svgPath: VIcons.stars,
            //         //           color: VmodelColors.white,
            //         //           svgWidth: 12,
            //         //           svgHeight: 12,
            //         //         ),
            //         //         addHorizontalSpacing(2),
            //         //         Text(
            //         //           item.points,
            //         //           style: textTheme.displaySmall?.copyWith(
            //         //               fontSize: 10.sp,
            //         //               fontWeight: FontWeight.w500,
            //         //               color: Colors.white),
            //         //         ),
            //         //       ],
            //         //     )
            //         //   ],
            //         // ),
            //         addVerticalSpacing(4),
            //         // item.categories!=null?   Text(
            //         //      item.categories!,
            //         //      style: textTheme.displaySmall
            //         //          ?.copyWith(fontSize: 8.sp, color: VmodelColors.white),
            //         //      maxLines: 1,
            //         //      overflow: TextOverflow.ellipsis,
            //         //    ): Text(
            //         //  "",
            //         //   style: textTheme.displaySmall
            //         //       ?.copyWith(fontSize: 8.sp, color: VmodelColors.white),
            //         //   maxLines: 1,
            //         //   overflow: TextOverflow.ellipsis,
            //         // ),
            //       ],
            //     ),
            //   ),
            // ),
          ),
          addVerticalSpacing(15),
          Flexible(
            child: Container(
              constraints: BoxConstraints(maxWidth: 120),
              child: Text(
                itemName,
                style: textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.w500),
                maxLines: 2,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ],
      ),
    );
  }
}


// class CategoryListItem extends StatelessWidget {
//   const CategoryListItem({
//     Key? key,
//     required this.item,
//     required this.onTap,
//     required this.onLongPress,
//     required this.itemName,
//     this.isViewAll = false,
//   }) : super(key: key);

//   final DiscoverItemObject item;
//   final VoidCallback? onTap;
//   final bool isViewAll;
//   final VoidCallback? onLongPress;
//   final String itemName;

//   @override
//   Widget build(BuildContext context) {
//     TextTheme textTheme = Theme.of(context).textTheme;
//     return GestureDetector(
//       onTap: () {
//         // onTap!();
//       },
//       onLongPress: () {
//         // onLongPress!();
//       },
//       child: SizedBox(
//         height: 160,
//         // width: 130,
//         width: SizerUtil.width * 0.42,
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             // Container(
//             //   height: 130,
//             //   width: 130,
//             //   padding: const EdgeInsets.all(8.0),
//             //   child: ClipRRect(
//             //     borderRadius: BorderRadius.circular(8),
//             //     child: CachedNetworkImage(imageUrl: item.image),
//             //   ),
//             // ),
//             Container(
//               height: 110,
//               // width: 130,
//               // width: SizerUtil.width * 0.42,
//               margin: EdgeInsets.symmetric(horizontal: isViewAll ? 0 : 5),
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(8),
//                 image: DecorationImage(
//                     image: CachedNetworkImageProvider(item.image),
//                     fit: BoxFit.cover),
//               ),
//             ),
//             addVerticalSpacing(8),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               // crossAxisAlignment: CrossAxisAlignment.end,
//               children: [
//                 Flexible(
//                   child: Text(
//                     itemName,
//                     style: textTheme.displaySmall?.copyWith(
//                         fontSize: 12.sp,
//                         color: VmodelColors.primaryColor,
//                         fontWeight: FontWeight.w500),
//                     maxLines: 1,
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                 ),
//               ],
//             ),
//             addVerticalSpacing(4),
//           ],
//         ),
//       ),
//     );
//   }
// }
