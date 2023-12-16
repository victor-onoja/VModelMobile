import 'dart:developer' as dev;
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image/image.dart' as img;

import 'package:cropperx/cropperx.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vmodel/src/features/create_posts/models/crop_model.dart';

import '../../../core/utils/costants.dart';
import '../../../core/utils/helper_functions.dart';
import '../../../vmodel.dart';

// final croppedDataProvider = StateProvider<Map<String, List<Uint8List>>>((ref) {
final stackIndexProvider = StateProvider<int>((ref) {
  return 0;
});

// final croppedImagesToUploadProviderx = StateProvider<List<Uint8List>>((ref) {
//   return [];
// });

final croppedImagesProvider =
    NotifierProvider<CroppedImagesToUploadNotifier, List<Uint8List>>(
        CroppedImagesToUploadNotifier.new);

class CroppedImagesToUploadNotifier extends Notifier<List<Uint8List>> {
  @override
  build() {
    return [];
  }

  void replaceAll(List<Uint8List> images) {
    state = images;
  }

  void removeImageAt(int index) {
    print('Removing image at $index');
    state.removeAt(index);
    state = [...state];
  }

  void clearAll() {
    state = [];
  }
}

class CropWidgetsNotifier extends Notifier<List<CropKeyModel>> {
  @override
  build() {
    return [];
  }

  addWidget(
      {required String assetId,
      required GlobalKey key,
      required Widget widget}) {
    final indx = state.indexWhere((element) => element.id == assetId);
    if (indx >= 0) {
      state[indx].isRemoved = false;
    } else {
      final newValue = CropKeyModel(id: assetId, key: key, cropView: widget);
      state.add(newValue);
    }
    updateCurrentIndex(assetId);
  }

  updateIfExists(String assetId) {
    final sss = state.indexWhere((element) => element.id == assetId);
    state[sss].isRemoved = false;
    // for(CropKeyModel ss in state) {
    //  if(ss.id == assetId) {
    //
    //  }
    // }
  }

  remove(int index, String currentSelectedId) {
    state[index].isRemoved = true;
    // if(index == 0) {
    //   ref.read(stackIndexProvider.notifier).state =
    // }
    updateCurrentIndex(currentSelectedId);
    for (var element in state) {
      print('removing index $index.......................${element.isRemoved}');
    }
  }

  updateCurrentIndex(String currentSelectedId) {
    final itemIndex =
        state.indexWhere((element) => element.id == currentSelectedId);
    ref.read(stackIndexProvider.notifier).state = itemIndex;
  }

  discardAll() {
    for (var element in state) {
      element.key.currentState?.dispose();
    }
    state.clear();
  }

  Future<void> process(Iterable<String> ids) async {
    // print('processing...........................$ids');
    // ref.read(croppedImagesToUploadProviderx.notifier).state = [];
    ref.read(croppedImagesProvider.notifier).clearAll();
    // VLoader.changeLoadingState(true);
    final List<Uint8List> allData = [];
    for (var vall in state) {
      // print(
      //     '${vall.id} isRemoved : ${vall.isRemoved} .......................... isContained: ${ids.contains(vall.id)}');
      // if (!vall.isRemoved && ids.contains(vall.id)) {
      if (ids.contains(vall.id)) {
        final data = await Cropper.crop(cropperKey: vall.key);
        if (data != null) {
          allData.add(data);
        }
      }
    }

    // print('returning size ${allData.length}..........................');

    // ref.read(croppedImagesToUploadProviderx.notifier).state = allData;
    ref.read(croppedImagesProvider.notifier).replaceAll(allData);
    // VLoader.changeLoadingState(false);
    // return allData;
  }

  Future<void> processSingle(GlobalKey key) async {
    // ref.read(croppedImagesToUploadProviderx.notifier).state = [];
    dev.log("[8sl2] Processing single");
    ref.read(croppedImagesProvider.notifier).clearAll();
    // VLoader.changeLoadingState(true);
    final List<Uint8List> allData = [];
    final data = await Cropper.crop(cropperKey: key);
    dev.log("[8sl2] cropped ${data?.length}");

    if (data != null) {
      // final sso = XFile.fromData(data);

      // dev.log("[8sl2] file len: ${await sso.length()}");
      final owow = await testCompressFile(data);
      // final imageCroppedBytes = img.Image.fromBytes(width: width, height: height, bytes: allData.)
      allData.add(owow);
    }
    // ref.read(croppedImagesToUploadProviderx.notifier).state = allData;
    ref.read(croppedImagesProvider.notifier).replaceAll(allData);
    // VLoader.changeLoadingState(false);
    // return allData;
  }

  List<Widget> nonRemoved() {
    List<Widget> theList = [];
    for (var sss in state) {
      if (!sss.isRemoved) {
        theList.add(sss.cropView);
      }
    }
    return theList;
  }

  // updateAt(int index) {
  // }
}

// class CropWidgetsNotifier extends Notifier<List<AssetEntity>> {
//   @override
//   build() {
//     return [];
//   }

//   addWidget(Uint8List newValue) {
//     state.add(newValue);
//   }

//   remove(int index) {
//     state.removeAt(index);
//   }

//   update() {}
// }

final croppedWidgetsProvider =
    NotifierProvider<CropWidgetsNotifier, List<CropKeyModel>>(() {
  return CropWidgetsNotifier();
});
