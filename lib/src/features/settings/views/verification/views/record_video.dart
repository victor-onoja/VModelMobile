import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vmodel/src/core/routing/navigator_1.0.dart';
import 'package:vmodel/src/core/utils/shared.dart';
import 'package:vmodel/src/features/settings/views/verification/views/submit_video.dart';
import 'package:vmodel/src/res/icons.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/shared/appbar/appbar.dart';

List<CameraDescription> cameras = [];

class RecordVideo extends StatefulWidget {
  final XFile image;
  const RecordVideo({Key? key, required this.image}) : super(key: key);

  @override
  State<RecordVideo> createState() => _RecordVideoState();
}

class _RecordVideoState extends State<RecordVideo> {
  CameraController? controller;

  XFile? videoFile;
  bool isRecording = false;

  getAvailableCamera() async {
    cameras = await availableCameras();
    setState(() {});
    controller = CameraController(
      cameras[1],
      ResolutionPreset.max,
    );
    controller!.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }

  @override
  void initState() {
    super.initState();
    if (mounted) {
      getAvailableCamera();
    }
  }

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const VWidgetsAppBar(
        appbarTitle: "Record a short video of yourself",
        appBarHeight: 50,
        elevation: 0.0,
        leadingIcon: VWidgetsBackButton(),
      ),
      body: controller?.value != null
          ? controller!.value.isInitialized
              ? SingleChildScrollView(
                  child: Padding(
                    padding: const VWidgetsPagePadding.horizontalSymmetric(
                      20,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        addVerticalSpacing(30),
                        Text(
                          "Please press record, then say (or sign) the yellow text and press stop when you’re done.",
                          style: Theme.of(context)
                              .textTheme
                              .displayMedium
                              ?.copyWith(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  color: VmodelColors.primaryColor),
                          textAlign: TextAlign.center,
                        ),
                        addVerticalSpacing(60),
                        Center(
                          child: Center(
                            child: SizedBox(
                                height: 400,
                                width: 430,
                                child: CameraPreview(
                                  controller!,
                                  child: Center(
                                      child: Text(
                                    "“Hi, my name is Sam”",
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayMedium
                                        ?.copyWith(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 30,
                                            color:
                                                VmodelColors.yellowTextColor),
                                    textAlign: TextAlign.center,
                                  )),
                                )),
                          ),
                        ),
                        addVerticalSpacing(40),
                        isRecording
                            ? GestureDetector(
                                onTap: () async {
                                  await controller!
                                      .stopVideoRecording()
                                      .then((value) {
                                    setState(() {
                                      videoFile = value;
                                    });
                                  });
                                  // ignore: use_build_context_synchronously
                                  navigateAndReplaceRoute(
                                      context,
                                      SubmitVideo(
                                        videoFile: videoFile!,
                                        image: widget.image,
                                      ));
                                  // await controller!.pauseVideoRecording();
                                },
                                child: Container(
                                  height: 60,
                                  width: 60,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white,
                                      border: Border.all(
                                          width: 2.5,
                                          color: VmodelColors.primaryColor)),
                                  child: Center(
                                      child: SvgPicture.asset(
                                    VIcons.pauseIcon,
                                    width: 30,
                                    height: 30,
                                  )),
                                ),
                              )
                            : GestureDetector(
                                onTap: () async {
                                  await controller!.startVideoRecording();
                                  setState(() {
                                    isRecording = true;
                                  });
                                },
                                child: Container(
                                  height: 60,
                                  width: 60,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white,
                                      border: Border.all(
                                          width: 2.5,
                                          color: VmodelColors.primaryColor)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Container(
                                      height: 60,
                                      width: 60,
                                      decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: VmodelColors.primaryColor),
                                      child: Center(
                                          child: SvgPicture.asset(
                                        VIcons.micIcon,
                                        height: 40,
                                        width: 40,
                                      )),
                                    ),
                                  ),
                                ),
                              ),
                      ],
                    ),
                  ),
                )
              : Container()
          : Container(),
    );
  }
}
