//determine Location
import 'dart:developer' as dev;
import 'dart:developer';
import 'dart:io';
import 'package:any_link_preview/any_link_preview.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:local_auth/local_auth.dart';
import 'package:vmodel/src/core/cache/credentials.dart';
import 'package:vmodel/src/core/utils/validators_mixins.dart';
import 'package:vmodel/src/features/dashboard/dash/controller.dart';
import 'package:vmodel/src/shared/response_widgets/toast.dart';
import 'package:vmodel/src/vmodel.dart';
import '../../features/dashboard/discover/models/vell_article.dart';
import '../../features/dashboard/feed/model/feed_model.dart';
import '../../shared/dialogs/discard_dialog.dart';
import '../cache/local_storage.dart';
import '../controller/discard_editing_controller.dart';
import 'costants.dart';
import 'enum/service_job_status.dart';
import 'dart:async';

Future<Position> determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;
  permission = await Geolocator.requestPermission();
  // Test if location services are enabled.
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    permission = await Geolocator.requestPermission();

    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
  }

  return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high);
}

final biometricStateProvider = StateProvider((ref) => false);

class UppercaseLimitTextInputFormatter extends TextInputFormatter {
  int uppercaseLimit;
  int currentUppercaseCount = 0;

  UppercaseLimitTextInputFormatter({this.uppercaseLimit = 4});

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final upperCase = RegExp(r'[A-Z]');
    // Use RegExp to remove any uppercase letters beyond the limit
    final matches = upperCase.allMatches(newValue.text);
    if (matches.length > uppercaseLimit) {
      toastContainer(text: 'Uppercase limit reached!');
      return oldValue;
    }
    return newValue;
  }
}

class BiometricService {
  static bool isEnabled = false;
  // bool get biometricEnabled => _isEnabled;
  //
  // static updateBiometricEnabledStatus(bool value) {
  //   _biometricEnabled = value;
  // }

  static Future<bool> authenticateUser() async {
    //initialize Local Authentication plugin.
    final LocalAuthentication localAuthentication = LocalAuthentication();
    //status of authentication.
    bool isAuthenticated = false;
    //check if device supports biometrics authentication.
    bool isBiometricSupported = await localAuthentication.isDeviceSupported();
    //check if user has enabled biometrics.
    //check
    bool canCheckBiometrics = await localAuthentication.canCheckBiometrics;

    //if device supports biometrics and user has enabled biometrics, then authenticate.
    if (isBiometricSupported && canCheckBiometrics) {
      try {
        isAuthenticated = await localAuthentication.authenticate(
          localizedReason: 'Please complete the biometrics to proceed.',
          // authMessages: [AuthMessages()],
          options: const AuthenticationOptions(
              biometricOnly: true, useErrorDialogs: true, stickyAuth: true),
        );
      } on PlatformException catch (e) {
        print(e);
      }
    }
    return isAuthenticated;
  }
}

bool onPopPage(
  BuildContext context,
  WidgetRef ref, {
  VoidCallback? onDiscard,
}) {
  bool hasChanges = false;
  if (ref.exists(discardProvider)) {
    hasChanges = ref.read(discardProvider.notifier).checkForChanges();
  }
  if (hasChanges) {
    // showModal();

    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return DiscardDialog(onDiscard: onDiscard);
        });
  } else {
    if (context.mounted) goBack(context);
  }
  return !hasChanges;
}

Future getUserProfileDetails({Function(String, String)? onComplete}) async {
  final getToken = await VCredentials.inst.getUserCredentials();
  // final getUserId = await VCredentials.inst.getUserId();
  final getUsername = await VCredentials.inst.getUsername();

  final biometricStatus =
      await VModelSharedPrefStorage().getBool(VSecureKeys.biometricEnabled);
  BiometricService.isEnabled = biometricStatus;

  if (getToken != null && getUsername != null) {
    onComplete!(getToken, getUsername);
  }
}

Future<String?> cropImage(String filePath) async {
  final cropFile = await ImageCropper().cropImage(
    sourcePath: filePath,
    aspectRatioPresets: [
      CropAspectRatioPreset.square,
      // CropAspectRatioPreset.ratio3x2,
      // CropAspectRatioPreset.original,
      // CropAspectRatioPreset.ratio4x3,
      // CropAspectRatioPreset.ratio16x9
    ],
    cropStyle: CropStyle.circle,
    uiSettings: [
      AndroidUiSettings(
        // initAspectRatio: CropAspectRatioPreset.square,
        lockAspectRatio: false,
      ),
    ],
  );
  return cropFile?.path;
}

Future<String?> imagePicker() async {
  // This is the image picker
  final picker = ImagePicker();
  // Implementing the image picker
  Future<String> _openImagePicker() async {
    final XFile? pickedImage =
        await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      return pickedImage.path;
    }
    return "";
  }

  var imagePath = await _openImagePicker();

  return imagePath;
}

Future<String?> selectAndCropImage() async {
  final image = await imagePicker();

  final croppedImage = await cropImage(image!);
  return croppedImage;
}

Future<CroppedFile?> croppedImage(File imageFile) async =>
    await ImageCropper.platform.cropImage(
      sourcePath: imageFile.path,
      // aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio16x9,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.ratio4x3
      ],

      uiSettings: [androidUISettingsLocked()],
    );

AndroidUiSettings androidUISettingsLocked() => AndroidUiSettings(
      toolbarTitle: 'Crop Image',
      lockAspectRatio: false,
      initAspectRatio: CropAspectRatioPreset.original,
      // toolbarWidgetColor: Colors.white
    );

Future pickImage(ImageSource source) async {
  //File imageTemporary;
  File? img;
  try {
    final image = await ImagePicker().pickImage(source: source);

    if (image == null) return;

    File imageTemporary = File(image.path);

    img = imageTemporary;
  } on PlatformException catch (e) {
    print('Failed to pick $e');
  }

  print(img);

  return img;
}

Future<List<File>> getImages(
    {bool isGallery = true,
    bool isMultiple = true,
    bool isCamera = false}) async {
  final List<XFile> pickedFile;
  XFile? singleOnePicked;

  if (isGallery == true && isMultiple == true && isCamera == false) {
    pickedFile = await picker.pickMultiImage();
    List<XFile> xfilePick = pickedFile;

    if (xfilePick.isNotEmpty) {
      for (var i = 0; i < xfilePick.length; i++) {
        // state++;
        selectedImages.add(File(xfilePick[i].path));
        print(selectedImages.length);
      }
    }
  }
  if (isGallery == true && isMultiple == false && isCamera == false) {
    singleOnePicked = await picker.pickImage(source: ImageSource.gallery);

    selectedImages.clear();
    if (singleOnePicked != null) {
      selectedImages.add(File(singleOnePicked.path));
    } else {
      selectedImages = [];
    }
  }
  if (isCamera == true && isMultiple == false && isGallery == false) {
    print('----imgagepicker called------- ');
    singleOnePicked = await picker.pickImage(source: ImageSource.camera);
    selectedImages.clear();
    if (singleOnePicked != null) {
      selectedImages.add(File(singleOnePicked.path));
    } else {
      selectedImages = [];
    }
  }
  print('-------called again -------');
  print('selected image: $selectedImages -----------');
  return selectedImages;
}

Future<List<File>> pickServiceImages() async {
  final picker = ImagePicker();
  try {
    // final XFile? pickedFile = await picker.pickImage(source: source);
    // if (false && serviceImages.length >= VConstants.maxServiceBannerImages) {
    //   VWidgetShowResponse.showToast(ResponseEnum.warning,
    //       message:
    //           "Maximum of ${VConstants.maxServiceBannerImages} can be selected");
    //   return;
    // }

    final List<XFile> pickedFile = await picker.pickMultiImage();
    // serviceImages =
    //     pickedFile?.take(VConstants.maxServiceBannerImages).toList() ?? [];

    // final List<File> imageFiles = [];

    // serviceImages =
    // if (pickedFile.isNotEmpty) {
    return pickedFile.map((e) => File(e.path)).toList();

    // for (var i = 0; i < pickedFile.length; i++) {
    //   // state++;
    //   imageFiles.add(File(pickedFile[i].path));

    //   print(selectedImages.length);
    // }
    // }
    // if (pickedFile != null) {
    //   image = XFile(pickedFile.path);
    //   if (image != null) {
    //     imageName = "Banner";
    //     print('Image Name: ${pickedFile.path}');
    //   }
    // }
    // if (mounted) setState(() {});
  } catch (e) {
    print(e);
  }
  return [];
}

Future<Uint8List> testCompressFile(Uint8List list) async {
  var result = await FlutterImageCompress.compressWithList(
    list,
    minHeight: 1920,
    minWidth: 1080,
    quality: 96,
    rotate: 0,
  );
  dev.log("[8sl2 bytes length: ${list.length / VConstants.MB}");
  dev.log("[8sl2 compressed length: ${result.length / VConstants.MB}");
  // print(result.length);
  return result;
}

//close snack bar

closeAnySnack() {
  // ScaffoldMessenger.of(AppNavigatorKeys.instance.navigatorKey.currentContext!)
  //     .hideCurrentSnackBar();
  AppNavigatorKeys.instance.scaffoldKey.currentState?.hideCurrentSnackBar();
}

void copyCouponToClipboard(String text) async {
// registerCouponCopy
  HapticFeedback.lightImpact();
  await Clipboard.setData(ClipboardData(text: text));
}

void copyTextToClipboard(String text) async {
  HapticFeedback.lightImpact();
  await Clipboard.setData(ClipboardData(text: text));
}

bool isValidDiscount(int discount) {
  //Original was 5 minimum
  return discount > 0;
}

double calculateDiscountedAmount(
    {required double price, required int discount}) {
  if (isValidDiscount(discount)) {
    final discountAmount = price * (discount) / 100;
    return price - discountAmount;
  }
  return price;
}

//Extension functions

String? firstPostThumbnailOrNull(List<FeedPostSetModel>? posts) {
  if (posts == null || posts.isEmpty)
    return null;
  else {
    final photos = posts.first.photos;

    if (photos.isEmpty) return null;
    return photos.first.thumbnail ?? photos.first.url;
    // return posts.f?.photos?.firstOrNull?.thumbnail ?? null;
  }
}

String formatAsHashtag(String text) {
  return '#${upperCaseWordsNoSpace(text)}';
}

/// Uppercase words in string with no spaces
/// Example: your name => YourName
String upperCaseWordsNoSpace(String value) {
  final separatedWords =
      value.split(RegExp(r'[!@#<>?":`~;[\]\\|=+)(*&^%-\s_]+'));
  var newString = '';

  log('upperCaseWord input: $value, split: $separatedWords');
  for (final word in separatedWords) {
    if (word.isEmptyOrNull) continue; //skip empty strings
    newString += word.capitalizeFirstVExt;
    // newString += word[0].toUpperCase() + word.substring(1).toLowerCase();
  }

  return newString;
}

extension JobOrServiceStatusExtension on ServiceOrJobStatus {
  // bool get canPublish {
  //   return this == ServiceOrJobStatus.draft;
  // }

  Color statusColor(bool processing) {
    if (processing) {
      return Colors.blue;
    }
    switch (this) {
      case ServiceOrJobStatus.active:
        return Colors.green;
      case ServiceOrJobStatus.closed:
        return Colors.red;
      case ServiceOrJobStatus.paused:
        return Colors.yellow;
      default:
        return Colors.grey;
    }
  }
}

extension CapitalizeFirstExtension on String {
  String get capitalizeFirstVExt {
    if (isEmpty) return this;
    return this[0].toUpperCase() + substring(1).toLowerCase();
  }
}

String getDayOfMonthSuffix(int dayNum) {
  if (!(dayNum >= 1 && dayNum <= 31)) {
    throw Exception('Invalid day of month');
  }

  if (dayNum >= 11 && dayNum <= 13) {
    return 'th';
  }

  switch (dayNum % 10) {
    case 1:
      return 'st';
    case 2:
      return 'nd';
    case 3:
      return 'rd';
    default:
      return 'th';
  }
}

extension NullableDateTimeExtension on DateTime? {
  String? get toIso8601DateOnlyString {
    final time = this?.toIso8601String().split('T').first;
    return '$time';
  }
}

extension DateTimeExtension on DateTime {
  String get toIso8601TimeString {
    final time = this.toIso8601String().split('T').last;
    return '$time';
  }

  String get toSuffixedDayMonthYear {
    return DateFormat("d'${getDayOfMonthSuffix(this.day)}' MMM, yyyy")
        .format(this);
  }

  String getSimpleDate({String suffix = 'ago'}) {
    final nnow = DateTime.now();
    final diff = (nnow.difference(this));

    if (diff.inSeconds < 60) {
      return '${diff.inSeconds.abs().pluralize('second')} $suffix';
    } else if (diff.inMinutes < 60) {
      return '${diff.inMinutes.abs().pluralize('minute')} $suffix';
    } else if (diff.inHours < 24) {
      return '${diff.inHours.abs().pluralize('hour')} $suffix';
    } else if (diff.inDays < 7) {
      return '${diff.inDays.abs().pluralize('day')} $suffix';
    } else if (diff.inDays < 14) {
      return '${(diff.inDays ~/ 7).abs().pluralize('week')} $suffix';
    }

    return VConstants.simpleDateFormatter.format(this);
  }

  String getSimpleDateOnJobCard({String suffix = 'ago'}) {
    final nnow = DateTime.now();
    final difference = (nnow.difference(this));

    if (difference.inMinutes < 1) {
      return 'Just now';
    } else if (difference.inMinutes == 1) {
      return '1 min ago';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes} mins ago';
    } else if (difference.inHours == 1) {
      return '1 hr ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} hrs ago';
    } else if (difference.inDays == 1) {
      return '1 day ago';
    } else if (difference.inDays < 10) {
      return '1 week ago';
    } else if (difference.inDays < 17) {
      return '2 weeks ago';
    } else if (difference.inDays < 30) {
      return '3 weeks ago';
    } else if (difference.inDays < 90) {
      final months = (difference.inDays / 30).floor();
      return '${months} month${months == 1 ? '' : 's'} ago';
    } else if (this.year < nnow.year) {
      return VConstants.simpleDateFormatter.format(this);
    } else
      return VConstants.simpleDateFormatterWithNoYear.format(this);
  }
}

extension NaivePluralization on int {
  String pluralize(String initialString, {String? pluralString}) {
    return this == 1
        ? '$this $initialString'
        : pluralString != null
            ? '$this $pluralString'
            : '$this ${initialString}s';
  }
}

// We will use this to build our own custom UI
Future<VellArticle> getLinkMetadataAny(String url, String title) async {
  Metadata? _metadata = await AnyLinkPreview.getMetadata(
    // link: "https://github.com/ghpranav/link_preview_generator",
    // link: "https://vellmagazine.com/article/100/1",
    // link: "https://builtwith.appwrite.io/projects/6464c5806a2344dcfcb9/",
    link: url,

    // cache: Duration(days: 7),
    // proxyUrl: "https://cors-anywhere.herokuapp.com/", // Need for web
  );
  print('[linkM_any-link]: ${_metadata}');

  return VellArticle(
    articleUrl: url,
    title: title,
    imageUrl: _metadata?.image,
  );
}

// String getSimpleDate(DateTime dt) {
//   final ss = DateFormat('d MMMM yyyy');
//   return ss.format(dt);
// }

extension DurationFormatter on Duration {
  /// Returns a day, hour, minute, second string representation of this `Duration`.
  ///
  ///
  /// Returns a string with days, hours, minutes, and seconds in the
  /// following format: `dd:HH:MM:SS`. For example,
  ///
  ///   var d = new Duration(days:19, hours:22, minutes:33);
  ///    d.dayHourMinuteSecondFormatted();  // "19:22:33:00"
  String dayHourMinuteSecondFormatted() {
    toString();
    final formattedHoursMinutes = [
      inHours,
      if (inMinutes.remainder(60) != 0) inMinutes.remainder(60),
    ].map((seg) {
      return seg.toString();
    }).join(':');

    return formattedHoursMinutes;
  }
}

String formatNumberWithSuffix(int number) {
  if (number >= 1000000) {
    double millions = number / 1000000;
    return '${millions.toStringAsFixed(millions.truncateToDouble() == millions ? 0 : 1)}M';
  } else if (number >= 1000) {
    double thousands = number / 1000;
    return '${thousands.toStringAsFixed(thousands.truncateToDouble() == thousands ? 0 : 1)}K';
  } else {
    return number.toString();
  }
}

// String dayHourMinuteSecondFormatted() {
//   toString();
//   final formattedHoursMinutes = [
//     inHours,
//     if (inMinutes.remainder(60) != 0) inMinutes.remainder(60),
//   ].map((seg) {
//     return seg.toString().padLeft(2, '0');
//   }).join(':');

//   return '${formattedHoursMinutes}';
// }

extension DurationTimesFormatter on Duration {
  /// Returns a day, hour, minute, second string representation of this `Duration`.
  ///
  ///
  /// Returns a string with days, hours, minutes, and seconds in the
  /// following format: `dd:HH:MM:SS`. For example,
  ///
  ///   var d = new Duration(days:19, hours:22, minutes:33);
  ///    d.dayHourMinuteSecondFormatted();  // "19:22:33:00"
  String getDurationForDropdown() {
    toString();
    final formattedHoursMinutes = [
      if (inHours > 0 && inHours < 13) inHours,
      if (inHours == 0 || inHours == 24) 12,
      if (inHours >= 13 && inHours < 24) inHours.remainder(12),
      inMinutes.remainder(60),
    ].map((seg) {
      return seg.toString().padLeft(2, '0');
    }).join(':');
    final postFix = inHours < 12 || inHours == 24 ? 'am' : 'pm';
    return '$formattedHoursMinutes $postFix';
  }

  String get toHourMinutes {
    final formattedHoursMinutes = [
      inHours,
      inMinutes.remainder(60),
    ].map((seg) {
      return seg.toString().padLeft(2, '0');
    }).join(':');
    return formattedHoursMinutes;
  }
}

Duration timeStringToDuration(String hourMinuteString) {
  var re = RegExp(
    r'^'
    r'([0-9]{1,2})'
    r':'
    r'([0-9]{1,2})'
    // r':'
    // r'(?<seconds>[0-9]{1,2})'
    r'$',

    // r'^(\d{1,2}):(\d{1,2})$'
  );

  print('[iki5] $hourMinuteString');

  var match = re.firstMatch(hourMinuteString);
  if (match == null) {
    // throw FormatException('Unrecognized time format');
    print('Unrecognized time format');
    return Duration.zero;
  }

  // print('[iki5] ${match[0]} ${match[1]}');
  // return Duration.zero;

  try {
    return Duration(
      hours: int.parse(match[1]!),
      minutes: int.parse(match[2]!),
      // seconds: int.parse(match.namedGroup('seconds') ?? '0'),
    );
  } catch (e, st) {
    print('[iki6] $e $st');
    rethrow;
  }
}

double getTotalPrice(Duration duration, String priceText) {
  final price = double.tryParse(priceText) ?? 0;
  return (duration.inMinutes / 60) * price;
}

Future<File> cachePath(String cacheUrl) async {
  // final cache = await CacheManager.getInstance();
  var file = await DefaultCacheManager().getSingleFile(cacheUrl);
  // print('[yxyw] path for photo url: ${file.path}');
  // var file = await cache.getFile(imageUrl);
  // return file.path;
  return file;
}

//For testing purposes
// enum VerificationType { blue, grey, none }

// Widget getUserVerificationIcon(String username) {
// final blueUserNames = [
//   'bridebox',
//   'biznizz',
//   'afrogarm',
//   'vmodel',
//   'byaaronwallace',
//   'theresatravis',
//   'antonina_akimova',
//   'ivaany',
// ];
// final greyUserNames = [
//   'gg500',
//   'testuser',
//   'irregular',
//   'markshire',
//   'jdynamo'
// ];

// if (blueUserNames.contains(username.toLowerCase())) {
//   // return VerificationType.blue;

//   return const RenderSvgWithoutColor(
//     svgPath: VIcons.verifiedIcon,
//     svgHeight: 12,
//     svgWidth: 12,
//   );
// } else if (greyUserNames.contains(username.toLowerCase())) {
//   // return VerificationType.grey;
//   return const RenderSvg(
//     svgPath: VIcons.verifiedIcon,
//     svgHeight: 12,
//     svgWidth: 12,
//     color: Color(0xFFC2C2C2),
//   );
// }
// // return VerificationType.none;
// return const SizedBox.shrink();
// }

// Widget getUserVerificationIcon(
//     {required bool isVerified, required bool blueTickVerified,}) {
//   if (blueTickVerified) {
//     return const RenderSvgWithoutColor(
//       svgPath: VIcons.verifiedIcon,
//       svgHeight: 12,
//       svgWidth: 12,
//     );
//   } else if (isVerified) {
//     return const RenderSvg(
//       svgPath: VIcons.verifiedIcon,
//       svgHeight: 12,
//       svgWidth: 12,
//       color: Color(0xFFC2C2C2),
//     );
//   }
//   // return VerificationType.none;
//   return const SizedBox.shrink();
// }

// Widget getVerificationIcon(String username) {

// }

String getZodicaSignByName(String? name) {
  return '';
  if (name == null) return '';
  switch (name.toLowerCase()) {
    case "aquarius":
      return "♒";
    case "capricorn":
      return "♑";
    case "pisces":
      return "🐟";
    case "aries":
      return "♈";
    case "pisces":
      return "♓️";
    case "taurus":
      return "♉";
    case "geminies":
      return "♊️";
    case "cancer":
      return "♋";
    case "leo":
      return "♌";
    case "virgo":
      return "♍";
    case "libra":
      return "♎️";
    case "scorpio":
      return "♏";
    case "sagittarius":
      return "♐";
    default:
      return "";
  }
}
