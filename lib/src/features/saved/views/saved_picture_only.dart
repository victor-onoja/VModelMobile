import 'package:flutter/cupertino.dart';
import 'package:vmodel/src/core/utils/enum/upload_ratio_enum.dart';
import 'package:vmodel/src/features/saved/views/saved_feed_carousel.dart';
import 'package:vmodel/src/res/colors.dart';
import 'package:vmodel/src/res/gap.dart';

/// This Widget is used for showing Picture only posts on top of the Gallery view
class SavedPictureOnlyPost extends StatefulWidget {
  const SavedPictureOnlyPost({
    Key? key,
    required this.aspectRatio,
    required this.isSaved,
    // required this.homeCtrl,
    required this.imageList,
  }) : super(key: key);

  final UploadAspectRatio aspectRatio;
  final bool isSaved;
  // final HomeController homeCtrl;
  final List imageList;

  @override
  SavedPictureOnlyPostState createState() => SavedPictureOnlyPostState();
}

class SavedPictureOnlyPostState extends State<SavedPictureOnlyPost> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: [
            SavedFeedCarousel(
              onTapImage: () {},
              aspectRatio: widget.aspectRatio,
              imageList: widget.imageList,
              onPageChanged: (value, reason) {
                setState(() {
                  currentIndex = value;
                });
              },
            ),
            if (widget.imageList.length > 1)
              Padding(
                padding: const EdgeInsets.all(6),
                child: Wrap(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  alignment: WrapAlignment.center,
                  children: widget.imageList.asMap().entries.map((entry) {
                    return GestureDetector(
                      child: Container(
                        width: 5.92,
                        height: 5.95,
                        margin: const EdgeInsets.symmetric(
                            vertical: 3.0, horizontal: 2.525),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: VmodelColors.white
                              .withOpacity(currentIndex == entry.key ? 1 : 0.2),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
          ],
        ),
        addVerticalSpacing(7),
      ],
    );
  }
}
