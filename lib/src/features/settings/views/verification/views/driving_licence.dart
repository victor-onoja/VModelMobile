import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:vmodel/src/core/routing/navigator_1.0.dart';
import 'package:vmodel/src/core/utils/shared.dart';
import 'package:vmodel/src/features/settings/views/verification/views/display_captured_driving-licence.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/shared/appbar/appbar.dart';

List<CameraDescription> cameras = [];

class UploadIdentityDocument extends StatefulWidget {
  const UploadIdentityDocument({Key? key}) : super(key: key);

  @override
  State<UploadIdentityDocument> createState() => _UploadIdentityDocumentState();
}

class _UploadIdentityDocumentState extends State<UploadIdentityDocument> {
  CameraController? controller;

  XFile? pictureFile;

  getAvailableCamera() async {
    cameras = await availableCameras();
    setState(() {});
    controller = CameraController(
      cameras[0],
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
        appbarTitle: "Driving licence",
        appBarHeight: 50,
        elevation: 0.0,
        leadingIcon: VWidgetsBackButton(),
      ),
      body: controller?.value != null
          ? !controller!.value.isInitialized
              ? Container()
              : SingleChildScrollView(
                  child: Padding(
                    padding: const VWidgetsPagePadding.horizontalSymmetric(
                      20,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        addVerticalSpacing(30),
                        Text(
                          "Make sure the front of your driving licence is in the frame.",
                          style: Theme.of(context)
                              .textTheme
                              .displayMedium
                              ?.copyWith(
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                // color: VmodelColors.primaryColor,
                              ),
                          textAlign: TextAlign.center,
                        ),
                        addVerticalSpacing(60),
                        Center(
                          child: Center(
                            child: Container(
                                height: 400,
                                width: 400,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20)),
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: CameraPreview(controller!))),
                          ),
                        ),
                        addVerticalSpacing(40),
                        GestureDetector(
                          onTap: () async {
                            pictureFile = await controller!.takePicture();
                            setState(() {});
                            // ignore: use_build_context_synchronously
                            navigateToRoute(context,
                                CapturedDrivingLicence(image: pictureFile!));
                          },
                          child: Container(
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                              border: Border.all(
                                width: 2.5,
                                // color: VmodelColors.primaryColor,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Container(
                                height: 60,
                                width: 60,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  // color: VmodelColors.primaryColor,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
          : Container(),
    );
  }
}
