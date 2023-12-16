import 'package:fluttertoast/fluttertoast.dart';
import 'package:vmodel/src/vmodel.dart';

import '../../../../core/cache/local_storage.dart';
import '../../../../res/res.dart';
import '../profile_features/widgets/social_accounts_feature/social_accounts_textfield.dart';


class EditSocialsDialog extends StatefulWidget {
  final Widget? popupTitle;
  final String? title;

  const EditSocialsDialog(
      { this.popupTitle ,
      super.key,
      this.title});

  @override
  State<EditSocialsDialog> createState() => _EditSocialsDialogState();
}

class _EditSocialsDialogState extends State<EditSocialsDialog> {
  TextEditingController instagramController = TextEditingController();
  TextEditingController twitterController = TextEditingController();
  TextEditingController facebookController = TextEditingController();
  TextEditingController pinterestController = TextEditingController();
  TextEditingController tiktokController = TextEditingController();
  TextEditingController youtubeController = TextEditingController();


  @override
  void dispose() {
    instagramController.dispose();
    twitterController.dispose();
    facebookController.dispose();
    pinterestController.dispose();
    tiktokController.dispose();
    youtubeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
      title: Center(
        child: widget.popupTitle ??
            Text(widget.title!,
                style: Theme.of(context).textTheme.displayLarge!.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).primaryColor,
                    )),
      ),
      titleTextStyle: Theme.of(context).textTheme.displayLarge,
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SocialAccountsTextField(
              socialAccountName: "Instagram",
              onTap: () {},
              // isAccountActive: isAccountActive,
              textController: instagramController,
              onPressedSave: () {},
              onChanged: (value) async {
                if (instagramController.text != "") {
                  await VModelSharedPrefStorage()
                      .putString('instagram_username', instagramController.text);

                } else {
                  Fluttertoast.showToast(
                      msg: "Please fill the field",
                      gravity: ToastGravity.TOP,
                      timeInSecForIosWeb: 1,
                      backgroundColor: VmodelColors.error.withOpacity(0.6),
                      textColor: Colors.white,
                      fontSize: 16.0);
                }
              },
            ),
            SocialAccountsTextField(
              socialAccountName: "TikTok",
              onTap: () {},
              // isVisible: tiktokTextVisible,
              textController: tiktokController,
              onPressedSave: () {},
              onChanged: (value) async {
                if (tiktokController.text != "") {
                  await VModelSharedPrefStorage()
                      .putString('tiktok_username', tiktokController.text);
                } else {
                  Fluttertoast.showToast(
                      msg: "Please fill the field",
                      gravity: ToastGravity.TOP,
                      timeInSecForIosWeb: 1,
                      backgroundColor: VmodelColors.error.withOpacity(0.6),
                      textColor: Colors.white,
                      fontSize: 16.0);
                }
              },
            ),
            SocialAccountsTextField(
              socialAccountName: "YouTube",
              onTap: () {},
              textController: youtubeController,
              onPressedSave: () {},
              onChanged: (value) async {
                if (youtubeController.text != "") {
                  await VModelSharedPrefStorage()
                      .putString('youtube_username', youtubeController.text);
                } else {
                  Fluttertoast.showToast(
                      msg: "Please fill the field",
                      gravity: ToastGravity.TOP,
                      timeInSecForIosWeb: 1,
                      backgroundColor: VmodelColors.error.withOpacity(0.6),
                      textColor: Colors.white,
                      fontSize: 16.0);
                }
              },
            ),
            SocialAccountsTextField(
              socialAccountName: "Twitter",
              onTap: () {},
              textController: twitterController,
              onPressedSave: () {},
              onChanged: (value) async {
                if (twitterController.text != "") {
                  await VModelSharedPrefStorage()
                      .putString('twitter_username', twitterController.text);
                } else {
                  Fluttertoast.showToast(
                      msg: "Please fill the field",
                      gravity: ToastGravity.TOP,
                      timeInSecForIosWeb: 1,
                      backgroundColor: VmodelColors.error.withOpacity(0.6),
                      textColor: Colors.white,
                      fontSize: 16.0);
                }
              },
            ),
            SocialAccountsTextField(
              socialAccountName: "Facebook",
              onTap: () {},
              textController: facebookController,
              onPressedSave: () {},
              onChanged: (value) async {
                if (facebookController.text != "") {
                  await VModelSharedPrefStorage()
                      .putString('facebook_username', facebookController.text);
                } else {
                  Fluttertoast.showToast(
                      msg: "Please fill the field",
                      gravity: ToastGravity.TOP,
                      timeInSecForIosWeb: 1,
                      backgroundColor: VmodelColors.error.withOpacity(0.6),
                      textColor: Colors.white,
                      fontSize: 16.0);
                }
              },
            ),
            SocialAccountsTextField(
              socialAccountName: "Pinterest",
              onTap: () {},
              textController: pinterestController,
              onPressedSave: () {},
              onChanged: (value) async {
                if (pinterestController.text != "") {
                  await VModelSharedPrefStorage()
                      .putString('pinterest_username', pinterestController.text);
                } else {
                  Fluttertoast.showToast(
                      msg: "Please fill the field",
                      gravity: ToastGravity.TOP,
                      timeInSecForIosWeb: 1,
                      backgroundColor: VmodelColors.error.withOpacity(0.6),
                      textColor: Colors.white,
                      fontSize: 16.0);
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
