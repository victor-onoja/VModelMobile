import 'package:either_option/either_option.dart';
import 'package:vmodel/src/app_locator.dart';
import 'package:vmodel/src/core/utils/exception_handler.dart';

class LocalServicesRepository {
  LocalServicesRepository._();
  static LocalServicesRepository instance = LocalServicesRepository._();

  Future<Either<CustomException, Map<String, dynamic>>> getAllServices({
    bool? popular,
    int? pageCount,
    int? pageNumber,
    String? search,
    String? category,
    String? remote,
    String? discounted,
  }) async {
    print('[oe9s] print remote $remote, discounted $discounted');

    try {
      final result =
          await vBaseServiceInstance.mutationQuery(mutationDocument: '''
query allServices(\$pageNumber: Int, \$popular: Boolean, \$pageCount: Int,
                  \$search: String, \$category: String, \$remote: String,
                  \$discounted: String
) {
 
  allServices(pageNumber: \$pageNumber, pageCount: \$pageCount, popular: \$popular,
  search: \$search, category: \$category, remote: \$remote, discounted: \$discounted
  ) {
    id
    title
    discount
    banner {
      url
      thumbnail
    }
    views
    price
    description
    period
    isOffer
    serviceType
    usageType
    createdAt
    faq
    lastUpdated
    #deleted
    paused
    status
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
    delivery {
      id
      name
    }
    hasAdditional
    likes
  }
   allServicesTotalNumber
}
        ''', payload: {
        'popular': popular,
        'pageCount': pageCount,
        'pageNumber': pageNumber,
        'search': search,
        'category': category,
        'remote': remote,
        'discounted': discounted,
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
}

class SavedServicesRepository {
  SavedServicesRepository._();
  static SavedServicesRepository instance = SavedServicesRepository._();

  Future<Either<CustomException, Map<String, dynamic>>> getSavedServices({
    int? pageCount,
    int? pageNumber,
  }) async {
    try {
      final result =
          await vBaseServiceInstance.mutationQuery(mutationDocument: '''
query savedServices(\$pageCount: Int, \$pageNumber: Int) {
  savedServices(pageCount: \$pageCount, pageNumber: \$pageNumber) {
    id
    service {
      id
      title
      discount
      banner {
        url
        thumbnail
      }
      views
      price
      description
      period
      isOffer
      serviceType
      usageType
      createdAt
      lastUpdated
      paused
      status
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
      delivery {
        id
        name
      }
      hasAdditional
      likes
    }
  }
  savedServicesTotalNumber
}
        ''', payload: {
        'pageCount': pageCount,
        'pageNumber': pageNumber,
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

  Future<Either<CustomException, Map<String, dynamic>>> searchSavedServices({
    int? pageCount,
    int? pageNumber,
    String? search = "",
  }) async {
    try {
      final result =
          await vBaseServiceInstance.mutationQuery(mutationDocument: '''
query searchSavedServices(\$pageCount: Int, \$pageNumber: Int, \$search: String!) {
  searchSavedServices(pageCount: \$pageCount, pageNumber: \$pageNumber, search: \$search) {
      id
      title
      discount
      banner {
        url
        thumbnail
      }
      views
      price
      description
      period
      isOffer
      serviceType
      usageType
      createdAt
      lastUpdated
      paused
      status
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
      delivery {
        id
        name
      }
      hasAdditional
      likes
    }
  
}
        ''', payload: {
        'pageCount': pageCount,
        'pageNumber': pageNumber,
        "search": search,
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
}
