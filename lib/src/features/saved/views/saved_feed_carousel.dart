import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:vmodel/src/core/utils/enum/upload_ratio_enum.dart';

import 'package:vmodel/src/vmodel.dart';

class SavedFeedCarousel extends StatefulWidget {
  const SavedFeedCarousel({
    super.key,
    required this.aspectRatio,
    required this.imageList,
    required this.onPageChanged,
    required this.onTapImage,
  });

  final UploadAspectRatio aspectRatio;
  final List imageList;
  final VoidCallback onTapImage;
  final Function(int, CarouselPageChangedReason) onPageChanged;

  @override
  State<StatefulWidget> createState() {
    return _SavedFeedCarouselState();
  }
}

class _SavedFeedCarouselState extends State<SavedFeedCarousel> {
  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          // height: 300,
          // color: Colors.amber,
          child: CarouselSlider(
            items: List.generate(
              widget.imageList.length,
              (index) => GestureDetector(
                onTap: widget.onTapImage,
                child: CachedNetworkImage(
                  imageUrl: widget.imageList[index]['itemLink'],
                  width: double.maxFinite,
                  height: double.maxFinite,
                  // fit: BoxFit.cover,
                  fit: BoxFit.contain,
                  placeholderFadeInDuration: Duration.zero,
                  fadeInDuration: Duration.zero,
                  fadeOutDuration: Duration.zero,
                  placeholder: (context, url) {
                    return CachedNetworkImage(
                      imageUrl: url,
                      memCacheHeight: 300,
                      // width: double.maxFinite,
                      // height: double.maxFinite,
                      fit: BoxFit.cover,
                      // fit: BoxFit.contain,
                      placeholderFadeInDuration: Duration.zero,
                      fadeInDuration: Duration.zero,
                      fadeOutDuration: Duration.zero,
                      progressIndicatorBuilder:
                          (context, url, downloadProgress) {
                        return Center(
                            child: CircularProgressIndicator.adaptive(
                          strokeWidth: 3,
                          value: downloadProgress.progress,
                        ));
                      },
                    );
                  },
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
              //     Image.asset(
              //   widget.imageList[index],
              //   width: double.infinity,
              //   height: double.infinity,
              //   fit: BoxFit.cover,
              // ),
            ),
            carouselController: _controller,
            options: CarouselOptions(
              padEnds: false,
              viewportFraction: 1,
              aspectRatio: widget.aspectRatio.ratio,
              initialPage: 0,
              enableInfiniteScroll: widget.imageList.length > 1 ? true : false,
              onPageChanged: widget.onPageChanged,
              // height: 300ssss,
              // ch
            ),
            // options: CarouselOptions(
            //     autoPlay: true,
            //     enlargeCenterPage: true,
            //     aspectRatio: 2.0,
            //     onPageChanged: (index, reason) {
            //       setState(() {
            //         _current = index;
            //       });
            //     }),
          ),
        ),
      ],
    );
  }
}
