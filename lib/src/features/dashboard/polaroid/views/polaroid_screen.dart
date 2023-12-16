import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:vmodel/src/core/routing/navigator_1.0.dart';
import 'package:vmodel/src/features/booking/views/booking_settings/booking_settings.dart';
import 'package:vmodel/src/features/jobs/create_jobs/views/create_job_view_first.dart';
import 'package:vmodel/src/res/assets/app_asset.dart';
import 'package:vmodel/src/res/res.dart';
import '../widget/polaroid_row.dart';
import '../widget/tabscreen/Polaroid_1.dart';
import '../widget/tabscreen/Polaroid_2.dart';
import '../widget/tabscreen/Polaroid_3.dart';
import '../widget/tabscreen/Polaroid_4.dart';
// import '../widget/tabscreen/polaroid_1.dart';
// import '../widget/tabscreen/polaroid_2.dart';
// import '../widget/tabscreen/polaroid_3.dart';
// import '../widget/tabscreen/polaroid_4.dart';

class Polaroid extends StatefulWidget {
  const Polaroid({Key? key}) : super(key: key);

  @override
  State<Polaroid> createState() => _PolaroidState();
}

class _PolaroidState extends State<Polaroid>
    with SingleTickerProviderStateMixin {
  late TabController tabBarController;
  @override
  void initState() {
    tabBarController = TabController(length: 4, vsync: this);
    super.initState();
  }

  String selectedPolarid = "Polaroid #1";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, value) {
          return [
            SliverAppBar(
              leading: BackButton(
                color: VmodelColors.mainColor,
              ),
              //   centerTitle: true,
              title: Padding(
                padding: EdgeInsets.only(left: 70.sp, right: 0),
                child: Row(
                  //  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Samantha",
                      style: TextStyle(
                        color: VmodelColors.mainColor,
                        fontSize: 16.sp,
                        fontFamily: "AvenirNext",
                      ),
                    ),
                    SvgPicture.asset(
                      'assets/icons/verified.svg',
                    ),
                  ],
                ),
              ),
              stretch: true,
              // snap: true,
              floating: true,
              //  pinned: true,
              collapsedHeight: 370.h,
              expandedHeight: 200,
              backgroundColor: Colors.white,
              actions: [
                IconButton(
                  padding: const EdgeInsets.only(left: 0, right: 0),
                  onPressed: () {},
                  icon: messageIcon,
                  iconSize: 15,
                ),
                IconButton(
                  padding: const EdgeInsets.only(left: 0, right: 0),
                  onPressed: () {},
                  icon: notificaionIcon,
                  iconSize: 15,
                ),
                IconButton(
                  padding: const EdgeInsets.only(left: 0, right: 0),
                  onPressed: () {
                    navigateToRoute(context, const CreateJobFirstPage());
                  },
                  icon: circleIcon,
                  iconSize: 15,
                ),
              ],
              flexibleSpace: Padding(
                padding: EdgeInsets.only(top: 70.sp, left: 0, right: 0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              top: 40.sp, left: 15.sp, right: 15.sp),
                          child: const CircleAvatar(
                            backgroundImage: AssetImage(
                              'assets/images/models/model_11.png',
                            ),
                            maxRadius: 50,
                            minRadius: 35,
                          ),
                        ),
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.only(
                              top: 36,
                            ),
                            child: Text(
                              "Hi, I’m a model with ABC Model Agency in San Francisco, CA who is interested in building a go...",
                              style: TextStyle(
                                  wordSpacing: 5,
                                  fontFamily: "AvenirNext,Medium",
                                  fontSize: 15,
                                  color: VmodelColors.buttonColor),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          right: 0, left: 20.sp, top: 7.sp, bottom: 0),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              right: 11,
                              left: 4,
                            ),
                            child: Row(
                              children: [
                                SvgPicture.asset(
                                  "assets/icons/star.svg",
                                  height: 18,
                                  width: 18,
                                  color: VmodelColors.mainColor,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      right: 7.sp,
                                      left: 7.sp,
                                      top: 7.sp,
                                      bottom: 7.sp),
                                  child: Text(
                                    "4.9",
                                    style: TextStyle(
                                        fontFamily: "AvenirNext,Medium",
                                        fontSize: 15,
                                        color: VmodelColors.mainColor),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SvgPicture.asset(
                                "assets/icons/location.svg",
                                height: 25,
                                width: 25,
                                color: VmodelColors.mainColor,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    right: 10, left: 7, top: 7, bottom: 7),
                                child: Text(
                                  "Los Angeles, USA",
                                  style: TextStyle(
                                      fontFamily: "AvenirNext,Medium",
                                      fontSize: 15,
                                      color: VmodelColors.mainColor),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              right: 11,
                              left: 4,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SvgPicture.asset(
                                  "assets/icons/vector.svg",
                                  height: 18,
                                  width: 18,
                                  color: VmodelColors.mainColor,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      right: 11, left: 10, top: 7, bottom: 0),
                                  child: Text(
                                    "Commercial, Glamour, Runway",
                                    style: TextStyle(
                                        fontFamily: "AvenirNext,Medium",
                                        fontSize: 15,
                                        color: VmodelColors.mainColor),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.only(
                              right: 11,
                              left: 4,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SvgPicture.asset(
                                  "assets/icons/vector.svg",
                                  height: 18,
                                  width: 18,
                                  color: VmodelColors.mainColor,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      right: 11, left: 10, top: 7, bottom: 0),
                                  child: Text(
                                      "From £250",
                                    style: TextStyle(
                                        fontFamily: "AvenirNext,Medium",
                                        fontSize: 15,
                                        color: VmodelColors.mainColor),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          backgroundColor: VmodelColors.buttonColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () {
                          navigateToRoute(context, const BookingSettings());
                        },
                        child: Center(
                          child: Text(
                            "Book Now",
                            style: TextStyle(
                                fontFamily: "AvenirNext,Medium",
                                fontSize: 15,
                                color: VmodelColors.white),
                          ).paddingSymmetric(horizontal: 20, vertical: 0),
                        )).marginSymmetric(horizontal: 25),
                    //  buttonWidget(() {}, ),
                    Row(
                      children: [
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              elevation: 0,
                              backgroundColor: VmodelColors.borderColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            onPressed: () {},



                            child: Center(
                              child: const Text(
                                "Messages",
                                style: TextStyle(color: Colors.black),
                              ).paddingSymmetric(horizontal: 2, vertical: 6),
                            )).marginSymmetric(horizontal: 23),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              elevation: 0,
                              backgroundColor: VmodelColors.borderColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            onPressed: () {},
                            child: Center(
                              child: const Text(
                                "Portfolio",
                                style: TextStyle(color: Colors.black),
                              ).paddingSymmetric(horizontal: 2, vertical: 5),
                            )).marginSymmetric(horizontal: 0),
                        IconButton(
                          padding: const EdgeInsets.only(left: 20, right: 22),
                          onPressed: () {},
                          icon: instagramIcon,
                        ),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              elevation: 0,
                              backgroundColor: VmodelColors.borderColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            onPressed: () {},
                            child: Center(
                              child: SvgPicture.asset(
                                'assets/icons/shop.svg',
                              ).paddingSymmetric(horizontal: 0, vertical: 0),
                            )).marginSymmetric(horizontal: 0),
                      ],
                    ),
                  ],
                ),
              ),
              bottom: TabBar(
                  padding: const EdgeInsets.all(0),
                  controller: tabBarController,
                  tabs: [
                    PolaroidRow(
                      isSelected: selectedPolarid == "Polaroid #1",
                      text: "Polaroid1",
                    ),
                    PolaroidRow(
                      isSelected: selectedPolarid == "Polaroid #2",
                      text: "Polaroid #2",
                    ),
                    PolaroidRow(
                      isSelected: selectedPolarid == "Polaroid #3",
                      text: "Polaroid #3",
                    ),
                    PolaroidRow(
                      isSelected: selectedPolarid == "Polaroid #4",
                      text: "Polaroid #4",
                    ),
                  ]),
            ),
          ];
        },
        body: TabBarView(controller: tabBarController, children: const [
          Polaroid1(),
          Polaroid2(),
          Polaroid3(),
          Polaroid4(),
        ]),
      ),
    );
  }
}
// Hi, I’m a model with ABC Model Agency in San Francisco, CA who is interested in building a go...