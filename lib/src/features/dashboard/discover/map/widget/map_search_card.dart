import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vmodel/src/res/colors.dart';
import 'package:vmodel/src/res/icons.dart';
import 'package:vmodel/src/shared/rend_paint/render_svg.dart';

class MapSearchCard extends StatefulWidget {
  final int initialPage;
  const MapSearchCard({Key? key, required this.initialPage}) : super(key: key);

  @override
  State<MapSearchCard> createState() => _MapSearchCardState();
}

class _MapSearchCardState extends State<MapSearchCard> {
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ScrollingImage(
            initialPage: widget.initialPage,
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Samantha",
                style: textTheme.displayMedium!.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                  color: VmodelColors.text,
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const RenderSvg(
                    svgPath: VIcons.stars,
                    svgWidth: 10,
                    svgHeight: 10,
                  ),
                  const SizedBox(
                    width: 6,
                  ),
                  Text(
                    "4.9",
                    style: textTheme.displayMedium!.copyWith(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: VmodelColors.text,
                    ),
                  ),
                ],
              )
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          Row(
            children: [
              Expanded(
                child: Text(
                  "Face, Glamour, Runway, Beauty",
                  style: textTheme.displayMedium!.copyWith(
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                    color: VmodelColors.text,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Text(
                '2 miles',
                style: textTheme.displayMedium!.copyWith(
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                  color: VmodelColors.text,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            "from £100",
            style: textTheme.displayMedium!.copyWith(
              fontWeight: FontWeight.w600,
              fontSize: 14,
              color: VmodelColors.text,
            ),
          ),
        ],
      ),
    );
  }
}

class ScrollingImage extends StatefulWidget {
  const ScrollingImage({Key? key, required this.initialPage}) : super(key: key);
  final int initialPage;

  @override
  State<ScrollingImage> createState() => _ScrollingImageState();
}

class _ScrollingImageState extends State<ScrollingImage> {
  int _current = 0;
  final CarouselController _controller = CarouselController();

  List<String> images = [
    'assets/images/models/model_11.png',
    'assets/images/models/model01.png',
    'assets/images/models/model02.png',
    'assets/images/models/model_11.png',
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 394,
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(15)),
            child: CarouselSlider(
              items: List.generate(
                images.length,
                (index) => Image.asset(
                  images[index],
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              carouselController: _controller,
              options: CarouselOptions(
                viewportFraction: 1,
                aspectRatio: 1,
                initialPage: widget.initialPage,
                enableInfiniteScroll: false,
                onPageChanged: (value, reason) {
                  setState(() {
                    _current = value;
                  });
                },
                height: 470,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: images.asMap().entries.map((entry) {
                  return GestureDetector(
                    onTap: () => _controller.animateToPage(entry.key),
                    child: Container(
                      width: 8.0,
                      height: 8.0,
                      margin: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 4.0),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _current == entry.key
                              ? Colors.white
                              : const Color.fromRGBO(255, 255, 255, 0.6)),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                child: SvgPicture.asset(
                  VIcons.unsavedIcon,
                  color: Colors.white,
                  width: 25,
                  height: 25,
                ),
              )),
        ],
      ),
    );
  }
}
