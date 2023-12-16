import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vmodel/src/core/routing/navigator_1.0.dart';
import 'package:vmodel/src/core/utils/helper_functions.dart';
import 'package:vmodel/src/features/create_posts/views/create_post_with_images.dart';
import 'package:vmodel/src/features/settings/widgets/settings_submenu_tile_widget.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/shared/loader/full_screen_dialog_loader.dart';
import 'package:vmodel/src/shared/modal_pill_widget.dart';

import '../../create_posts/views/create_post_with_camera.dart';

class VWidgetsVModelMainCreateAPostFunctionality extends StatelessWidget {
  const VWidgetsVModelMainCreateAPostFunctionality({super.key});

  @override
  Widget build(BuildContext context) {
    List vModelButtonItems = [
      VWidgetsSettingsSubMenuTileWidget(
        title: "Upload from Gallery",
        onTap: () async {
          popSheet(context);
          navigateToRoute(
              AppNavigatorKeys.instance.navigatorKey.currentContext!,
              const CreatePostWithImagesMediaPicker());
        },
      ),
      VWidgetsSettingsSubMenuTileWidget(
        title: "Upload from Camera",
        onTap: () async {
          popSheet(context);
          VLoader.changeLoadingState(true);
          // final imageData = await getImages(
          //     isCamera: true, isMultiple: false, isGallery: false);

          // print('-------$imageData-----------');

          var imageData = await pickImage(ImageSource.camera);

           print('-------$imageData-----------');


          VLoader.changeLoadingState(false);

          navigateToRoute(
              AppNavigatorKeys.instance.navigatorKey.currentContext!,
               CreatePostWithCameraPicker(cameraImage: imageData ,));
          // if (mounted) {
          // navigateToRoute(
          //     AppNavigatorKeys.instance.navigatorKey.currentContext!,
          //     // CreatePostPage(images: selectedImages));
          //     const CreatePostPage(
          //         images: [], aspectRatio: UploadAspectRatio.square));
          // }
        },
      ),
    ];
    return Column(
      // mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      // mainAxisSize: MainAxisSize.min,
      children: [
        addVerticalSpacing(15),
        const Align(alignment: Alignment.center, child: VWidgetsModalPill()),
        addVerticalSpacing(25),
        Expanded(
          child: ListView.separated(
              itemBuilder: ((context, index) => vModelButtonItems[index]),
              separatorBuilder: (context, index) => const Divider(),
              itemCount: vModelButtonItems.length),
        )
      ],
    );
  }
}
