import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vmodel/src/res/icons.dart';
import 'package:vmodel/src/res/res.dart';

class StartRatings extends StatelessWidget {
  const StartRatings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        "Star Rating",
        style: Theme.of(context).textTheme.displayMedium?.copyWith(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: VmodelColors.primaryColor,
            ),
      ),
      addVerticalSpacing(8),
       const Row(
        children: [
          Flexible(
              child: StarRatingWidget(
            title: "1",
          )),
          Flexible(
              child: StarRatingWidget(
            title: "2",
          )),
          Flexible(
              child: StarRatingWidget(
            title: "3",
          )),
          Flexible(
              child: StarRatingWidget(
            title: "4",
          )),
          Flexible(
              child: StarRatingWidget(
            title: "5",
          )),
        ],
      )
    ]);
  }
}

class StarRatingWidget extends StatefulWidget {
  const StarRatingWidget({Key? key, required this.title}) : super(key: key);

  final String title;
  @override
  _StarRatingWidgetState createState() => _StarRatingWidgetState();
}

class _StarRatingWidgetState extends State<StarRatingWidget> {
  bool checked = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          checked = !checked;
        });
      },
      child: Padding(
        padding: const EdgeInsets.only(right: 15),
        child: Container(
          height: 37,
          width: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: checked ? VmodelColors.primaryColor : VmodelColors.white,
            border: Border.all(
              width: 1,
              color: VmodelColors.primaryColor,
            ),
          ),
          child: Center(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 15,
                width: 15,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: checked
                        ? VmodelColors.white
                        : VmodelColors.primaryColor),
                child: Center(
                  child: SvgPicture.asset(
                    VIcons.star,
                    width: 14,
                    height: 14,
                    color: checked
                        ? VmodelColors.primaryColor
                        : VmodelColors.white,
                  ),
                ),
              ),
              addHorizontalSpacing(6),
              Text(widget.title,
                  style: Theme.of(context).textTheme.displayMedium?.copyWith(
                      fontSize: 14,
                      fontWeight: checked ? FontWeight.w700 : FontWeight.w500,
                      color: checked
                          ? VmodelColors.white
                          : VmodelColors.primaryColor)),
            ],
          )),
        ),
      ),
    );
  }
}
