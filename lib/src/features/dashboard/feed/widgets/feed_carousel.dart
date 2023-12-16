import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pinch_zoom_release_unzoom/pinch_zoom_release_unzoom.dart';
import 'package:vmodel/src/core/utils/enum/upload_ratio_enum.dart';

import '../../../../shared/shimmer/post_shimmer.dart';
import '../../../../vmodel.dart';
import '../controller/new_feed_provider.dart';

class FeedCarousel extends ConsumerStatefulWidget {
  const FeedCarousel({
    super.key,
    required this.aspectRatio,
    required this.imageList,
    required this.onPageChanged,
    required this.onTapImage,
    this.isLocalPreview = false,
  });

  final bool isLocalPreview;
  final UploadAspectRatio aspectRatio;
  final List imageList;
  final VoidCallback onTapImage;
  final Function(int, CarouselPageChangedReason) onPageChanged;

  @override
  ConsumerState<FeedCarousel> createState() {
    return _FeedCarouselState();
  }
}

class _FeedCarouselState extends ConsumerState<FeedCarousel> {
  final CarouselController _controller = CarouselController();
  bool blockScroll = false;
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final isPinchToZoom = ref.watch(isPinchToZoomProvider);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Image.network(
        //   "${widget.imageList.first.url}",
        //   loadingBuilder: (context, child, loadingProgress) {
        //     return CircularProgressIndicator(
        //       value: (loadingProgress?.cumulativeBytesLoaded ?? 1) /
        //           (loadingProgress?.expectedTotalBytes ?? 1),
        //     );
        //   },
        // ),
        // Image.network(
        //   "${widget.imageList.first.url}",
        //   frameBuilder: (context, child, _, __) {
        //     return const PostShimmerPage();
        //   },
        //   errorBuilder: (context, error, stackTrace) =>
        //       Center(child: Text("Error getting image")),
        // ),
        Flexible(
          // height: 300,
          // color: Colors.amber,
          child:
              // widget.imageList.length == 1
              //     ?
              // Image.network(
              //         "${widget.imageList.first.url}",
              //         frameBuilder: (BuildContext context, Widget child, int? frame,
              //             bool? wasSynchronouslyLoaded) {
              //           if (frame != null && frame >= 0) {
              //             return child;
              //           }
              //           return const SizedBox(
              //             height: 200,
              //             width: double.maxFinite,
              //             child: PostShimmerPage(),
              //           );
              //         },
              //       )
              // :
              PinchZoomReleaseUnzoomWidget(
            // zoomChild: Image.network(
            //   "${widget.imageList.first.url}",
            //   frameBuilder: (BuildContext context, Widget child, int? frame,
            //       bool? wasSynchronouslyLoaded) {
            //     if (frame != null && frame >= 0) {
            //       return child;
            //     }
            //     return const SizedBox(
            //       height: 200,
            //       width: double.maxFinite,
            //       child: PostShimmerPage(),
            //     );
            //   },
            // ),
            zoomChild: CachedNetworkImage(
              imageUrl: widget.imageList[_currentIndex].url,
              fadeInDuration: Duration.zero,
              fadeOutDuration: Duration.zero,
              width: double.maxFinite,
              height: double.maxFinite,
              filterQuality: FilterQuality.medium,
              // fit: BoxFit.cover,
              fit: BoxFit.contain,
              placeholder: (context, url) {
                return const PostShimmerPage();
              },
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
            // child: AspectRatio(
            //   aspectRatio: widget.aspectRatio.ratio,
            //   child: PageView.builder(
            //       scrollBehavior: ScrollConfiguration.of(context).copyWith(
            //         scrollbars: false,
            //         overscroll: false,
            //         dragDevices: {
            //           PointerDeviceKind.touch,
            //           PointerDeviceKind.mouse,
            //         },
            //       ),
            //       onPageChanged: (index) {
            //         _currentIndex = index;
            //       },
            //       physics: isPinchToZoom
            //           ? const NeverScrollableScrollPhysics()
            //           : null,
            //       itemCount: widget.imageList.length,
            //       itemBuilder: (context, index) {
            //         return CachedNetworkImage(
            //           imageUrl: widget.imageList[index].url,
            //           fadeInDuration: Duration.zero,
            //           fadeOutDuration: Duration.zero,
            //           width: double.maxFinite,
            //           height: double.maxFinite,
            //           filterQuality: FilterQuality.medium,
            //           // fit: BoxFit.cover,
            //           fit: BoxFit.contain,
            //           placeholder: (context, url) {
            //             return const PostShimmerPage();
            //           },
            //           errorWidget: (context, url, error) =>
            //               const Icon(Icons.error),
            //         );
            //       }),
            // ),
            child: CarouselSlider(
              disableGesture: true,
              items: List.generate(
                widget.imageList.length,
                (index) => widget.isLocalPreview
                    ? Image.memory(
                        widget.imageList[index],
                      )
                    // : isPinchToZoom
                    //     ? Image.network(
                    //         "${widget.imageList.first.url}",
                    //         frameBuilder: (BuildContext context, Widget child,
                    //             int? frame, bool? wasSynchronouslyLoaded) {
                    //           if (frame != null && frame >= 0) {
                    //             return child;
                    //           }
                    //           return const SizedBox(
                    //             height: 200,
                    //             width: double.maxFinite,
                    //             child: PostShimmerPage(),
                    //           );
                    //         },
                    //       )
                    : CachedNetworkImage(
                        imageUrl: widget.imageList[index].url,
                        fadeInDuration: Duration.zero,
                        fadeOutDuration: Duration.zero,
                        width: double.maxFinite,
                        height: double.maxFinite,
                        filterQuality: FilterQuality.medium,
                        // fit: BoxFit.cover,
                        fit: BoxFit.contain,
                        placeholder: (context, url) {
                          return const PostShimmerPage();
                          // return CachedNetworkImage(
                          //   imageUrl: url,
                          //   // memCacheHeight: 300,
                          //   fadeInDuration: Duration.zero,
                          //   fadeOutDuration: Duration.zero,
                          //   // width: double.maxFinite,
                          //   // height: double.maxFinite,
                          //   fit: BoxFit.cover,
                          //   // fit: BoxFit.contain,
                          //   progressIndicatorBuilder:
                          //       (context, url, downloadProgress) {
                          //     return const PostShimmerPage();
                          //     // return Center(
                          //     //     child: CircularProgressIndicator(
                          //     //   strokeWidth: 3,
                          //     //   value: downloadProgress.progress,
                          //     // ));
                          //   },
                          // );
                        },
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
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
                enableInfiniteScroll: false,
                // widget.imageList.length > 1 ? true : false,
                onPageChanged: (index, reason) {
                  _currentIndex = index;
                  widget.onPageChanged(index, reason);
                },
                scrollPhysics:
                    isPinchToZoom ? NeverScrollableScrollPhysics() : null,
                // height: 300,
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
            twoFingersOn: () {
              ref.read(isPinchToZoomProvider.notifier).state = true;
              // setState(() => blockScroll = true);
            },
            twoFingersOff: () => Future.delayed(
              PinchZoomReleaseUnzoomWidget.defaultResetDuration,
              () {
                ref.read(isPinchToZoomProvider.notifier).state = false;
                // setState(() => blockScroll = false);
              },
            ),
          ),
        ),
      ],
    );
  }
}
