import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vmodel/src/res/assets/main_assets_path.dart';
import 'package:vmodel/src/res/colors.dart';
import 'package:vmodel/src/res/icons.dart';
import 'package:vmodel/src/shared/rend_paint/render_svg.dart';

class RenderContentIcons extends StatefulWidget {
  const RenderContentIcons({
    Key? key,
    required this.likes,
    required this.shares,
    required this.isLiked,
    required this.isShared,
    required this.likedFunc,
    required this.shieldFunc,
    required this.isSaved,
    required this.saveFunc,
    required this.shareFunc,
    required this.sendFunc,
  }) : super(key: key);

  final String likes;
  final String shares;
  final bool isLiked;
  final bool isShared;
  final bool isSaved;
  final Function() saveFunc;
  final Function() likedFunc;
  final Function() shieldFunc;
  final Function() shareFunc;
  final Function() sendFunc;

  @override
  State<RenderContentIcons> createState() => _RenderContentIconsState();
}

class _RenderContentIconsState extends State<RenderContentIcons>
    with AutomaticKeepAliveClientMixin {
  Color color = const Color.fromRGBO(255, 255, 255, 0.8);

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return ListView(
      shrinkWrap: true,
      cacheExtent: 1000,
      children: [
        ContentIcons(
          svgPath: VIcons.likedIcon2,
          title: widget.likes,
          iconColor: widget.isLiked ? VmodelColors.heartIconColor : color,
          onClicked: widget.likedFunc,
        ),
        // ContentIcons(
        //   svgPath: VIcons.shieldTicIcon,
        //   title: widget.shares,
        //   iconColor: widget.isShared ? VmodelColors.badgeIconColor : color,
        //   onClicked: widget.shieldFunc,
        // ),
        ContentIcons(
          svgPath: VIcons.exportIcon,
          onClicked: widget.shareFunc,
        ),
        GestureDetector(
          onTap: widget.saveFunc,
          child: RenderSvg(
            svgPath: VIcons.savedIcon2,
            svgHeight: 23,
            svgWidth: 23,
            color: widget.isSaved
                ? Colors.white
                : const Color.fromRGBO(255, 255, 255, 0.8),
          ),
        ),
        const SizedBox(
          height: 18,
        ),
        Text(
          '',
          style: textTheme.displayMedium!.copyWith(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Colors.white.withOpacity(0.8)),
        ),
        GestureDetector(
          onTap: widget.sendFunc,
          child: const RenderSvg(
            svgPath: VIcons.sendWithoutNot2,
            svgHeight: 23,
            svgWidth: 23,
            color: Color.fromRGBO(255, 255, 255, 0.8),
          ),
        ),
        const SizedBox(
          height: 2,
        ),
        Text(
          '',
          style: textTheme.displayMedium!.copyWith(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Colors.white.withOpacity(0.8)),
        ),
        Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              height: 62,
              width: 51,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                      width: 2, color: Colors.white.withOpacity(0.5)),
                  image: DecorationImage(
                      image: AssetImage(VmodelAssets1.profileImage),
                      fit: BoxFit.cover)),
            ),
            Container(
              height: 16,
              width: 16,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: VmodelColors.text,
                border:
                    Border.all(width: 1, color: Colors.white.withOpacity(0.5)),
              ),
              child: Center(
                child: Text(
                  '+',
                  style: textTheme.displayMedium!.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.white.withOpacity(0.8)),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class ContentIcons extends StatelessWidget {
  final String svgPath;
  final String? title;
  final Color? iconColor;
  final Function() onClicked;
  const ContentIcons(
      {Key? key,
      required this.svgPath,
      this.title,
      required this.onClicked,
      this.iconColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Column(
        children: [
          GestureDetector(
              onTap: onClicked,
              child: SvgPicture.asset(
                svgPath,
                color: iconColor ?? const Color.fromRGBO(255, 255, 255, 0.8),
                width: svgPath == VIcons.likedIcon2 ? 23 : 29,
                height: svgPath == VIcons.likedIcon2 ? 23 : 29,
              )),
          const SizedBox(
            height: 2,
          ),
          Text(
            title ?? '',
            style: textTheme.displayMedium!.copyWith(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Colors.white.withOpacity(0.8)),
          ),
        ],
      ),
    );
  }
}
