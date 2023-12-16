import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class VUtilsShare {
  static void onShare(BuildContext context, List imagePaths, String text,
      String subject) async {
    // A builder is used to retrieve the context immediately
    // surrounding the ElevatedButton.
    //
    // The context's `findRenderObject` returns the first
    // RenderObject in its descendent tree when it's not
    // a RenderObjectWidget. The ElevatedButton's RenderObject
    // has its position and size after it's built.
    final box = context.findRenderObject() as RenderBox?;

    // if (imagePaths.isNotEmpty) {
    //   final files = <XFile>[];
    //   for (var i = 0; i < imagePaths.length; i++) {
    //     files.add(XFile(imagePaths[i], name: 'vimages'));
    //   }
    //   await Share.shareXFiles(files,
    //       text: text,
    //       subject: subject,
    //       sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size);
    // } else {
    await Share.share(text,
        subject: subject,
        sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size);
    // }
  }
}
