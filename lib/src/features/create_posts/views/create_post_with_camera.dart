import 'dart:io';

import 'package:cropperx/cropperx.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vmodel/src/features/create_posts/views/create_post.dart';
import 'package:vmodel/src/res/colors.dart';
import 'package:vmodel/src/vmodel.dart';

import '../../../core/utils/enum/upload_ratio_enum.dart';
import '../../../res/icons.dart';
import '../controller/cropped_data_controller.dart';

final cropProcessingProvider = StateProvider((ref) => false);

class CreatePostWithCameraPicker extends ConsumerStatefulWidget {
  final File cameraImage;

  const CreatePostWithCameraPicker({super.key, required this.cameraImage});

  @override
  ConsumerState<CreatePostWithCameraPicker> createState() =>
      _CreatePostWithImagesMediaPickerState();
}

class _CreatePostWithImagesMediaPickerState
    extends ConsumerState<CreatePostWithCameraPicker> {
  // final picker = ImagePicker();

  UploadAspectRatio cropAspectRatio = UploadAspectRatio.square;
  final GlobalKey _cropperKey = GlobalKey(debugLabel: 'cropperKey');

  @override
  void initState() {
    super.initState();
  }

  // @override
  // void dispose() {
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    print(' --------post with camera :$widget.cameraImage --- ');

    return Scaffold(
      backgroundColor: Colors.black,
      // extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.black,
        leading: CloseButton(
          color: Colors.white,
          onPressed: () {
            ref.read(croppedWidgetsProvider.notifier).discardAll();
            goBack(context);
          },
        ),
      ),
      floatingActionButton: GestureDetector(
        onTap: () async {
          HapticFeedback.lightImpact();
          await ref
              .read(croppedWidgetsProvider.notifier)
              .processSingle(_cropperKey);
          if (context.mounted) {
            navigateToRoute(context,
                CreatePostPage(images: const [], aspectRatio: cropAspectRatio));
          }
          // }
        },
        child: Container(
          width: 84,
          height: 40,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: const Color.fromRGBO(238, 238, 238, 1)),
          child: Center(
            child: Text(
              "Continue",
              style: context.textTheme.displaySmall!.copyWith(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  color: VmodelColors.greyDeepText),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Column(
        children: [
          SizedBox(
              height: height * 0.7,
              width: double.maxFinite,
              child: Center(
                child: Cropper(
                  cropperKey: _cropperKey,
                  overlayType: OverlayType.rectangle,
                  aspectRatio: cropAspectRatio.ratio,
                  image: Image.file(
                    File(widget.cameraImage.path),
                  ),
                ),
              )),
          Expanded(
            child: controlIcons(height),
          ),
        ],
      ),
    );
  }

//Can be made a component to be reused on gallery post as well
  Widget controlIcons(double height) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 16,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 24,
                height: 20,
                decoration: BoxDecoration(
                  border: Border.all(
                      color: const Color.fromRGBO(238, 238, 238, 0.7)),
                ),
                child: Center(
                  child: Text(
                    cropAspectRatio.simpleName,
                    style: context.textTheme.displaySmall!.copyWith(
                        fontWeight: FontWeight.w400,
                        fontSize: 8,
                        color: VmodelColors.white),
                  ),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width / 3,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        onAspectRatioChanged(UploadAspectRatio.square);
                      },
                      child: SvgPicture.asset(
                        // selected == selectedSquare
                        cropAspectRatio == UploadAspectRatio.square
                            ? VIcons.squareFilled
                            : VIcons.squareOutline,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        onAspectRatioChanged(UploadAspectRatio.portrait);
                      },
                      child: SvgPicture.asset(
                        // selected == selectedPostrait
                        cropAspectRatio == UploadAspectRatio.portrait
                            ? VIcons.portraitFilled
                            : VIcons.portraitOutline,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        onAspectRatioChanged(UploadAspectRatio.pro);
                      },
                      child: SvgPicture.asset(
                        // selected == selectedPro
                        cropAspectRatio == UploadAspectRatio.pro
                            ? VIcons.proFilled
                            : VIcons.proOutline,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        onAspectRatioChanged(UploadAspectRatio.wide);
                      },
                      child: SvgPicture.asset(
                        // selected == selectedWidescreen
                        cropAspectRatio == UploadAspectRatio.wide
                            ? VIcons.wideFilled
                            : VIcons.wideOutline,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                width: 65,
                child: Text(
                  cropAspectRatio.apiValue.toUpperCase(),
                  style: context.textTheme.displaySmall!.copyWith(
                      fontWeight: FontWeight.w400,
                      fontSize: 10,
                      color: VmodelColors.white),
                  textAlign: TextAlign.end,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void onAspectRatioChanged(UploadAspectRatio ratio) {
    cropAspectRatio = ratio;
    setState(() {});
  }
}
