import 'package:flutter/services.dart';
import 'package:vmodel/src/shared/response_widgets/toast.dart';

import '../costants.dart';

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}

class MaxHashtagsFormatter extends TextInputFormatter {
  final RegExp hashTagRegx = RegExp(r"\s#(\w+)", caseSensitive: false);
  // static final

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final count = hashTagRegx.allMatches(newValue.text).length;
    if (count > VConstants.maxPostHastagsAllowed) {
      // toastContainer(text: "Exceeded 50 hashtags");
      return oldValue;
    }

    return newValue;
  }
}
