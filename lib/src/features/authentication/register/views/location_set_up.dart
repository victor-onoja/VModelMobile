import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:vmodel/src/core/utils/helper_functions.dart';
import 'package:vmodel/src/features/settings/views/verification/views/blue-tick/widgets/text_field.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/shared/appbar/appbar.dart';
import 'package:vmodel/src/shared/buttons/primary_button.dart';
import 'package:vmodel/src/vmodel.dart';

import '../../../../core/controller/app_user_controller.dart';
import '../../../../shared/popup_dialogs/confirmation_popup.dart';
import '../../../../shared/response_widgets/toast.dart';
import '../provider/location_position_controller.dart';
import 'signup_display_name_setup.dart';

// class SignUpLocationViews extends ConsumerWidget {
//   const SignUpLocationViews({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     ref.watch(registerProvider);

//     final notifierR = ref.watch(registerProvider.notifier);

//     return Scaffold(
//       appBar: const VWidgetsAppBar(
//         appbarTitle: "",
//         elevation: 0,
//         leadingIcon: VWidgetsBackButton(),
//       ),
//       body: Padding(
//         padding:
//             const EdgeInsets.only(left: 25.0, right: 25, top: 20, bottom: 25),
//         child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               addVerticalSpacing(150),
//               Text(
//                 'What city are you in?',
//                 style: VModelTypography1.promptTextStyle
//                     .copyWith(fontWeight: FontWeight.w600, fontSize: 14.sp),
//               ),
//               addVerticalSpacing(8),
//               addVerticalSpacing(20),
//               SizedBox(
//                 height: 42,
//                 child: VWidgetsTextFieldWithoutTitle(
//                   controller: notifierR.locationTextField,
//                   // maxLines: 1,
//                   hintText: 'Eg: London, United Kingdom',

//                   onSaved: (p0) {},
//                   onChanged: (p0) {},
//                   onFieldSubmitted: (p0) {},
//                 ),
//               ),
//               const Spacer(),
//               vWidgetsInitialButton(
//                 () {
//                   print(signUpUserType);
//                   navigateToRoute(
//                       context,
//                       signUpUserType == "Business"
//                           ? const SignUpWebSiteView()
//                           : const SignUpPriceViews());
//                 },
//                 'Continue',
//               ),
//             ]),
//       ),
//     );
//   }
// }

class SignUpLocationViews extends ConsumerStatefulWidget {
  const SignUpLocationViews({
    super.key,
    this.initialValue,
    this.isLocationUpdate = false,
  });
  final String? initialValue;
  final bool isLocationUpdate;

  @override
  ConsumerState<SignUpLocationViews> createState() =>
      _SignUpLocationViewsState();
}

class _SignUpLocationViewsState extends ConsumerState<SignUpLocationViews> {
  final String apiKey = "AIzaSyCKdIyABKpYZWDwnkhKD8D2n_0JTAW3Hj8";
  TextEditingController locController = TextEditingController();
  final isShowButtonLoading = ValueNotifier(false);

  List<AutocompletePrediction> placePredictions = [];

  void placeAutoComplete(String query) async {
    Uri uri =
        Uri.https("maps.googleapis.com", "maps/api/place/autocomplete/json", {
      "input": query,
      "key": apiKey,
    });
    String? response = await NetworkUtility.fetchUrl(uri);

    if (response != null) {
      print(response);
      PlaceAutocompleteResponse result =
          PlaceAutocompleteResponse.parseAutocompleteResult(response);

      if (result.predictions != null) {
        setState(() {
          placePredictions = result.predictions!;
        });
      }
    }
  }

  @override
  void initState() {
    // getLongLat(showDialog: true);
    locController.text = widget.initialValue ?? '';
    super.initState();
  }

  double long = 0.0;
  double lat = 0.0;
  Future<void> getLongLat({bool showDialog = false}) async {
    // Position getPosition = await determinePosition();
    await determinePosition().then((value) {
      lat = value.latitude;
      long = value.longitude;
      return null;
    }).onError((String error, stackTrace) async {
      print('888^^^0000 $error');
      if (showDialog) {
        if (error.contains('denied')) {
          await _showEnableLocationPopup(context,
              title: "Permission Access",
              description:
                  "VModel requires permission for location access to function "
                  "while on this page.",
              positiveCallback: Geolocator.openAppSettings);
        } else if (error.contains('disabled')) {
          await _showEnableLocationPopup(context,
              title: "Location Disabled",
              description:
                  'VModel requires location access for the proper functioning of '
                  'app. Please enable device location.',
              positiveCallback: Geolocator.openLocationSettings);
        }
        isShowButtonLoading.value = false;
      }

      return VWidgetShowResponse.showToast(ResponseEnum.warning,
          message: error);
    });

    // print('GetLongLat function ${getPosition.toJson()}');
    // setState(() {
    //   lat = getPosition.latitude;
    //   long = getPosition.longitude;
    // });
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(appUserProvider);
    final position = ref.watch(latLongProvider(context));

    return WillPopScope(
      onWillPop: () async {
        if (!widget.isLocationUpdate) moveAppToBackGround();
        return true;
      },
      child: Scaffold(
        appBar: VWidgetsAppBar(
            appbarTitle: "", elevation: 0, leadingIcon: VWidgetsBackButton()
            // leadingIcon: widget.isLocationUpdate
            //     ? VWidgetsBackButton()
            //     : SizedBox.shrink(),
            // leadingIcon: SizedBox.shrink(),
            ),
        body: Padding(
          padding: const VWidgetsPagePadding.horizontalSymmetric(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'What city are you in?',
                style: context.textTheme.bodyMedium
                    ?.copyWith(fontWeight: FontWeight.w600, fontSize: 14.sp),
              ),
              addVerticalSpacing(8),
              VWidgetsTextFieldNormal(
                // label: "",
                hintText: "Search your location",
                controller: locController,
                onChanged: (value) {
                  placeAutoComplete(value ?? '');
                },
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: placePredictions.length,
                  itemBuilder: (context, index) => LocationListTile(
                    press: () {
                      setState(() {
                        locController.text =
                            placePredictions[index].description!;
                        placePredictions = [];
                      });
                    },
                    location: placePredictions[index].description!,
                  ),
                ),
              ),
              addVerticalSpacing(12),
              ValueListenableBuilder(
                  valueListenable: isShowButtonLoading,
                  builder: ((context, value, child) {
                    return VWidgetsPrimaryButton(
                      buttonTitle: "Continue",
                      showLoadingIndicator: value,
                      onPressed: () async {
                        HapticFeedback.lightImpact();
                        print('+++++++++>>>>>>> Contingue called');
                        // VLoader.changeLoadingState(true);
                        isShowButtonLoading.value = true;
                        if (widget.isLocationUpdate) {
                          //Todo (Ernest): call user location update mutation
                          print('+++++++++>>>>>>> if block');
                          // VLoader.changeLoadingState(false);
                          if (mounted) {
                            if (lat == 0 && long == 0) {
                              print('+++++++++>>>>>>> else block no latlong');
                              await getLongLat(showDialog: true);
                            }
                            await ref
                                .read(appUserProvider.notifier)
                                .updateUserLocation(
                                    // lat: lat,
                                    // lon: long,
                                    lat: 0,
                                    lon: 0,
                                    locationName: locController.text.trim());
                            // VLoader.changeLoadingState(false);
                            isShowButtonLoading.value = false;
                            goBack(context);
                          }
                        } else {
                          // await registerRepoInstance.updateUserLocation(
                          //     userIDPk!, locController.text, long, lat, signUpUserType);
                          print('+++++++++>>>>>>> else block');
                          if (lat == 0 && long == 0) {
                            print('+++++++++>>>>>>> else block no latlong');
                            // await determinePosition()
                            //     .onError((String error, stackTrace) {
                            //   if (error.contains('denied')) {
                            //     _showEnableLocationPopup(context,
                            //         title: "Permission Access",
                            //         description:
                            //             "VModel requires permission for location access to function "
                            //             "while on this page.",
                            //         positiveCallback: Geolocator.openAppSettings);
                            //   } else if (error.contains('disabled')) {
                            //     _showEnableLocationPopup(context,
                            //         title: "Location Disabled",
                            //         description:
                            //             'VModel requires location access for the proper functioning of '
                            //             'app. Please enable device location.',
                            //         positiveCallback: Geolocator.openLocationSettings);
                            //   }
                            //   return VWidgetShowResponse.showToast(ResponseEnum.warning,
                            //       message: '$error');
                            // });
                            await getLongLat(showDialog: true);
                          }

                          print('+++++++++>>>>>>> second check $lat: $long');
                          if (lat == 0 && long == 0) {
                            return;
                          }
                          await ref
                              .read(appUserProvider.notifier)
                              .updateUserLocation(
                                  lat: 0,
                                  lon: 0,
                                  // lat: lat,
                                  // lon: long,
                                  locationName: locController.text.trim());
                          // VLoader.changeLoadingState(false);
                          isShowButtonLoading.value = false;

                          if (mounted) {
                            navigateToRoute(
                                context, const SignUpDisplayNameSetup());

                            // navigateToRoute(
                            //     context,
                            //     isBusinessAccount
                            //         ? const SignUpWebSiteView()
                            //         // : const SignUpPriceViews());
                            // : const SignUpUploadPhotoPage());
                          }
                        }
                      },
                      enableButton: true,
                    );
                  })),
              addVerticalSpacing(40),
            ],
          ),
        ),
      ),
    );
  }

  // void _saveLocation() {}

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
                if (res && mounted) {
                  goBack(context);
                }
                print('***^^^^^^^************ $res');
              },
              onPressedNo: () {
                Navigator.pop(context, false);
              },
            )));
  }
}

class NetworkUtility {
  static Future<String?> fetchUrl(Uri uri,
      {Map<String, String>? headers}) async {
    try {
      final response = await http.get(uri, headers: headers);
      if (response.statusCode == 200) {
        return response.body;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }
}

/// The Autocomplete response contains place predictions and status
class PlaceAutocompleteResponse {
  final String? status;
  final List<AutocompletePrediction>? predictions;

  PlaceAutocompleteResponse({this.status, this.predictions});

  factory PlaceAutocompleteResponse.fromJson(Map<String, dynamic> json) {
    return PlaceAutocompleteResponse(
      status: json['status'] as String?,
      predictions: json['predictions'] != null
          ? json['predictions']
              .map<AutocompletePrediction>(
                  (json) => AutocompletePrediction.fromJson(json))
              .toList()
          : null,
    );
  }

  static PlaceAutocompleteResponse parseAutocompleteResult(
      String responseBody) {
    final parsed = json.decode(responseBody).cast<String, dynamic>();

    return PlaceAutocompleteResponse.fromJson(parsed);
  }
}

class AutocompletePrediction {
  /// [description] contains the human-readable name for the returned result. For establishment results, this is usually
  /// the business name.
  final String? description;

  /// [structuredFormatting] provides pre-formatted text that can be shown in your autocomplete results
  final StructuredFormatting? structuredFormatting;

  /// [placeId] is a textual identifier that uniquely identifies a place. To retrieve information about the place,
  /// pass this identifier in the placeId field of a Places API request. For more information about place IDs.
  final String? placeId;

  /// [reference] contains reference.
  final String? reference;

  AutocompletePrediction({
    this.description,
    this.structuredFormatting,
    this.placeId,
    this.reference,
  });

  factory AutocompletePrediction.fromJson(Map<String, dynamic> json) {
    return AutocompletePrediction(
      description: json['description'] as String?,
      placeId: json['place_id'] as String?,
      reference: json['reference'] as String?,
      structuredFormatting: json['structured_formatting'] != null
          ? StructuredFormatting.fromJson(json['structured_formatting'])
          : null,
    );
  }
}

class StructuredFormatting {
  /// [mainText] contains the main text of a prediction, usually the name of the place.
  final String? mainText;

  /// [secondaryText] contains the secondary text of a prediction, usually the location of the place.
  final String? secondaryText;

  StructuredFormatting({this.mainText, this.secondaryText});

  factory StructuredFormatting.fromJson(Map<String, dynamic> json) {
    return StructuredFormatting(
      mainText: json['main_text'] as String?,
      secondaryText: json['secondary_text'] as String?,
    );
  }
}

class LocationListTile extends StatelessWidget {
  const LocationListTile({
    Key? key,
    required this.location,
    required this.press,
  }) : super(key: key);

  final String location;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          onTap: press,
          horizontalTitleGap: 0,
          leading: SvgPicture.asset("assets/icons/location_pin.svg"),
          title: Text(
            location,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const Divider(
          height: 1,
          thickness: 1,
        ),
      ],
    );
  }
}
