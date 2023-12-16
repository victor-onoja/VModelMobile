import 'package:either_option/either_option.dart';
import 'package:vmodel/src/app_locator.dart';
import 'package:vmodel/src/core/utils/exception_handler.dart';

abstract class NotificationRepository {
  Future<Either<CustomException, Map<String, dynamic>>> getNotifications({
    required int pageCount,
    required int pageNumber,
  });
}

class NotificationsRepository implements NotificationRepository {
  @override
  Future<Either<CustomException, Map<String, dynamic>>> getNotifications({
    required int pageCount,
    required int pageNumber,
  }) async {
    print('[wzs1] repo page ${pageNumber}, pageCount $pageCount');
    try {
      final result = await vBaseServiceInstance.getQuery(queryDocument: '''
      query notifications (\$pageCount: Int, \$pageNumber: Int) {
        
  notifications (pageCount:\$pageCount, pageNumber:\$pageNumber) {
    id
    profilePictureUrl
    id
    modelGroup
    meta
    isConnectionRequest
    connected
    post{
      id
      likes
      aspectRatio
      locationInfo
      caption
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
        firstName
        lastName
        profilePictureUrl
        isVerified
        blueTickVerified
      }
      album {
        id
        name
      }
      tagged {
        id
        username
        profilePictureUrl
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
      #id
      #user{
      #id
      #firstName
      #lastName
      #username
      #profilePictureUrl
      #}
      #aspectRatio
      }
    message
    model
    modelId
    read
    createdAt
  }
  notificationsTotalNumber
}
        ''', payload: {
        'pageCount': pageCount,
        'pageNumer': pageNumber,
      });
      print('Notification Fetching user notifications $result');

      final Either<CustomException, Map<String, dynamic>> response =
          result.fold((left) => Left(left), (right) {
        // print("77777777777777777777777777777777 $right");

        // final albumList = right?['notifications'] as List<dynamic>?;
        return Right(right!);
      });

      // print("''''''''''''''''''''''''''''''$response");
      return response;
    } catch (e) {
      return Left(CustomException(e.toString()));
    }
  }
}
