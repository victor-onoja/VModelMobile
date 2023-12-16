import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vmodel/src/res/res.dart';

import '../../../core/utils/enum/upload_ratio_enum.dart';
import '../../../vmodel.dart';
import '../../dashboard/feed/widgets/feed_carousel.dart';
import '../controller/cropped_data_controller.dart';

class PostPreview extends ConsumerStatefulWidget {
  const PostPreview({
    super.key,
    required this.aspectRatio,
  });
  final UploadAspectRatio aspectRatio;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PostPreviewState();
}

class _PostPreviewState extends ConsumerState<PostPreview> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final images = ref.watch(croppedImagesProvider);

    return Scaffold(
      backgroundColor: Colors.black,
      // appBar: VWidgetsAppBar(
      //   // backgroundColor: Colors.black,
      //   appbarTitle: '',
      //   leadingIcon: VWidgetsBackButton(
      //     buttonColor: Colors.white,
      //   ),
      // ),
      body: Column(
        children: [
          const Row(
            children: [
              VWidgetsBackButton(buttonColor: Colors.white),
            ],
          ),
          Expanded(child: addVerticalSpacing(16)),
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              // mainAxisSize: MainAxisSize.min,
              children: [
                FeedCarousel(
                  aspectRatio: widget.aspectRatio,
                  imageList: images,
                  isLocalPreview: true,
                  onPageChanged: (value, reason) {
                    setState(() {
                      currentIndex = value;
                    });
                  },
                  onTapImage: () {},
                ),
                if (images.length > 1) addVerticalSpacing(10),
                if (images.length > 1)
                  Wrap(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    alignment: WrapAlignment.center,
                    children: images.asMap().entries.map((entry) {
                      return GestureDetector(
                        child: Container(
                          width: 5.92,
                          height: 5.95,
                          margin: const EdgeInsets.symmetric(
                              vertical: 3.0, horizontal: 2.525),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: VmodelColors.white.withOpacity(
                                currentIndex == entry.key ? 1 : 0.2),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
              ],
            ),
          ),
          Expanded(child: addVerticalSpacing(16)),
        ],
      ),
    );
  }
}
