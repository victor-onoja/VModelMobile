
import 'package:cropperx/cropperx.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';

import '../../../core/utils/enum/upload_ratio_enum.dart';

class CropperScreen extends StatefulWidget {
  const CropperScreen(
      {super.key,
      this.imageToCrop,
      required this.aspectRatio,
      required this.entityImage,
      required this.getCroppedImage,
      this.cropperKey,
      required this.crop});
  // final ValueChanged onAspectRatioChanged;
  final Uint8List? imageToCrop;
  final AssetEntityImage entityImage;
  final UploadAspectRatio aspectRatio;
  final ValueChanged<Uint8List> getCroppedImage;
  final VoidCallback crop;
  final GlobalKey<State<StatefulWidget>>? cropperKey;

  @override
  State<CropperScreen> createState() => _CropperScreenState();
}

class _CropperScreenState extends State<CropperScreen> {
  Uint8List? _imageToCrop;
  Uint8List? _croppedImage;
  final int _rotationTurns = 0;
  // final double _aspectRatio = 1;
  // final GlobalKey _cropperKey = GlobalKey(debugLabel: 'cropperKey');

  @override
  void initState() {
    super.initState();
    // widget.crop();
  }

  @override
  void dispose() {
    super.dispose();
    print('Disposing widget');
  }

  @override
  Widget build(BuildContext context) {
    return
        // Stack(listOfBytes
        // children: [
        // Positioned.fill(
        //   child:
        Cropper(
      backgroundColor: Colors.black,
      overlayColor: Colors.black,
      aspectRatio: widget.aspectRatio.ratio,
      cropperKey: widget.cropperKey,
      overlayType: OverlayType.rectangle,
      rotationTurns: _rotationTurns,
      image: widget.entityImage, // Image.memory(_imageToCrop!),
      onScaleStart: (details) {
        // todo: define started action.
      },
      onScaleUpdate: (details) {
        // todo: define updated action.
      },
      onScaleEnd: (details) {
        // todo: define ended action.
        widget.crop();
      },
      // ),
      //   ),

      //   const Center(
      //     child: CircularProgressIndicator(
      //       color: Colors.white,
      //       backgroundColor: Colors.black,
      //     ),
      //   ),
      // ],
    );
    // return Scaffold(
    //   body: SafeArea(
    //       child:
    //       // Column(
    //       //   children: [
    //       Cropper(
    //         overlayColor: Colors.redAccent.withOpacity(0.3),
    //         aspectRatio: getAspectRatio,
    //                 cropperKey: widget.cropperKey,
    //                 overlayType: OverlayType.rectangle,
    //                 rotationTurns: _rotationTurns,
    //                 image: widget.entityImage,// Image.memory(_imageToCrop!),
    //                 onScaleStart: (details) {
    //                   // todo: define started action.
    //                 },
    //                 onScaleUpdate: (details) {
    //                   // todo: define updated action.
    //                 },
    //                 onScaleEnd: (details) {
    //                   // todo: define ended action.
    //                 },
    //               )
    //         // const SizedBox(height: 16),
    //         // Wrap(
    //         //   spacing: 16,
    //         //   children: [
    //         //     ElevatedButton(
    //         //       child: const Text('Pick image'),
    //         //       onPressed: () async {
    //         //         final image = await _picker.pickImage(
    //         //           source: ImageSource.gallery,
    //         //         );
    //         //
    //         //         if (image != null) {
    //         //           final imageBytes = await image.readAsBytes();
    //         //           setState(() {
    //         //             _imageToCrop = imageBytes;
    //         //           });
    //         //         }
    //         //       },
    //         //     ),
    //         //     ElevatedButton(
    //         //       child: const Text('Switch overlay'),
    //         //       onPressed: () {
    //         //         setState(() {
    //         //           _overlayType = _overlayType == OverlayType.circle
    //         //               ? OverlayType.grid
    //         //               : _overlayType == OverlayType.grid
    //         //                   ? OverlayType.rectangle
    //         //                   : OverlayType.circle;
    //         //         });
    //         //       },
    //         //     ),
    //         //     ElevatedButton(
    //         //       child: const Text('Crop image'),
    //         //       onPressed: () async {
    //         //         final imageBytes = await Cropper.crop(
    //         //           cropperKey: _cropperKey,
    //         //         );
    //         //
    //         //         if (imageBytes != null) {
    //         //           setState(() {
    //         //             _croppedImage = imageBytes;
    //         //           });
    //         //         }
    //         //       },
    //         //     ),
    //         //     IconButton(
    //         //       onPressed: () {
    //         //         setState(() => _rotationTurns--);
    //         //       },
    //         //       icon: const Icon(Icons.rotate_left),
    //         //     ),
    //         //     IconButton(
    //         //       onPressed: () {
    //         //         setState(() => _rotationTurns++);
    //         //       },
    //         //       icon: const Icon(Icons.rotate_right),
    //         //     ),
    //         //   ],
    //         // ),
    //         // const SizedBox(height: 16),
    //         // if (_croppedImage != null)
    //         //   Padding(
    //         //     padding: const EdgeInsets.all(36.0),
    //         //     child: Image.memory(_croppedImage!),
    //         //   ),
    //     //   ],
    //     // ),
    //   ),
    // );
  }
}
