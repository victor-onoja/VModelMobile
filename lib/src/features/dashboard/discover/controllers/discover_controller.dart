// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vmodel/src/features/dashboard/new_profile/model/gallery_model.dart';

import '../../../../core/models/app_user.dart';
import '../../../../core/utils/costants.dart';
import '../models/discover_all_sections_model.dart';
import '../models/discover_item.dart';
import '../repository/discover_repo.dart';

final searchControllerProvider =
    Provider.autoDispose((ref) => TextEditingController());

final searchUsersProvider =
    StateProvider.autoDispose<AsyncValue<List<VAppUser>>>(
        (ref) => const AsyncData([]));
final discoverProvider =
    AsyncNotifierProvider<DiscoverController, DiscoverSectionsDataModel?>(
        () => DiscoverController());

// final featuredTalentsProvider = FutureProvider((ref) async {
//   return DiscoverController().getFeaturedTalentList();
// });

final feaaturedListProvider =
    FutureProvider<List<DiscoverItemObject>>((ref) async {
  List<DiscoverItemObject> rv = [];
  List newList = await DiscoverController()
      .feaaturedList(VConstants.discoverSectionItemsCount, 1);

  newList.forEach((e) {
    rv.add(DiscoverItemObject.fromMap(e)
        // DiscoverItemObject(
        //   e['firstName'],
        //   e['profilePictureUrl'],
        //   '4.9',
        //   e['bio'] ?? "",
        //   e['age'] ?? "",
        //   e['ethnicity'] ?? "",
        //   e['height']?['value'] ?? "",
        //   e['gender'] ?? "",
        //   e['label'] ?? "",
        //   e['price'] ?? "",
        //   e['location']?['locationName'] ?? "",
        //   e['hair'] ?? "",
        //   e['username'],
        // ),
        );
  });
  return rv;
});

final risingTalentsProvider =
    FutureProvider<List<DiscoverItemObject>>((ref) async {
  List<DiscoverItemObject> rv = [];
  List newList = await DiscoverController()
      .risingTalent(VConstants.discoverSectionItemsCount, 1);

  newList.forEach((e) {
    // rv.add(
    rv.add(DiscoverItemObject.fromMap(e)
        // DiscoverItemObject(
        //   e['firstName'],
        //   e['profilePictureUrl'],
        //   '4.9',
        //   e['bio'] ?? "",
        //   e['age'] ?? "",
        //   e['ethnicity'] ?? "",
        //   e['height']?['value'] ?? "",
        //   e['gender'] ?? "",
        //   e['label'] ?? "",
        //   e['price'] ?? "",
        //   e['location']?['locationName'] ?? "",
        //   e['hair'] ?? "",
        //   e['username'],
        // ),
        );
  });
  return rv;
});

final petModelProvider = FutureProvider<List<DiscoverItemObject>>((ref) async {
  List<DiscoverItemObject> rv = [];
  List newList = await DiscoverController()
      .petModels(VConstants.discoverSectionItemsCount, 1);

  newList.forEach((e) {
    rv.add(DiscoverItemObject.fromMap(e)
        // DiscoverItemObject(
        //   e['firstName'],
        //   e['profilePictureUrl'],
        //   '4.9',
        //   e['bio'] ?? "",
        //   e['age'] ?? "",
        //   e['ethnicity'] ?? "",
        //   e['height']?['value'] ?? "",
        //   e['gender'] ?? "",
        //   e['label'] ?? "",
        //   e['price'] ?? "",
        //   e['location']?['locationName'] ?? "",
        //   e['hair'] ?? "",
        //   e['username'],
        // ),
        );
  });
  return rv;
});

final photographersProvider =
    FutureProvider<List<DiscoverItemObject>>((ref) async {
  List<DiscoverItemObject> rv = [];
  List newList = await DiscoverController()
      .photographers(VConstants.discoverSectionItemsCount, 1);

  newList.forEach((e) {
    rv.add(DiscoverItemObject.fromMap(e)
        // DiscoverItemObject(
        //   e['firstName'],
        //   e['profilePictureUrl'],
        //   '4.9',
        //   e['bio'] ?? "",
        //   e['age'] ?? "",
        //   e['ethnicity'] ?? "",
        //   e['height']?['value'] ?? "",
        //   e['gender'] ?? "",
        //   e['label'] ?? "",
        //   e['price'] ?? "",
        //   e['location']?['locationName'] ?? "",
        //   e['hair'] ?? "",
        //   e['username'],
        // ),
        );
  });
  return rv;
});

class DiscoverController extends AsyncNotifier<DiscoverSectionsDataModel?> {
  // final List<VAppUser> searchResults = [];
  var searchController;
  final List<VAppUser> searchResults = [];
  String _latestSearchText = '';

  Future feaaturedList(int pageCount, int pageNumber) async {
    print('FFFFFFFFFFFFFFFF rebuild calculation state');
    final discoverRepoInstance = DiscoverRepository.instance;

    final response =
        await discoverRepoInstance.getFeaturedTalents(pageCount, pageNumber);

    return response.fold((left) {
      // VWidgetShowResponse.showToast(ResponseEnum.sucesss,
      //     message: 'Failed to get featured list');
      return [];
    }, (right) {
      final dList = right;

      print('--- dlist -----$dList ----- ');

      return dList as List;
    });
  }

  Future risingTalent(int pageCount, int pageNumber) async {
    print('FFFFFFFFFFFFFFFF rebuild calculation state');
    final discoverRepoInstance = DiscoverRepository.instance;

    final response =
        await discoverRepoInstance.getRisingTalents(pageCount, pageNumber);

    return response.fold((left) {
      // VWidgetShowResponse.showToast(ResponseEnum.sucesss,
      //     message: 'Failed to get featured list');
      return [];
    }, (right) {
      final dList = right;

      print('--- dlist -----$dList ----- ');

      return dList as List;
    });
  }

  Future rT() async {
    print('FFFFFFFFFFFFFFFF rebuild calculation state');
    final discoverRepoInstance = DiscoverRepository.instance;

    final response = await discoverRepoInstance.getRT(4, 4);

    return response.fold((left) {
      // VWidgetShowResponse.showToast(ResponseEnum.sucesss,
      //     message: 'Failed to get featured list');
      return [];
    }, (right) {
      final dList = right[''];

      print('--- dlist -----$dList ----- ');

      return dList as List;
    });
  }

  Future photographers(int pageCount, int pageNumber) async {
    print('FFFFFFFFFFFFFFFF rebuild calculation state');
    final discoverRepoInstance = DiscoverRepository.instance;

    final response =
        await discoverRepoInstance.getPhotographers(pageCount, pageNumber);

    return response.fold((left) {
      // VWidgetShowResponse.showToast(ResponseEnum.sucesss,
      //     message: 'Failed to get featured list');
      return [];
    }, (right) {
      final dList = right;

      print('--- dlist -----$dList ----- ');

      return dList as List;
    });
  }

  Future populartalents(int pageCount, int pageNumber) async {
    print('FFFFFFFFFFFFFFFF rebuild calculation state');
    final discoverRepoInstance = DiscoverRepository.instance;

    final response =
        await discoverRepoInstance.getPopularTalents(pageCount, pageNumber);

    return response.fold((left) {
      // VWidgetShowResponse.showToast(ResponseEnum.sucesss,
      //     message: 'Failed to get popular list');
      return [];
    }, (right) {
      final dList = right;

      print('--- dlist -----$dList ----- ');

      return dList as List;
    });
  }

  Future petModels(int pageCount, int pageNumber) async {
    print('FFFFFFFFFFFFFFFF rebuild calculation state');
    final discoverRepoInstance = DiscoverRepository.instance;

    final response =
        await discoverRepoInstance.getPetModels(pageCount, pageNumber);

    return response.fold((left) {
      // VWidgetShowResponse.showToast(ResponseEnum.sucesss,
      //     message: 'Failed to get featured list');
      return [];
    }, (right) {
      final dList = right;

      print('--- dlist -----$dList ----- ');

      return dList as List;
    });
  }

  int _dataCount = 5;

  @override
  Future<DiscoverSectionsDataModel?> build() async {
    final response =
        await DiscoverRepository.instance.getExplore(dataCount: _dataCount);
    return response.fold((left) {
      print('On Left error fetching from explore: ${left.message}');
      return null;
    }, (right) {
      print('[kkl]');
      return DiscoverSectionsDataModel.fromMap(right);
    });
  }

  Future<List<VAppUser>> searchUsers(String searchQuery) async {
    print('[pxp] search for: $searchQuery');

    _latestSearchText = searchQuery;

    // _searchTimer = Timer(const Duration(milliseconds: 1000), () async {});
    if (searchQuery.isEmpty) {
      ref.read(searchUsersProvider.notifier).state = const AsyncData([]);
      return [];
    }

    ref.read(searchUsersProvider.notifier).state = const AsyncLoading();
    try {
      final response = await discoverRepoInstance.searchUsers(searchQuery);
      return response.fold((left) {
        print('On Left error searching users: ${left.message}');
        return [];
      }, (right) {
        print('On Rignt searching users: $right');

        // final users = right.map((data) => SearchUserModel.fromMap(data));
        final users = right.map((data) => VAppUser.fromMinimalMap(data));
        // for (var v in users) {
        //   print('Leingth: ${users.length}   user is ${v.username}');
        // }
        // print('[pp =========&&&&&&&&&&&&& search results for: $searchQuery');
        if (searchQuery == _latestSearchText) {
          ref.read(searchUsersProvider.notifier).state =
              AsyncData(users.toList());
        }
        print('[pp =========&&&&&&&&&&&&& search results for: ${users.length}');
        return users.toList();
      });
    } catch (e) {
      print('Error retrieving users: $e');
      return [];
      // return <Map<String, dynamic>>[];
    }
  }

  void updateSearchController(TextEditingController controller) {
    searchController = controller;
  }
}

final popularGalleryProvider =
    AsyncNotifierProvider<PopularGalleryNotifier, List<GalleryModel>>(
        () => PopularGalleryNotifier());

class PopularGalleryNotifier extends AsyncNotifier<List<GalleryModel>> {
  final _repository = DiscoverRepository.instance;

  @override
  Future<List<GalleryModel>> build() async {
    state = const AsyncLoading();

    final res = await _repository.getPopularGalleries();
    return res.fold((left) {
      return [];
    }, (right) {
      final List<GalleryModel> galleryList = [];
      if (right.isNotEmpty) {
        for (Map<String, dynamic> value in right) {
          try {
            final gallery = GalleryModel.fromMap(value);
            galleryList.add(gallery);
          } catch (e, stackTrack) {
            print('<GGGGGGGGGGGGGGGGGGGG> $e $stackTrack');
          }
        }
        return galleryList;
      }
      return [];
    });
  }
}
