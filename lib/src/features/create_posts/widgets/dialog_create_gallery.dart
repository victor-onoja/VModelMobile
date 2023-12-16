import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/routing/navigator_1.0.dart';
import '../../../core/utils/enum/album_type.dart';
import '../../../core/utils/helper_functions.dart';
import '../../../core/utils/validators_mixins.dart';
import '../../../shared/popup_dialogs/textfield_popup.dart';
import '../../../shared/text_fields/primary_text_field.dart';
import '../../dashboard/new_profile/controller/gallery_controller.dart';

class CreateGalleryDialog extends ConsumerWidget {
  CreateGalleryDialog({Key? key, required this.isPolaroid}) : super(key: key);
  final int _maxLength = 20;
  final TextEditingController _controller = TextEditingController();
  final bool isPolaroid;
  // final fieldKey =  GlobalKey<FormFieldState>();
  bool _isValid = false;
  final showLoading = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return VWidgetsAddAlbumPopUp(
      controller: _controller,
      popupTitle: "Create a new gallery",
      buttonTitle: "Continue",
      showLoading: showLoading,
      // textFieldlabel: "Name:",
      customTextField: VWidgetsPrimaryTextFieldWithTitle(
        formatters: [
          LengthLimitingTextInputFormatter(_maxLength),
          // SentenceCaseFormatter()
        ],
        label: "Name:",
        isIncreaseHeightForErrorText: true,
        hintText: "Ex. Commercial",
        helperText: "$_maxLength characters maximum",
        // onChanged: (value) {
        //   if(value.isNotEmpty) {
        //     _controller.text = capitalizeFirst(_controller.text);
        //   }
        //
        // },
        validator: (String? value) {
          final message = VValidatorsMixin.isNotEmpty(value);
          _isValid = message == null;
          return message;
        },
        controller: _controller,
        //onSaved: (){},
      ),
      onPressed: () async {
        HapticFeedback.lightImpact();
//         if(_controller.text.isEmpty) {
//           V
// return;
//         }
        //VLoader.changeLoadingState(true);
        showLoading.value = true;

        if (_isValid) {
          final albumName = _controller.text.trim();
          await ref.read(galleryProvider(null).notifier).createAlbum(
              albumName, isPolaroid ? AlbumType.polaroid : AlbumType.portfolio);
          if (context.mounted) {
            goBack(context);
          }
        }

        // await ref
        //     .read(albumsProvider.notifier)
        //     .createAlbum(
        //         _controller.text.capitalizeFirst!
        //             .trim(),
        //         userIDPk!)
        //     .then((value) =>
        //         ref.refresh(myStreamProvider));

        //VLoader.changeLoadingState(false);
        showLoading.value = false;
      },
    );
  }
}

class SentenceCaseFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text.capitalizeFirstVExt,
      selection: newValue.selection,
    );
  }
}
