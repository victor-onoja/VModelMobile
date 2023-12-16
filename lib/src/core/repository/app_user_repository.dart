import 'package:either_option/either_option.dart';

import '../../app_locator.dart';
import '../utils/exception_handler.dart';

class AppUserRepository {
  AppUserRepository._();

  //For debugging purposes only
  final _TAG = 'AppUserRepository';

  static AppUserRepository instance = AppUserRepository._();

  Future<Either<CustomException, Map<String, dynamic>>> getMe() async {
    _tagPrint("HHHHHHHHHHHHHHHHHHHHHHHHHHHHH getting me");
    try {
      final result = await vBaseServiceInstance.getQuery(queryDocument: '''
      
query{
  viewMe{
    id
    dob
    email
    username
    firstName
    lastName
    displayName
    bio
    zodiacSign
    connectionStatus
    allowConnectionView
    connectionId
    gender
    alertOnProfileVisit
    whoCanMessageMe
    whoCanFeatureMe
    whoCanViewMyNetwork
    whoCanConnectWithMe
    isVerified
    blueTickVerified
    dateJoined
    lastLogin
    phone {
      countryCode
      number
      completed
    }
    height {
      value
      unit
    }
    location{
      latitude
      longitude
      locationName
    }
    website
    price
    postcode
    gender
    ethnicity
    size
    hair
    eyes
    profilePictureUrl
    thumbnailUrl
    isBusinessAccount
    userType
    label
    isFollowing
    personality
    yearsOfExperience
     waist{
      value
      unit
    }
    height{
      value
      unit
    }
    bust{
      value
      unit
    }
    feet{
      value
      unit
    }
    chest{
      value
      unit
    }
    socials {
     facebook {
      username
      noOfFollows
     }
     instagram {
      username
      noOfFollows
     }
     twitter {
      username
      noOfFollows
     }
     tiktok {
      username
      noOfFollows
     }
     pinterest {
      username
      noOfFollows
     }
     youtube {
      username
      noOfFollows
     }
    }
  }
}
        ''', payload: {});

      final Either<CustomException, Map<String, dynamic>> response =
          result.fold((left) {
        return Left(left);
      }, (right) {
        final profile = right!['viewMe'];
        return Right(profile);
      });

      return response;
    } catch (e) {
      return Left(CustomException(e.toString()));
    }
  }

  Future<Either<CustomException, Map<String, dynamic>>> getAppUserInfo(
      {required String username}) async {
    _tagPrint("HHHHHHHHHHHHHHHHHHHHHHHHHHHHH $username");
    try {
      final result = await vBaseServiceInstance.getQuery(queryDocument: '''
      
  query getUser(\$username: String!){
  getUser(username:\$username){
    username
    id
    email
    bio
    zodiacSign
    connectionStatus
    allowConnectionView
    connectionId
    gender
    dob
    userType
    isVerified
    postNotification
    jobNotification
    couponNotification
    blueTickVerified
    height {
      value
      unit
    }
    location{
      locationName
    }
    website
    price
    postcode
    gender
    ethnicity
    size
    firstName
    lastName
    displayName
    hair
    eyes
    thumbnailUrl
    profilePictureUrl
    isBusinessAccount
    userType
    label
    isFollowing
    yearsOfExperience
      waist{
      value
      unit
    }
    height{
      value
      unit
    }
    bust{
      value
      unit
    }
    feet{
      value
      unit
    }
    chest{
      value
      unit
    }
    socials {
     facebook {
      username
      noOfFollows
     }
     instagram {
      username
      noOfFollows
     }
     twitter {
      username
      noOfFollows
     }
     tiktok {
      username
      noOfFollows
     }
     pinterest {
      username
      noOfFollows
     }
     youtube {
      username
      noOfFollows
     }
    }
  
  }
}
        ''', payload: {
        'username': username,
      });

      final Either<CustomException, Map<String, dynamic>> response =
          result.fold((left) {
        return Left(left);
      }, (right) {
        final profile = right!['getUser'];

        return Right(profile);
      });

      return response;
    } catch (e) {
      return Left(CustomException(e.toString()));
    }
  }

  Future<Either<CustomException, Map<String, dynamic>>> updateProfile({
    // int? id,
    bool? allowConnectionView,
    String? firstName,
    String? lastName,
    String? displayName,
    String? label,
    String? personality,
    String? bio,
    String? website,
    String? dob,
    String? hair,
    String? eyes,
    Map<String, dynamic>? phone,
    Map<String, dynamic>? chest,
    Map<String, dynamic>? bust,
    Map<String, dynamic>? waist,
    Map<String, dynamic>? feet,
    Map<String, dynamic>? height,
    String? gender,
    String? locationName,
    String? modelSize,
    String? ethnicity,
    String? profilePictureUrl,
    String? thumbnailUrl,
    int? yearsOfExperience,
  }) async {
    try {
      final response =
          await vBaseServiceInstance.mutationQuery(mutationDocument: '''
           mutation updateProfile(
            \$allowConnectionView: Boolean,
      \$bio: String,
      \$country: String,
      \$ethnicity: String,
      \$eyes: String,
      \$firstName: String,
      \$gender: String,
      \$hair: String,
      \$lastName: String,
      \$phoneNumber: PhoneInputType,
      \$postcode: String,
      \$dob: Date,
      \$price: String,
      \$size: String,
      \$displayName: String,
      \$label: String,
      \$personality: String,
      \$website: String,
      \$profilePictureUrl: String,
      \$thumbnail: String,
      \$yearsOfExperience: Int,

      \$bust: BustInputType,
      \$height: UserHeightInputType,
      \$chest: ChestInputType,
      \$feet: FeetInputType,
      \$waist: WaistInputType,

       ) {
  updateProfile(
    allowConnectionView: \$allowConnectionView
      bio: \$bio,
      country: \$country,
      ethnicity: \$ethnicity,
      eyes: \$eyes,
      firstName: \$firstName,
      gender: \$gender,
      hair: \$hair,
      dob: \$dob,
      lastName: \$lastName,
      displayName: \$displayName,
      phoneNumber: \$phoneNumber,
      postcode: \$postcode,
      price: \$price,
      size: \$size,
      label: \$label,
      personality: \$personality,
      website: \$website,
      profilePictureUrl: \$profilePictureUrl,
      thumbnail: \$thumbnail,
      yearsOfExperience: \$yearsOfExperience,
      bust: \$bust
      height: \$height
      chest: \$chest
      feet: \$feet
      waist: \$waist

  ) {
    user {
      id
      username
      lastName
      firstName
      displayName
      bio
      country
      allowConnectionView
      email
      ethnicity
      eyes
      dob
      gender
      hair
      personality
       waist{
      value
      unit
    }
    height{
      value
      unit
    }
    bust{
      value
      unit
    }
    feet{
      value
      unit
    }
    chest{
      value
      unit
    }
      phone {
        countryCode
        number
        completed
      }
      postcode
      price
      size
      website
      isActive
      thumbnailUrl
      profilePictureUrl
      isBusinessAccount
      userType
      label
      isFollowing
      yearsOfExperience
    }
  }
}
        ''', payload: {
        // 'id': id ,
        // 'profilePictureUrl': profilePictureUrl,
        'allowConnectionView': allowConnectionView,
        'bio': bio,
        'website': website,
        'firstName': firstName,
        'lastName': lastName,
        'displayName': displayName,
        'label': label,
        'hair': hair,
        'eyes': eyes,
        'dob': dob,
        'phoneNumber': phone,
        'gender': gender,
        'ethnicity': ethnicity,
        'size': modelSize,
        'personality': personality,
        'profilePictureUrl': profilePictureUrl,
        'thumbnail': thumbnailUrl,
        'yearsOfExperience': yearsOfExperience,

        'height': height,
        'chest': chest,
        'feet': feet,

        'waist': waist,
        'bust': bust,
      });

      final Either<CustomException, Map<String, dynamic>> result =
          response.fold((left) => Left(left),
              (right) => Right(right!['updateProfile']['user']));
      return result;
    } catch (e) {
      _tagPrint('Error updating profile picture in  ===> $e');
      return Left(CustomException(e.toString()));
    }
  }

  Future<Either<CustomException, Map<String, dynamic>>> updateUsername({
    String? username,
    // String? email,
  }) async {
    try {
      final response =
          await vBaseServiceInstance.mutationQuery(mutationDocument: '''
            mutation updateProfile(\$username: String) {
              updateProfile(username: \$username) {
                message
                token
                user {
                  id
                  username
                }
              }
            }
        ''', payload: {
        'username': username,
      });

      final Either<CustomException, Map<String, dynamic>> result =
          response.fold(
              (left) => Left(left), (right) => Right(right!['updateProfile']));
      return result;
    } catch (e) {
      _tagPrint('Error updating profile picture in  ===> $e');
      return Left(CustomException(e.toString()));
    }
  }

  Future<Either<CustomException, Map<String, dynamic>>> updateNotification({
    bool? alertProfileVisit,
    // String? email,
  }) async {
    try {
      final response =
          await vBaseServiceInstance.mutationQuery(mutationDocument: '''
            mutation updateProfile(\$alertOnProfileVisit: Boolean) {
              updateProfile(alertOnProfileVisit: \$alertOnProfileVisit) {
                message
                token
                user {
                  alertOnProfileVisit
                }
              }
            }
        ''', payload: {
        'alertOnProfileVisit': alertProfileVisit,
      });

      final Either<CustomException, Map<String, dynamic>> result =
          response.fold((left) {
        print(left.message);
        return Left(left);
      }, (right) => Right(right!['updateProfile']));
      return result;
    } catch (e) {
      _tagPrint('Error updating profile picture in  ===> $e');
      return Left(CustomException(e.toString()));
    }
  }

  Future<Either<CustomException, Map<String, dynamic>>> updateUserSocials({
    String? facebook,
    String? instagram,
    String? tiktok,
    String? pinterest,
    String? youtube,
    String? twitter,
    String? linkedin,
    String? patreon,
    String? reddit,
    String? snapchat,
    int? facebookFollows,
    int? instaFollows,
    int? twitterFollows,
    int? youtubeSubs,
    int? tiktokFollows,
    int? pinterestFollows,
    int? linkedinFollows,
    int? patreonFollows,
    int? redditFollows,
    int? snapchatFollows,
  }) async {
    print("facebooks$facebook");
    try {
      final result =
          await vBaseServiceInstance.mutationQuery(mutationDocument: '''
mutation updateUserSocials(
  \$facebook: String, \$facebookFollows: Int, \$instagram: String,
  \$instaFollows: Int, \$pinterest: String, \$pinterestFollows: Int,
  \$tiktok: String, \$tiktokFollows: Int, \$twitter: String, \$twitterFollows: Int,
  \$youtube: String, \$youtubeSubs: Int, \$linkedin: String, \$linkedinFollows: Int,
  \$patreon: String, \$patreonFollows: Int, \$reddit: String, \$redditFollows: Int,
  \$snapchat: String, \$snapchatFollows: Int
){
  updateUserSocials(
    facebook: \$facebook,
    facebookFollows: \$facebookFollows,
    instagram: \$instagram,
    instaFollows:\$instaFollows,
    tiktok:\$tiktok,
    tiktokFollows: \$tiktokFollows,
    twitter:\$twitter,
    twitterFollows:\$twitterFollows,
    pinterest:\$pinterest,
    pinterestFollows:\$pinterestFollows,
    youtube: \$youtube,
    youtubeSubs:\$youtubeSubs,
    patreon:\$patreon,
    patreonFollows: \$patreonFollows,
    linkedin: \$linkedin,
    linkedinFollows:\$linkedinFollows,
    reddit:\$reddit,
    redditFollows:\$redditFollows,
    snapchat:\$snapchat,
    snapchatFollows:\$snapchatFollows,
  ){
    socials{
      instagram{
        username
        noOfFollows
      },
      facebook{
        username
        noOfFollows
      },
      tiktok{
        username
        noOfFollows
      },
    	youtube{
        username
        noOfFollows
      },
      pinterest{
        username
        noOfFollows
      },
      twitter{
        username
        noOfFollows
      },

       snapchat{
        username
        noOfFollows
      },
       reddit{
        username
        noOfFollows
      },
       linkedin{
        username
        noOfFollows
      },
       patreon{
        username
        noOfFollows
      },
    }
  }
}
        ''', payload: {
        'facebook': facebook,
        'facebookFollows': facebookFollows,
        'instagram': instagram,
        'instaFollows': instaFollows,
        'tiktok': tiktok,
        'tiktokFollows': tiktokFollows,
        'pinterest': pinterest,
        'pinterestFollows': pinterestFollows,
        'youtube': youtube,
        'youtubeSubs': youtubeSubs,
        'twitter': twitter,
        'twitterFollows': twitterFollows,
        'snapchat': snapchat,
        'linkedin': linkedin,
        'reddit': reddit,
        'patreon': patreon,
        'patreonFollows': patreonFollows,
        'snapchatFollows': snapchatFollows,
        'linkedinFollows': linkedinFollows,
        'redditFollows': redditFollows,
      });

      final Either<CustomException, Map<String, dynamic>> response =
          result.fold((left) {
        return Left(left);
      }, (right) {
        print('WWWWWWWWooooowwwww what is null here $right');
        return Right(right!['updateUserSocials']);
      });

      print('WWWWWWWWooooowwwww this is response $response');
      return response;
    } catch (e) {
      return Left(CustomException(e.toString()));
    }
  }

  Future<Either<CustomException, Map<String, dynamic>>>
      deleteProfilePicture() async {
    try {
      final result = await vBaseServiceInstance.getQuery(queryDocument: '''

mutation deleteProfilePicture{
  deleteProfilePic {
    user {
      thumbnailUrl
      profilePictureUrl
    }
  }
}

        ''', payload: {});

      final Either<CustomException, Map<String, dynamic>> response =
          result.fold((left) {
        print('Error deleteing profile picture ${left.message}');
        return Left(left);
      }, (right) {
        return Right(right!['deleteProfilePic']['user']);
      });
      return response;
    } catch (e) {
      return Left(CustomException(e.toString()));
    }
  }

  String _tagPrint(String message) {
    return '[$_TAG] $message';
  }

  Future<Either<CustomException, Map<String, dynamic>>> updateUserLocation({
    // int? id,
    // required Map<String, dynamic> location,
    required String latitude,
    required String longitude,
    required String locationName,
  }) async {
    try {
      final response =
          await vBaseServiceInstance.mutationQuery(mutationDocument: '''
           mutation myUpdateProfile(
         \$latitude : String!,
         \$longitude : String!,
         \$locationName : String,
       ) {
  updateProfile(
      location: {
        latitude: \$latitude
        longitude: \$longitude
        locationName: \$locationName
      }
  ) {
    user {
      id
      username
      location{
        latitude
        longitude
        locationName
      }
    }
  }
}
        ''', payload: {
        'latitude': latitude,
        'longitude': longitude,
        'locationName': locationName,
      });

      final Either<CustomException, Map<String, dynamic>> result =
          response.fold((left) {
        print('AQQQQQQQQ ${left.message}');
        return Left(left);
      }, (right) {
        print('AQQQQQQQQ $right');
        return Right(right!['updateProfile']['user']);
      });
      return result;
    } catch (e) {
      _tagPrint('Error updating profile picture in  ===> $e');
      return Left(CustomException(e.toString()));
    }
  }

  //
  // Future<Either<CustomException, Map<String, dynamic>>> updateProfilePicture({
  //   required String profilePictureUrl,
  // }) async {
  //   try {
  //     final response = await vBaseServiceInstance.mutationQuery(
  //       mutatonDocument: '''
  //       mutation updateProfile(\$profilePictureUrl: String!) {
  //         updateProfile(profilePictureUrl: \$profilePictureUrl) {
  //           user {
  //             username
  //             lastName
  //             firstName
  //             isActive
  //             bio
  //             id
  //             profilePictureUrl
  //             profilePicture
  //           }
  //         }
  //       }
  //     ''',
  //       payload: {
  //         'profilePictureUrl': profilePictureUrl,
  //       },
  //     );
  //
  //     final Either<CustomException, Map<String, dynamic>> result =
  //     response.fold(
  //             (left) => Left(left),
  //             (right) => Right(right!['updateProfile']['user']));
  //     return result;
  //   } catch (e) {
  //     print('Error uploading profile picture in $_TAG ===> $e');
  //     return Left(CustomException(e.toString()));
  //   }
  // }
}
