import 'package:flutter/material.dart';


class ReferAndEarnActionButton extends StatelessWidget {
  const ReferAndEarnActionButton({
    required this.onPressed,
    required this.title,
    super.key,
  });

  /// Title
  final String title;

  /// On Pressed
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        style: OutlinedButton.styleFrom(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            textStyle: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(color: Theme.of(context).primaryColor),
            side: BorderSide(color: Theme.of(context).primaryColor)),
        onPressed: onPressed,
        child: Text(
          title,
          style: Theme.of(context).textTheme.bodyLarge!,
        ));
  }
}
