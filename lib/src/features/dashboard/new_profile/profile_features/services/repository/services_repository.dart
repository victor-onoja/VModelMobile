import 'package:either_option/either_option.dart';
import 'package:vmodel/src/app_locator.dart';
import 'package:vmodel/src/core/utils/exception_handler.dart';
// import 'package:get/get.dart';

final servicesRepoInstance = ServicesRepository.instance;

class ServicesRepository {
  ServicesRepository._();

  static ServicesRepository instance = ServicesRepository._();

  Future<Either<CustomException, List<dynamic>>> getUserServices(
      {String? username}) async {
    try {
      final result =
          await vBaseServiceInstance.mutationQuery(mutationDocument: '''
    query userServices(\$username: String) {
  userServices(username: \$username) {
    id
    title
    description
    serviceType
    period
    price
    #meta
    isDigitalContentCreator
    hasAdditional
    isOffer
    discount
    usageType
    likes
    saves
    shares
    userLiked
    usageLength
    #deleted
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
      displayName
      isVerified
      blueTickVerified
      isBusinessAccount
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
  }
}
        ''', payload: {
        "username": username,
      });

      final Either<CustomException, List<dynamic>> servicesResponse =
          result.fold((left) => Left(left), (right) {
        print("INside right ''''''''''''''''''''''''''''''");

        final servicesList = right?['userServices'] as List<dynamic>?;
        return Right(servicesList ?? []);
      });

      print("''''''''''''''''''''''''''''''$servicesResponse");
      return servicesResponse;
    } catch (e) {
      return Left(CustomException(e.toString()));
    }
  }

  Future<Either<CustomException, List<dynamic>>> getRecommendedServices(
      {required int dataCount}) async {
    try {
      final result =
          await vBaseServiceInstance.mutationQuery(mutationDocument: '''
            query recommendedServices(\$dataCount: Int!) {
              explore(dataCount: \$dataCount) {
                recommendedServices {
                  id
                  title
                  description
                  serviceType
                  period
                  price
                  isDigitalContentCreator
                  hasAdditional
                  isOffer
                  discount
                  usageType
                  likes
                  saves
                  shares
                  userLiked
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
                    displayName
                    isVerified
                    blueTickVerified
                    isBusinessAccount
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
                }
              }
            }

        ''', payload: {'dataCount': dataCount});

      final Either<CustomException, List<dynamic>> servicesResponse =
          result.fold((left) => Left(left), (right) {
        print("INside right ''''''''''''''''''''''''''''''");

        final servicesList =
            right?['explore']['recommendedServices'] as List<dynamic>?;
        return Right(servicesList ?? []);
      });

      print("''''''''''''''''''''''''''''''$servicesResponse");
      return servicesResponse;
    } catch (e) {
      return Left(CustomException(e.toString()));
    }
  }

  Future<Either<CustomException, List<dynamic>>> getSimilarServices(
      {String? serviceId}) async {
    try {
      final result =
          await vBaseServiceInstance.mutationQuery(mutationDocument: '''
    query similarServices(\$serviceId: Int!) {
  similarServices(serviceId: \$serviceId) {
    id
    title
    description
    serviceType
    period
    price
    #meta
    isDigitalContentCreator
    hasAdditional
    isOffer
    discount
    usageType
    likes
    saves
    shares
    userLiked
    usageLength
    #deleted
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
      displayName
      isVerified
      blueTickVerified
      isBusinessAccount
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
  }
}
        ''', payload: {
        "serviceId": serviceId,
      });

      final Either<CustomException, List<dynamic>> servicesResponse =
          result.fold((left) => Left(left), (right) {
        print("INside right ''''''''''''''''''''''''''''''");

        final servicesList = right?['similarServices'] as List<dynamic>?;
        print("nkjwnefwejh ${servicesList!.length}");
        return Right(servicesList ?? []);
      });

      print("''''''''''''''''''''''''''''''$servicesResponse");
      return servicesResponse;
    } catch (e) {
      return Left(CustomException(e.toString()));
    }
  }

  Future<Either<CustomException, List<dynamic>>>
      getRecentlyViewedServices() async {
    try {
      final result =
          await vBaseServiceInstance.mutationQuery(mutationDocument: '''
    query recentlyViewedServices {
  recentlyViewedServices {
    id
    service {
      id
      title
      description
      serviceType
      period
      price
      isDigitalContentCreator
      hasAdditional
      isOffer
      discount
      usageType
      likes
      faq
      saves
      shares
      userLiked
      usageLength
      deliveryTimeline
      views
      createdAt
      lastUpdated
      delivery {
        id
        name
      }
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
      displayName
      isVerified
      blueTickVerified
      isBusinessAccount
      profilePictureUrl
      thumbnailUrl 
               location {
                locationName
               }
    }
    }
  }
}
        ''', payload: {});

      final Either<CustomException, List<dynamic>> servicesResponse =
          result.fold((left) => Left(left), (right) {
        print("INside right ''''''''''''''''''''''''''''''");

        final servicesList = right?['recentlyViewedServices'] as List<dynamic>?;
        print("nkjwnefwejhwefw ${servicesList!.length}");
        return Right(servicesList ?? []);
      });

      print("''''''''''''''''''''''''''''''$servicesResponse");
      return servicesResponse;
    } catch (e) {
      return Left(CustomException(e.toString()));
    }
  }

  Future<Either<CustomException, Map<String, dynamic>>> getUserService(
      {required int serviceId, String? username}) async {
    try {
      final result =
          await vBaseServiceInstance.mutationQuery(mutationDocument: '''
    query userService(\$serviceId: Int!, \$username: String) {
  userService(serviceId:\$serviceId, username: \$username) {
    id
   title
   description
   serviceType
   period
   price
   ##meta
   isDigitalContentCreator
   hasAdditional
   discount
   usageType
   usageLength
   deliveryTimeline
   views
   createdAt
   lastUpdated
   user {
     id
     username
     displayName
   }
   delivery {
     id
     name
   }
  }
}
        ''', payload: {
        "serviceId": serviceId,
        "username": username,
      });

      final Either<CustomException, Map<String, dynamic>> servicesResponse =
          result.fold((left) => Left(left), (right) {
        print("INside right ${right?['userService'].runtimeType}");

        final servicesList = right?['userService'] as Map<String, dynamic>?;
        return Right(servicesList ?? {});
      });

      print("''''''''''''''''''''''''''''''$servicesResponse");
      return servicesResponse;
    } catch (e) {
      return Left(CustomException(e.toString()));
    }
  }

  Future<Either<CustomException, Map<String, dynamic>>> createService({
    required String period,
    required String title,
    required String serviceType,
    required String description,
    required double price,
    required String deliveryTimeline,
    required bool isOffer,
    String? usageType,
    String? usageLength,
    required bool isDigitalContent,
    required bool hasAdditionalServices,
    int? percentDiscount,
    List? banner,
    double? initialDeposit,
    List<String>? category,
    List? faqs,
  }) async {
    print('creating a service');
    print('''
        $period +
        $title +
        $serviceType +
        $description +
        $price
        $deliveryTimeline +
        $usageType +
        $usageLength +
        $isDigitalContent
        $hasAdditionalServices
        $percentDiscount
       banner $banner
       ''');
    try {
      final result =
          await vBaseServiceInstance.mutationQuery(mutationDocument: '''
          mutation createService(\$period: String!,\$title: String!,
          \$serviceType: String!, \$description: String,\$price: Float!,
          \$deliveryTimeline: String!, \$usageType: String,\$usageLength: String,
          \$isDigitalContentCreator:Boolean!, \$hasAdditional:Boolean!, \$isOffer: Boolean!,
          \$discount: Int, \$initialDeposit: Int, \$bannerUrl: [BannerInputType], 
          \$category: [String], \$faq: [FAQType],
          ) {
             createService(period: \$period,title: \$title, serviceType: \$serviceType,
             description: \$description, price: \$price,deliveryTimeline: \$deliveryTimeline,
             usageType: \$usageType, usageLength: \$usageLength,
              isDigitalContentCreator: \$isDigitalContentCreator, isOffer: \$isOffer,
               hasAdditional: \$hasAdditional, discount: \$discount,
               initialDeposit: \$initialDeposit, bannerUrl: \$bannerUrl,
               category: \$category, faq: \$faq
               ) {
             success
             message
             service {
              id
              title
              description
              serviceType
              period
              price
              usageType
              usageLength
              #deleted
              deliveryTimeline
              createdAt
              lastUpdated
              isDigitalContentCreator
              hasAdditional
              views
              discount
              isOffer
              banner {
                url
                thumbnail
              }
              initialDeposit
              category
              user {
               id
               username
               displayName
               isVerified
               blueTickVerified
               isBusinessAccount
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
             }
            }
          }

        ''', payload: {
        "title": title,
        "price": price,
        "serviceType": serviceType,
        "description": description,
        "deliveryTimeline": deliveryTimeline,
        "usageLength": usageLength,
        "usageType": usageType,
        "period": period,
        "isDigitalContentCreator": isDigitalContent,
        "hasAdditional": hasAdditionalServices,
        "isOffer": isOffer,
        "discount": percentDiscount ?? 0,
        "bannerUrl": banner,
        "initialDeposit": initialDeposit,
        "category": category,
        "faq": faqs,
      });

      final Either<CustomException, Map<String, dynamic>> response =
          result.fold((left) {
        print("falsi ${left.message}");
        return Left(left);
      }, (right) {
        final parentMap = right?['createService'];
        final isSuccess = parentMap['success'] ?? false;
        if (isSuccess) {
          print('${parentMap["service"]}');
          return Right(parentMap['service']);
        }
        print('LLLLLLLLLLLLLLLLL got here');
        return Right({});
      });

      return response;
    } catch (e, st) {
      print('failed to create service $e \n $st');
      return Left(CustomException(e.toString()));
    }
  }

  Future<Either<CustomException, Map<String, dynamic>>> duplicate(
      {required Map<String, dynamic> data}) async {
    print('duplicating a service');
    try {
      final result =
          await vBaseServiceInstance.mutationQuery(mutationDocument: '''
          mutation createService(\$period: String!,\$title: String!,
          \$serviceType: String!, \$description: String,\$price: Float!,
          \$deliveryTimeline: String!, \$usageType: String,\$usageLength: String,
          \$isDigitalContentCreator:Boolean!, \$hasAdditional:Boolean!, \$isOffer: Boolean!,
          \$discount: Int, \$initialDeposit: Int, \$bannerUrl: [BannerInputType], 
          \$category: [String], \$publish: Boolean, \$faq: [FAQType]) {
             createService(period: \$period,title: \$title, serviceType: \$serviceType,
             description: \$description, price: \$price,deliveryTimeline: \$deliveryTimeline,
             usageType: \$usageType, usageLength: \$usageLength,
              isDigitalContentCreator: \$isDigitalContentCreator, isOffer: \$isOffer,
               hasAdditional: \$hasAdditional, discount: \$discount,
               initialDeposit: \$initialDeposit, bannerUrl: \$bannerUrl,
               category: \$category, publish: \$publish, faq: \$faq) {
             success
             message
             service {
              id
              title
              description
              serviceType
              period
              price
              usageType
              usageLength
              #deleted
              deliveryTimeline
              createdAt
              lastUpdated
              isDigitalContentCreator
              hasAdditional
              views
              discount
              isOffer
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
               displayName
               isVerified
               blueTickVerified
               isBusinessAccount
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
             }
            }
          }

        ''', payload: data);

      final Either<CustomException, Map<String, dynamic>> response =
          result.fold((left) {
        print("leftttttttt ${left.message}");
        return Left(left);
      }, (right) {
        final parentMap = right?['createService'];
        final isSuccess = parentMap['success'] ?? false;
        if (isSuccess) {
          print('[uu1] ${parentMap["service"]["user"]}');
          return Right(parentMap['service']);
        }
        print('LLLLLLLLLLLLLLLLL got here');
        return Right({});
      });

      return response;
    } catch (e, st) {
      print('failed to create service $e \n $st');
      return Left(CustomException(e.toString()));
    }
  }

  Future<Either<CustomException, Map<String, dynamic>>> updateService({
    required int serviceId,
    required String period,
    required String title,
    required String description,
    required String serviceType,
    required double price,
    required String deliveryTimeline,
    String? usageType,
    String? usageLength,
    required bool isDigitalContent,
    required bool hasAdditionalServices,
    int? percentDiscount,
    int? initialDeposit,
    List? banner,
    List<String>? category,
    List? faqs,
  }) async {
    print('updating service with id $serviceId');
    try {
      final result =
          await vBaseServiceInstance.mutationQuery(mutationDocument: '''

          mutation updateService(\$serviceId:Int!, \$period: String!,\$title: String!,
          \$serviceType: String!, \$description: String,\$price: Float!,
          \$deliveryTimeline: String!, \$usageType: String,\$usageLength: String,
           \$isDigitalContentCreator:Boolean!, \$hasAdditional:Boolean!,
           \$discount: Int, \$initialDeposit: Int, \$bannerUrl: [BannerInputType],
           \$category: [String], \$faq: [FAQType],
           ) {
             updateService(serviceId:\$serviceId, period: \$period,title: \$title, serviceType: \$serviceType,
             description: \$description, price: \$price,deliveryTimeline: \$deliveryTimeline,
             usageType: \$usageType, usageLength: \$usageLength,
              isDigitalContentCreator: \$isDigitalContentCreator,
               hasAdditional: \$hasAdditional, discount: \$discount,
               initialDeposit: \$initialDeposit, bannerUrl: \$bannerUrl,
               category: \$category, faq: \$faq,
               ) {
             success
             message
             service {
              id
              title
              description
              serviceType
              period
              price
              usageType
              usageLength
              #deleted
              deliveryTimeline
              createdAt
              lastUpdated
              isDigitalContentCreator
              hasAdditional
              discount

              views
              banner {
                url
                thumbnail
              }
              initialDeposit
              category
              isOffer
              paused
              processing
              status
              user {
               id
               username
               displayName
               isVerified
               blueTickVerified
               isBusinessAccount
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
             }
            }
          }

        ''', payload: {
        "serviceId": serviceId,
        "title": title,
        "price": price,
        "description": description,
        "serviceType": serviceType,
        "deliveryTimeline": deliveryTimeline,
        "usageLength": usageLength,
        "usageType": usageType,
        "period": period,
        "isDigitalContentCreator": isDigitalContent,
        "hasAdditional": hasAdditionalServices,
        "discount": percentDiscount,
        "bannerUrl": banner,
        "initialDeposit": initialDeposit,
        "category": category,
        "faq": faqs,
      });

      final Either<CustomException, Map<String, dynamic>> response =
          result.fold((left) => Left(left), (right) {
        final parentMap = right?['updateService'];
        if (parentMap != null) {
          return Right(parentMap);
        }
        return Right({"message": "Something went wrong updating service"});
      });

      return response;
    } catch (e) {
      return Left(CustomException(e.toString()));
    }
  }

  Future<Either<CustomException, Map<String, dynamic>>> pauseService(
      int serviceId) async {
    print(serviceId);
    try {
      final result =
          await vBaseServiceInstance.mutationQuery(mutationDocument: '''
          mutation pauseService(\$serviceId: Int!) {
            pauseService(serviceId: \$serviceId) {
              success
            }
          }
        ''', payload: {
        "serviceId": serviceId,
      });

      final Either<CustomException, Map<String, dynamic>> userName =
          result.fold((left) => Left(left), (right) {
        print('[pauseService] %%%%%%%%%%%%%%% $right');
        return Right(right!['pauseService']);
      });

      return userName;
    } catch (e) {
      return Left(CustomException(e.toString()));
    }
  }

  Future<Either<CustomException, Map<String, dynamic>>> resumeService(
      int serviceId) async {
    print(serviceId);
    try {
      final result =
          await vBaseServiceInstance.mutationQuery(mutationDocument: '''
          mutation resumeService(\$serviceId: Int!) {
            resumeService(serviceId: \$serviceId) {
              success
            }
          }
        ''', payload: {
        "serviceId": serviceId,
      });

      final Either<CustomException, Map<String, dynamic>> userName =
          result.fold((left) => Left(left), (right) {
        print('[resumeService] %%%%%%%%%%%%%%% $right');
        return Right(right!['resumeService']);
      });

      return userName;
    } catch (e) {
      return Left(CustomException(e.toString()));
    }
  }

  Future<Either<CustomException, Map<String, dynamic>>> publishService(
      int serviceId) async {
    print('publish a service');
    print(serviceId);
    try {
      final result =
          await vBaseServiceInstance.mutationQuery(mutationDocument: '''
          mutation publishService(\$serviceId: Int!) {
          publishService(serviceId:\$serviceId) {
            success
            }
          }
        ''', payload: {
        "serviceId": serviceId,
      });

      final Either<CustomException, Map<String, dynamic>> userName =
          result.fold((left) => Left(left), (right) {
        print('[pd] %%%%%%%%%%%%%%% $right');
        return Right(right!['publishService']);
      });

      return userName;
    } catch (e) {
      return Left(CustomException(e.toString()));
    }
  }

  Future<Either<CustomException, Map<String, dynamic>>> deleteService(
      int serviceId) async {
    print('delete a service');
    print(serviceId);
    try {
      final result =
          await vBaseServiceInstance.mutationQuery(mutationDocument: '''
          mutation deleteService(\$serviceId: Int!) {
          deleteService(serviceId:\$serviceId) {
            success
            message
            }
          }
        ''', payload: {
        "serviceId": serviceId,
      });

      final Either<CustomException, Map<String, dynamic>> userName =
          result.fold((left) => Left(left), (right) {
        print('[pd] %%%%%%%%%%%%%%% $right');
        return Right(right!['deleteService']);
      });

      return userName;
    } catch (e) {
      return Left(CustomException(e.toString()));
    }
  }

  Future<Either<CustomException, Map<String, dynamic>>> likeService(
      int serviceId) async {
    print(serviceId);
    try {
      final result =
          await vBaseServiceInstance.mutationQuery(mutationDocument: '''
          mutation likeService(\$serviceId: Int!) {
  likeService(serviceId: \$serviceId) {
    success
  }
}
        ''', payload: {
        "serviceId": serviceId,
      });

      final Either<CustomException, Map<String, dynamic>> userName =
          result.fold((left) => Left(left), (right) {
        print('[pd] %%%%%%%%%%%%%%% $right');
        return Right(right!['likeService']);
      });

      return userName;
    } catch (e) {
      return Left(CustomException(e.toString()));
    }
  }

  Future<Either<CustomException, Map<String, dynamic>>> saveService(
      int serviceId) async {
    print(serviceId);
    try {
      final result =
          await vBaseServiceInstance.mutationQuery(mutationDocument: '''
          mutation saveService(\$serviceId: Int!) {
  saveService(serviceId: \$serviceId) {
    success
  }
}
        ''', payload: {
        "serviceId": serviceId,
      });

      final Either<CustomException, Map<String, dynamic>> userName =
          result.fold((left) => Left(left), (right) {
        print('[pd] %%%%%%%%%%%%%%% $right');
        return Right(right!['saveService']);
      });

      return userName;
    } catch (e) {
      return Left(CustomException(e.toString()));
    }
  }
}
