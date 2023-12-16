import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vmodel/src/core/models/app_user.dart';

import '../../../../../vmodel.dart';
import 'package:image/image.dart' as img;


class ImageGridSplitterPageFirst extends ConsumerStatefulWidget {
  const ImageGridSplitterPageFirst({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ImageGridSplitterPageState();
}

class _ImageGridSplitterPageState
    extends ConsumerState<ImageGridSplitterPageFirst> {
  final image = 'assets/images/discover_categories/cat_health_beauty.jpg';
  // final GlobalKey<State<StatefulWidget>>? cropperKey;
  final GlobalKey cropperKey = GlobalKey(debugLabel: 'cropperKey');

  @override
  Widget build(BuildContext context) {
    VAppUser? user;
    // final appUser = ref.watch(appUserProvider);

    // user = appUser.valueOrNull;

    return Scaffold(
      body: SafeArea(
        child: ClipRect(
          child: ColoredBox(
            color: Colors.green,
            child: Stack(
              alignment: Alignment.center,
              children: [
                RepaintBoundary(
                  // key: ,
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: LayoutBuilder(
                      builder: (_, constraint) {
                        return InteractiveViewer(
                          clipBehavior: Clip.none,
                          // transformationController: _transformationController,
                          constrained: false,
                          child: Builder(
                            builder: (context) {
                              // final imageStream = widget.image.image.resolve(
                              //   _imageConfiguration,
                              // );

                              return RotatedBox(
                                quarterTurns: 0,
                                child: Image.asset(image, fit: BoxFit.cover),
                              );
                            },
                          ),
                          minScale: 1,
                          maxScale: 4,
                          // onInteractionStart: widget.onScaleStart,
                          // onInteractionUpdate: widget.onScaleUpdate,
                          // onInteractionEnd: widget.onScaleEnd,
                        );
                      },
                    ),
                  ),
                ),
                // GridView.builder(
                //   itemCount: 9,
                //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                //     crossAxisCount: 3,
                //     mainAxisSpacing: 3,
                //     crossAxisSpacing: 3,
                //     childAspectRatio: 3 / 4,
                //   ),
                //   itemBuilder: (context, index) {
                //     return Cropper(
                //         backgroundColor: Colors.black,
                //         overlayColor: Colors.black,
                //         aspectRatio: 3 / 4,
                //         cropperKey: cropperKey,
                //         overlayType: OverlayType.rectangle,
                //         // rotationTurns: 1,
                //         image: Image.asset(image,
                //             fit: BoxFit.cover), // Image.memory(_imageToCrop!),
                //         onScaleStart: (details) {
                //           // todo: define started action.
                //         },
                //         onScaleUpdate: (details) {
                //           // todo: define updated action.
                //         },
                //         onScaleEnd: (details) {
                //           // todo: define ended action.
                //           // widget.crop();
                //         });
                //     // return Container(
                //     //   height: 100.h / 3,
                //     //   width: 100.w / 3,
                //     //   color: Colors.amber.withOpacity(0.3),
                //     // );
                //   },
                // ),
                Positioned.fill(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Divider(
                          // color: widget.overlayColor,
                          // thickness: widget.gridLineThickness,
                          ),
                      Divider(
                          // color: widget.overlayColor,
                          // thickness: widget.gridLineThickness,
                          ),
                    ],
                  ),
                ),
                Positioned.fill(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      VerticalDivider(
                          // color: widget.overlayColor,
                          // thickness: widget.gridLineThickness,
                          ),
                      VerticalDivider(
                          // color: widget.overlayColor,
                          // thickness: widget.gridLineThickness,
                          ),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    // final sss =
                    //     await DefaultAssetBundle.of(context).loadString(image);
                    // final imagee = img.decodeJpg(File(sss).readAsBytesSync());
                    final imagee = await decodeAsset(image);
                    if (imagee == null) {
                      print('[yyw] image was null');
                      return;
                    }
                    final pics = splitImage(imagee, 3, 3);
                    print('[yyw] number of pieces is ${pics.length}');
                    // navigateToRoute(
                    //     context,
                    //     SplitPiecesPage(
                    //       pieces: pics,
                    //     ));
                  },
                  child: Text('Split'),
                )
              ],
            ),
          ),
        ),
      ),
    );

    // return Scaffold(
    //   appBar: VWidgetsAppBar(
    //     appbarTitle: "Image Splitter",
    //     leadingIcon: const VWidgetsBackButton(),
    //     backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    //   ),
    //   body: Stack(
    //     alignment: AlignmentDirectional.center,
    //     children: [
    //       // Container(
    //       //   height: 100.h,
    //       //   width: 100.w,
    //       //   child:
    //       //       Image.asset(image, fit: BoxFit.fill),
    //       // ),
    //       Positioned.fill(
    //         child: Image.asset(image, fit: BoxFit.cover),
    //       ),
    //       GridView.builder(
    //         itemCount: 9,
    //         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    //           crossAxisCount: 3,
    //           mainAxisSpacing: 3,
    //           crossAxisSpacing: 3,
    //           childAspectRatio: 3 / 4,
    //         ),
    //         itemBuilder: (context, index) {

    //     Cropper(
    //   backgroundColor: Colors.black,
    //   overlayColor: Colors.black,
    //   aspectRatio: widget.aspectRatio.ratio,
    //   cropperKey: widget.cropperKey,
    //   overlayType: OverlayType.rectangle,
    //   rotationTurns: _rotationTurns,
    //   image: widget.entityImage, // Image.memory(_imageToCrop!),
    //   onScaleStart: (details) {
    //     // todo: define started action.
    //   },
    //   onScaleUpdate: (details) {
    //     // todo: define updated action.
    //   },
    //   onScaleEnd: (details) {
    //     // todo: define ended action.
    //     widget.crop();
    //   },
    //   // ),
    //           return Container(
    //             height: 100.h / 3,
    //             width: 100.w / 3,
    //             color: Colors.amber.withOpacity(0.3),
    //           );
    //         },
    //       )
    //     ],
    //   ),
    // );
  }

  Future<img.Image?> decodeAsset(String path) async {
    final data = await rootBundle.load(path);

    // Utilize flutter's built-in decoder to decode asset images as it will be
    // faster than the dart decoder.
    final buffer =
        await ui.ImmutableBuffer.fromUint8List(data.buffer.asUint8List());

    final id = await ui.ImageDescriptor.encoded(buffer);
    final codec = await id.instantiateCodec(
        targetHeight: id.height, targetWidth: id.width);

    final fi = await codec.getNextFrame();

    final uiImage = fi.image;
    final uiBytes = await uiImage.toByteData();

    final image = img.Image.fromBytes(
        width: id.width,
        height: id.height,
        bytes: uiBytes!.buffer,
        numChannels: 4);

    return image;
  }

  List<img.Image> splitImage(
      img.Image inputImage, int horizontalPieceCount, int verticalPieceCount) {
    img.Image image = inputImage;

    final pieceWidth = (image.width / horizontalPieceCount).round();
    final pieceHeight = (image.height / verticalPieceCount).round();
    final pieceList = List<img.Image>.empty(growable: true);

    print(
        '[yywx0] Image piece: (${pieceWidth},${pieceHeight}) width: ${image.width} and height: ${image.height}');
    int x = 0, y = 0;
    for (int i = 0; i < verticalPieceCount; i++) {
      for (int j = 0; j < horizontalPieceCount; j++) {
        print('[yywx1] Adding piece x: $x and y: $y');
        pieceList.add(img.copyCrop(image,
            x: x, y: y, width: pieceWidth, height: pieceHeight));
        x += pieceWidth;
      }
      x = 0;
      y += pieceHeight;
    }

    // for (var y = 0; y < image.height; y += pieceHeight) {
    //   for (var x = 0; x < image.width; x += pieceWidth) {
    //     print('[yywx2] Adding piece x: $x and y: $y');
    //     // pieceList.add(img.copyCrop(image,
    //     //     x: x, y: y, width: pieceWidth, height: pieceHeight));
    //   }
    // }

    return pieceList;
  }
}
