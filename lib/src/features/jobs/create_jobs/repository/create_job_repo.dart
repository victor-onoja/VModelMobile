import 'dart:io';

import 'package:either_option/either_option.dart';
import 'package:flutter/foundation.dart';
// import 'package:get/get.dart';
import 'package:vmodel/src/app_locator.dart';
import 'package:vmodel/src/core/api/file_service.dart';
import 'package:vmodel/src/core/network/urls.dart';
import 'package:vmodel/src/core/utils/exception_handler.dart';

import '../model/job_data.dart';

class CreateJobRepository {
  CreateJobRepository._();
  static CreateJobRepository instance = CreateJobRepository._();

  Future<Either<CustomException, Map<String, dynamic>>> createJob({
    required JobDataModel jobData,
    required List<Map<String, dynamic>> deliveryData,
    required bool isAdvanced,
  }) async {
    print("'''''''''''wwwwwwwwww\n\n ${jobData.toJson()}");
    print("\n\n'''''''''''wwwwwwwwww $deliveryData");
    try {
      final result =
          await vBaseServiceInstance.mutationQuery(mutationDocument: '''
mutation postJob(
\$jobTitle: String!, 
\$jobType:String!, 
\$priceOption:String!, 
\$priceValue: Float!, 
\$talents: [String]!, 
\$preferredGender:String!, 
\$deliveryData: [DeliveryDataInputType]!, 
\$deliveryType: String, 
\$isDigitalContent: Boolean!, 
\$brief:String, 
\$briefFile: String, 
\$briefLink:String,
\$location:LocationInputType!, 
\$deliverablesType: String!, 
\$usageType:String, 
\$usageLength: String 
\$minAge: Int 
\$maxAge: Int 
\$size: String 
\$skinComplexion: String
\$shortDescription: String! 
\$height: HeightInputType
\$ethnicity: String
\$acceptMultiple: Boolean!
\$category: [String]
) {
  createJob (
jobTitle: \$jobTitle,
jobType: \$jobType,
priceOption: \$priceOption,
priceValue: \$priceValue,
talents: \$talents,
preferredGender: \$preferredGender,
deliveryData: \$deliveryData,
brief: \$brief,
briefFile: \$briefFile,
briefLink: \$briefLink,
deliveryType: \$deliveryType,
isDigitalContent: \$isDigitalContent,
deliverablesType: \$deliverablesType,
usageType: \$usageType,
usageLength: \$usageLength,
location:\$location,
minAge: \$minAge,
maxAge: \$maxAge,
size: \$size,
skinComplexion: \$skinComplexion,
shortDescription: \$shortDescription,
height: \$height,
ethnicity: \$ethnicity,
acceptMultiple: \$acceptMultiple,
category: \$category,
  ) {
    success
    job {
      id
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
      acceptMultiple
      category
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
        username
      }
    }
  }
}

# mutation postJob(
# \$jobTitle: String!, 
# \$jobType:String!, 
# \$priceOption:String!, 
# \$priceValue: Float!, 
# \$talents: [String]!, 
# \$preferredGender:String!, 
# \$deliveryData: [DeliveryDataInputType]!, 
# \$deliveryType: String!, 
# \$isDigitalContent: Boolean!, 
# \$brief:String, 
# \$briefFile: String, 
# \$briefLink:String,
# \$location:LocationInputType!, 
# \$deliverablesType: String!, 
# \$usageType:String, 
# \$usageLength: String,
# \$minAge: Int, 
# \$maxAge: Int, 
# \$size: String, 
# \$skinComplexion: String,
# \$shortDescription: String!, 
# \$height: HeightInputType,
# \$ethnicity: String,
# \$acceptMultiple: Boolean!,

# ) {
  # createJob (
# jobTitle: \$jobTitle,
# jobType: \$jobType,
# priceOption: \$priceOption,
# priceValue: \$priceValue,
# talents: \$talents,
# preferredGender: \$preferredGender,
# deliveryData: \$deliveryData,
# brief: \$brief,
# briefFile: \$briefFile,
# briefLink: \$briefLink,
# deliveryType: \$deliveryType,
# isDigitalContent: \$isDigitalContent,
# deliverablesType: \$deliverablesType,
# usageType: \$usageType,
# usageLength: \$usageLength,
# location:\$location,
# minAge: \$minAge,
# maxAge: \$maxAge,
# size: \$size,
# skinComplexion: \$skinComplexion,
# shortDescription: \$shortDescription,
# height: \$height,
# ethnicity: \$ethnicity,
# acceptMultiple: \$acceptMultiple,
  # ) {
    # success
    # job {
      # id
      # jobTitle
      # jobType
      # priceOption
      # priceValue
      # preferredGender
      # shortDescription
      # brief
      # briefLink
      # briefFile
      # deliverablesType
      # jobDelivery {
        # date
        # startTime
        # endTime
      # }
      # ethnicity
      # talentHeight{
        # value
        # unit
      # }
      # size
      # skinComplexion
      # minAge
      # maxAge
      # isDigitalContent
      # talents
      # jobLocation {
        # latitude
        # longitude
        # locationName
      # }
      # usageType {
        # id
        # name
      # }
      # usageLength {
        # id
        # name
      # }
      # creator {
        # username
      # }
    # }
  # }
# }
        ''', payload: {
        /*
        'jobTitle': jobData.jobTitle,
        'jobType': jobData.jobType,
        'priceOption': jobData.priceOption,
        'priceValue': jobData.priceValue,
        'talents': jobData.talents,
        'preferredGender': jobData.preferredGender,
        // 'deliveryData': 'zzzzzzzzzzzzwwwwwwwwww',
        "deliveryData": [
          {"date": "2023-07-12", "startTime": "8:00 am", "endTime": "9:00 am"}
        ],
        'brief': jobData.brief,
        'briefFile': jobData.briefFile,
        'briefLink': jobData.briefLink,
        'deliveryType': jobData.deliverablesType,
        'isDigitalContent': jobData.isDigitalContent,
        'deliverablesType': jobData.deliverablesType,
        'usageType': jobData.usageType,
        'usageLength': jobData.usageLength,
        // 'location': jobData.location,
        "location": {
          "latitude": "0",
          "longitude": "0",
          "locationName": "Alaska, US"
        },
        'minAge': jobData.minAge,
        'maxAge': jobData.maxAge,
        'size': jobData.size.apiValue,
        'skinComplexion': jobData.complexion,
        'shortDescription': jobData.shortDescription,
        // 'height': jobData.height,
        "height": {"inches": 6, "cm": 4},
        'ethnicity': 'Black',//jobData.ethnicity.apiValue,
        */

        "jobTitle": jobData.jobTitle,
        "jobType": jobData.jobType,
        'priceOption': jobData.priceOption,
        'priceValue': jobData.priceValue,
        "talents": jobData.talents,
        'preferredGender': jobData.preferredGender,
        "deliveryData": deliveryData,
        'brief': jobData.brief,
        'briefFile': jobData.briefFile,
        'briefLink': jobData.briefLink,
        'deliveryType': "type",
        'isDigitalContent': jobData.isDigitalContent,
        'deliverablesType': jobData.deliverablesType,
        'usageType': jobData.isDigitalContent ? jobData.usageType : null,
        'usageLength': jobData.isDigitalContent ? jobData.usageLength : null,
        "location": jobData.location,
        'minAge': jobData.minAge,
        'maxAge': jobData.maxAge,
        'size': isAdvanced ? jobData.size?.apiValue : null,
        // 'skinComplexion': jobData.complexion,
        'skinComplexion': null,
        'shortDescription': jobData.shortDescription,
        'height': isAdvanced ? jobData.height : null,
        'ethnicity': isAdvanced ? jobData.ethnicity?.apiValue : null,
        'acceptMultiple': jobData.acceptMultiple,
        'category': jobData.category,

        // "jobTitle": "Jobless 2",
        // "jobType": "On-Location",
        // "priceOption": "hour",
        // "priceValue": 87.50,
        // "talents": ["model"],
        // "preferredGender": "male",
        // "deliveryData": [
        //   {"date": "2023-07-12", "startTime": "540", "endTime": "1020"}
        // ],
        // "brief": null,
        // "briefFile": null,
        // "briefLink": null,
        // "deliveryType": "Digital photos of model",
        // "isDigitalContent": false,
        // "deliverablesType": "Photoshoot for 1 hour",
        // "usageType": null,
        // "usageLength": null,
        // "location": {
        //   "latitude": "0",
        //   "longitude": "0",
        //   "locationName": "Tampa, US"
        // },
        // "minAge": 0,
        // "maxAge": 0,
        // "size": null,
        // "skinComplexion": null,
        // "shortDescription": "A short description",
        // "height": null,
        // "ethnicity": null,
        // "acceptMultiple": false

        //Test Data
        // "jobTitle": "First test job 1",
        // "jobType": "On-Location",
        // "priceOption": "hour",
        // "priceValue": 33.50,
        // "talents": [
        //   {"talentType": "model", "numOfTalent": 1}
        // ],
        // "preferredGender": "male",
        // "deliveryData": [
        //   {"date": "2023-07-22", "startTime": "540", "endTime": "1020"}
        // ],
        // "brief": "This is a short brief about the job",
        // "briefFile": "briefFile",
        // "briefLink": "http://www.myfile.app/document.pdf",
        // "deliveryType": "Digital photos of model",
        // "isDigitalContent": false,
        // "deliverablesType": "Photoshoot for 1 hour",
        // "usageType": "commercial",
        // "usageLength": "1 year",
        // "location": {
        //   "latitude": "0",
        //   "longitude": "0",
        //   "locationName": "Alaska, US"
        // },
        // "minAge": 20,
        // "maxAge": 30,
        // "size": "Mq",
        // "skinComplexion": "Light",
        // "shortDescription": "A short description",
        // "height": {"value": 6, "unit": "cm"},
        // "ethnicity": "Asian",
      });

      return result.fold((left) {
        print('BBBB000000000000 $left');
        return Left(left);
      }, (right) {
        print('YYYYYYyayyyyy $right');
        return Right(right!['createJob']);
      });
    } catch (e) {
      print('Error $e');
      return Left(CustomException(e.toString()));
    }
  }

  Future<Either<CustomException, Map<String, dynamic>>> updateJob({
    required int jobId,
    required JobDataModel jobData,
    required List<Map<String, dynamic>> deliveryData,
    required bool isAdvanced,
  }) async {
    // print("'''''''''''wwwwwwwwww\n\n ${jobData.toJson()}");
    debugPrint("ID IS $jobId w\n\n ${jobData.toJson()}");
    print("\n\n'''''''''''wwwwwwwwww $deliveryData");
    try {
      final result =
          await vBaseServiceInstance.mutationQuery(mutationDocument: '''

          mutation update(
          \$jobId: Int!, 
          \$jobTitle: String!, 
          \$jobType:String!, 
          \$priceOption:String!, 
          \$priceValue: Float!, 
          \$talents: [String]!, 
          \$preferredGender:String!, 
          \$deliveryData: [DeliveryDataInputType]!, 
          \$deliveryType: String, 
          \$isDigitalContent: Boolean!, 
          \$brief:String, 
          \$briefFile: String, 
          \$briefLink:String,
          \$location:LocationInputType!, 
          \$deliverablesType: String!, 
          \$usageType:String, 
          \$usageLength: String 
          \$minAge: Int 
          \$maxAge: Int 
          \$size: String 
          \$skinComplexion: String
          \$shortDescription: String! 
          \$height: HeightInputType
          \$ethnicity: String
          \$acceptMultiple: Boolean!
          \$category: String
          ) {
            updateJob (
              jobId: \$jobId,
          jobTitle: \$jobTitle,
          jobType: \$jobType,
          priceOption: \$priceOption,
          priceValue: \$priceValue,
          talents: \$talents,
          preferredGender: \$preferredGender,
          deliveryData: \$deliveryData,
          brief: \$brief,
          briefFile: \$briefFile,
          briefLink: \$briefLink,
          deliveryType: \$deliveryType,
          isDigitalContent: \$isDigitalContent,
          deliverablesType: \$deliverablesType,
          usageType: \$usageType,
          usageLength: \$usageLength,
          location:\$location,
          minAge: \$minAge,
          maxAge: \$maxAge,
          size: \$size,
          skinComplexion: \$skinComplexion,
          shortDescription: \$shortDescription,
          height: \$height,
          ethnicity: \$ethnicity,
          acceptMultiple: \$acceptMultiple,
          category: \$category,
            ) {
              success
              job {
                id
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
                acceptMultiple
                category
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
                  username
                }
              }
            }
          }


        ''', payload: {
        /*
        'jobTitle': jobData.jobTitle,
        'jobType': jobData.jobType,
        'priceOption': jobData.priceOption,
        'priceValue': jobData.priceValue,
        'talents': jobData.talents,
        'preferredGender': jobData.preferredGender,
        // 'deliveryData': 'zzzzzzzzzzzzwwwwwwwwww',
        "deliveryData": [
          {"date": "2023-07-12", "startTime": "8:00 am", "endTime": "9:00 am"}
        ],
        'brief': jobData.brief,
        'briefFile': jobData.briefFile,
        'briefLink': jobData.briefLink,
        'deliveryType': jobData.deliverablesType,
        'isDigitalContent': jobData.isDigitalContent,
        'deliverablesType': jobData.deliverablesType,
        'usageType': jobData.usageType,
        'usageLength': jobData.usageLength,
        // 'location': jobData.location,
        "location": {
          "latitude": "0",
          "longitude": "0",
          "locationName": "Alaska, US"
        },
        'minAge': jobData.minAge,
        'maxAge': jobData.maxAge,
        'size': jobData.size.apiValue,
        'skinComplexion': jobData.complexion,
        'shortDescription': jobData.shortDescription,
        // 'height': jobData.height,
        "height": {"inches": 6, "cm": 4},
        'ethnicity': 'Black',//jobData.ethnicity.apiValue,
        */

        "jobId": jobId,
        "jobTitle": jobData.jobTitle,
        "jobType": jobData.jobType,
        'priceOption': jobData.priceOption,
        'priceValue': jobData.priceValue,
        "talents": jobData.talents,
        'preferredGender': jobData.preferredGender,
        "deliveryData": deliveryData,
        'brief': jobData.brief,
        'briefFile': jobData.briefFile,
        'briefLink': jobData.briefLink,
        'deliveryType': "type",
        'isDigitalContent': jobData.isDigitalContent,
        'deliverablesType': jobData.deliverablesType,
        'usageType': jobData.isDigitalContent ? jobData.usageType : null,
        'usageLength': jobData.isDigitalContent ? jobData.usageLength : null,
        "location": jobData.location,
        'minAge': jobData.minAge,
        'maxAge': jobData.maxAge,
        'size': isAdvanced ? jobData.size?.apiValue : null,
        // 'skinComplexion': jobData.complexion,
        'skinComplexion': null,
        'shortDescription': jobData.shortDescription,
        'height': isAdvanced ? jobData.height : null,
        'ethnicity': isAdvanced ? jobData.ethnicity?.apiValue : null,
        'acceptMultiple': jobData.acceptMultiple,
        'category': jobData.category,

        // "jobTitle": "Jobless 2",
        // "jobType": "On-Location",
        // "priceOption": "hour",
        // "priceValue": 87.50,
        // "talents": ["model"],
        // "preferredGender": "male",
        // "deliveryData": [
        //   {"date": "2023-07-12", "startTime": "540", "endTime": "1020"}
        // ],
        // "brief": null,
        // "briefFile": null,
        // "briefLink": null,
        // "deliveryType": "Digital photos of model",
        // "isDigitalContent": false,
        // "deliverablesType": "Photoshoot for 1 hour",
        // "usageType": null,
        // "usageLength": null,
        // "location": {
        //   "latitude": "0",
        //   "longitude": "0",
        //   "locationName": "Tampa, US"
        // },
        // "minAge": 0,
        // "maxAge": 0,
        // "size": null,
        // "skinComplexion": null,
        // "shortDescription": "A short description",
        // "height": null,
        // "ethnicity": null,
        // "acceptMultiple": false

        //Test Data
        // "jobTitle": "First test job 1",
        // "jobType": "On-Location",
        // "priceOption": "hour",
        // "priceValue": 33.50,
        // "talents": [
        //   {"talentType": "model", "numOfTalent": 1}
        // ],
        // "preferredGender": "male",
        // "deliveryData": [
        //   {"date": "2023-07-22", "startTime": "540", "endTime": "1020"}
        // ],
        // "brief": "This is a short brief about the job",
        // "briefFile": "briefFile",
        // "briefLink": "http://www.myfile.app/document.pdf",
        // "deliveryType": "Digital photos of model",
        // "isDigitalContent": false,
        // "deliverablesType": "Photoshoot for 1 hour",
        // "usageType": "commercial",
        // "usageLength": "1 year",
        // "location": {
        //   "latitude": "0",
        //   "longitude": "0",
        //   "locationName": "Alaska, US"
        // },
        // "minAge": 20,
        // "maxAge": 30,
        // "size": "Mq",
        // "skinComplexion": "Light",
        // "shortDescription": "A short description",
        // "height": {"value": 6, "unit": "cm"},
        // "ethnicity": "Asian",
      });

      return result.fold((left) {
        print('BBBB000000000000 $left');
        return Left(left);
      }, (right) {
        print('YYYYYYyayyyyy $right');
        return Right(right!['updateJob']);
      });
    } catch (e) {
      print('Error $e');
      return Left(CustomException(e.toString()));
    }
  }

  Future<Either<CustomException, Map<String, dynamic>>> duplicateJob({
    required Map<String, dynamic> data,
  }) async {
    print("Duplicating job wwwwwwwww\n");
    // debugPrint("Duplicating job \n$data");
    // print("\n\n'''''''''''wwwwwwwwww $deliveryData");
    try {
      final result =
          await vBaseServiceInstance.mutationQuery(mutationDocument: '''
mutation duplicateJob(
\$jobTitle: String!, 
\$jobType:String!, 
\$priceOption:String!, 
\$priceValue: Float!, 
\$talents: [String]!, 
\$preferredGender:String!, 
\$deliveryData: [DeliveryDataInputType]!, 
\$deliveryType: String, 
\$isDigitalContent: Boolean!, 
\$brief:String, 
\$briefFile: String, 
\$briefLink:String,
\$location:LocationInputType!, 
\$deliverablesType: String!, 
\$usageType:String, 
\$usageLength: String 
\$minAge: Int 
\$maxAge: Int 
\$size: String 
\$skinComplexion: String
\$shortDescription: String! 
\$height: HeightInputType
\$ethnicity: String
\$acceptMultiple: Boolean!
\$category: String
\$publish: Boolean
) {
  createJob (
jobTitle: \$jobTitle,
jobType: \$jobType,
priceOption: \$priceOption,
priceValue: \$priceValue,
talents: \$talents,
preferredGender: \$preferredGender,
deliveryData: \$deliveryData,
brief: \$brief,
briefFile: \$briefFile,
briefLink: \$briefLink,
deliveryType: \$deliveryType,
isDigitalContent: \$isDigitalContent,
deliverablesType: \$deliverablesType,
usageType: \$usageType,
usageLength: \$usageLength,
location:\$location,
minAge: \$minAge,
maxAge: \$maxAge,
size: \$size,
skinComplexion: \$skinComplexion,
shortDescription: \$shortDescription,
height: \$height,
ethnicity: \$ethnicity,
acceptMultiple: \$acceptMultiple,
category: \$category,
publish: \$publish,
  ) {
    success
    job {
      id
      jobTitle
     #jobType
     #priceOption
     #priceValue
     #preferredGender
     #shortDescription
     #brief
     #briefLink
     #briefFile
     #deliverablesType
     #jobDelivery {
     #  date
     #  startTime
     #  endTime
     #}
     #ethnicity
     #talentHeight{
     #  value
     #  unit
     #}
     #size
     #skinComplexion
     #minAge
     #maxAge
     #isDigitalContent
     #talents
     #acceptMultiple
     #category
     #jobLocation {
     #  latitude
     #  longitude
     #  locationName
     #}
     #usageType {
     #  id
     #  name
     #}
     #usageLength {
     #  id
     #  name
     #}
     #creator {
     #  username
     #}
    }
  }
}

        ''', payload: data);

      return result.fold((left) {
        print('BBBB000000000000 $left');
        return Left(left);
      }, (right) {
        print('YYYYYYyayyyyy $right');
        return Right(right!['createJob']);
      });
    } catch (e) {
      print('Error $e');
      return Left(CustomException(e.toString()));
    }
  }

  //Upload file
  Future<Either<CustomException, String?>> uploadFiles(List<File> files,
      {OnUploadProgressCallback? onUploadProgress}) async {
    final fps = files.map((e) => e.path).toList();
    try {
      final res = await FileService.fileUploadMultipart(
        url: VUrls.postMediaUploadUrl,
        files: fps,
        onUploadProgress: onUploadProgress,
      );
      // return res;
      print('%%%MMMMMMMMM REturning right $res');
      return Right(res);
    } catch (e) {
      return Left(CustomException(e.toString()));
    }
  }

  Future<Either<CustomException, String?>> uploadRawBytesList(
      List<Uint8List> rawData,
      {OnUploadProgressCallback? onUploadProgress}) async {
    // final fps = files.map((e) => e.path).toList();
    try {
      final res = await FileService.rawBytesDataUploadMultipart(
        url: VUrls.postMediaUploadUrl,
        rawDataList: rawData,
        onUploadProgress: onUploadProgress,
      );
      // return res;
      print('%%%MMMMMMMMM REturning right $res');
      return Right(res);
    } catch (e) {
      return Left(CustomException(e.toString()));
    }
  }
}
