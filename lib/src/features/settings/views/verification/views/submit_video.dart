import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:vmodel/src/core/routing/navigator_1.0.dart';
import 'package:vmodel/src/core/utils/shared.dart';
import 'package:vmodel/src/features/jobs/job_market/views/job_market_offer_accepted.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/shared/appbar/appbar.dart';
import 'package:vmodel/src/shared/buttons/primary_button.dart';

class SubmitVideo extends StatefulWidget {
  final XFile image;
  const SubmitVideo({Key? key, required this.image, required this.videoFile})
      : super(key: key);

  final XFile videoFile;
  @override
  State<SubmitVideo> createState() => _SubmitVideoState();
}

class _SubmitVideoState extends State<SubmitVideo> {
  late VideoPlayerController _videoController;

  playVideo(XFile video) {
    _videoController = VideoPlayerController.file(File(video.path))
      ..initialize().then((_) {
        _videoController.setLooping(false);
        _videoController.pause();
        setState(() {});
      });
  }

  int taps = 0;
  @override
  void initState() {
    super.initState();
    playVideo(widget.videoFile);
  }

  @override
  void dispose() {
    _videoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const VWidgetsAppBar(
        appbarTitle: "Selfie Video",
        appBarHeight: 50,
        elevation: 0.0,
        leadingIcon: VWidgetsBackButton(),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const VWidgetsPagePadding.horizontalSymmetric(
            20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              addVerticalSpacing(30),
              Text(
                "Great! Check your video is easy to see and hear before you press send.",
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color: VmodelColors.primaryColor),
                textAlign: TextAlign.center,
              ),
              addVerticalSpacing(60),
              Center(
                child: Center(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _videoController.value.isPlaying
                            ? _videoController.pause()
                            : _videoController.play();
                      });
                    },
                    child: Container(
                      height: 400,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20)),
                      child: VideoPlayer(_videoController),
                    ),
                  ),
                ),
              ),
              addVerticalSpacing(60),
              VWidgetsPrimaryButton(
                onPressed: () {
                  navigateAndReplaceRoute(
                      context,
                      VerifyNationalID(
                        image: widget.image,
                      ));
                },
                buttonTitle: "Submit video",
                enableButton: true,
              ),
              addVerticalSpacing(20),
              GestureDetector(
                onTap: () {
                  goBack(context);
                },
                child: Text(
                  "Retake video",
                  style: Theme.of(context).textTheme.displayMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: VmodelColors.primaryColor),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
