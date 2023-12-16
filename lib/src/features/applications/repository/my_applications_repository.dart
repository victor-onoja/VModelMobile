import 'package:either_option/either_option.dart';
import 'package:vmodel/src/app_locator.dart';
import 'package:vmodel/src/core/utils/exception_handler.dart';

class MyApplicationsRepository {
  MyApplicationsRepository._();
  static MyApplicationsRepository instance = MyApplicationsRepository._();

  Future<Either<CustomException, Map<String, dynamic>>> getMyApplications({
    int? pageCount,
    int? pageNumber,
  }) async {
    try {
      final result = await vBaseServiceInstance.getQuery(queryDocument: '''
query userApplications(
  \$pageNumber: Int!,
  
  \$pageCount: Int!,
	
	){
  userApplications(
   pageNumber:\$pageNumber,
    pageCount: \$pageCount
  ){
    id,
    dateCreated,
    job{
      noOfApplicants
      creator{
        id,
       
        thumbnailUrl
        lastName,
        firstName,
        username,
      },
      
    	jobTitle,
      priceOption,
      priceValue,
      preferredGender,
      shortDescription,
      briefFile,
      brief,
      briefLink,
      deliverablesType,
      isDigitalContent,
      jobType,
      deliveryType,
      ethnicity,
      size,
      skinComplexion,
      createdAt,
      deleted,
      views,
      acceptMultiple,
   
      minAge,
      maxAge,
      talents,
      talentHeight{
        value,
        unit,
      },
      jobDelivery{
        date,
        startTime,
        endTime,
      },
      jobLocation{
        latitude,
        longitude,
        locationName
      }
    },
    proposedPrice,
    accepted,
    rejected,
    deleted,
   
  }
}
        ''', payload: {
        'pageCount': pageCount,
        'pageNumber': pageNumber,
      });

      return result.fold((left) {
        print('left $left');
        return Left(left);
      }, (right) {
        print('$right');
        return Right(right!);
      });
    } catch (e) {
      print('Error $e');
      return Left(CustomException(e.toString()));
    }
  }
}



//       maxAge,
//       talents,
//       talentHeight{
//         value,
//         unit,
//       },
//       jobDelivery{
//         date,
//         startTime,
//         endTime,
//       },
//       jobLocation{
//         latitude,
//         longitude,
//         locationName
//       }
//     },
//     proposedPrice,
//     accepted,
//     rejected,
//     deleted,
//   }
// }