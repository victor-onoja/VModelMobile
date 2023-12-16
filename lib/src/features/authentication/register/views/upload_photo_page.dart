import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vmodel/src/features/dashboard/dash/dashboard_ui.dart';
import 'package:vmodel/src/res/icons.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/shared/buttons/primary_button.dart';
import 'package:vmodel/src/shared/rend_paint/render_svg.dart';
import 'package:vmodel/src/vmodel.dart';

import '../../../../core/controller/app_user_controller.dart';
import '../../../../core/utils/helper_functions.dart';
import '../provider/user_types_controller.dart';

class SignUpUploadPhotoPage extends ConsumerStatefulWidget {
  const SignUpUploadPhotoPage({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<SignUpUploadPhotoPage> createState() =>
      _OnboardingPhotoPageState();
}

class _OnboardingPhotoPageState extends ConsumerState<SignUpUploadPhotoPage> {
  bool isUploaded = false;
  String uploadButtonTitle = 'Upload';
  String? _imageFilename;

  File? _image;
  final isShowButtonLoading = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    final isBusinessAccount = ref.watch(isAccountTypeBusinessProvider);

    return Scaffold(
      // backgroundColor: VmodelColors.background,
      appBar: AppBar(
        leading: const VWidgetsBackButton(),
        // backgroundColor: VmodelColors.background,
        elevation: 0,
        iconTheme: IconThemeData(color: VmodelColors.mainColor),
      ),
      body: Column(
        children: [
          Center(
              child: Text(
            isBusinessAccount ? 'Upload image' : 'Upload a profile photo',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
          )),
          addVerticalSpacing(20),
          GestureDetector(
            // onTap: _openImagePicker,
            onTap: () {
              selectAndCropImage().then((value) async {
                _image = File('$value');
                setState(() {});
              });
            },
            child: Container(
                height: 200,
                width: 200,
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
                    : const RenderSvgWithoutColor(
                        svgPath: VIcons.vModelProfile,
                        svgHeight: 120,
                        svgWidth: 120,
                      )),
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
          const Spacer(),

          ValueListenableBuilder(
            valueListenable: isShowButtonLoading,
            builder: ((context, value, child) {
              return SizedBox(
                // padding: const VWidgetsPagePadding.horizontalSymmetric(0),
                width: 120,
                child: VWidgetsPrimaryButton(
                  showLoadingIndicator: value,
                  onPressed: () async {
                    HapticFeedback.lightImpact();
                    // final bytes = await _image!.readAsBytes();
                    // String base64Image = base64Encode(bytes);
                    // VLoader.changeLoadingState(true);
                    isShowButtonLoading.value = true;

                    if (_image != null && _image != "") {
                      await ref
                          .read(appUserProvider.notifier)
                          .uploadProfilePicture(_image!.path,
                              onProgress: (sent, total) {
                        final percentUploaded = (sent / total);
                        print(
                            '########## $_image\n [$percentUploaded%]  sent: $sent ---- total: $total');
                      });
                    }

                    // final authNotifier = ref.read(authProvider.notifier);
                    // userIDPk = authNotifier.state.pk!;
                    // final storePk =
                    //     VModelSharedPrefStorage().putInt('pk', userIDPk);
                    // final storeToken = VModelSharedPrefStorage()
                    //     .putString('token', authNotifier.state.token);
                    // await VCredentials.inst.storeUserCredentials(
                    //     authNotifier.state.token);

                    //
                    // Future.wait([storeToken, storePk]);
                    // await authNotifier.pictureUpdate(
                    //     authNotifier.state.pk!, base64Image, '${authNotifier.state.username}_$_imageFilename');
                    // VLoader.changeLoadingState(false);
                    isShowButtonLoading.value = false;
                    if (!mounted) return;
                    ref.invalidate(appUserProvider);
                    navigateAndRemoveUntilRoute(context, const DashBoardView());
                  },
                  enableButton: _image != null ? true : false,
                  buttonTitle: 'Continue',
                ),
              );
            }),
          ),

          // Image.network('https://vmodel-app.herokuapp.com/graphql/media/${ref.read(authProvider.notifier).state.profilePicture}'),
          addVerticalSpacing(40),
        ],
      ),
    );
  }
}
