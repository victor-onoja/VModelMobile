import 'dart:ui' as ui;

import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:vmodel/src/core/models/app_user.dart';
import 'package:vmodel/src/core/utils/helper_functions.dart';
import 'package:vmodel/src/core/utils/validators_mixins.dart';

import '../../../../shared/appbar/appbar.dart';
import '../../../../shared/buttons/primary_button.dart';
import '../../../../vmodel.dart';
import 'package:image/image.dart' as img;

import 'vcrop_your_image.dart';

enum selectedSplitEnum { oneThree, twoThree, threeThree, fourThree }

class CropTestPage extends ConsumerStatefulWidget {
  const CropTestPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CropTestPageState();
}

class _CropTestPageState extends ConsumerState<CropTestPage> {
  final image = 'assets/images/discover_categories/cat_health_beauty.jpg';
  String? _image;
  final List _imageList = [];
  final List _splitOptions = [];
  // final GlobalKey<State<StatefulWidget>>? cropperKey;
  final GlobalKey cropperKey = GlobalKey(debugLabel: 'cropperKey');
  bool _shoeLoading = false;
  selectedSplitEnum selectedSplit = selectedSplitEnum.threeThree;
  int splitHeight = 3;
  int splitWidtht = 3;

  @override
  Widget build(BuildContext context) {
    VAppUser? user;
    // final appUser = ref.watch(appUserProvider);

    // user = appUser.valueOrNull;

    return Scaffold(
      appBar: VWidgetsAppBar(
        appbarTitle: "Crop Test",
        leadingIcon: const VWidgetsBackButton(),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: _image.isEmptyOrNull
          ? Center(
              child: VWidgetsPrimaryButton(
              onPressed: () async {
                var data = await imagePicker();
                if (data!.isNotEmpty) {
                  _image = data;
                }
                if (mounted) setState(() {});
              },
              buttonTitle: "Upload",
              butttonWidth: SizerUtil.width * .5,
            ))
          : SafeArea(
              left: false,
              right: false,
              child: Column(
                children: [
                  Expanded(
                    child: VCropYourImage(
                      image: _image ?? '',
                    ),
                  ),
                  // Expanded(
                  //   child: Column(
                  //     children: [
                  //       Flexible(
                  //         flex: 2,
                  //         child: CropperMine(
                  //           // backgroundColor: Colors.black,
                  //           // overlayColor: Colors.black,
                  //           // aspectRatio: widget.aspectRatio.ratio,
                  //           gridRowCount: splitHeight,
                  //           aspectRatio: 3 / 4,
                  //           cropperKey: cropperKey,
                  //           overlayType: OverlayType.grid,
                  //           // rotationTurns: _rotationTurns,
                  //           image: Image.file(
                  //             File(_image!),
                  //             fit: BoxFit.fitHeight,
                  //           ), // Image.memory(_imageToCrop!),
                  //           onScaleStart: (details) {
                  //             // todo: define started action.
                  //           },
                  //           onScaleUpdate: (details) {
                  //             // todo: define updated action.
                  //           },
                  //           onScaleEnd: (details) {
                  //             // todo: define ended action.
                  //             // widget.crop();
                  //           },
                  //         ),
                  //       ),

                  //       // if (_shoeLoading)
                  //       //       Center(
                  //       //           child: CircularProgressIndicator.adaptive())

                  //       addVerticalSpacing(20),
                  //       VWidgetsPrimaryButton(
                  //         butttonWidth: SizerUtil.width * .5,
                  //         buttonColor: Theme.of(context)
                  //             .buttonTheme
                  //             .colorScheme
                  //             ?.secondary,
                  //         buttonTitleTextStyle: Theme.of(context)
                  //             .textTheme
                  //             .displayMedium!
                  //             .copyWith(
                  //               fontWeight: FontWeight.w600,
                  //               color: Theme.of(context).primaryColor,
                  //             ),
                  //         onPressed: () async {
                  //           var data = await imagePicker();
                  //           if (data!.isNotEmpty) {
                  //             _image = data;
                  //           }
                  //           if (mounted) setState(() {});
                  //         },
                  //         buttonTitle: 'Select Image',
                  //       ),
                  //       addVerticalSpacing(30),
                  //       VWidgetsPrimaryButton(
                  //         onPressed: () async {
                  //           setState(() {
                  //             _shoeLoading = true;
                  //           });
                  //           // final sss =
                  //           //     await DefaultAssetBundle.of(context).loadString(image);
                  //           // final imagee = img.decodeJpg(File(sss).readAsBytesSync());
                  //           final data =
                  //               await CropperMine.crop(cropperKey: cropperKey);

                  //           // final imagee = await decodeAsset(image);
                  //           final imagee = await decodeAsset('',
                  //               memImage: data!,
                  //               isFromMemory: true); // hImage.memory(data!);
                  //           if (imagee == null) {
                  //             return;
                  //           }
                  //           final pics =
                  //               splitImage(imagee, splitHeight, splitWidtht);
                  //           setState(() {
                  //             _shoeLoading = false;
                  //           });
                  //         },
                  //         buttonTitle: "Crop & Post",
                  //         butttonWidth: SizerUtil.width * .5,
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  // Padding(
                  //   padding: const EdgeInsets.all(8.0),
                  //   child: Column(
                  //     children: [
                  //       Row(
                  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //         children: [
                  //           BusinessInfoTagWidget(
                  //               isSelected:
                  //                   selectedSplit == selectedSplitEnum.oneThree
                  //                       ? true
                  //                       : false,
                  //               text: '1x3',
                  //               onPressed: () {
                  //                 splitHeight = 1;
                  //                 splitWidtht = 3;
                  //                 selectedSplit = selectedSplitEnum.oneThree;
                  //                 setState(() {});
                  //               }),
                  //           BusinessInfoTagWidget(
                  //               isSelected:
                  //                   selectedSplit == selectedSplitEnum.twoThree
                  //                       ? true
                  //                       : false,
                  //               text: '2x3',
                  //               onPressed: () {
                  //                 splitHeight = 2;
                  //                 splitWidtht = 3;
                  //                 selectedSplit = selectedSplitEnum.twoThree;
                  //                 setState(() {});
                  //               }),
                  //           BusinessInfoTagWidget(
                  //               isSelected: selectedSplit ==
                  //                       selectedSplitEnum.threeThree
                  //                   ? true
                  //                   : false,
                  //               text: '3x3',
                  //               onPressed: () {
                  //                 splitHeight = 3;
                  //                 splitWidtht = 3;
                  //                 selectedSplit = selectedSplitEnum.threeThree;
                  //                 setState(() {});
                  //               }),
                  //           BusinessInfoTagWidget(
                  //               isSelected:
                  //                   selectedSplit == selectedSplitEnum.fourThree
                  //                       ? true
                  //                       : false,
                  //               text: '4x3',
                  //               onPressed: () {
                  //                 splitHeight = 4;
                  //                 splitWidtht = 3;
                  //                 selectedSplit = selectedSplitEnum.fourThree;
                  //                 setState(() {});
                  //               }),
                  //         ],
                  //       ),
                  //       addVerticalSpacing(20),
                  //       VWidgetsPrimaryButton(
                  //         butttonWidth: SizerUtil.width * .5,
                  //         buttonColor: Theme.of(context)
                  //             .buttonTheme
                  //             .colorScheme
                  //             ?.secondary,
                  //         buttonTitleTextStyle: Theme.of(context)
                  //             .textTheme
                  //             .displayMedium!
                  //             .copyWith(
                  //               fontWeight: FontWeight.w600,
                  //               color: Theme.of(context).primaryColor,
                  //             ),
                  //         onPressed: () async {
                  //           setState(() {
                  //             _shoeLoading = true;
                  //           });
                  //           // final sss =
                  //           //     await DefaultAssetBundle.of(context).loadString(image);
                  //           // final imagee = img.decodeJpg(File(sss).readAsBytesSync());
                  //           final data =
                  //               await CropperMine.crop(cropperKey: cropperKey);

                  //           // final imagee = await decodeAsset(image);
                  //           final imagee = await decodeAsset('',
                  //               memImage: data!,
                  //               isFromMemory: true); // hImage.memory(data!);
                  //           if (imagee == null) {
                  //             return;
                  //           }
                  //           final pics =
                  //               splitImage(imagee, splitHeight, splitWidtht);
                  //           setState(() {
                  //             _shoeLoading = false;
                  //           });
                  //         },
                  //         buttonTitle: 'Split',
                  //       ),
                  //     ],
                  //   ),
                  // ),
                ],
              ),
            ),
    );
  }

  Future<img.Image?> decodeAsset(String path,
      {Uint8List? memImage, bool isFromMemory = false}) async {
    late final ImmutableBuffer buffer;

    if (!isFromMemory) {
      final data = await rootBundle.load(path);

      // Utilize flutter's built-in decoder to decode asset images as it will be
      // faster than the dart decoder.
      buffer =
          await ui.ImmutableBuffer.fromUint8List(data.buffer.asUint8List());
    } else {
      buffer = await ui.ImmutableBuffer.fromUint8List(memImage!);
    }

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
