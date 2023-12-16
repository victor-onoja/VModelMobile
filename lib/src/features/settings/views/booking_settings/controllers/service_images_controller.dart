// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/controller/discard_editing_controller.dart';
import '../../../../../core/utils/costants.dart';
import '../../../../../core/utils/helper_functions.dart';
import '../../../../../shared/response_widgets/toast.dart';
import '../models/banner_model.dart';

final serviceImagesProvider =
    NotifierProvider.autoDispose<ServiceImagesNotifier, List<BannerModel>>(
        ServiceImagesNotifier.new);

class ServiceImagesNotifier extends AutoDisposeNotifier<List<BannerModel>> {
  final int maxLimit = 10;
  @override
  build() {
    return [];
  }

  void addImages(List<BannerModel> images) {
    final int len = state.length;
    if (len > maxLimit) return;

    state = [...state, ...images.take(maxLimit - len)];
  }

  void removeImage(int index) {
    final newState = state;
    newState.removeAt(index);
    state = [...newState];
  }

  Future<void> pickImages() async {
    if (state.length >= VConstants.maxServiceBannerImages) {
      VWidgetShowResponse.showToast(ResponseEnum.warning,
          message:
              "Maximum of ${VConstants.maxServiceBannerImages} can be selected");
      return;
    }
    final pickedImages = await pickServiceImages();
    final banners =
        pickedImages.map((e) => BannerModel(file: e, isFile: true)).toList();
    addImages(banners);

    ref
        .read(discardProvider.notifier)
        .updateState('banners', newValue: [...banners]);
  }
}
