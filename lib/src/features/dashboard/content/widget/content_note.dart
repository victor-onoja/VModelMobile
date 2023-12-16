import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vmodel/src/res/colors.dart';
import 'package:vmodel/src/res/icons.dart';

class ContentNote extends StatefulWidget {
  const ContentNote({Key? key, required this.name, required this.rating})
      : super(key: key);

  final String name;
  final String rating;

  @override
  State<ContentNote> createState() => _ContentNoteState();
}

class _ContentNoteState extends State<ContentNote> {
  bool readMore = true;
  void showMore() {
    setState(() {
      readMore = !readMore;
    });
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Padding(
        padding: const EdgeInsets.only(left: 15, right: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              children: [
                Text(
                  widget.name,
                  style: textTheme.displayMedium!.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: Colors.white.withOpacity(0.8)),
                ),
                const SizedBox(
                  width: 8,
                ),
                SvgPicture.asset(VIcons.verifiedIcon),
                const SizedBox(
                  width: 10,
                ),
                SvgPicture.asset(VIcons.userIcon),
                const SizedBox(
                  width: 2,
                ),
                Text(
                  widget.rating,
                  style: textTheme.displayMedium!.copyWith(
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                      color: Colors.white.withOpacity(0.8)),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            RichText(
                text: TextSpan(children: [
              TextSpan(
                text: "Had a lot of fun working with the beautiful ",
                style: textTheme.displayMedium!.copyWith(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    color: Colors.white.withOpacity(0.8)),
              ),
              TextSpan(
                  text: 'Elena Michaels. ',
                  style: textTheme.displayMedium!.copyWith(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: VmodelColors.text2.withOpacity(0.8))),
              TextSpan(
                text: " It was an amazing experience . Here’s the ",
                style: textTheme.displayMedium!.copyWith(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    color: Colors.white.withOpacity(0.8)),
              ),
              if (readMore == true)
                TextSpan(
                    text: "results if the shoot. Download",
                    style: textTheme.displayMedium!.copyWith(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: Colors.white.withOpacity(0.8))),
              TextSpan(
                text: readMore == false ? " ..more" : " ..show less",
                recognizer: TapGestureRecognizer()..onTap = () => showMore(),
                style: Theme.of(context).textTheme.displayMedium!.copyWith(
                    color: VmodelColors.text2,
                    fontWeight: FontWeight.w500,
                    fontSize: 14),
              ),
            ])),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 6),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SvgPicture.asset(VIcons.waveIcon),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    'Burnaboy - Location',
                    style: textTheme.displayMedium!.copyWith(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: Colors.white.withOpacity(0.8)),
                  )
                ],
              ),
            )
          ],
        ));
  }
}
