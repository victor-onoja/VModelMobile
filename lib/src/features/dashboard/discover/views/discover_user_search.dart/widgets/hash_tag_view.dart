import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class HashTagView extends StatelessWidget {
  const HashTagView({
    super.key,
    required this.image,
    required this.title,
  });
  final String image;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
            image: CachedNetworkImageProvider(image), fit: BoxFit.cover),
      ),
      child: Container(
        padding: const EdgeInsets.fromLTRB(8, 0, 10, 10),
        alignment: Alignment.bottomCenter,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          // gradient: const LinearGradient(
          //   begin: Alignment.topCenter,
          //   end: Alignment.bottomCenter,
          //   stops: [0.6, 1],
          //   colors: [Colors.transparent, Colors.black87],
          // ),
        ),
        child: Text(
          title,
          style: Theme.of(context)
              .textTheme
              .displayMedium
              ?.copyWith(color: Colors.white, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
