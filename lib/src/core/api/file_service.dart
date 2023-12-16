import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'package:path/path.dart' as fileUtil;
import "package:http_parser/http_parser.dart" show MediaType;

import '../network/graphql_confiq.dart';
// import 'package:upload_download_app/models/file.dart' as model;

typedef OnDownloadProgressCallback = void Function(
    int receivedBytes, int totalBytes);
typedef OnUploadProgressCallback = void Function(int sentBytes, int totalBytes);

class FileService {
  static bool trustSelfSigned = true;

  static HttpClient getHttpClient() {
    HttpClient httpClient = HttpClient()
      ..connectionTimeout = const Duration(seconds: 10);
    // ..badCertificateCallback = ((X509Certificate cert, String host, int port) => trustSelfSigned);

    return httpClient;
  }

  static String baseUrl = 'https://192.168.0.15:45455';

  // static fileGetAllMock() {
  //   return List.generate(
  //     20,
  //         (i) => model.File(
  //         fileName: 'filename $i.jpg',
  //         dateModified: DateTime.now().add(Duration(minutes: i)),
  //         size: i * 1000),
  //   );
  // }

  // static Future<List<model.File>> fileGetAll() async {
  //   var httpClient = getHttpClient();
  //
  //   final url = '$baseUrl/api/file';
  //
  //   var httpRequest = await httpClient.getUrl(Uri.parse(url));
  //
  //   var httpResponse = await httpRequest.close();
  //
  //   var jsonString = await readResponseAsString(httpResponse);
  //
  //   return model.fileFromJson(jsonString);
  // }

  static Future<String> fileDelete(String fileName) async {
    var httpClient = getHttpClient();

    final url = Uri.encodeFull('$baseUrl/api/file/$fileName');

    var httpRequest = await httpClient.deleteUrl(Uri.parse(url));

    var httpResponse = await httpRequest.close();

    var response = await readResponseAsString(httpResponse);

    return response;
  }

  /** FILE UPLOAD NOT USING MULTIPART
  static Future<String> fileUpload(
      {required String url,
      required File file,
      OnUploadProgressCallback? onUploadProgress}) async {
    // assert(file != null);

    final url = '$baseUrl/api/file';

    final fileStream = file.openRead();

    int totalByteLength = file.lengthSync();

    final httpClient = getHttpClient();

    final request = await httpClient.postUrl(Uri.parse(url));

    request.headers.set(HttpHeaders.contentTypeHeader, ContentType.binary);

    request.headers.add("filename", fileUtil.basename(file.path));

    request.contentLength = totalByteLength;

    int byteCount = 0;
    Stream<List<int>> streamUpload = fileStream.transform(
      StreamTransformer.fromHandlers(
        handleData: (data, sink) {
          byteCount += data.length;

          if (onUploadProgress != null) {
            onUploadProgress(byteCount, totalByteLength);
            // CALL STATUS CALLBACK;
          }

          sink.add(data);
        },
        handleError: (error, stack, sink) {
          print(error.toString());
        },
        handleDone: (sink) {
          sink.close();
          // UPLOAD DONE;
        },
      ),
    );

    await request.addStream(streamUpload);

    final httpResponse = await request.close();

    if (httpResponse.statusCode != 200) {
      throw Exception('Error uploading file');
    } else {
      return await readResponseAsString(httpResponse);
    }
  }

  */

  static Future<String> fileUploadMultipart(
      {required String url,
      List<String>? files,
      OnUploadProgressCallback? onUploadProgress}) async {
    // assert(filePath == null || files == null);

    // final url = ;

    final httpClient = getHttpClient();

    final request = await httpClient.postUrl(Uri.parse(url));

    int byteCount = 0;

    // var multipart = await http.MultipartFile.fromPath(fileUtil.basename(file.path), file.path);
    List<http.MultipartFile> mpList = [];

    if (files == null) {
      // final fileName = fileUtil.basename(filePath!);
      // final ext =fileUtil.extension(fileName);
      //
      // final file =  await http.MultipartFile.fromPath(
      //   "file", filePath,
      //   filename: fileName ,
      //   contentType: MediaType('image', 'jpeg'),);
      // mpList.add(file)
      //Todo throw an exception
      return Future.value('');
    }

    for (String item in files) {
      final fileName = fileUtil.basename(item);
      final ext = fileUtil.extension(fileName);
      final file = await http.MultipartFile.fromPath(
        "file${mpList.length}",
        item,
        filename: fileName,
        contentType: MediaType('image', ext),
      );
      mpList.add(file);
    }

    // final multipart =  List.generate(filePath.length, (index)  {
    //   final fileName = fileUtil.basename(filePath[index]);
    //   final ext =fileUtil.extension(fileName);
    //   print('exxxxxxxxxxxxxxxxxxxxxt $ext');
    //   final file = getMPFile(index, filePath[index], fileName);
    //   return file;
    // }
    // );
    // var multipart = ;

    // final fileStreamFile = file.openRead();

    // var multipart = MultipartFile("file", fileStreamFile, file.lengthSync(),
    //     filename: fileUtil.basename(file.path));

    // Uri uri = Uri.parse(VUrls.profilePictureUploadUrl);
    // final headers = {"Authorization": 'Token ${GraphQlConfig.restToken}'};
    // http.MultipartRequest requestMultipart = http.MultipartRequest('POST', request.uri);
    // requestMultipart.headers.addAll(headers);
    var requestMultipart = http.MultipartRequest("POST", request.uri);

    requestMultipart.files.addAll(mpList);

    var msStream = requestMultipart.finalize();

    var totalByteLength = requestMultipart.contentLength;

    request.contentLength = totalByteLength;

    request.headers.set(HttpHeaders.contentTypeHeader,
        requestMultipart.headers[HttpHeaders.contentTypeHeader] as Object);
    request.headers.set(
        HttpHeaders.authorizationHeader, 'Token ${GraphQlConfig.restToken}');
    print('token is');
    print(GraphQlConfig.restToken);

    Stream<List<int>> streamUpload = msStream.transform(
      StreamTransformer.fromHandlers(
        handleData: (data, sink) {
          sink.add(data);

          byteCount += data.length;

          if (onUploadProgress != null) {
            onUploadProgress(byteCount, totalByteLength);
            // CALL STATUS CALLBACK;
          }
        },
        handleError: (error, stack, sink) {
          throw error;
        },
        handleDone: (sink) {
          sink.close();
          // UPLOAD DONE;
        },
      ),
    );

    await request.addStream(streamUpload);

    final httpResponse = await request.close();
//
    var statusCode = httpResponse.statusCode;

    if (statusCode ~/ 100 != 2) {
      throw Exception(
          'Error uploading file, Status code: ${httpResponse.statusCode}');
    } else {
      final res = await readResponseAsString(httpResponse);
      // var res = await http.Response.fromStream(httpResponsebb);
      print('<<<<<<<<>>>>>>>>>>>> $statusCode \n  $res  ');
      return res;
    }
  }

  static Future<String> rawBytesDataUploadMultipart(
      {required String url,
      List<Uint8List>? rawDataList,
      OnUploadProgressCallback? onUploadProgress}) async {
    // assert(filePath == null || files == null);

    // final url = ;

    final httpClient = getHttpClient();

    final request = await httpClient.postUrl(Uri.parse(url));

    int byteCount = 0;

    // var multipart = await http.MultipartFile.fromPath(fileUtil.basename(file.path), file.path);
    List<http.MultipartFile> mpList = [];

    if (rawDataList == null) {
      // final fileName = fileUtil.basename(filePath!);
      // final ext =fileUtil.extension(fileName);
      //
      // final file =  await http.MultipartFile.fromPath(
      //   "file", filePath,
      //   filename: fileName ,
      //   contentType: MediaType('image', 'jpeg'),);
      // mpList.add(file)
      //Todo throw an exception
      return Future.value('');
    }

    int count = 0;
    for (Uint8List item in rawDataList) {
      // final fileName = fileUtil.basename(item);
      // final ext =fileUtil.extension(fileName);
      var image = http.MultipartFile.fromBytes(
        'image$count',
        item,
        filename: 'postImage$count.jpg',
        contentType: MediaType('image', '.jpg'),
      );
      // request.files.add(image);
      mpList.add(image);
      // final file =  await http.MultipartFile.fromPath(
      //   "file${mpList.length}", item,
      //   filename: fileName ,
      //   contentType: MediaType('image', '.jpg'),);
      ++count;
    }

    // final multipart =  List.generate(filePath.length, (index)  {
    //   final fileName = fileUtil.basename(filePath[index]);
    //   final ext =fileUtil.extension(fileName);
    //   print('exxxxxxxxxxxxxxxxxxxxxt $ext');
    //   final file = getMPFile(index, filePath[index], fileName);
    //   return file;
    // }
    // );
    // var multipart = ;

    // final fileStreamFile = file.openRead();

    // var multipart = MultipartFile("file", fileStreamFile, file.lengthSync(),
    //     filename: fileUtil.basename(file.path));

    // Uri uri = Uri.parse(VUrls.profilePictureUploadUrl);
    // final headers = {"Authorization": 'Token ${GraphQlConfig.restToken}'};
    // http.MultipartRequest requestMultipart = http.MultipartRequest('POST', request.uri);
    // requestMultipart.headers.addAll(headers);
    var requestMultipart = http.MultipartRequest("POST", request.uri);

    requestMultipart.files.addAll(mpList);

    var msStream = requestMultipart.finalize();

    var totalByteLength = requestMultipart.contentLength;

    request.contentLength = totalByteLength;

    request.headers.set(HttpHeaders.contentTypeHeader,
        requestMultipart.headers[HttpHeaders.contentTypeHeader] as Object);
    request.headers.set(
        HttpHeaders.authorizationHeader, 'Token ${GraphQlConfig.restToken}');
    print('token is');
    print(GraphQlConfig.restToken);

    Stream<List<int>> streamUpload = msStream.transform(
      StreamTransformer.fromHandlers(
        handleData: (data, sink) {
          sink.add(data);

          byteCount += data.length;

          if (onUploadProgress != null) {
            onUploadProgress(byteCount, totalByteLength);
            // CALL STATUS CALLBACK;
          }
        },
        handleError: (error, stack, sink) {
          throw error;
        },
        handleDone: (sink) {
          sink.close();
          // UPLOAD DONE; 
        },
      ),
    );

    await request.addStream(streamUpload);

    final httpResponse = await request.close();
//
    var statusCode = httpResponse.statusCode;

    if (statusCode ~/ 100 != 2) {
      throw Exception(
          'Error uploading file, Status code: ${httpResponse.statusCode}');
    } else {
      final res = await readResponseAsString(httpResponse);
      // var res = await http.Response.fromStream(httpResponsebb);
      print('<<<<<<<<>>>>>>>>>>>> $statusCode \n  $res  ');
      return res;
    }
  }

  /** FILE DOWNLOAD

    static Future<Future> fileDownload(
      {required String fileName,
      required OnUploadProgressCallback onDownloadProgress}) async {
    assert(fileName != null);

    final url = Uri.encodeFull('$baseUrl/api/file/$fileName');

    final httpClient = getHttpClient();

    final request = await httpClient.getUrl(Uri.parse(url));

    request.headers
        .add(HttpHeaders.contentTypeHeader, "application/octet-stream");

    var httpResponse = await request.close();

    int byteCount = 0;
    int totalBytes = httpResponse.contentLength;

    Directory appDocDir = await getApplicationDocumentsDirectory();
    String appDocPath = appDocDir.path;

    //appDocPath = "/storage/emulated/0/Download";

    File file = File("$appDocPath/$fileName");

    var raf = file.openSync(mode: FileMode.write);

    Completer completer = Completer<String>();

    httpResponse.listen(
      (data) {
        byteCount += data.length;

        raf.writeFromSync(data);

        if (onDownloadProgress != null) {
          onDownloadProgress(byteCount, totalBytes);
        }
      },
      onDone: () {
        raf.closeSync();

        completer.complete(file.path);
      },
      onError: (e) {
        raf.closeSync();
        file.deleteSync();
        completer.completeError(e);
      },
      cancelOnError: true,
    );

    return completer.future;
  }
*/

  static Future<String> readResponseAsString(HttpClientResponse response) {
    var completer = Completer<String>();
    var contents = StringBuffer();
    response.transform(utf8.decoder).listen((String data) {
      contents.write(data);
    }, onDone: () => completer.complete(contents.toString()));
    return completer.future;
  }
}
