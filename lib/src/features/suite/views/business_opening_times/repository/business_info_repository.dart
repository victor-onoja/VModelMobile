import 'package:either_option/either_option.dart';
import 'package:vmodel/src/app_locator.dart';

import '../../../../../core/utils/exception_handler.dart';

final businessOpeningInfoRepoInstance = BusinessOpeningInfoRepository.instance;

class BusinessOpeningInfoRepository {
  BusinessOpeningInfoRepository._();
  static BusinessOpeningInfoRepository instance =
      BusinessOpeningInfoRepository._();
  Future<Either<CustomException, Map<String, dynamic>>> getFeedStream(
      {int? pageCount, int? pageNumber}) async {
    try {
      final result = await vBaseServiceInstance.getQuery(queryDocument: '''
          
  query feedPosts(\$pageCount: Int, \$pageNumber: Int) {
  allPostsTotalNumber
  allPosts(feed: true, pageCount: \$pageCount, pageNumber: \$pageNumber) {
    id
    likes
    aspectRatio
    locationInfo
    caption
    likes
    userLiked
    userSaved
    createdAt
    updatedAt
    service {
      id
      title
      price
      description
      period
      user {
       id
       username
      }
    }
    user {
      id
      username
      displayName
      userType
      label
      isBusinessAccount
      thumbnailUrl
      profilePictureUrl
      isVerified
      blueTickVerified
    }
    album{
      id
      name
    }
    tagged {
      id
      username
      profilePictureUrl
      thumbnailUrl
    }
    photos {
      id
      description
      itemLink
    }
    videos {
      id
      description
      itemLink
    }
  }
}
          
''', payload: {
        "pageCount": pageCount,
        "pageNumber": pageNumber,
      });

      return result.fold((left) {
        return Left(left);
      }, (right) {
        // return Right(right!['allPosts']);
        print("allPosts ${right!['allPosts']}");
        return Right(right);
      });
    } catch (e) {
      print(e);
      return Left(CustomException(e.toString()));
    }
  }

  Future<Either<CustomException, Map<String, dynamic>>>
      getBusinessOpenTimesInfo({String? username}) async {
    try {
      final result = await vBaseServiceInstance.getQuery(queryDocument: '''

query businessAccountOpeningTimesInfo(\$username: String) {
  businessInfo (username: \$username) {
    timesInfo {
      id
      isOpen
      times {
        day
        allDay
        open
        close
      }
    }
    extrasInfo {
      id
      title
    }
    safetyInfo {
      id
      title
    }
  }
}

          
''', payload: {"username": username});

      return result.fold((left) {
        return Left(left);
      }, (right) {
        return Right(right!['businessInfo']);
      });
    } catch (e) {
      print(e);
      return Left(CustomException(e.toString()));
    }
  }

  Future<Either<CustomException, Map<String, dynamic>>>
      updateWorkingDaysAndHours(List<Map<String, dynamic>> data) async {
    try {
      final result =
          await vBaseServiceInstance.mutationQuery(mutationDocument: '''
              mutation workingHours(\$times: [OpenDaysInputType]!) {
              updateBusinessOpenTimes(times: \$times) {
                message
                businessInfo {
                  extrasInfo {
                    id
                    title
                  }
                  safetyInfo {
                    id
                    title
                  }
                  timesInfo {
                    isOpen
                    times {
                      day
                      open
                      close
                      allDay
                    }
                  }
                }
              }
            }
        ''', payload: {'times': data});

      final Either<CustomException, Map<String, dynamic>> userName =
          result.fold((left) => Left(left), (right) {
        print('%%%%%%%%%%%%%%% $right');
        // final isSuccessful = right!['savePost']['success'];
        return Right(right!['updateBusinessOpenTimes']);
      });

      return userName;
    } catch (e) {
      // log('${e.toString()}');
      return Left(CustomException(e.toString()));
    }
  }

  Future<Either<CustomException, Map<String, dynamic>>> addBusinessExtraInfo(
      List<String> data) async {
    try {
      final result =
          await vBaseServiceInstance.mutationQuery(mutationDocument: '''
            mutation AddBusinessExtras(\$titles: [String]!) {
              addBusinessExtras(titles: \$titles) {
                message 
                businessInfo {
                  extrasInfo {
                    id
                    title
                  }
                  safetyInfo {
                    id
                    title
                  }
                  timesInfo {
                    isOpen
                    times {
                      day
                      open
                      close
                      allDay
                    }
                  }
                }
              }
            }
        ''', payload: {'titles': data});

      return result.fold((left) => Left(left), (right) {
        print('%%%%%%%%%%%%%%% $right');
        // final isSuccessful = right!['savePost']['success'];
        return Right(right!['addBusinessExtras']);
      });
    } catch (e) {
      // log('${e.toString()}');
      return Left(CustomException(e.toString()));
    }
  }

  Future<Either<CustomException, Map<String, dynamic>>>
      removeBusinessesExtraInfo(int id) async {
    try {
      final result =
          await vBaseServiceInstance.mutationQuery(mutationDocument: '''
            mutation RemoveBusinessExtra(\$id: Int!) {
              removeBusinessExtras(extraId: \$id) {
                message
              }
            }
        ''', payload: {'id': id});

      return result.fold((left) => Left(left), (right) {
        print('%%%%%%%%%%%%%%% $right');
        // final isSuccessful = right!['savePost']['success'];
        return Right(right!['removeBusinessExtras']);
      });
    } catch (e) {
      // log('${e.toString()}');
      return Left(CustomException(e.toString()));
    }
  }

  Future<Either<CustomException, Map<String, dynamic>>> addBusinessSafetyRules(
      List<String> data) async {
    try {
      final result =
          await vBaseServiceInstance.mutationQuery(mutationDocument: '''
            mutation AddBusinessSafetyRules(\$titles: [String]!) {
              addBusinessSafetyRules(titles: \$titles) {
                message 
                businessInfo {
                  extrasInfo {
                    id
                    title
                  }
                  safetyInfo {
                    id
                    title
                  }
                  timesInfo {
                    isOpen
                    times {
                      day
                      open
                      close
                      allDay
                    }
                  }
                }
              }
            }
        ''', payload: {'titles': data});

      return result.fold((left) => Left(left), (right) {
        print('%%%%%%%%%%%%%%% $right');
        // final isSuccessful = right!['savePost']['success'];
        return Right(right!['addBusinessSafetyRules']);
      });
    } catch (e) {
      // log('${e.toString()}');
      return Left(CustomException(e.toString()));
    }
  }

  Future<Either<CustomException, Map<String, dynamic>>>
      removeBusinessesSafetyRule(int id) async {
    try {
      final result =
          await vBaseServiceInstance.mutationQuery(mutationDocument: '''
            
            mutation RemoveBusinessSafetyRule(\$id: Int!) {
              removeBusinessSafetyRules(safetyRuleId: \$id) {
                message
              }
            }
        ''', payload: {'id': id});

      return result.fold((left) => Left(left), (right) {
        print('%%%%%%%%%%%%%%% $right');
        // final isSuccessful = right!['savePost']['success'];
        return Right(right!['removeBusinessSafetyRules']);
      });
    } catch (e) {
      // log('${e.toString()}');
      return Left(CustomException(e.toString()));
    }
  }
}
