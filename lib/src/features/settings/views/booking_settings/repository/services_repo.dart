import 'dart:developer';

import 'package:either_option/either_option.dart';
import 'package:vmodel/src/app_locator.dart';
import 'package:vmodel/src/core/utils/exception_handler.dart';

class ServicePackagesRepository {
  ServicePackagesRepository._();

  //For debugging purposes only
  final _TAG = 'ServicePackagesRepository';

  static ServicePackagesRepository instance = ServicePackagesRepository._();

  Future<Either<CustomException, List<dynamic>>> userServices(
      String? username) async {
    try {
      final result = await vBaseServiceInstance.getQuery(queryDocument: '''
      query userServices (\$username: String!) {
  userServices (username: \$username) {
                id
                title
                price
                description
                period
                user{
               id
               firstName
               lastName
               }
                delivery{
               id
               name
               addedBy
               }
               usageType
               usageLength
               deleted
               deliveryTimeline
  }
}
        ''', payload: {
        'username': username,
      });
  

      final Either<CustomException, List<dynamic>> response =
          result.fold((left) => Left(left), (right) {
        // print("77777777777777777777777777777777 $right");

        final albumList = right?['userServices'] as List<dynamic>?;
        return Right(albumList ?? []);
      });

      // print("''''''''''''''''''''''''''''''$response");
      return response;
    } catch (e) {
      return Left(CustomException(e.toString()));
    }
  }

  Future<Either<CustomException, Map<String, dynamic>>> createService(
      String deliveryTimeline,
      String description,
      String period,
      double price,
      String title,
      String usageLength,
      String usageType) async {
    try {
     
      final result =
          await vBaseServiceInstance.mutationQuery(mutationDocument: '''
          mutation createService(\$deliveryTimeline: String!, \$description: String, \$period: String!, \$price: Float!, \$title: String!, \$usageLength: String!, \$usageType: String!) {
            createService(deliveryTimeline: \$deliveryTimeline, description: \$description, period: \$period, price: \$price, title: \$title, usageLength: \$usageLength, usageType: \$usageType) {
              success
              message
              service{
                id
                title
                price
                description
                period
                user{
               id
               firstName
               lastName
               }
                delivery{
               id
               name
               addedBy
               }
               usageType
               usageLength
               deleted
               deliveryTimeline
               }
            }
          }
        ''', payload: {
        'deliveryTimeline': deliveryTimeline,
        'description': description,
        'period': period,
        'price': price,
        'title': title,
        'usageLength': usageLength,
        'usageType': usageType
      });
   
      final Either<CustomException, Map<String, dynamic>> userName =
          result.fold((left) => Left(left), (right) {
        print('%%%%%%%%%%%%%%% $right');
        return Right(right!['tokenAuth']);
      });
      print("tis is the $usageType");
      return userName;
    } catch (e) {
      log("${Left(e.toString())}");
      print("tis is the $usageType");
      return Left(CustomException(e.toString()));
    }
  }

  Future<Either<CustomException, Map<String, dynamic>>> updateService(
      String deliveryTimeline,
      String description,
      String period,
      double price,
      String title,
      String usageLength,
      String usageType) async {
    try {
      final result =
          await vBaseServiceInstance.mutationQuery(mutationDocument: '''
          mutation UpdateService(\$deliveryTimeline: String, \$description: Strin, \$period: String, \$price: Float, \$title: String, \$usageLength: String, \$usageType: String) {
            updateService(deliveryTimeline: \$deliveryTimeline, description: \$description, period: \$period, price: \$price, title: \$title, usageLength: \$usageLength, usageType: \$usageType) {
              
              service{
                id
                title
                price
                description
                period
                user{
               id
               firstName
               lastName
               }
                delivery{
               id
               name
               addedBy
               }
               usageType
               usageLength
               deleted
               deliveryTimeline
               }
            }
          }
        ''', payload: {
        'deliveryTimeline': deliveryTimeline,
        'description': description,
        'period': period,
        'price': price,
        'title': title,
        'usageLength': usageLength,
        'usageType': usageType
      });

      print("tis is the $usageType");
      final Either<CustomException, Map<String, dynamic>> userName =
          result.fold((left) => Left(left), (right) {
        print('%%%%%%%%%%%%%%% $right');
        return Right(right!['tokenAuth']);
      });

      return userName;
    } catch (e) {
      print("tis is the $usageType");
      return Left(CustomException(e.toString()));
    }
  }

  Future<Either<CustomException, Map<String, dynamic>>> deleteService(
      int serviceId) async {
    try {
      final result =
          await vBaseServiceInstance.mutationQuery(mutationDocument: '''
          mutation DeleteService(\$serviceId: Int!) {
            deleteService(serviceId: \$serviceId,) {
              success
              message
            }
          }
        ''', payload: {'serviceId': serviceId});

      final Either<CustomException, Map<String, dynamic>> userName =
          result.fold((left) => Left(left), (right) {
        print('%%%%%%%%%%%%%%% $right');
        return Right(right!['tokenAuth']);
      });

      return userName;
    } catch (e) {
      return Left(CustomException(e.toString()));
    }
  }

  Future<Either<CustomException, List<dynamic>>> userService(
      String? username, int? serviceId) async {
  
    try {
      final result = await vBaseServiceInstance.getQuery(queryDocument: '''
      query userService (\$username: String!, \$serviceId: Int!) {
  userService (username: \$username, serviceId: \$serviceId) {
    
                id
                title
                price
                description
                period
                user{
               id
               firstName
               lastName
               }
                delivery{
               id
               name
               addedBy
               }
               usageType
               usageLength
               deleted
               deliveryTimeline
  }
}
        ''', payload: {
        'username': username,
        'serviceId': serviceId,
      });
   

      final Either<CustomException, List<dynamic>> response =
          result.fold((left) => Left(left), (right) {
        // print("77777777777777777777777777777777 $right");

        final albumList = right?['userServices'] as List<dynamic>?;
        return Right(albumList ?? []);
      });

      // print("''''''''''''''''''''''''''''''$response");
      return response;
    } catch (e) {
      return Left(CustomException(e.toString()));
    }
  }

 
}
