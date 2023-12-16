import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vmodel/src/core/controller/app_user_controller.dart';
import 'package:vmodel/src/core/network/graphql_service.dart';
import 'package:vmodel/src/features/settings/views/account_settings/views/security_and_privacy_settings.dart';
import 'package:vmodel/src/features/settings/views/alert_settings.dart';
import 'package:vmodel/src/features/settings/views/apperance/views/apperance_screen.dart';
import 'package:vmodel/src/features/settings/views/feed/feed_settings_homepage.dart';
import 'package:vmodel/src/features/settings/views/payment/views/payments_homepage.dart';
import 'package:vmodel/src/features/settings/views/permissions/views/permissions_homepage.dart';
import 'package:vmodel/src/features/settings/views/profile/views/account_settings.dart';
import 'package:vmodel/src/features/settings/views/verification_setting.dart';
import 'package:vmodel/src/res/icons.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/shared/appbar/appbar.dart';
import 'package:vmodel/src/shared/rend_paint/render_svg.dart';
import 'package:vmodel/src/vmodel.dart';

import '../../../core/utils/helper_functions.dart';
import '../../dashboard/new_profile/profile_features/widgets/profile_picture_widget.dart';
import '../other_options/controller/settings_controller.dart';
import 'profile_settings_homepage.dart';
import 'upload_settings/gallery_settings_homepage.dart';

class SettingsSheet extends ConsumerStatefulWidget {
  const SettingsSheet({Key? key}) : super(key: key);
  static const routeName = 'settings';

  @override
  ConsumerState<SettingsSheet> createState() => _SettingsSheetState();
}

class _SettingsSheetState extends ConsumerState<SettingsSheet> {
  buildRedirectingMenuItem(
      BuildContext context, String title, String icon, Widget nextScreen) {
    return InkWell(
      onTap: () {
        navigateToRoute(context, nextScreen);
      },
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 6.0),
          child: Column(
            children: [
              // addVerticalSpacing(13),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                // mainAxisSize: MainAxisSize.max,
                children: [
                  Flexible(
                    child: RenderSvg(
                      svgPath: icon,
                      svgHeight: 24,
                      svgWidth: 24,
                      color: Theme.of(context).iconTheme.color,
                    ),
                  ),
                  addHorizontalSpacing(20),
                  Expanded(
                    child: Text(
                      title,
                      style: Theme.of(context).textTheme.displayLarge!.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // This is the image picker
  final _picker = ImagePicker();
  // Implementing the image picker
  Future<String> _openImagePicker() async {
    final XFile? pickedImage =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      return pickedImage.path;
    }
    return "";
  }

  // Future<CroppedFile?> cropImage(String filePath) async {
  //   return await ImageCropper().cropImage(
  //     sourcePath: filePath,
  //     aspectRatioPresets: [
  //       CropAspectRatioPreset.square,
  //       CropAspectRatioPreset.ratio3x2,
  //       CropAspectRatioPreset.original,
  //       CropAspectRatioPreset.ratio4x3,
  //       CropAspectRatioPreset.ratio16x9
  //     ],
  //     uiSettings: [
  //       AndroidUiSettings(
  //         initAspectRatio: CropAspectRatioPreset.original,
  //         lockAspectRatio: false,
  //       ),
  //     ],
  //   );
  // }

  @override
  Widget build(
    BuildContext context,
  ) {
    final authNotifier = ref.watch(authProvider);
    final authNotif = ref.watch(authProvider.notifier);
    final authNot = authNotif.state;
    final appUser = ref.watch(appUserProvider);
    final user = appUser.valueOrNull;
    // final authNotifier = ref.watch(authProvider.notifier);
    Get.put(VSettingsController());

    List menuItems = [
      buildRedirectingMenuItem(
        context,
        'Portfolio',
        VIcons.menuProfileNew,
        const ProfileSettingsHomepage(),
      ),
      buildRedirectingMenuItem(
        context,
        'Account',
        VIcons.user,
        const ProfileSettingPage(),
      ),

      // buildRedirectingMenuItem(
      //   context,
      //   'Bookings and Services',
      //   VIcons.receiptitem,
      //   const BookingSettingsPage(),
      // ),
      buildRedirectingMenuItem(
        context,
        'Galleries',
        VIcons.gallery,
        const GallerySettingsHomepage(),
        // const UploadSettingsHomepage(),
      ),
      buildRedirectingMenuItem(
        context,
        'Payments',
        VIcons.cards,
        const PaymentSettingsHomepage(),
      ),

      // buildRedirectingMenuItem(
      //   context,
      //   'My network',
      //   VIcons.menuMyNetwork,
      //   const MyNetwork(),
      // ),

      buildRedirectingMenuItem(
        context,
        'Feed',
        VIcons.verticalPostIcon,
        const FeedSettingsHomepage(),
      ),

      buildRedirectingMenuItem(
        context,
        'Notifications',
        VIcons.notification,
        AlertSettingsPage(user: user),
      ),
      buildRedirectingMenuItem(
        context,
        'Verification',
        VIcons.scanner,
        const VerificationSettingPage(),
      ),
      buildRedirectingMenuItem(
        context,
        'Permissions',
        VIcons.menuPermissionNew,
        PermissionsHomepage(user: user),
      ),
      buildRedirectingMenuItem(context, 'Apperance', VIcons.apperanceLogo,
          const ApperanceHomepage()),
      buildRedirectingMenuItem(
        context,
        'Security & Privacy',
        VIcons.lock,
        const AccountSettingsPage(),
      ),
      // _buildRedirectingMenuItem(
      //     context, 'Privacy', VIcons.shield, const PrivacySettingsPage()),
    ];

    return Scaffold(
      appBar: VWidgetsAppBar(
        leadingIcon: const VWidgetsBackButton(),
        // backgroundColor: VmodelColors.white,
        appbarTitle: "Settings",
      ),
      // AppBar(
      //   elevation: 0.5,
      //   backgroundColor: VmodelColors.background,
      //   leading: const VWidgetsBackButton(),
      //   title: const VWidgetsAppBarTitleText(titleText: "Settings"),
      // ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      bottomSheet: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        height: SizeConfig.screenHeight * 0.95,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            addVerticalSpacing(4),
            Container(
              height: 117,
              width: 117,
              color: Theme.of(context).scaffoldBackgroundColor,
              alignment: Alignment.center,
              child: ProfilePicture(
                showBorder: false,
                //VMString.pictureCall + authNot.profilePicture!,
                displayName: '${user?.displayName}',
                url: '${user?.profilePictureUrl}',
                headshotThumbnail: '${user?.thumbnailUrl}',
                size: 100,
              ),
            ),
            addVerticalSpacing(12),
            Container(
              alignment: Alignment.center,
              color: Theme.of(context).scaffoldBackgroundColor,
              child: GestureDetector(
                onTap: () {
                  selectAndCropImage().then((value) async {
                    print(value);
                    if (value != null && value != "") {
                      ref.read(appUserProvider.notifier).uploadProfilePicture(
                          value, onProgress: (sent, total) {
                        final percentUploaded = (sent / total);
                        print(
                            '########## $value\n [$percentUploaded%]  sent: $sent ---- total: $total');
                      });
                    }
                  });
                },
                child: Text(
                  'Edit Image',
                  textAlign: TextAlign.start,
                  style: Theme.of(context).textTheme.bodyLarge!,
                ),
              ),
            ),
            addVerticalSpacing(40),
            Expanded(
              child: Container(
                color: Theme.of(context).scaffoldBackgroundColor,
                margin: const EdgeInsets.only(
                  left: 16,
                  right: 16,
                ),
                child: ListView.separated(
                    itemBuilder: ((context, index) => menuItems[index]),
                    separatorBuilder: (context, index) => Divider(
                          color: Theme.of(context).dividerColor,
                        ),
                    itemCount: menuItems.length),
              ),
            ),
            addVerticalSpacing(30),
          ],
        ),
      ),
    );
  }
}
