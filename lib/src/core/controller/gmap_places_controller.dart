import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vmodel/src/core/models/places_model.dart';
import 'package:vmodel/src/core/utils/validators_mixins.dart';

import '../network/urls.dart';

final placeSearchQueryProvider = StateProvider<String?>((ref) {
  return null;
});

final suggestedPlacesProvider = AsyncNotifierProvider.autoDispose<
    SuggestedPlacesNotifier,
    List<AutocompletePrediction>>(SuggestedPlacesNotifier.new);

class SuggestedPlacesNotifier
    extends AutoDisposeAsyncNotifier<List<AutocompletePrediction>> {
  @override
  FutureOr<List<AutocompletePrediction>> build() async {
    final query = ref.watch(placeSearchQueryProvider);
    if (query.isEmptyOrNull) return [];
    return await _getLocationResults(query!) ?? [];
    // return [];
  }

  // Future<void> getPlaces() {

  // }

  Future<List<AutocompletePrediction>?> _getLocationResults(
      String query) async {
    print('Searching for query $query');

    Uri uri =
        Uri.https("maps.googleapis.com", "maps/api/place/autocomplete/json", {
      "input": query,
      // "input": "-33.873138,151.211276",
      "key": VUrls.mapsApiKey,
    });
    String? response = await getPlaces(uri);
    // print(response);

    if (response == null) {
      return null;
    }
    PlaceAutocompleteResponse result =
        PlaceAutocompleteResponse.parseAutocompleteResult(response);

    print('Searching for query ${result.predictions?.length}');
    return result.predictions;
  }

  static Future<String?> getPlaces(Uri uri,
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
