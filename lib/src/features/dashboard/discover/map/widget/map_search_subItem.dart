import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vmodel/src/res/icons.dart';

class MapSearchSubItem extends StatelessWidget {
  const MapSearchSubItem({Key? key, required this.imagePath}) : super(key: key);
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Container(
      height: 270,
      width: 216,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          image: DecorationImage(
              image: AssetImage(
                imagePath,
              ),
              fit: BoxFit.cover)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Align(
              alignment: Alignment.topRight,
              child: SvgPicture.asset(
                VIcons.unsavedIcon,
                color: Colors.white,
                width: 25,
                height: 25,
              )),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                      "Samantha",
                      style: textTheme.displayMedium!.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: Colors.white),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text("from £100",
                      style: textTheme.displayMedium!.copyWith(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: Colors.white)),
                ],
              ),
              const SizedBox(
                height: 4,
              ),
              Text(
                "Face, Glamour, Runway, Beauty",
                style: textTheme.displayMedium!.copyWith(
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                    color: Colors.white),
                maxLines: 2,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
