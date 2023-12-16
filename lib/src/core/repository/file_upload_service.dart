import 'dart:io';
import 'dart:typed_data';

import 'package:either_option/either_option.dart';
// import 'package:get/get.dart';
import 'package:vmodel/src/core/api/file_service.dart';
import 'package:vmodel/src/core/utils/exception_handler.dart';

class FileUploadRepository {
  FileUploadRepository._();
  static FileUploadRepository instance = FileUploadRepository._();

  //Upload file

  Future<Either<CustomException, String?>> uploadFiles(List<File> files,
      {OnUploadProgressCallback? onUploadProgress,
      required String uploadEndpoint}) async {
    final fps = files.map((e) => e.path).toList();
    try {
      final res = await FileService.fileUploadMultipart(
        url: uploadEndpoint,
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
      {OnUploadProgressCallback? onUploadProgress,
      required String uploadEndpoint}) async {
    // final fps = files.map((e) => e.path).toList();
    try {
      final res = await FileService.rawBytesDataUploadMultipart(
        url: uploadEndpoint,
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
