import 'package:flutter/material.dart';

class DetailsFloatingContainer extends StatelessWidget {
  final String details;
  final Offset position;

  DetailsFloatingContainer({required this.details, required this.position});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      child: Container(
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 3,
              blurRadius: 7,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Text(
          details,
          style: Theme.of(context).textTheme.displayMedium?.copyWith(
                color: Theme.of(context).primaryColor,
                fontSize: 12,
              ),
        ),
      ),
    );
  }
}
