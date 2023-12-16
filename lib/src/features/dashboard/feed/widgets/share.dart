import 'package:cached_network_image/cached_network_image.dart';
import 'package:vmodel/src/core/utils/share.dart';
import 'package:vmodel/src/res/icons.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/vmodel.dart';

import '../../../../shared/rend_paint/render_svg.dart';

class ShareWidget extends StatelessWidget {
  final String? shareLabel;
  final String? shareTitle;
  final String? shareImage;
  final String? shareURL;
  final bool isWebPicture;
  const ShareWidget(
      {required this.shareLabel,
      required this.shareTitle,
      required this.shareImage,
      required this.shareURL,
      this.isWebPicture = false,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: const EdgeInsets.only(bottom: 80),
      height: 500,
      decoration: BoxDecoration(
          // color: Colors.white,
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(8), topLeft: Radius.circular(8))),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.center,
              child: Container(
                height: 5,
                width: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: VmodelColors.primaryColor.withOpacity(0.15),
                ),
              ),
            ),

            addVerticalSpacing(15),

            Text(
              shareLabel!,
              style: Theme.of(context).textTheme.displayMedium?.copyWith(
                  // color: VmodelColors.primaryColor,
                  fontWeight: FontWeight.w600),
            ),

            addVerticalSpacing(15),

            //

            Row(
              children: [
                Container(
                  height: 70,
                  width: 70,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    image: DecorationImage(
                      image: isWebPicture
                          ? CachedNetworkImageProvider(shareImage!)
                          : Image.asset(shareImage!).image,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                addHorizontalSpacing(10),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        shareTitle!,
                        style:
                            Theme.of(context).textTheme.displayMedium?.copyWith(
                                // color: VmodelColors.primaryColor,
                                fontWeight: FontWeight.w600),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        shareURL!,
                        style:
                            Theme.of(context).textTheme.displayMedium?.copyWith(
                                // color: VmodelColors.primaryColor,
                                fontWeight: FontWeight.w500),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                )
              ],
            ),

            const Divider(
              height: 25,
            ),

            const ShareOption(
              iconPath: VIcons.copyUrlIcon,
              title: "Copy Url",
            ),
            const ShareOption(
              iconPath: VIcons.safariIcon,
              title: "Open in Safari",
            ),
            const ShareOption(
              iconPath: VIcons.mailIcon,
              title: "Mail",
            ),
            //  const ShareOption(iconPath: VIcons.mailIcon, title: "Mail",),
            const ShareOption(
              iconPath: VIcons.twitterIcon,
              title: "Twitter",
              width: 18,
              height: 18,
            ),
            const ShareOption(
              iconPath: VIcons.facebookIcon,
              title: "Facebook",
            ),
            ShareOption(
              iconPath: VIcons.moreIcon,
              title: "Share via",
              height: 3.67,
              width: 14.67,
              onTap: () {
                VUtilsShare.onShare(
                    context,
                    [
                      'assets/images/doc/main-model.png',
                    ],
                    "VModel \nMy first shoot with Jd Official. I’m so excited for the future to come! I never actually believed I would be picked when I applied, but I got in! I’m sooooooooo happy!",
                    "My first shoot with Jd Official. I’m so excited for the future to come! I never actually believed I would be picked when I applied, but I got in! I’m sooooooooo happy!t");
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ShareOption extends StatelessWidget {
  const ShareOption(
      {Key? key,
      required this.title,
      required this.iconPath,
      this.height,
      this.width,
      this.onTap})
      : super(key: key);

  final String title;
  final String iconPath;
  final double? height;
  final double? width;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: onTap,
          child: Row(
            children: [
              RenderSvg(
                svgPath: iconPath,
                svgHeight: height ?? 22,
                svgWidth: width ?? 22,
              ),
              addHorizontalSpacing(8),
              Text(
                title,
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                    // color: VmodelColors.primaryColor,
                    fontWeight: FontWeight.w500),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        const Divider(
          height: 25,
        ),
      ],
    );
  }
}
