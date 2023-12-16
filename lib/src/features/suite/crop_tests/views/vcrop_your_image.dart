import 'dart:io';
import 'dart:typed_data';
import 'dart:developer' as dev;

import 'package:crop_your_image/crop_your_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vmodel/src/res/res.dart';

import '../../../../core/utils/costants.dart';
import '../../../../core/utils/enum/album_type.dart';
import '../../../../core/utils/enum/upload_ratio_enum.dart';
import '../../../../core/utils/helper_functions.dart';
import '../../../../shared/response_widgets/toast.dart';
import '../../../../shared/text_fields/dropdown_text_normal.dart';
import '../../../create_posts/controller/create_post_controller.dart';
import '../../../dashboard/new_profile/controller/gallery_controller.dart';
import '../../../dashboard/new_profile/model/gallery_model.dart';

class VCropYourImage extends ConsumerStatefulWidget {
  const VCropYourImage({super.key, required this.image});

  final String image;

  @override
  _VCropYourImageState createState() => _VCropYourImageState();
}

class _VCropYourImageState extends ConsumerState<VCropYourImage> {
  // static const _images = const [
  //   'assets/images/city.png',
  //   'assets/images/lake.png',
  //   'assets/images/train.png',
  //   'assets/images/turtois.png',
  // ];

  GalleryModel? selectedAlbum;
  final _cropController = CropController();
  final _imageDataList = <Uint8List>[];
  final _aspectRatio = UploadAspectRatio.portrait;

  var _loadingImage = false;
  var _currentImage = 0;
  set currentImage(int value) {
    _cropController.aspectRatio = _aspectRatio.ratio;
    setState(() {
      _currentImage = value;
    });
    _cropController.image = _imageDataList[_currentImage];
  }

  var _isSumbnail = false;
  var _isCropping = false;
  var _isCircleUi = false;
  Uint8List? _croppedData;
  var _statusText = '';

  @override
  void initState() {
    _loadAllImages();
    super.initState();
  }

  Future<void> _loadAllImages() async {
    setState(() {
      _loadingImage = true;
    });
    // for (final assetName in _images) {
    _imageDataList.add(await _load(widget.image));
    // }
    setState(() {
      _loadingImage = false;
    });
  }

  Future<Uint8List> _load(String assetName) async {
    // final assetData = await rootBundle.load(assetName);
    // return assetData.buffer.asUint8List();
    final f = File(assetName);
    return await f.readAsBytes();
  }

  @override
  Widget build(BuildContext context) {
    final galleries = ref.watch(galleryProvider(null));
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Center(
        child: Visibility(
          visible: !_loadingImage && !_isCropping,
          child: Column(
            children: [
              if (_imageDataList.length >= 4)
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      // _buildSumbnail(_imageDataList[0]),
                      // const SizedBox(width: 16),
                      // _buildSumbnail(_imageDataList[1]),
                      // const SizedBox(width: 16),
                      // _buildSumbnail(_imageDataList[2]),
                      // const SizedBox(width: 16),
                      _buildSumbnail(_imageDataList[0]),
                    ],
                  ),
                ),
              Expanded(
                child: Visibility(
                  visible: _croppedData == null,
                  child: Stack(
                    children: [
                      if (_imageDataList.isNotEmpty) ...[
                        Crop(
                          controller: _cropController,
                          image: _imageDataList[_currentImage],
                          onCropped: (croppedData) async {
                            dev.log(
                                '[8ssl2] ${croppedData.length / VConstants.MB}');
                            final owow = await testCompressFile(croppedData);
                            setState(() {
                              _croppedData = croppedData;
                              _isCropping = false;
                            });
                          },
                          withCircleUi: _isCircleUi,
                          onStatusChanged: (status) => setState(() {
                            _statusText = <CropStatus, String>{
                                  CropStatus.nothing: 'Crop has no image data',
                                  CropStatus.loading:
                                      'Crop is now loading given image',
                                  CropStatus.ready: 'Crop is now ready!',
                                  CropStatus.cropping:
                                      'Crop is now cropping image',
                                }[status] ??
                                '';
                          }),
                          initialSize: 0.9,
                          // maskColor: null,
                          cornerDotBuilder: (size, edgeAlignment) =>
                              const SizedBox.shrink(),
                          interactive: true,
                          // fixArea: true,
                          radius: 0,
                          initialAreaBuilder: (rect) {
                            return Rect.fromLTRB(
                              rect.left + 24,
                              rect.top + 24,
                              rect.right - 24,
                              rect.bottom - 24,
                            );
                          },
                        ),
                        IgnorePointer(
                          child: Padding(
                            padding: const EdgeInsets.all(24),
                            child: Container(
                              decoration: BoxDecoration(
                                border:
                                    Border.all(width: 1.5, color: Colors.white),
                                // borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          ),
                        ),
                      ],
                      // Positioned(
                      //   right: 16,
                      //   bottom: 16,
                      //   child: GestureDetector(
                      //     onTapDown: (_) => setState(() => _isSumbnail = true),
                      //     onTapUp: (_) => setState(() => _isSumbnail = false),
                      //     child: CircleAvatar(
                      //       backgroundColor:
                      //           _isSumbnail ? Colors.blue.shade50 : Colors.blue,
                      //       child: Center(
                      //         child: Icon(Icons.crop_free_rounded),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                  replacement: Center(
                    child: _croppedData == null
                        ? SizedBox.shrink()
                        : Image.memory(_croppedData!),
                  ),
                ),
              ),
              addVerticalSpacing(16),
              if (_croppedData == null)
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.center,
                      //   children: [
                      //     IconButton(
                      //       icon: Icon(Icons.crop_7_5),
                      //       onPressed: () {
                      //         _isCircleUi = false;
                      //         _cropController.aspectRatio = 16 / 4;
                      //       },
                      //     ),
                      //     IconButton(
                      //       icon: Icon(Icons.crop_16_9),
                      //       onPressed: () {
                      //         _isCircleUi = false;
                      //         _cropController.aspectRatio = 16 / 9;
                      //       },
                      //     ),
                      //     IconButton(
                      //       icon: Icon(Icons.crop_5_4),
                      //       onPressed: () {
                      //         _isCircleUi = false;
                      //         _cropController.aspectRatio = 4 / 3;
                      //       },
                      //     ),
                      //     IconButton(
                      //       icon: Icon(Icons.crop_square),
                      //       onPressed: () {
                      //         _isCircleUi = false;
                      //         _cropController
                      //           ..withCircleUi = false
                      //           ..aspectRatio = 1;
                      //       },
                      //     ),
                      //     IconButton(
                      //         icon: Icon(Icons.circle),
                      //         onPressed: () {
                      //           _isCircleUi = true;
                      //           _cropController.withCircleUi = true;
                      //         }),
                      //   ],
                      // ),
                      // const SizedBox(height: 16),
                      Container(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              _isCropping = true;
                            });
                            _isCircleUi
                                ? _cropController.cropCircle()
                                : _cropController.crop();
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            child: Text('CROP IT!'),
                          ),
                        ),
                      ),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              if (_croppedData != null)
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      galleries.maybeWhen(
                          data: (values) {
                            final mData = values.where((element) {
                              return element.galleryType == AlbumType.portfolio;
                            }).toList();
                            return VWidgetsDropdownNormal(
                              hintText: "Select gallery...",
                              items: mData,
                              value: selectedAlbum,
                              validator: (val) {
                                if (val == null) {
                                  return 'Select gallery';
                                }
                                return null;
                              },
                              itemToString: (val) => val.name,
                              onChanged: (val) {
                                setState(() {
                                  // dropdownIdentifyValue = val;
                                  selectedAlbum = val;
                                });
                              },
                            );
                          },
                          orElse: () => Text('No data')),
                      Container(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () async {
                            if (selectedAlbum != null && _croppedData != null) {
                              await ref
                                  .read(createPostProvider(null).notifier)
                                  .createPost(
                                    albumId: selectedAlbum!.id,
                                    aspectRatio: _aspectRatio,
                                    // images: selectedFiles,
                                    rawBytes: [_croppedData!],
                                    caption: 'Created with new cropper!',
                                  );
                              VWidgetShowResponse.showToast(
                                  ResponseEnum.sucesss,
                                  message: "Post created successfully");
                              // if (context.mounted) {
                              //   navigateAndRemoveUntilRoute(
                              //       context, const DashBoardView());
                              // }
                            } else {
                              VWidgetShowResponse.showToast(ResponseEnum.failed,
                                  message: "Please select gallery");
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            child: Text('Post'),
                          ),
                        ),
                      ),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              const SizedBox(height: 16),
              Text(_statusText),
              const SizedBox(height: 16),
            ],
          ),
          replacement: const CircularProgressIndicator.adaptive(),
        ),
      ),
    );
  }

  Expanded _buildSumbnail(Uint8List data) {
    // Expanded _buildSumbnail(String data) {
    final index = -1;
    //_imageDataList.indexOf(data);
    return Expanded(
      child: InkWell(
        onTap: () {
          _croppedData = null;
          currentImage = index;
        },
        child: Container(
          height: 100,
          decoration: BoxDecoration(
            border: index == _currentImage
                ? Border.all(
                    width: 8,
                    color: Colors.blue,
                  )
                : null,
          ),
          child: Image.memory(
            data,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
