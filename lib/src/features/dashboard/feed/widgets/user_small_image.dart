import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class UserSmallImage extends StatefulWidget {
  const UserSmallImage(
      {Key? key,
      this.height = 29,
      required this.imageUrl,
      this.marginRight = 6,
      this.width = 29,
      this.marginBottom = 0})
      : super(key: key);
  final double? height;
  final double width;
  final double marginBottom;
  final double marginRight;
  final String imageUrl;
  @override
  UserSmallImageState createState() => UserSmallImageState();
}

class UserSmallImageState extends State<UserSmallImage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      width: widget.width,
      alignment: Alignment.center,
      padding: const EdgeInsets.all(0),
      margin: EdgeInsets.only(
          right: widget.marginRight, top: 1, bottom: widget.marginBottom),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        shape: BoxShape.circle,
      ),
      child: Container(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          decoration: const BoxDecoration(shape: BoxShape.circle),
          child: CachedNetworkImage(
            imageUrl: widget.imageUrl,
            width: 26,
            height: 26,
            fit: BoxFit.cover,
            placeholderFadeInDuration: Duration.zero,
            fadeInDuration: Duration.zero,
            fadeOutDuration: Duration.zero,
          )),
    );
  }
}
