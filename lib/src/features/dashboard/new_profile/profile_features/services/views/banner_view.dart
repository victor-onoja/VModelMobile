import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:vmodel/src/features/settings/views/booking_settings/models/service_image_model.dart';
import 'package:vmodel/src/shared/shimmer/post_shimmer.dart';
import 'package:vmodel/src/vmodel.dart';

class BannerView extends StatefulWidget {
  const BannerView({super.key, required this.urls, required this.index});
  final List<ServiceImageModel> urls;
  final int index;

  @override
  State<BannerView> createState() => _BannerViewState();
}

class _BannerViewState extends State<BannerView> {
  final CarouselController _controller = CarouselController();
  int _currentIndex = 0;
  List<ServiceImageModel> left = [];
  List<ServiceImageModel> right = [];

  @override
  void initState() {
    left = widget.urls.sublist(0, widget.index);
    right = widget.urls.sublist(widget.index, widget.urls.length);

    // bottom = widget.data!['bottom'];
    left = left.reversed.toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const Key centerKey = ValueKey('sliver-list');
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          leading: VWidgetsBackButton(
            buttonColor: Colors.white,
          ),
        ),
        backgroundColor: Colors.black,
        body: Center(
          child: SizedBox(
            height: 500,
            child: CustomScrollView(
              center: centerKey,
              scrollDirection: Axis.horizontal,
              slivers: [
                SliverList.builder(
                  itemCount: left.length,
                  itemBuilder: (context, index) => Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    child: CachedNetworkImage(
                        imageUrl: left[index].url!,
                        fadeInDuration: Duration.zero,
                        fadeOutDuration: Duration.zero,
                        width: SizerUtil.width,
                        height: 500,
                        fit: BoxFit.cover,
                        // fit: BoxFit.contain,
                        placeholder: (context, url) {
                          // return const PostShimmerPage();
                          return Padding(
                            padding: EdgeInsets.symmetric(horizontal: 5),
                            child: CachedNetworkImage(
                              imageUrl: left[index].thumbnail!,
                              fadeInDuration: Duration.zero,
                              fadeOutDuration: Duration.zero,
                              width: SizerUtil.width,
                              height: 500,
                              fit: BoxFit.cover,
                              placeholder: (context, url) {
                                return const PostShimmerPage();
                              },
                            ),
                          );
                        },
                        errorWidget: (context, url, error) =>
                            // const Icon(Icons.error),
                            const PostShimmerPage()),
                  ),
                ),
                SliverList.builder(
                  key: centerKey,
                  itemCount: right.length,
                  itemBuilder: (context, index) => Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    child: CachedNetworkImage(
                        imageUrl: right[index].url!,
                        fadeInDuration: Duration.zero,
                        fadeOutDuration: Duration.zero,
                        width: SizerUtil.width,
                        height: 500,
                        fit: BoxFit.cover,
                        // fit: BoxFit.contain,
                        placeholder: (context, url) {
                          // return const PostShimmerPage();
                          return Padding(
                            padding: EdgeInsets.symmetric(horizontal: 5),
                            child: CachedNetworkImage(
                              imageUrl: right[index].thumbnail!,
                              fadeInDuration: Duration.zero,
                              fadeOutDuration: Duration.zero,
                              width: SizerUtil.width,
                              height: 500,
                              fit: BoxFit.cover,
                              placeholder: (context, url) {
                                return const PostShimmerPage();
                              },
                            ),
                          );
                        },
                        errorWidget: (context, url, error) =>
                            // const Icon(Icons.error),
                            const PostShimmerPage()),
                  ),

                  //     Image.asset(
                  //   widget.imageList[index],
                  //   width: double.infinity,
                  //   height: double.infinity,
                  //   fit: BoxFit.cover,
                  // ),
                )
              ],
            ),
          ),
        ));
  }
}
