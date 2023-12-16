import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vmodel/src/features/dashboard/dash/dashboard_ui.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/shared/buttons/primary_button.dart';
import 'package:vmodel/src/shared/loader/full_screen.dart';
import 'package:vmodel/src/vmodel.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/api/graphql_service.dart';

class OnboardingPhotoPage extends ConsumerStatefulWidget {
  const OnboardingPhotoPage({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<OnboardingPhotoPage> createState() =>
      _OnboardingPhotoPageState();
}

class _OnboardingPhotoPageState extends ConsumerState<OnboardingPhotoPage> {
  bool isUploaded = false;
  String uploadButtonTitle = 'Upload';

  File? _image;

  // This is the image picker
  final _picker = ImagePicker();
  // Implementing the image picker
  Future<void> _openImagePicker() async {
    final XFile? pickedImage =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: VmodelColors.background,
      appBar: AppBar(
        leading: const VWidgetsBackButton(),
        backgroundColor: VmodelColors.background,
        elevation: 0,
        iconTheme: IconThemeData(color: VmodelColors.mainColor),
      ),
      body: ProgressHUD(
        child: Builder(builder: (context) {
          return SingleChildScrollView(
            child: Column(
              children: [
                Center(
                    child: Text(
                  'Upload a profile photo',
                  style: promptTextStyle,
                )),
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: _openImagePicker,
                  child: Container(
                    height: 245,
                    width: 245,
                    decoration: const BoxDecoration(
                      color: VmodelColors.appBarShadowColor,
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: _image != null
                        ? CircleAvatar(
                            radius: 110,
                            backgroundImage: FileImage(
                              _image!,
                              // fit: BoxFit.cover,
                              //       scale: 100
                              // height: SizeConfig.screenWidth * 0.49,
                            ),
                          )
                        : Image.asset(
                            VmodelAssets1.logoTransparant,
                            height: SizeConfig.screenWidth * 0.49,
                          ),
                  ),
                ),
                addVerticalSpacing(SizeConfig.screenHeight * 0.275),
                //addVerticalSpacing(40),
                // Padding(
                //   padding: const VWidgetsPagePadding.horizontalSymmetric(18),
                //   child: VWidgetsPrimaryButton(
                //     onPressed: () {
                //       isUploaded = true;
                //       setState(() {
                //         uploadButtonTitle = 'Change';
                //       });
                //     },
                //     enableButton: true,
                //     buttonTitle: uploadButtonTitle,
                //   ),
                // ),
                // addVerticalSpacing(10),
                Padding(
                  padding: const VWidgetsPagePadding.horizontalSymmetric(18),
                  child: VWidgetsPrimaryButton(
                    onPressed: () async { HapticFeedback.lightImpact();
                      final progress = ProgressHUD.of(context);
                      final bytes = await _image!.readAsBytes();
                      String base64Image = base64Encode(bytes);
                      // print(bytes);
                      // final multipartFile = http.MultipartFile.fromBytes( 'profilePicture',
                      //   bytes,
                      //   filename: 'profile_picture.jpg',);
                      // MultipartFile( bytes,   filename: 'image.jpg');
                      // print(multipartFile);;
                      progress?.show();
                      final authNotifier = ref.read(authProvider.notifier);
                      await authNotifier.pictureUpdate(authNotifier.state.pk!,
                          base64Image, 'profilePicture');
                      progress?.dismiss();
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => const DashBoardView()));
                      // print(authNotifier.state.profilePicture);
                    },
                    enableButton: _image != null ? true : false,
                    buttonTitle: 'Continue',
                  ),
                ),

                // Image.network('https://vmodel-app.herokuapp.com/graphql/media/${ref.read(authProvider.notifier).state.profilePicture}'),
                addVerticalSpacing(40),
              ],
            ),

            // const Spacer(),
          );
        }),
      ),
    );
  }
}
