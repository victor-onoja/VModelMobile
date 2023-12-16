import '../../../../shared/picture_styles/rounded_square_avatar.dart';
import '../../../../vmodel.dart';

class PopupHeadshot extends StatefulWidget {
  const PopupHeadshot({
    super.key,
    required this.url,
    required this.thumbnailUrl,
    this.onLiked,
  });
  final String? url;
  final String? thumbnailUrl;
  final VoidCallback? onLiked;

  @override
  State<PopupHeadshot> createState() => _PopupHeadshotState();
}

class _PopupHeadshotState extends State<PopupHeadshot> {
  bool _tapped = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => goBack(context),
      child: Material(
        color: Colors.transparent,
        // child: Center(
        child: SizedBox(
          height: 320,
          width: 270,
          child: GestureDetector(
            onTap: () {},
            child: Column(
              children: [
                RoundedSquareAvatar(
                    url: '${widget.url}',
                    thumbnail: '${widget.thumbnailUrl}',
                    size: Size.fromHeight(270),
                    radius: 30),
                // addVerticalSpacing(2),
                // Row(
                //   children: [
                //     addHorizontalSpacing(16),
                //     IconButton(
                //       padding: const EdgeInsets.all(2),
                //       splashRadius: 22,
                //       onPressed: () {
                //         _tapped = !_tapped;
                //         setState(() {});
                //         widget.onLiked?.call();
                //       },
                //       icon: _tapped
                //           ? RenderSvg(
                //               svgPath: VIcons.unlikedIcon,
                //               color: VmodelColors.white,
                //               svgWidth: 18,
                //               svgHeight: 18,
                //             )
                //           : RenderSvg(
                //               svgPath: VIcons.likedIcon,
                //               color: VmodelColors.white,
                //               svgWidth: 18,
                //               svgHeight: 18,
                //             ),
                //     )
                //   ],
                // ),
              ],
            ),
          ),
        ),
        // ),
      ),
    );
  }
}
