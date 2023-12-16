import 'dart:developer';

import 'package:either_option/either_option.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:vmodel/src/app_locator.dart';
import 'package:vmodel/src/core/utils/exception_handler.dart';

class VBaseService {
  VBaseService._();
  static VBaseService vBaseService = VBaseService._();
//Query(Same as Get request)
  Future<Either<CustomException, Map<String, dynamic>?>> getQuery(
      {required String queryDocument,
      required Map<String, dynamic> payload}) async {
    Either<CustomException, Map<String, dynamic>?> response;
    final request = await graphQLConfigInstance.client().query(QueryOptions(
          document: gql(queryDocument),
          variables: payload,
        ));

    // print(request);
    // print(request.parsedData.runtimeType);
    // print(request.parsedData);
    // print(request.source);

    if (request.hasException) {
      // log('query is: ${queryDocument}');
      print('getQuery Exception making request \n'
          '\n Link error: ${request.exception?.linkException},'
          ' \n graphQL Error: ${request.exception?.graphqlErrors}');
      response =
          Left(CustomException(request.exception!.linkException!.toString()));
    } else {
      response = Right(request.data);
    }

    return response;
  }

//Mutation(Same as Post request)
  Future<Either<CustomException, Map<String, dynamic>?>> mutationQuery(
      {required String mutationDocument,
      required Map<String, dynamic> payload}) async {
    Either<CustomException, Map<String, dynamic>?> response;
    final request = await graphQLConfigInstance.client().mutate(
        MutationOptions(document: gql(mutationDocument), variables: payload));
    // print(mutationDocument);
    // print('\n\n\n');
    // print(payload);
    print("VBaseService() Api response: ${request.data}");
    if (request.hasException) {
      final loginError = 'Exception making request:\n'
          // 'Mutation:  $mutationDocument \n'
          ' Error message: ${request.exception!.graphqlErrors.first.message}, \n'
          ' Link error: ${request.exception?.linkException},'
          ' \n GraphQL Error: ${request.exception?.graphqlErrors}';
      print(loginError);

      // debugPrint("PAYLOAD IS \n$payload");

      if (request.exception?.linkException == null) {
        var errMsg = request.exception!.graphqlErrors.first.message;
        // response = Left(CustomException(errMsg));
        response = Left(CustomException(errMsg));
      } else {
        response =
            Left(CustomException(request.exception!.linkException!.toString()));
        // response = Left(CustomException(loginError));
      }
    } else {
      response = Right(request.data);
    }

    return response;
  }

  //muation without options

  //Mutation(Same as Post request)
  Future<Map<String, dynamic>?> mutateOrdinaryQuery(
      {required String mutatonDocument,
      required Map<String, dynamic> payload}) async {
    final request = await graphQLConfigInstance.client().mutate(
        MutationOptions(document: gql(mutatonDocument), variables: payload));

    print("Api source: ${request.data}");

    return request.data;
  }

  //query

  //Query(Same as Get request)
  Future<Map<String, dynamic>?> getOrdinaryQuery(
      {required String queryDocument,
      required Map<String, dynamic> payload}) async {
    final request = await graphQLConfigInstance.client().query(QueryOptions(
          document: gql(queryDocument),
          variables: payload,
        ));

    // print(request);
    // print(request.parsedData.runtimeType);
    // print(request.parsedData);
    print(request.data);

    return request.data;
  }
}
