import 'package:flutter/material.dart';
import 'package:vmodel/src/core/routing/navigator_1.0.dart';
import 'package:vmodel/src/features/dashboard/feed/widgets/share.dart';
import 'package:vmodel/src/features/jobs/job_market/widget/job_details_card.dart';
import 'package:vmodel/src/res/assets/app_asset.dart';
import 'package:vmodel/src/res/icons.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/shared/appbar/appbar_title_text.dart';
import 'package:vmodel/src/shared/buttons/normal_back_button.dart';
import 'package:vmodel/src/shared/rend_paint/render_svg.dart';

class JobDetails extends StatelessWidget {
  const JobDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xffffffff),
        centerTitle: true,
        leading: const VWidgetsBackButton(),
        title: const VWidgetsAppBarTitleText(titleText: 'Job Details'),
        actions: [
          SizedBox(
              width: 80,
              height: 30,
              child: Row(
                children: [
                  Flexible(
                      child: IconButton(
                          padding: const EdgeInsets.all(0),
                          onPressed: () {},
                          icon: const RenderSvg(
                            svgPath: VIcons.setting,
                            svgHeight: 24,
                            svgWidth: 24,
                          ))),
                  Flexible(
                      child: IconButton(
                          padding: const EdgeInsets.all(0),
                          onPressed: () {
                            openVModelMenu(context, isNotTabScreen: true);
                          },
                          icon: circleIcon)),
                  addHorizontalSpacing(5),
                ],
              )),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: VWidgetsJobDetailsCard(
                userName: "Chirstopher M. Davis",
                location: "London UK",
                duration: "3:30 Hr",
                gender: "Male",
                budget: "450",
                jobInfo: 'Hello,\n'
                    'We’re a small photography team looking for a Models to help us build our portfolio,'
                    'we’re interested in Food, Commercial, Glamour and abstract shoots.\n'
                    'Thanks.\nWe need about 5 models for this campaign, interested models should please send us an offer :)',
                image: const AssetImage(VmodelAssets2.circleImage2),
                categoryTags: const [
                  "Commercial",
                  "Glamour",
                  "Food",
                  "Runway",
                ],
                onPressedShare: () {
                  showModalBottomSheet(
                    isScrollControlled: true,
                    isDismissible: true,
                    useRootNavigator: true,
                    backgroundColor: Colors.transparent,
                    context: context,
                    builder: (context) => const ShareWidget(
                      shareLabel: 'Share Job',
                      shareTitle: 'Christopher M\'s Job',
                      shareImage: 'assets/images/doc/main-model.png',
                      shareURL: 'Vmodel.app/Jobs/Christophers-job',
                    ),
                  );
                },
                onPressedLocation: () {},
                onPressedSendMessege: () {},
                onPressedSendOffer: () {}),
          ),
        ],
      ),
    );
  }
}
