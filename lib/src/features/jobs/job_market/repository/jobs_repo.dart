import 'package:either_option/either_option.dart';
import 'package:vmodel/src/app_locator.dart';
import 'package:vmodel/src/core/utils/exception_handler.dart';

class JobsRepository {
  JobsRepository._();
  static JobsRepository instance = JobsRepository._();

  Future<Either<CustomException, Map<String, dynamic>>> getJobs({
    bool? myJobs,
    String? search,
    String? category,
    String? username,
    int? pageCount,
    int? pageNumber,
    String? remote,
  }) async {
    try {
      final result = await vBaseServiceInstance.getQuery(queryDocument: '''
query getJobs(
      \$myJobs: Boolean,
      \$search: String,
      \$category: String,
      \$pageCount: Int,
      \$pageNumber: Int,
      \$username: String,
      \$remote: String,
){
  jobsTotalNumber
  jobs(
    myJobs: \$myJobs,
    search: \$search,
    category: \$category,
    # popular: \$popular,
    pageCount: \$pageCount,
    pageNumber: \$pageNumber,
    username: \$username,
    remote: \$remote,
  ) {
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
      #firstName
      #lastName
      displayName
      #bio
      location {
        latitude
        longitude
        locationName
      }
      profilePictureUrl
      thumbnailUrl
      isBusinessAccount
      userType
      label
    }
  }
}

        ''', payload: {
        'myJobs': myJobs,
        'search': search,
        'category': category,
        'pageCount': pageCount,
        'pageNumber': pageNumber,
        'username': username,
        'remote': remote,
      });

      return result.fold((left) {
        print('BBBB000000000000 $left');
        return Left(left);
      }, (right) {
        print('YYYYYYyayyyyy $right');
        return Right(right!);
      });
    } catch (e) {
      print('Error $e');
      return Left(CustomException(e.toString()));
    }
  }

  Future<Either<CustomException, Map<String, dynamic>>> getJob(
      {required int jobId}) async {
    try {
      final result =
          await vBaseServiceInstance.mutationQuery(mutationDocument: '''
      {
        job (jobId: $jobId){
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
           brief
           briefLink
           briefFile
           saves
           userSaved
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
           acceptMultiple
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
             #firstName
             #lastName
             displayName
             #bio
             location {
               latitude
               longitude
               locationName
             }
             profilePictureUrl
             thumbnailUrl
             isBusinessAccount
             userType
             label
           }
           applicationSet {
            id
            proposedPrice
            accepted
            rejected
            applicant {
              id
              username
            }
          }
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
        return Right(right!['job']);
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
      final result = await vBaseServiceInstance.getQuery(queryDocument: '''
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
        category
        paused
        closed
        processing
        status
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
        acceptMultiple
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
          #firstName
          #lastName
          displayName
          #bio
          location {
            latitude
            longitude
            locationName
          }
          profilePictureUrl
          thumbnailUrl
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
        category
        isDigitalContentCreator
        hasAdditional
        discount
        usageType
        usageLength      
        deliveryTimeline
        views
        faq
        createdAt
        lastUpdated
    banner {
      url
      thumbnail
    }
    initialDeposit
    category
    paused
    processing
    status
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
        print('popularJobsss ${right!['explore']['popularJobs']}');
        return Right(right['explore']);
      });
    } catch (e) {
      print('Error $e');
      return Left(CustomException(e.toString()));
    }
  }

  Future<Either<CustomException, Map<String, dynamic>>> getRecommendedJobs({
    required int dataCount,
  }) async {
    try {
      final result = await vBaseServiceInstance.getQuery(queryDocument: '''
query recommendedJobs(\$dataCount: Int!) {
  explore(dataCount: \$dataCount){
  recommendedJobs {
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
        acceptMultiple
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
          #firstName
          #lastName
          displayName
          #bio
          location {
            latitude
            longitude
            locationName
          }
          profilePictureUrl
          thumbnailUrl
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
        category
        isDigitalContentCreator
        hasAdditional
        discount
        usageType
        usageLength      
        deliveryTimeline
        views
        createdAt
        lastUpdated
    banner {
      url
      thumbnail
    }
    initialDeposit
    category
    paused
    processing
    status
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
        print('popularJobsss ${right!['explore']['popularJobs']}');
        return Right(right['explore']);
      });
    } catch (e) {
      print('Error $e');
      return Left(CustomException(e.toString()));
    }
  }

  Future<Either<CustomException, List<dynamic>>> getSimilarJobs({
    required int jobId,
  }) async {
    try {
      final result = await vBaseServiceInstance.getQuery(queryDocument: '''
query similarJobs(\$jobId: Int!) {
  similarJobs(jobId: \$jobId){
 
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
        acceptMultiple
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
          #firstName
          #lastName
          displayName
          #bio
          location {
            latitude
            longitude
            locationName
          }
          profilePictureUrl
          thumbnailUrl
          isBusinessAccount
          userType
          label
        }
      }
    }

        ''', payload: {"jobId": jobId});

      return result.fold((left) {
        print('BBBB000000000000 $left');
        return Left(left);
      }, (right) {
        final List<dynamic> list = right!['similarJobs'];
        return Right(list);
      });
    } catch (e) {
      print('Error $e');
      return Left(CustomException(e.toString()));
    }
  }

  Future<Either<CustomException, List<dynamic>>> getRecentlyViewedJobs() async {
    try {
      final result = await vBaseServiceInstance.getQuery(
        queryDocument: '''
query recentlyViewedJobs {
  recentlyViewedJobs {
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
      acceptMultiple
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
        displayName
        location {
          latitude
          longitude
          locationName
        }
        profilePictureUrl
        thumbnailUrl
        isBusinessAccount
        userType
        label
      }
    }
  }
}

        ''',
        payload: {},
      );

      return result.fold((left) {
        print('BBBB000000000000 $left');
        return Left(left);
      }, (right) {
        final List<dynamic> list = right!['recentlyViewedJobs'];
        return Right(list);
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

  Future<Either<CustomException, Map<String, dynamic>>> getJobApplications({
    required int jobId,
  }) async {
    try {
      final result = await vBaseServiceInstance.getQuery(queryDocument: '''

query jobApplications(\$jobId: Int!) {
  jobApplications(jobId: \$jobId) {
    id
    proposedPrice
    accepted
    rejected
    deleted
    dateCreated
    job {
      id
    }
    applicant {
      id
      username
      displayName
      profilePictureUrl
      thumbnailUrl
      email
      label
      isVerified
      blueTickVerified
      bio
    }
  }
}

        ''', payload: {
        "jobId": jobId,
      });

      return result.fold((left) {
        print('BBBB000000000000 $left');
        return Left(left);
      }, (right) {
        print('YYYYYYyayyyyy $right');
        return Right(right!);
      });
    } catch (e) {
      print('Error $e');
      return Left(CustomException(e.toString()));
    }
  }

  Future<Either<CustomException, Map<String, dynamic>>> acceptApplicationOffer({
    required int applicationId,
    required bool acceptApplication,
    required bool rejectApplication,
  }) async {
    try {
      final result =
          await vBaseServiceInstance.mutationQuery(mutationDocument: '''
mutation acceptApplication(\$applicationId: Int!, \$acceptApplication: Boolean, \$rejectApplication: Boolean) {
  acceptOrRejectApplication(applicationId: \$applicationId, acceptApplication: \$acceptApplication, rejectApplication: \$rejectApplication) {
    message
    application {
      id
      proposedPrice
      accepted
      rejected
      deleted
      dateCreated
      job {
        id
      }
      applicant {
        id
        username
        fullName
        profilePictureUrl
        email
        label
        isVerified
        bio
      }
    }
  }
}
        ''', payload: {
        "applicationId": applicationId,
        "acceptApplication": acceptApplication,
        "rejectApplication": rejectApplication
      });

      return result.fold((left) {
        print('BBBB000000000000 $left');
        return Left(left);
      }, (right) {
        print('YYYYYYyayyyyy $right');
        return Right(right!);
      });
    } catch (e) {
      print('Error $e');
      return Left(CustomException(e.toString()));
    }
  }

  Future<Either<CustomException, Map<String, dynamic>>> pauseJob(
      int jobId) async {
    print(jobId);
    try {
      final result =
          await vBaseServiceInstance.mutationQuery(mutationDocument: '''
          mutation pauseJob(\$jobId: Int!) {
            pauseJob(jobId: \$jobId) {
              success
            }
          }
        ''', payload: {
        "jobId": jobId,
      });

      final Either<CustomException, Map<String, dynamic>> userName =
          result.fold((left) => Left(left), (right) {
        print('[pauseJob] %%%%%%%%%%%%%%% $right');
        return Right(right!['pauseJob']);
      });

      return userName;
    } catch (e) {
      return Left(CustomException(e.toString()));
    }
  }

  Future<Either<CustomException, Map<String, dynamic>>> resumeJob(
      int jobId) async {
    print(jobId);
    try {
      final result =
          await vBaseServiceInstance.mutationQuery(mutationDocument: '''
          mutation resumeJob(\$jobId: Int!) {
            resumeJob(jobId: \$jobId) {
              success
            }
          }
        ''', payload: {
        "jobId": jobId,
      });

      final Either<CustomException, Map<String, dynamic>> userName =
          result.fold((left) => Left(left), (right) {
        print('[resumeJob] %%%%%%%%%%%%%%% $right');
        return Right(right!['resumeJob']);
      });

      return userName;
    } catch (e) {
      return Left(CustomException(e.toString()));
    }
  }

  Future<Either<CustomException, Map<String, dynamic>>> closeJob(
      int jobId) async {
    print(jobId);
    try {
      final result =
          await vBaseServiceInstance.mutationQuery(mutationDocument: '''
          mutation closeJob(\$jobId: Int!) {
            closeJob(jobId: \$jobId) {
              success
            }
          }
        ''', payload: {
        "jobId": jobId,
      });

      final Either<CustomException, Map<String, dynamic>> userName =
          result.fold((left) => Left(left), (right) {
        print('[closeJob] %%%%%%%%%%%%%%% $right');
        return Right(right!['closeJob']);
      });

      return userName;
    } catch (e) {
      return Left(CustomException(e.toString()));
    }
  }

  Future<Either<CustomException, Map<String, dynamic>>> saveJob(
      int jobId) async {
    try {
      final result =
          await vBaseServiceInstance.mutationQuery(mutationDocument: '''
          mutation saveJob(\$jobId: Int!) {
  saveJob(jobId: \$jobId) {
    success
  }
}
        ''', payload: {
        "jobId": jobId,
      });

      final Either<CustomException, Map<String, dynamic>> userName =
          result.fold((left) {
        print("left $left");
        return Left(left);
      }, (right) {
        print('[pd] %%%%%%%%%%%%%%% $right');
        return Right(right!['saveJob']);
      });

      return userName;
    } catch (e) {
      return Left(CustomException(e.toString()));
    }
  }
}
