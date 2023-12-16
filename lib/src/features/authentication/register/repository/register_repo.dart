import 'package:either_option/either_option.dart';
import 'package:vmodel/src/app_locator.dart';
import 'package:vmodel/src/core/utils/exception_handler.dart';

final registerRepoInstance = RegisterReposity.instance;

class RegisterReposity {
  RegisterReposity._();
  static RegisterReposity instance = RegisterReposity._();
  // final GraphQLClient _client = vBaseServiceInstance.client;

  Future<Either<CustomException, Map<String, dynamic>>> getUserTypes() async {
    try {
      final result = await vBaseServiceInstance.getQuery(queryDocument: '''
{
  userTypes{
    enterprise
    businessLabels
    talents
    talentLabels{
      model
      influencer
      digitalCreator
      photographer
      videographer
      stylist
      petModel{
        cat
        dog
      }
    }
  }
}
        ''', payload: {});

      return result.fold((left) {
        print('failed registering ----------->>>>>>> $left');
        return Left(left);
      }, (right) {
        print('success registering ----------->>>>>>> $right');
        return Right(right!['userTypes']);
      });
    } catch (e) {
      return Left(CustomException(e.toString()));
    }
  }

  //Todo update signup to use this request
  Future<Either<CustomException, Map<String, dynamic>>> register({
    required String email,
    required String password1,
    required String username,
    required String password2,
    required String firstName,
    required String lastName,
    required String userType,
    required String userTypeLabel,
    required bool isBusinessAccount,
  }) async {
    print(email);
    try {
      final result =
          await vBaseServiceInstance.mutationQuery(mutationDocument: '''
      
          mutation Register(\$email: String!, \$password1: String!,
           \$password2: String!, \$username: String!, \$lastName: String!,
            \$firstName: String!, \$userType: String!, \$label: String!,
             \$isBusinessAccount: Boolean!) {
            register(email: \$email, password1: \$password1,
             password2: \$password2, username: \$username, lastName: \$lastName,
              firstName: \$firstName,  userType: \$userType, label: \$label,
               isBusinessAccount: \$isBusinessAccount ) {
              success,
              token,
              restToken,
              errors,
            }
          }

        ''', payload: {
        'email': email,
        'password1': password1,
        'password2': password2,
        'username': username,
        'firstName': firstName,
        'lastName': lastName,
        'userType': userType,
        'label': userTypeLabel,
        'isBusinessAccount': isBusinessAccount,
      });

      return result.fold((left) {
        print('failed registering ----------->>>>>>> $left');
        return Left(left);
      }, (right) {
        print('success registering ----------->>>>>>> $right');
        return Right(right!['register']);
      });
    } catch (e) {
      return Left(CustomException(e.toString()));
    }
  }

  Future<bool> checkUserNameAvailability(String username) async {
    try {
      final result = await vBaseServiceInstance.mutationQuery(
        mutationDocument: '''
        mutation CheckIfUsernameExist(\$username: String!) {
          getIfUsernameExist(username: \$username) {
            message
            exists
          }
        }
      ''',
        payload: {'username': username},
      );

      final Either<CustomException, Map<String, dynamic>?> eitherResult =
          result;

      final bool exists = eitherResult.fold((left) {
        print('Error checking username availability: $left');
        return false;
      }, (right) {
        final gQLData = right;
        print("Query DATA ====> ${gQLData?['getIfUsernameExist']}");
        return gQLData?['getIfUsernameExist']['exists'] ?? false;
      });

      return exists;
    } catch (e) {
      print('Error checking username availability: $e');
      return false;
    }
  }

  Future<Either<CustomException, Map<String, dynamic>>> updateUserLocation(
      int id,
      // String username,
      String locationName,
      double long,
      double lat,
      String userType) async {
    // print('location update username is EEEEEEEEEEEEEEEEEEEEEEEEE $username');
    try {
      final result =
          await vBaseServiceInstance.mutationQuery(mutationDocument: '''
       mutation updateUser(\$id: ID!, \$locationName: String!, \$latitude: Float!, \$longitude: Float!){
  updateUser(input:{
   
    location:{
      create:{
        latitude:\$latitude,
        longitude:\$longitude,
        locationName:\$locationName,
      }
    }
  },where:{
    id:{
      exact: \$id
    }
  }){
    ok
    errors{
      messages
      field
    }
    result{
      id
    }
  }
} 

        ''', payload: {
        'id': id,
        'locationName': locationName,
        'latitude': lat,
        // 'username': username,
        'longitude': long,
      });

      final Either<CustomException, Map<String, dynamic>> userName =
          result.fold((left) => Left(left), (right) => Right(right!));

      return userName;
    } catch (e) {
      return Left(CustomException(e.toString()));
    }
  }

  updatePrice(String username, double price, String userType) async {
    try {
      final result =
          await vBaseServiceInstance.mutationQuery(mutationDocument: '''
            mutation updateUser(\$username: String!, \$price: Float!){
  updateUser(input:{

    price:\$price,
  },where:{
    id:{
      exact:\$id
    }
  }){
    ok
    errors{
      messages
      field
    }
    result{
      id
    }
  }
}
        ''', payload: {'price': price, 'username': username});

      final Either<CustomException, Map<String, dynamic>> userName =
          result.fold((left) => Left(left), (right) => Right(right!));

      return userName;
    } catch (e) {
      return Left(CustomException(e.toString()));
    }
  }

  updateWebsite(int userID, String website, String userType) async {
    try {
      final result =
          await vBaseServiceInstance.mutationQuery(mutationDocument: '''
            mutation updateuser(\$id: ID!,\$website: String!){
  updateUser(input:{
  
    website:\$website
  },where:{
    id:{
      exact:\$id
    }
  }){
    ok
    errors{
      messages
      field
    }
    result{
      id
    }
  }
}
        ''', payload: {
        'website': website,
        'id': userID,
      });

      final Either<CustomException, Map<String, dynamic>> userName =
          result.fold((left) => Left(left), (right) => Right(right!));

      return userName;
    } catch (e) {
      return Left(CustomException(e.toString()));
    }
  }

  updateAccountType(
      int id, bool isBusinessAccount, String specifiedAccountType) async {
    try {
      final result =
          await vBaseServiceInstance.mutationQuery(mutationDocument: '''
      mutation updateUser(\$id: ID!, \$isBusinessAccount: Boolean!, \$type: String!){
  updateUser(input:{
    isBusinessAccount:\$isBusinessAccount
    userType:\$type
  },where:{
    id:{
      exact:\$id
    }
  }){
    ok
    errors{
      messages
      field
    }
    result{
      id
      username
      isBusinessAccount
      userType
    }
  }
}
        ''', payload: {
        'isBusinessAccount': isBusinessAccount,
        'type': specifiedAccountType,
        'id': id,
      });

      final Either<CustomException, Map<String, dynamic>> data =
          result.fold((left) => Left(left), (right) => Right(right!));

      // return userName;
      return;
    } catch (e) {
      print('Error updating account type $e');
      return Left(CustomException(e.toString()));
    }
  }

  Future<List<Map<String, dynamic>>> searchUsers(String searchQuery) async {
    try {
      final result = await vBaseServiceInstance.mutationQuery(
        mutationDocument: '''
        query SearchUsers(\$search: String!) {
          searchUsers(search: \$search) {
            username
            firstName
            lastName
            profilePictureUrl
          }
        }
      ''',
        payload: {'search': searchQuery},
      );

      final Either<CustomException, Map<String, dynamic>?> searchResult =
          result;

      return searchResult.fold(
        (left) {
          print('Error searching users: ${left.message}');
          return <Map<String, dynamic>>[];
        },
        (right) {
          final List<dynamic> userDataList =
              right?['searchUsers'] as List<dynamic>;

          return userDataList
              .map((userData) => <String, dynamic>{
                    'username': userData['username'],
                    'firstName': userData['firstName'],
                    'lastName': userData['lastName'],
                    'profilePictureUrl': userData['profilePictureUrl'],
                  })
              .toList();
        },
      );
    } catch (e) {
      print('Error searching users: $e');
      return <Map<String, dynamic>>[];
    }
  }
}
