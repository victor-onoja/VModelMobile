import 'package:timelines/timelines.dart';
import 'package:vmodel/src/features/booking/widgets/booking_sequence_profile_info_card.dart';
import 'package:vmodel/src/res/icons.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/shared/appbar/appbar.dart';
import 'package:vmodel/src/shared/buttons/primary_button.dart';
import 'package:vmodel/src/shared/rend_paint/render_svg.dart';
import 'package:vmodel/src/vmodel.dart';

class BookingSequencePage extends StatelessWidget {
  const BookingSequencePage({super.key});

  @override
  Widget build(BuildContext context) {
       
    return Scaffold(
      appBar: VWidgetsAppBar(
        leadingIcon: const VWidgetsBackButton(),
        appbarTitle: "Booking Sequence",
        trailingIcon: [
          GestureDetector(
                onTap: () {}, child: const RenderSvg(svgPath: VIcons.setting)),
         
        ],
      ),
      body: Padding(
        padding: const VWidgetsPagePadding.horizontalSymmetric(18),
        child: Column(
          children: [
            addVerticalSpacing(25),
            VWidgetsBookingSequenceProfileInfoCard(
              profileName: "Georgina Powell",
              profileImage: VmodelAssets1.profileImage,
              address: "Yonkers, New York, USA",
              startDate: "12 Oct 2023",
              endDate: "16 Oct 2023",
              dateEstimation: "5",
            ),
            addVerticalSpacing(10),
            VWidgetsPrimaryButton(
              onPressed: () {},
              buttonTitle: "Send Message",
              enableButton: true,
            ),
            const Divider(
              thickness: 1,
              height: 25,
            ),
            addVerticalSpacing(5),
       
            Expanded(
                child: SingleChildScrollView(
              child: Column(
                children: [
                  addVerticalSpacing(10),
                  Row(
                    children: [
                      SizedBox(
                        height: 100.0,
                        child: TimelineNode(
                          indicator: const RenderSvg(
                            svgPath: VIcons.pen,
                            color: VmodelColors.primaryColor,
                          ),
                          endConnector: SolidLineConnector(
                            color: VmodelColors.primaryColor.withOpacity(0.5),
                            indent: 5, // endIndent: 5,
                          ),
                        ),
                      ),
                      addHorizontalSpacing(15),
                      const Text("Share this Work")
                    ],
                  ),
                  Row(
                    children: [
                      SizedBox(
                        //height: 100.0,
                        child: TimelineNode(
                          indicator: const RenderSvg(
                            svgPath: VIcons.pen,
                            color: VmodelColors.primaryColor,
                          ),
                          startConnector: SolidLineConnector(
                            endIndent: 5,
                            color: VmodelColors.primaryColor.withOpacity(0.5),
                          ),
                          endConnector: SolidLineConnector(
                            color: VmodelColors.primaryColor.withOpacity(0.5),
                            indent: 5,
                          ),
                        ),
                      ),
                      addHorizontalSpacing(15),
                      SizedBox(
                      
                        width: MediaQuery.of(context).size.width/1.25,
                        child: Theme(
                          data:  Theme.of(context).copyWith(dividerColor: Colors.transparent),
                          child: const ExpansionTile(
                            title: Text(
                              "Test",
                              style: TextStyle(
                                  fontSize: 16.0, fontWeight: FontWeight.w500),
                            ),
                            trailing: RenderSvg(svgPath: VIcons.downwardArrowIcon),
                            children: <Widget>[
                               Text("Hello"),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      SizedBox(
                        height: 100.0,
                        child: TimelineNode(
                          indicator: const RenderSvg(
                            svgPath: VIcons.pen,
                            color: VmodelColors.primaryColor,
                          ),
                          startConnector: SolidLineConnector(
                            endIndent: 5,
                            color: VmodelColors.primaryColor.withOpacity(0.5),
                          ),
                          endConnector: SolidLineConnector(
                            color: VmodelColors.primaryColor.withOpacity(0.5),
                            indent: 5,
                          ),
                        ),
                      ),
                      addHorizontalSpacing(15),
                      const Text("My ")
                    ],
                  ),
                  Row(
                    children: [
                      SizedBox(
                        height: 100.0,
                        child: TimelineNode(
                          indicator: const RenderSvg(
                            svgPath: VIcons.pen,
                            color: VmodelColors.primaryColor,
                          ),
                          startConnector: SolidLineConnector(
                            endIndent: 5,
                            color: VmodelColors.primaryColor.withOpacity(0.5),
                          ),
                          endConnector: SolidLineConnector(
                            color: VmodelColors.primaryColor.withOpacity(0.5),
                            indent: 5,
                          ),
                        ),
                      ),
                      addHorizontalSpacing(15),
                      const Text("Booking Scheduled")
                    ],
                  ),
                  Row(
                    children: [
                      SizedBox(
                        height: 100.0,
                        child: TimelineNode(
                          indicator: const RenderSvg(
                            svgPath: VIcons.pen,
                            color: VmodelColors.primaryColor,
                          ),
                          startConnector: SolidLineConnector(
                            endIndent: 5,
                            color: VmodelColors.primaryColor.withOpacity(0.5),
                          ),
                          endConnector: SolidLineConnector(
                            color: VmodelColors.primaryColor.withOpacity(0.5),
                            indent: 5,
                          ),
                        ),
                      ),
                      addHorizontalSpacing(15),
                      const Text("Payment Confirmed")
                    ],
                  ),
                  Row(
                    children: [
                      SizedBox(
                        height: 100.0,
                        child: TimelineNode(
                          indicator: const RenderSvg(
                            svgPath: VIcons.pen,
                            color: VmodelColors.primaryColor,
                          ),
                          startConnector: SolidLineConnector(
                            endIndent: 5,
                            color: VmodelColors.primaryColor.withOpacity(0.5),
                          ),
                          endConnector: SolidLineConnector(
                            color: VmodelColors.primaryColor.withOpacity(0.5),
                            indent: 5,
                          ),
                        ),
                      ),
                      addHorizontalSpacing(15),
                      const Text("Booking changed to")
                    ],
                  ),
                  Row(
                    children: [
                      SizedBox(
                        height: 100.0,
                        child: TimelineNode(
                          indicator: const RenderSvg(
                            svgPath: VIcons.pen,
                            color: VmodelColors.primaryColor,
                          ),
                          startConnector: SolidLineConnector(
                            endIndent: 5,
                            color: VmodelColors.primaryColor.withOpacity(0.5),
                          ),
                        ),
                      ),
                      addHorizontalSpacing(15),
                      const Text("Booking Created")
                    ],
                  ),
                  addVerticalSpacing(60)
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }
}
