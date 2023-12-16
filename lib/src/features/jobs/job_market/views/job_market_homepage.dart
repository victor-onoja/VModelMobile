import 'package:flutter/services.dart';
import 'package:vmodel/src/features/jobs/job_market/views/business_user/business_offers_details_page.dart';

import '../../../../res/assets/app_asset.dart';
import '../../../../res/icons.dart';
import '../../../../res/res.dart';
import '../../../../shared/appbar/appbar.dart';
import '../../../../shared/rend_paint/render_svg.dart';
import '../../../../shared/text_fields/dropdown_text_field.dart';
import '../../../../shared/text_fields/primary_text_field.dart';
import '../../../../vmodel.dart';
import '../../../dashboard/feed/widgets/share.dart';
import '../../../dashboard/menu_settings/menu_sheet.dart';
import '../widget/job_market_card.dart';

class JobMarketHomepage extends StatefulWidget {
  const JobMarketHomepage({super.key});

  @override
  State<JobMarketHomepage> createState() => _JobMarketHomepageState();
}

class _JobMarketHomepageState extends State<JobMarketHomepage> {
  String selectedVal1 = "Photographers";
  String selectedVal2 = "Models";

  Future<void> reloadData() async {}

  final List items = [
    {
      "username": "Christopher M",
      "imagePath": VmodelAssets2.jobM,
      "address": "Paris",
      "time": "4:30 Hr",
      "gender": "Male",
      "fees": "750",
    },
    {
      "username": "Mikel M",
      "imagePath": VmodelAssets2.imageContainer,
      "address": "London",
      "time": "3:20 Hr",
      "gender": "Female",
      "fees": "250",
    },
    {
      "username": "Francis K",
      "imagePath": VmodelAssets2.jobM,
      "address": "London",
      "time": "1:30 Hr",
      "gender": "Female",
      "fees": "490",
    },
    {
      "username": "Jane D",
      "imagePath": VmodelAssets2.imageContainer,
      "address": "London",
      "time": "9:30 Hr",
      "gender": "Female",
      "fees": "950",
    },
    {
      "username": "Christopher M",
      "imagePath": VmodelAssets2.jobM,
      "address": "Paris",
      "time": "12:00 Hr",
      "gender": "Male",
      "fees": "630",
    },
    {
      "username": "Mikel O",
      "imagePath": VmodelAssets2.imageContainer,
      "address": "London",
      "time": "6:30 Hr",
      "gender": "Female",
      "fees": "850",
    },
    {
      "username": "Christopher M",
      "imagePath": VmodelAssets2.jobM,
      "address": "London",
      "time": "2:00 Hr",
      "gender": "Male",
      "fees": "900",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: VWidgetsAppBar(
        appBarHeight: 50,
        backgroundColor: VmodelColors.appBarBackgroundColor,
        leadingIcon: const VWidgetsBackButton(),
        
        appbarTitle: "Job Market",
        trailingIcon: [
         SizedBox(
                width: 80,
                // height: 30,
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
                              showModalBottomSheet(
                                backgroundColor: Colors.transparent,
                                useRootNavigator: true,
                                context: context,
                                isScrollControlled: true,
                                enableDrag: true,
                                anchorPoint: const Offset(0, 200),
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(16),
                                    topRight: Radius.circular(16),
                                  ),
                                ),
                                builder: ((context) => const MenuSheet()),
                              );
                            },
                            icon: circleIcon)),
                    addHorizontalSpacing(5),
                  ],
                )),
          
        ],
      ),
      body: RefreshIndicator.adaptive(
        onRefresh: () {
          HapticFeedback.lightImpact();
          return reloadData();
        },
        child: SingleChildScrollView(
          padding: const VWidgetsPagePadding.horizontalSymmetric(10),
          child: Column(
            children: [
              const VWidgetsPrimaryTextFieldWithTitle(
                hintText: "Search",
                suffixIcon: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: RenderSvg(
                    svgPath: VIcons.searchIcon,
                    svgHeight: 24,
                    svgWidth: 24,
                  ),
                ),
              ),
              addVerticalSpacing(15),
              Padding(
                padding: const VWidgetsPagePadding.horizontalSymmetric(5),
                child: SizedBox(
                  height: 50,
                  child: ListView(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    children: [
                      VWidgetsDropDownTextField<String>(
                        havePrefix: true,
                        onChanged: (selected) {
                          setState(() {
                            selectedVal1 = selected;
                          });
                        },
                        value: selectedVal1,
                        hintText: "",
                        options: const ["Photographers", "Models"],
                        fieldLabel: "Job",
                        getLabel: (String value) => selectedVal1,
                      ),
                      addHorizontalSpacing(8),
                      VWidgetsDropDownTextField<String>(
                        havePrefix: true,
                        onChanged: (selected) {
                          setState(() {
                            selectedVal2 = selected;
                          });
                        },
                        value: selectedVal2,
                        hintText: "",
                        options: const ["Photographers", "Models"],
                        fieldLabel: "Job Types",
                        getLabel: (String value) => selectedVal2,
                      ),
                    ],
                  ),
                ),
              ),
              addVerticalSpacing(20),
              ListView.builder(
                itemCount: items.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final item = items[index];
                  return VWidgetsJobMarketCard(
                    userName: item["username"],
                    imagePath: item["imagePath"],
                    address: item["address"],
                    time: item["time"],
                    // gender: item["gender"],
                    fees: item["fees"],
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
                    onTapCard: () {
                      navigateToRoute(
                          context, const BusinessOfferDetailsPage());
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
