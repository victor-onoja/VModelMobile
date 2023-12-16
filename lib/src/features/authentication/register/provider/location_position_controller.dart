import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';

import '../../../../core/routing/navigator_1.0.dart';
import '../../../../core/utils/helper_functions.dart';
import '../../../../shared/popup_dialogs/confirmation_popup.dart';
import '../../../../shared/response_widgets/toast.dart';

final latLongProvider = AsyncNotifierProvider.family
    .autoDispose<LatLongNotifier, Position?, BuildContext>(LatLongNotifier.new);

class LatLongNotifier
    extends AutoDisposeFamilyAsyncNotifier<Position?, BuildContext> {
  Position? myPositon;
  @override
  build(context) async {
    await determinePosition().then((value) {
      // myPositon = value.latitude;
      // long = value.longitude;
      myPositon = value;
      return null;
    }).onError((String error, stackTrace) async {
      print('888^^^0000 $error');
      if (true) {
        if (error.contains('denied')) {
          await _showEnableLocationPopup(context,
              title: "Permission Access",
              description:
                  "VModel requires permission for location access to function "
                  "while on this page.",
              positiveCallback: Geolocator.openAppSettings);
          // print('^^^^^^^^============0000 $error');
          print('^^^^^^^^============0000 $error');
          ref.invalidateSelf();
        } else if (error.contains('disabled')) {
          await _showEnableLocationPopup(context,
              title: "Location Disabled",
              description:
                  'VModel requires location access for the proper functioning of '
                  'app. Please enable device location.',
              positiveCallback: Geolocator.openLocationSettings);
          print('^^^^^^^^============0000 $error');
          ref.invalidateSelf();
        }
      }

      return VWidgetShowResponse.showToast(ResponseEnum.warning,
          message: error);
    });
    return myPositon;
  }

  Future<void> _showEnableLocationPopup(BuildContext context,
      {required String title,
      required String description,
      required Future<bool> Function() positiveCallback}) async {
    await showDialog(
        context: context,
        builder: ((context) => VWidgetsConfirmationPopUp(
              popupTitle: title,
              popupDescription: description,
              onPressedYes: () async {
                //Calls to settings are not supported on the web
                if (kIsWeb) return;
                final res = await positiveCallback();
                if (res && context.mounted) {
                  goBack(context);
                }
                print('***^^^^^^^************ $res');
              },
              onPressedNo: () {
                Navigator.pop(context);
              },
            )));
  }
}
