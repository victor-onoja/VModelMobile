import 'package:flutter/material.dart';

class VWidgetsModalPill extends StatelessWidget {
  const VWidgetsModalPill({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 5,
      width: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Theme.of(context).primaryColor.withOpacity(.15),
      ),
    );
  }
}
