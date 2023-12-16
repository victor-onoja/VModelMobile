import 'package:cached_network_image/cached_network_image.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/vmodel.dart';

class VWidgetsSenderTextCard extends StatelessWidget {
  final String? senderMessage;
  final String? senderImage;
  final bool? checkStatus;
  final double fontSize;
  final VoidCallback onSenderImageTap;

  const VWidgetsSenderTextCard(
      {required this.senderMessage,
      required this.senderImage,
      required this.onSenderImageTap,
      this.checkStatus,
      this.fontSize = 16,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const VWidgetsPagePadding.verticalSymmetric(5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          //Sender Profile
          // if (checkStatus == true)
          GestureDetector(
            onTap: onSenderImageTap,
            child: Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: const BorderRadius.all(
                  Radius.circular(40),
                ),
                image: DecorationImage(
                  image: CachedNetworkImageProvider(senderImage!),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          //  CircleAvatar(
          //     child: FadeInImage.assetNetwork(
          //       placeholder: 'assets/images/svg_images/Frame 33600.png',
          //       image: senderImage!,
          //     ),
          // //   )
          // else
          //   Container(
          //     width: 32,
          //     height: 32,
          //     decoration: BoxDecoration(
          //       color: VmodelColors.white,
          //       image: DecorationImage(
          //         image: AssetImage('assets/images/svg_images/Frame 33600.png'),
          //         fit: BoxFit.cover,
          //       ),
          //     ),
          //   ),
          addHorizontalSpacing(10),
          //Sender Text
          Flexible(
            child: Container(
              constraints:
                  BoxConstraints(maxWidth: SizeConfig.screenWidth * 0.7),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Theme.of(context).dividerColor,
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
                child: Text(
                  senderMessage!,
                  maxLines: null,
                  style: Theme.of(context).textTheme.displayMedium!.copyWith(
                        color: Theme.of(context).primaryColor,
                        fontSize: fontSize,
                        fontWeight: FontWeight.w500,
                      ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
