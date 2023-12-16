import 'package:flutter/material.dart';
import 'package:vmodel/src/res/colors.dart';


class TextOption extends StatelessWidget {
  const TextOption({Key? key, required this.title, required this.onTap}) : super(key: key);

  final String title;
  final Function () onTap;
  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        const Divider(height: 30,),

        GestureDetector(
          onTap: onTap,
          child: Text(title,
            style: Theme.of(context).textTheme.displayMedium?.copyWith(fontWeight: FontWeight.w400,
                fontSize: 18, color: VmodelColors.blueTextColor), maxLines: 2,
          ),
        ),
      ],
    );
  }
}