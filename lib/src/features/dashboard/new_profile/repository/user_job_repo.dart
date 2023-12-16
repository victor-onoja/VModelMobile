import 'package:either_option/either_option.dart';
import 'package:vmodel/src/app_locator.dart';
import 'package:vmodel/src/core/utils/exception_handler.dart';

class UserJobsRepository {
  UserJobsRepository._();
  static UserJobsRepository instance = UserJobsRepository._();

  Future<Either<CustomException, Map<String, dynamic>>> getUserJobs(
      String username) async {
    try {
      final result = await vBaseServiceInstance.getQuery(queryDocument: '''
  query userJobSet(\$username: String!) {
    getUserJobs(username:\$username){
      jobSet {
        id
        createdAt
        jobTitle
        jobType
        priceOption
        priceValue
        preferredGender
        shortDescription
        brief
        briefLink
        briefFile
        deliverablesType
        deleted
        jobDelivery {
          date
          startTime
          endTime
        }
        ethnicity
        talentHeight{
          value
          unit
        }
        size
        skinComplexion
        minAge
        maxAge
        isDigitalContent
        talents
        jobLocation {
          latitude
          longitude
          locationName
        }
        usageType {
          id
          name
        }
        usageLength {
          id
          name
        }
        creator {
          id
          username
          firstName
          lastName
          #bio
          location {
            latitude
            longitude
            locationName
          }
          profilePictureUrl
          isBusinessAccount
          userType
          label
        }
      }
    }
  }

        ''', payload: {"username": username});

      return result.fold((left) {
        print('BBBB000000000000 $left');
        return Left(left);
      }, (right) {
        print('YYYYYYyayyyyy $right');
        return Right(right!['getUser']);
      });
    } catch (e) {
      print('Error $e');
      return Left(CustomException(e.toString()));
    }
  }

  Future<Either<CustomException, Map<String, dynamic>>> deleteJob(
      {required int jobId}) async {
    try {
      final result =
          await vBaseServiceInstance.mutationQuery(mutationDocument: '''

    mutation deleteJob(\$jobId:Int!){
      deleteJob(jobId: \$jobId) {
       success 
      }
    }
        ''', payload: {
        "jobId": jobId,
      });

      return result.fold((left) {
        print('BBBB000000000000 $left');
        return Left(left);
      }, (right) {
        // print('YYYYYYyayyyyy $right');
        return Right(right!['deleteJob']);
      });
    } catch (e) {
      print('Error $e');
      return Left(CustomException(e.toString()));
    }
  }

  Future<Either<CustomException, Map<String, dynamic>>> applyToJob({
    required int jobId,
    required double proposedPrice,
  }) async {
    try {
      final result =
          await vBaseServiceInstance.mutationQuery(mutationDocument: '''

mutation applyToJob(\$jobId:Int!, \$proposedPrice: Float!) {
  applyToJob(jobId: \$jobId, proposedPrice: \$proposedPrice) {
    message
    application {
      id
      proposedPrice
      accepted
      rejected
      job {
       id
        jobTitle
      }
      applicant {
        username
      }
    }
  }
}

        ''', payload: {
        "jobId": jobId,
        "proposedPrice": proposedPrice,
      });

      return result.fold((left) {
        print('BBBB000000000000 $left');
        return Left(left);
      }, (right) {
        print('YYYYYYyayyyyy $right');
        return Right(right!['applyToJob']);
      });
    } catch (e) {
      print('Error $e');
      return Left(CustomException(e.toString()));
    }
  }

  Future<Either<CustomException, Map<String, dynamic>>> getPopularJobs({
    required int dataCount,
  }) async {
    try {
      final result =
          await vBaseServiceInstance.mutationQuery(mutationDocument: '''
query popularJobs(\$dataCount: Int!) {
  explore(dataCount: \$dataCount){
      popularJobs {
        id
        createdAt
        jobTitle
        jobType
        priceOption
        priceValue
        preferredGender
        shortDescription
        brief
        briefLink
        briefFile
        deliverablesType
        jobDelivery {
          date
          startTime
          endTime
        }
        ethnicity
        talentHeight{
          value
          unit
        }
        size
        skinComplexion
        minAge
        maxAge
        isDigitalContent
        talents
        jobLocation {
          latitude
          longitude
          locationName
        }
        usageType {
          id
          name
        }
        usageLength {
          id
          name
        }
        creator {
          id
          username
          firstName
          lastName
          #bio
          location {
            latitude
            longitude
            locationName
          }
          profilePictureUrl
          isBusinessAccount
          userType
          label
        }
      }

       popularServices {
        id
        title
        description
        serviceType
        period
        price
        isDigitalContentCreator
        hasAdditional
        discount
        usageType
        usageLength
        deleted
        deliveryTimeline
        views
        createdAt
        lastUpdated
        user {
          id
          username
          profilePictureUrl
          isBusinessAccount
          userType
          label
        }
        delivery {
          id
          name
        }
      }
    }
  }

        ''', payload: {"dataCount": dataCount});

      return result.fold((left) {
        print('BBBB000000000000 $left');
        return Left(left);
      }, (right) {
        print('YYYYYYyayyyyy $right');
        return Right(right!['explore']);
      });
    } catch (e) {
      print('Error $e');
      return Left(CustomException(e.toString()));
    }
  }

  Future<Either<CustomException, Map<String, dynamic>>> userHasJob(
      {required String username}) async {
    try {
      final result =
          await vBaseServiceInstance.mutationQuery(mutationDocument: '''
     mutation (\$username: String!){
      getIfUsernameCreatedJob(username: \$username) {
        message
        createdJob
      }
    }
        ''', payload: {"username": username});

      return result.fold((left) {
        print('BBBB000000000000 $left');
        return Left(left);
      }, (right) {
        print('YYYYYYyayyyyy $right');
        return Right(right!['getIfUsernameCreatedJob']);
      });
    } catch (e) {
      print('Error $e');
      return Left(CustomException(e.toString()));
    }
  }
}
