import 'dart:convert';
import 'dart:developer' as dev;

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vmodel/src/core/models/app_user.dart';
import 'package:vmodel/src/core/models/bust_model.dart';
import 'package:vmodel/src/core/models/chest.dart';
import 'package:vmodel/src/core/models/feet_model.dart';
import 'package:vmodel/src/core/models/height_model.dart';
import 'package:vmodel/src/core/models/waist_model.dart';
import 'package:vmodel/src/core/repository/app_user_repository.dart';
import 'package:vmodel/src/core/utils/helper_functions.dart';

import '../../app_locator.dart';
import '../../features/authentication/controller/auth_status_provider.dart';
import '../../shared/response_widgets/toast.dart';
import '../api/file_service.dart';
import '../models/location_model.dart';
import '../models/phone_number_model.dart';
import '../models/user_socials.dart';
import '../network/urls.dart';
import '../utils/enum/ethnicity_enum.dart';
import '../utils/enum/gender_enum.dart';
import '../utils/enum/size_enum.dart';

//For most endpoints that require username as argument, 'null' indicates
// the current user whilst any other value indicates another user.
final userNameForApiRequestProvider =
    StateProvider.family.autoDispose<String?, String>((ref, arg) {
  final currentUser = ref.watch(appUserProvider).valueOrNull;
  if (arg == currentUser?.username) {
    return null;
  }
  return arg;
});

final appUserProvider =
    AutoDisposeAsyncNotifierProvider<AppUserNotifier, VAppUser?>(
        AppUserNotifier.new);

class AppUserNotifier extends AutoDisposeAsyncNotifier<VAppUser?> {
  // AppUserNotifier() : super();
  AppUserRepository? _repository;
  bool _isBuilding = false;

  @override
  Future<VAppUser?> build() async {
    _isBuilding = true;
    _repository = AppUserRepository.instance;
    // final VAppUser _stateCopy;
    dev.log(
        '[xxx578] ~~~~~~~~~~~USER rebuild>>>>>>]]]]]]]]] ${globalUsername}');
    print(
        "7777777777777777777 AppuserNotifier buildddddddddddd with username $globalUsername");

    // print("8888888888888 calling build with username $arg");
    // state = const AsyncLoading();
    final userProfile =
        // await _repository!.getAppUserInfo(username: username);
        await _repository!.getMe();
    VAppUser? initialState;
    userProfile.fold((left) {
      print(
          "8888888888888 () error in build ${left.message} ${StackTrace.current}");
      // return AsyncError(left.message, StackTrace.current);
    }, (right) {
      try {
        final newState = VAppUser.fromMap(right);

        print("+++++++++++++++++++++ map ${right['vmcrecord']}");
        initialState = newState;
        print(
            "+++++++++++++++++++++++++++++++++++++++++++++++++++++\n ${newState.yearsOfExperience} \n");
      } catch (e) {
        print("AAAAAAA error parsing json response $e ${StackTrace.current}");
      }
    });

    _isBuilding = false;
    return initialState;
  }

  Future<void> updateUserSocials({
    String? facebook,
    String? instagram,
    String? tiktok,
    String? pinterest,
    String? youtube,
    String? twitter,
    String? linkedin,
    String? snapchat,
    String? patreon,
    String? reddit,
    int? facebookFollows,
    int? instaFollows,
    int? twitterFollows,
    int? youtubeSubs,
    int? tiktokFollows,
    int? pinterestFollows,
    int? linkedinFollows,
    int? redditFollows,
    int? snapchatFollows,
    int? patreonFollows,
  }) async {
    final response = await _repository!.updateUserSocials(
      facebook: facebook,
      facebookFollows: facebookFollows,
      twitter: twitter,
      twitterFollows: twitterFollows,
      tiktok: tiktok,
      tiktokFollows: tiktokFollows,
      pinterest: pinterest,
      pinterestFollows: pinterestFollows,
      youtube: youtube,
      youtubeSubs: youtubeSubs,
      instagram: instagram,
      instaFollows: instaFollows,
      linkedin: linkedin,
      snapchat: snapchat,
      patreon: patreon,
      reddit: reddit,
      linkedinFollows: linkedinFollows,
      redditFollows: redditFollows,
      snapchatFollows: snapchatFollows,
      patreonFollows: patreonFollows,
    );
    response.fold((left) {
      print("left ${left}");
    }, (right) {
      final temp = state.value?.copyWith(
        socials: UserSocials.fromMap(right['socials']),
      );
      state = AsyncData(temp);
      return;
    });
  }

  Future<void> updateProfile({
    bool? allowConnectionView,
    String? bio,
    String? website,
    String? firstName,
    String? lastName,
    String? displayName,
    String? label,
    String? dob,
    String? personality,
    String? hair,
    String? eyes,
    PhoneNumberModel? phone, //would require verification later
    WaistModel? waist, //would require verification later
    HeightModel? height, //would require verification later
    FeetModel? feet, //would require verification later
    BustModel? bust, //would require verification later
    ChestModel? chest, //would require verification later
    Gender? gender,
    Ethnicity? ethnicity,
    LocationData? location, //currently locationName can't be updated
    ModelSize? modelSize,
    String? profilePictureUrl,
    String? thumbnailUrl,
    int? yearsOfExperience,
  }) async {
    final data = state.valueOrNull;
    print('=================>>>>>>>>>>>>>>============= ${phone?.toMap()}');
    // print('=================>>>>>>>>>>>>>>============= ${data}');
    try {
      final response = await _repository!.updateProfile(
        allowConnectionView: allowConnectionView ?? false,
        bio: bio ?? data?.bio,
        website: website ?? data?.website,
        firstName: firstName ?? data?.firstName,
        lastName: lastName ?? data?.lastName,
        displayName: displayName ?? data?.displayName,
        hair: hair ?? data?.hair,
        dob: dob ?? data?.dob?.toIso8601DateOnlyString,
        eyes: eyes ?? data?.eyes,
        phone: phone?.toMap() ?? data?.phone?.toMap(),
        gender: gender?.apiValue ?? data?.gender?.apiValue,
        ethnicity: ethnicity?.apiValue ?? data?.ethnicity?.apiValue,
        modelSize: modelSize?.apiValue ?? data?.modelSize?.apiValue,
        label: label ?? data?.label,
        personality: personality,
        height: height?.toMap() ?? data?.height?.toMap(),
        waist: waist?.toMap() ?? data?.waist?.toMap(),
        feet: feet?.toMap() ?? data?.feet?.toMap(),
        bust: bust?.toMap() ?? data?.bust?.toMap(),
        chest: chest?.toMap() ?? data?.chest?.toMap(),
        locationName: '',
        profilePictureUrl: profilePictureUrl ?? data?.profilePictureUrl,
        thumbnailUrl: thumbnailUrl ?? data?.thumbnailUrl,
        yearsOfExperience: yearsOfExperience ?? data?.yearsOfExperience,
      );

      response.fold((left) {
        dev.log('WTFWTFWTFWTFWTFWTFWTFWTFWTF ${left.message}');
        return null;
      }, (right) async {
        print('[jji] =================>>>>>>>>>>>>>>============= $right');
        final temp = state.value?.copyWith(
          allowConnectionView: right['allowConnectionView'],
          bio: right['bio'],
          firstName: right['firstName'],
          lastName: right['lastName'],
          displayName: right['displayName'],
          label: right['label'],
          personality: right['personality'],
          dob: DateTime.tryParse(right['dob'] ?? ''),
          hair: right['hair'],
          eyes: right['eyes'],
          phone: PhoneNumberModel.fromMap(right['phone'] ?? {}),
          gender: Gender.genderByApiValue(right['gender']),
          ethnicity: Ethnicity.ethnicityByApiValue(right['ethnicity']),
          modelSize: ModelSize.modelSizeByApiValue(right['size']),
          profilePictureUrl: right['profilePictureUrl'],
          thumbnailUrl: right['thumbnailUrl'],
          website: right['website'],
          yearsOfExperience: right['yearsOfExperience'],
        );

        state = AsyncData(temp);
        dev.log('>>>>>>>PPPPPPPPPPPPPPPPPPPPPPPPPPPPPP updated user state');
        return null;
      });
    } catch (e, st) {
      print('******************************************* $e \n ${st}');
    }
  }

  Future<void> updateUsername({
    String? username,
  }) async {
    final data = state.value!;
    try {
      final response = await _repository!.updateUsername(
        username: username ?? data.username,
      );

      response.fold((left) {
        return null;
      }, (right) async {
        print('[jji] =================>>>>>>>>>>>>>>============= $right');
        print('[crd] Auth token new is ${right["token"]}');
        final user = right['user'] ?? {};
        final temp = state.value?.copyWith(username: user['username']);
        state = AsyncData(temp);

        if (username != null) {
          await ref
              .read(authenticationStatusProvider.notifier)
              .updateCredentials(authToken: right['token']);
        }
        return null;
      });
    } catch (e) {
      print(
          '******************************************* $e \n ${StackTrace.current}');
    }
  }

  Future<void> updateNotification({
    bool? alertProfileVisit,
  }) async {
    final data = state.value!;
    try {
      final response = await _repository!.updateNotification(
        alertProfileVisit: alertProfileVisit ?? data.alertOnProfileVisit,
      );

      response.fold((left) {
        // print(
        //     '[jji] =================>>>>>>>>>>>>>>============= ${left.message}');
        return null;
      }, (right) async {
        print('[jji] =================>>>>>>>>>>>>>>============= $right');
        print('[crd] Auth token new is ${right["token"]}');
        final user = right['user'] ?? {};
        final temp = state.value
            ?.copyWith(alertOnProfileVisit: user['alertOnProfileVisit']);
        state = AsyncData(temp);
        return null;
      });
    } catch (e) {
      print(
          '******************************************* $e \n ${StackTrace.current}');
    }
  }

  Future<void> updateUserLocation({
    required double lat, //currently locationName can't be updated
    required double lon, //currently locationName can't be updated
    required String locationName, //currently locationName can't be updated
  }) async {
    final locationData =
        LocationData(latitude: lat, longitude: lon, locationName: locationName);
    print('\n\n>>>>>>>>============= ${locationData.toMap()}');
    try {
      final response = await _repository!.updateUserLocation(
          latitude: lat.toString(),
          longitude: lon.toString(),
          locationName: locationName);

      response.fold((left) {
        print('\n\n>====== ${left.message}');
        return;
      }, (right) {
        final temp = state.value?.copyWith(
          location: LocationData.fromMap(right['location']),
        );
        dev.log('>>>>>>>PPPPPPPPPPPPPPPPPPPPPPPPPPPPPP updated user state');
        state = AsyncData(temp);
        return;
      });
    } catch (e) {
      print(
          '******************************************* $e \n ${StackTrace.current}');
    }
  }

  Future<void> uploadProfilePicture(String path,
      {OnUploadProgressCallback? onProgress}) async {
    try {
      //Upload file to bucket
      String result = await FileService.fileUploadMultipart(
        url: VUrls.profilePictureUploadUrl,
        files: [path],
        onUploadProgress: onProgress,
      );
      final map = json.decode(result);
      final files = map["data"] as List<dynamic>;
      String baseUrl = map['base_url'] ?? '';
      final url = files.first['file_url'] ?? '';
      final thumbnail = files.first['sd_url'] ?? '';

      //Send url to backend API
      print('[eed] Thumbnail: $thumbnail and original: $url');
      if (url.isNotEmpty) {
        updateProfile(
          profilePictureUrl: '$baseUrl$url',
          thumbnailUrl: '$baseUrl$thumbnail',
        );
        // final gResponse = await _repository!.updateProfile(
        //     profilePictureUrl: '$baseUrl$url');
        // gResponse.fold((left) => print('Error occurred ${left.message}'),
        //     (right) {
        print('Printing right message');
        //   print(right);
        //   final temp = state.value?.copyWith(
        //     profilePicture: right['profilePictureUrl'],
        //   );
        //   state = AsyncData(temp);
        //   //Todo set state here to reflect image change
        // });
      }
    } catch (e) {
      print('@@@@@@@@@@@@@@@@@@@@@@@@@@@@2 $e');
      VWidgetShowResponse.showToast(
        ResponseEnum.failed,
        message: 'Error uploading headshot $e',
      );
    }

    // CreatePostRepository.instance.uploadProfilePicture(
    //     path,
    // onProgress: onProgress,

    //     onProgress: (sent, total) {
    //   final percentUploaded = (sent / total);
    //   print(
    //       '########## $path\n [$percentUploaded%]  sent: $sent ---- total: $total');
    //   // ref.read(progressProvider.notifier).state =
    //   //     percentUploaded;
    // },
    // );
  }

  Future<void> updateSocialUsernames(
      {String? facebook,
      String? instagram,
      String? tiktok,
      String? pinterest,
      String? youtube,
      String? twitter}) async {
    try {
      final userSocials = await _repository!.updateUserSocials(
          facebook: facebook,
          instagram: instagram,
          tiktok: tiktok,
          pinterest: pinterest,
          youtube: youtube,
          twitter: twitter);

      userSocials.fold((left) {
        VWidgetShowResponse.showToast(
          ResponseEnum.failed,
          message: 'Error updating socials ${left.message}',
        );
      }, (right) {
        final currentState = state.valueOrNull;
        if (currentState != null) {
          final newState =
              currentState.copyWith(socials: UserSocials.fromMap(right));
          state = AsyncData(newState);
        }
      });
    } catch (e) {
      print('Error updating user socials');
      VWidgetShowResponse.showToast(
        ResponseEnum.failed,
        message: 'Error updating socials $e',
      );
    }
  }

  Future<void> deleteHeadshot() async {
    final userSocials = await _repository!.deleteProfilePicture();
    userSocials.fold((left) {}, (right) {
      final pic = right['profilePictureUrl'];
      final thumbnail = right['thumbnailUrl'];
      state = AsyncData(state.value?.copyWith(
        profilePictureUrl: "$pic",
        thumbnailUrl: "$thumbnail",
      ));
    });
  }

  bool isCurrentUser(String? otherUsername) {
    final user = state.valueOrNull;
    return user?.username == otherUsername;
  }

  void onLogOut() {
    // if (!_isBuilding &&
    //     !state.isLoading &&
    //     !state.isReloading &&
    //     !state.isRefreshing) state = AsyncData(null);
    ref.invalidateSelf();
  }
}
