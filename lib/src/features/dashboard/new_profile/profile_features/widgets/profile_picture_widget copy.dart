// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:vmodel/src/res/icons.dart';
// import 'package:vmodel/src/shared/rend_paint/render_svg.dart';
// import 'package:vmodel/src/vmodel.dart';

// class ProfilePicture extends StatelessWidget {
//   final String? url;
//   final String? headshotThumbnail;
//   final double size;
//   final Color? borderColor;
//   final bool showBorder;

//   const ProfilePicture({
//     super.key,
//     required this.url,
//     required this.headshotThumbnail,
//     this.size = 70.00,
//     this.borderColor,
//     this.showBorder = false,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: size,
//       width: size,
//       decoration: showBorder
//           ? BoxDecoration(
//               shape: BoxShape.circle,
//               border: Border.all(
//                 width: 2,
//                 color: getPicturBorderColor(context),
//               ),
//             )
//           : null,
//       child: Padding(
//         padding: const EdgeInsets.all(2),
//         child: ClipRRect(
//           borderRadius: BorderRadius.circular(100),
//           child: CachedNetworkImage(
//             memCacheHeight: 200,
//             width: double.infinity,
//             fit: BoxFit.cover,
//             imageUrl: headshotThumbnail ?? "$url",
//             // imageUrl: "${headshotThumbnail}", // ?? "$url",
//             placeholderFadeInDuration: Duration.zero,
//             fadeInDuration: Duration.zero,
//             fadeOutDuration: Duration.zero,
//             placeholder: (context, url) =>
//                 const RenderSvgWithoutColor(svgPath: VIcons.vModelProfile),
//             errorWidget: (context, url, error) =>
//                 const RenderSvgWithoutColor(svgPath: VIcons.vModelProfile),
//           ),
//         ),
//       ),
//     );
//   }

//   Color getPicturBorderColor(BuildContext context) {
//     return borderColor ??
//         Theme.of(context).bottomNavigationBarTheme.backgroundColor!;
//   }
// }

// class NavProfilePicture extends StatelessWidget {
//   final String? url;
//   final double size;
//   final Color? borderColor;
//   final bool showBorder;

//   const NavProfilePicture({
//     super.key,
//     required this.url,
//     this.size = 70.00,
//     this.borderColor,
//     this.showBorder = false,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: size,
//       width: size,
//       padding: EdgeInsets.all(1),
//       decoration: showBorder
//           ? BoxDecoration(
//               shape: BoxShape.circle,
//               border: Border.all(
//                 width: 2,
//                 color: getPicturBorderColor(context),
//               ),
//             )
//           : null,
//       child: Container(
//         height: size,
//         width: size,
//         decoration: showBorder
//             ? BoxDecoration(
//                 shape: BoxShape.circle,
//                 image: DecorationImage(
//                     image: CachedNetworkImageProvider(
//                   "$url",
//                   // memCacheHeight: 200,
//                   // width: double.infinity,
//                   // fit: BoxFit.cover,
//                   // placeholderFadeInDuration: Duration.zero,
//                   // fadeInDuration: Duration.zero,
//                   // fadeOutDuration: Duration.zero,
//                   // placeholder: (context, url) =>
//                   //     const RenderSvgWithoutColor(svgPath: VIcons.vModelProfile),
//                   // errorWidget: (context, url, error) =>
//                   //     const RenderSvgWithoutColor(svgPath: VIcons.vModelProfile),
//                 )))
//             : null,
//       ),
//     );
//   }

//   Color getPicturBorderColor(BuildContext context) {
//     return borderColor ??
//         Theme.of(context).bottomNavigationBarTheme.backgroundColor!;
//   }
// }
