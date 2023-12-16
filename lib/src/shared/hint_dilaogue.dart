import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class HintDialogue extends StatefulWidget {
  const HintDialogue({super.key, this.onTapDialogue, required this.text});
  final VoidCallback? onTapDialogue;
  final String text;

  @override
  State<HintDialogue> createState() => _HintDialogueState();
}

class _HintDialogueState extends State<HintDialogue> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: SafeArea(
        child: GestureDetector(
          onTap: widget.onTapDialogue,
          child: Container(
            // constraints: BoxConstraints(maxWidth: 50),
            // width: 50,
            height: 30,
            margin:
                EdgeInsets.only(top: 10, bottom: 10, right: 10.w, left: 50.w),
            child: Text(
              widget.text,
              style: Theme.of(context)
                  .textTheme
                  .displayMedium
                  ?.copyWith(fontSize: 9.sp, fontWeight: FontWeight.w600),
            ),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Theme.of(context).scaffoldBackgroundColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  offset: Offset(0.0, 1.0), //(x,y)
                  blurRadius: 6.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
