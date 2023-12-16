import 'package:camera/camera.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vmodel/src/features/settings/views/verification/views/record_video.dart';
import 'package:vmodel/src/res/icons.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/shared/appbar/appbar.dart';
import 'package:vmodel/src/shared/buttons/primary_button.dart';
import 'package:vmodel/src/vmodel.dart';

class VerifyVideo extends StatefulWidget {
  final XFile image;
  const VerifyVideo({Key? key, required this.image}) : super(key: key);

  @override
  State<VerifyVideo> createState() => _VerifyVideoState();
}

class _VerifyVideoState extends State<VerifyVideo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const VWidgetsAppBar(
        appbarTitle: "Verifying your identity",
        appBarHeight: 50,
        elevation: 0.0,
        leadingIcon: VWidgetsBackButton(),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const VWidgetsPagePadding.horizontalSymmetric(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                addVerticalSpacing(40),
                Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      addVerticalSpacing(50),
                      SvgPicture.asset(
                        VIcons.recordIcon,
                        width: 55,
                        height: 55,
                      ),
                      addVerticalSpacing(25),
                      Text(
                        "Record a short video of yourself",
                        style: Theme.of(context)
                            .textTheme
                            .displayMedium
                            ?.copyWith(
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                                color: VmodelColors.primaryColor),
                      ),
                      addVerticalSpacing(20),
                      Padding(
                        padding:
                            const VWidgetsPagePadding.horizontalSymmetric(20),
                        child: Text(
                          "Make sure we sww you clearly, then say the words that appear to camera so we can match you to your photo ID.",
                          style: Theme.of(context)
                              .textTheme
                              .displayMedium
                              ?.copyWith(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  color: VmodelColors.primaryColor),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
                addVerticalSpacing(60),
                VWidgetsPrimaryButton(
                  buttonTitle: "I'm ready",
                  onPressed: () {
                    navigateToRoute(
                        context,
                        RecordVideo(
                          image: widget.image,
                        ));
                  },
                  enableButton: true,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
