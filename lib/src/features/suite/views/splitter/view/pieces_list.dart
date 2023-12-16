import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'dart:ui' as ui;
import 'package:image/image.dart' as imag;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:vmodel/src/core/utils/enum/upload_ratio_enum.dart';

import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/shared/appbar/appbar.dart';
import 'package:vmodel/src/shared/buttons/primary_button.dart';
import 'package:vmodel/src/shared/response_widgets/toast.dart';

import '../../../../../shared/buttons/normal_back_button.dart';

class SplitPiecesPage extends StatefulWidget {
  const SplitPiecesPage({super.key, required this.pieces});
  final List<imag.Image> pieces;

  @override
  State<SplitPiecesPage> createState() => _SplitPiecesPageState();
}

class _SplitPiecesPageState extends State<SplitPiecesPage> {
  GlobalKey _globalKey = GlobalKey();
  UploadAspectRatio cropAspectRatio = UploadAspectRatio.square;
  bool _showLoadingIndicator = false;

  List<File> _filesToSave = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: VWidgetsAppBar(
        appbarTitle: "Splitter",
        leadingIcon: const VWidgetsBackButton(),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: FutureBuilder(
          future: uiImageList(),
          builder: ((context, snapshot) {
            if (!snapshot.hasData) return Text('No data');

            return Column(
              children: [
                Expanded(
                  flex: 4,
                  child: GridView.builder(
                    itemCount: widget.pieces.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 0.5,
                      crossAxisSpacing: 0.5,
                      childAspectRatio: 3 / 4,
                    ),
                    itemBuilder: (ctxt, index) {
                      return getImageWidget(snapshot.data![index]);
                    },
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 45,
                            child: VWidgetsPrimaryButton(
                              onPressed: _showLoadingIndicator
                                  ? null
                                  : () {
                                      _saveImageToAlbum();
                                      _showLoadingIndicator = true;
                                      if (mounted) setState(() {});
                                    },
                              showLoadingIndicator: _showLoadingIndicator,
                              buttonTitle: "Save",
                              buttonColor: Theme.of(context)
                                  .buttonTheme
                                  .colorScheme
                                  ?.secondary,
                              buttonTitleTextStyle: Theme.of(context)
                                  .textTheme
                                  .displayMedium!
                                  .copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: Theme.of(context).primaryColor,
                                  ),
                            ),
                          ),
                        ),
                        addHorizontalSpacing(20),
                        Expanded(
                          child: VWidgetsPrimaryButton(
                            onPressed: () {},
                            buttonTitle: "Post",
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                addVerticalSpacing(30),
              ],
            );
          })),
    );
  }

  Future<File> convertImageToUint8List(imag.Image image, int time) async {
    final png = imag.encodePng(image);
    int timestamp = DateTime.now().millisecondsSinceEpoch;
    await File(
      '${(await getApplicationSupportDirectory()).path}${"vmodel$time"}/${timestamp}.png',
    ).create(recursive: true);
    final _file2 = File(
      '${(await getApplicationSupportDirectory()).path}${"vmodel$time"}/${timestamp}.png',
    );
    return await File(_file2.path).writeAsBytes(png);
  }

  Future _saveImageToAlbum() async {
    int _timestamp = DateTime.now().millisecondsSinceEpoch;
    _filesToSave.clear();
    if (widget.pieces.isNotEmpty) {
      Permission.storage.request();
      // setState(() => _showLoadingIndicator = true);
      for (var index = 0; index < widget.pieces.length; index++) {
        var file =
            await convertImageToUint8List(widget.pieces[index], _timestamp);

        _filesToSave.add(file);
      }
      print(_filesToSave.length);
      for (var data in _filesToSave) await GallerySaver.saveImage(data.path);
      _showLoadingIndicator = false;
      if (mounted) setState(() {});
      VWidgetShowResponse.showToast(ResponseEnum.sucesss,
          message: "Images saved");
      Navigator.pop(context);
    }
  }

  Widget getImageWidget(ui.Image item) {
    return RawImage(
      image: item,
      fit: BoxFit.cover,
    );
  }

  Future<List<ui.Image>> uiImageList() async {
    final List<ui.Image> dList = [];

    for (imag.Image x in widget.pieces) {
      final item = await convertImageToFlutterUi(x);
      dList.add(item);
    }
    return dList;
  }

  Future<ui.Image> convertImageToFlutterUi(imag.Image image) async {
    if (image.format != imag.Format.uint8 || image.numChannels != 4) {
      final cmd = imag.Command()
        ..image(image)
        ..convert(format: imag.Format.uint8, numChannels: 4);
      final rgba8 = await cmd.getImageThread();
      if (rgba8 != null) {
        image = rgba8;
      }
    }

    ui.ImmutableBuffer buffer =
        await ui.ImmutableBuffer.fromUint8List(image.toUint8List());

    ui.ImageDescriptor id = ui.ImageDescriptor.raw(buffer,
        height: image.height,
        width: image.width,
        pixelFormat: ui.PixelFormat.rgba8888);

    ui.Codec codec = await id.instantiateCodec(
        targetHeight: image.height, targetWidth: image.width);

    ui.FrameInfo fi = await codec.getNextFrame();
    ui.Image uiImage = fi.image;

    return uiImage;
  }
}
