import 'package:flutter/material.dart';
import 'package:vmodel/src/res/res.dart';

class BulletItem extends StatelessWidget {
  const BulletItem({Key? key, required this.text}) : super(key: key);

  final String text;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
            height: 8.0,
            width: 8.0,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              shape: BoxShape.circle,
            )),
        addHorizontalSpacing(10),
        Flexible(
          child: Text(
            text,
            style: Theme.of(context).textTheme.displayMedium?.copyWith(
                fontWeight: FontWeight.w500,
                fontSize: 14,
                color: Theme.of(context).primaryColor),
            maxLines: 2,
          ),
        ),
      ],
    );
  }
}
