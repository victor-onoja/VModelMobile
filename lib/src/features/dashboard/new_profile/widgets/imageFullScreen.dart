import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ImageFullScreen extends StatefulWidget {
  final String tag;
  final String url;
  const ImageFullScreen({super.key, required this.tag, required this.url});

  @override
  State<ImageFullScreen> createState() => _ImageFullScreenState();
}

class _ImageFullScreenState extends State<ImageFullScreen> {
  @override
  initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge, overlays: []);
    super.initState();
  }

  @override
  void dispose() {
    //SystemChrome.restoreSystemUIOverlays();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge,
        overlays: SystemUiOverlay.values);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          child: Stack(
            children: [
              Center(
                child: Hero(
                  tag: widget.tag,
                  child: CachedNetworkImage(
                    imageUrl: widget.url,
                    fadeInCurve: Curves.fastOutSlowIn,
                    fadeInDuration: Duration(milliseconds: 1000),
                    fadeOutDuration: Duration(milliseconds: 1000),
                  ),
                ),
              ),
              Positioned(
                right: 10,
                top: 10,
                child: IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(Icons.cancel, size: 30),
                  color: Theme.of(context).primaryColor.withOpacity(.5),
                ),
              )
            ],
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}
