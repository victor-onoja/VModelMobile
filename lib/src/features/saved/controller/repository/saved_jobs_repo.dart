import 'package:either_option/either_option.dart';
import 'package:vmodel/src/core/utils/exception_handler.dart';

import '../../../../app_locator.dart';

class SavedJobsRepository {
  SavedJobsRepository._();
  static SavedJobsRepository instance = SavedJobsRepository._();

  Future<Either<CustomException, Map<String, dynamic>>> getSavedJobs({
    String? search,
    int? pageCount,
    int? pageNumber,
  }) async {
    try {
      final result =
          await vBaseServiceInstance.mutationQuery(mutationDocument: '''
        query savedJobs(\$pageCount: Int, \$pageNumber: Int, \$search: String) {
  savedJobs(pageCount: \$pageCount, pageNumber: \$pageNumber, search: \$search) {
   id
    user {
      id
      username
      fullName
      userType
      label
      isBusinessAccount
      isVerified
      blueTickVerified
      profilePictureUrl
      thumbnailUrl
      location {
        locationName
      }
    }
    job {
      id
      createdAt
      jobTitle
      jobType
      priceOption
      priceValue
      preferredGender
      shortDescription
      category
      paused
      closed
      processing
      status
      status
      brief
      briefLink
      briefFile
      noOfApplicants
      deliverablesType
      jobDelivery {
        date
        startTime
        endTime
      }
      ethnicity
      talentHeight {
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
  savedJobsTotalNumber
}

        ''', payload: {
        'search': search,
        'pageCount': pageCount,
        'pageNumber': pageNumber,
      });

      return result.fold((left) {
        return Left(left);
      }, (right) {
        return Right(right as Map<String, dynamic>);
      });
    } catch (e) {
      print('Error $e');
      return Left(CustomException(e.toString()));
    }
  }
}
