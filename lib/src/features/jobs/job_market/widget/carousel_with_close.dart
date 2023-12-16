import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/widgets.dart';

import '../../../../res/gap.dart';
import '../../../../shared/carousel_indicators.dart';
import '../../../../vmodel.dart';
import '../../../dashboard/discover/models/mock_data.dart';

class CarouselWithClose extends StatefulWidget {
  const CarouselWithClose({
    super.key,
    this.children,
    this.height,
    this.autoPlay = true,
    this.cornerRadius = 10.0,
    this.aspectRatio = 16 / 9,
    this.padding = const EdgeInsets.symmetric(horizontal: 16),
  });

  final bool autoPlay;
  final double aspectRatio;
  final double? height;
  final double cornerRadius;
  final List<Widget>? children;
  final EdgeInsetsGeometry padding;

  @override
  State<CarouselWithClose> createState() => _CarouselWithCloseState();
}

class _CarouselWithCloseState extends State<CarouselWithClose> {
  final CarouselController _carouselController = CarouselController();
  int _currentIndex = 0;
  final _showCarousel = ValueNotifier(true);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: _showCarousel,
        builder: (context, value, _) {
          if (!value) return const SizedBox.shrink();
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // addVerticalSpacing(32),
              Padding(
                padding: widget.padding,
                child: ClipRRect(
                    // height: SizerUtil.height * 0.25,
                    // margin: const EdgeInsets.all(16),
                    // decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(widget.cornerRadius),
                    //   color: Colors.grey.shade300,
                    // ),
                    child: CarouselSlider(
                      disableGesture: false,
                      items: widget.children ??
                          List.generate(
                            mockDiscoverCarouselPrefix.length,
                            (index) {
                              return GestureDetector(
                                onTapDown: (tapDownDetails) {
                                  _carouselController.stopAutoPlay();
                                },
                                onTapUp: (details) {
                                  _carouselController.startAutoPlay();
                                },
                                child: Image.asset(
                                  mockDiscoverCarouselPrefix[index],
                                  width: double.maxFinite,
                                  scale: 0.5,
                                  fit: BoxFit.cover,
                                ),
                              );
                              // return CachedNetworkImage(
                              //   imageUrl: myCarouselItems[index].image,
                              //   fadeInDuration: Duration.zero,
                              //   fadeOutDuration: Duration.zero,
                              //   width: double.maxFinite,
                              //   height: double.maxFinite,
                              //   filterQuality: FilterQuality.medium,
                              //   fit: BoxFit.cover,
                              //   // fit: BoxFit.contain,
                              //   placeholder: (context, url) {
                              //     return const PostShimmerPage();
                              //   },
                              //   errorWidget: (context, url, error) =>
                              //       const Icon(Icons.error),
                              // );
                            },
                          ),
                      carouselController: _carouselController,
                      options: CarouselOptions(
                        height: widget.height,
                        padEnds: false,
                        autoPlay: widget.autoPlay,
                        viewportFraction: 1,
                        aspectRatio: widget.aspectRatio,
                        initialPage: 0,
                        enableInfiniteScroll: true,
                        // myItems.length > 1 ? true : false,
                        onPageChanged: (index, reason) {
                          _currentIndex = index;
                          setState(() {});
                          // widget.onPageChanged(index, reason);
                        },
                        // scrollPhysics:
                        //     isPinchToZoom ? NeverScrollableScrollPhysics() : null,
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
                    )),
              ),

              // Positioned(
              //   top: 20,
              //   right: 20,
              //   child: GestureDetector(
              //     onTap: () {
              //       // setState(() {});
              //       _showCarousel.value = !_showCarousel.value;
              //     },
              //     child: Container(
              //       padding: const EdgeInsets.all(2.5),
              //       decoration: BoxDecoration(
              //         shape: BoxShape.circle,
              //         color: VmodelColors.black.withOpacity(0.3),
              //       ),
              //       child: const Icon(
              //         Icons.close,
              //         color: Colors.white,
              //       ),
              //     ),
              //   ),

              //   // IconButton(
              //   //   icon: Icon(Icons.close),
              //   //   color: Colors.white,
              //   //   onPressed: () {},
              //   // ),
              // ),
              addVerticalSpacing(10),
              VWidgetsCarouselIndicator(
                currentIndex: _currentIndex,
                totalIndicators: widget.children?.length ??
                    mockDiscoverCarouselPrefix.length,
              ),
            ],
          );
        });
  }
}
