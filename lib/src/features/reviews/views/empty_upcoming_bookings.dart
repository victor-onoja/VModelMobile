import 'package:vmodel/src/features/reviews/widgets/booking_item.dart';
import 'package:vmodel/src/res/icons.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/shared/appbar/appbar_title_text.dart';
import 'package:vmodel/src/shared/buttons/primary_button.dart';
import 'package:vmodel/src/shared/rend_paint/render_svg.dart';
import 'package:vmodel/src/vmodel.dart';

class EmptyUpComingView extends StatelessWidget {
  const EmptyUpComingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const VWidgetsBackButton(),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        centerTitle: true,
        title: const VWidgetsAppBarTitleText(titleText: "My Booking"),
        elevation: 0.5,
        iconTheme: IconThemeData(color: VmodelColors.mainColor),
        actions: [
          Padding(
            padding: EdgeInsets.only(left: SizeConfig.screenWidth * 0.05),
            child: IconButton(
              onPressed: () {},
              icon: const RenderSvg(
                svgPath: VIcons.setting,
                svgHeight: 24,
                svgWidth: 24,
              ),
            ),
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildListDelegate(
              [
                addVerticalSpacing(20),
                Padding(
                  padding: const VWidgetsPagePadding.horizontalSymmetric(18),
                  child: Text(
                    "You don’t have upcoming bookings",
                    style: Theme.of(context).textTheme.displayMedium!.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: VmodelColors.primaryColor),
                  ),
                ),
                addVerticalSpacing(30),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const RenderSvg(
                      svgPath: VIcons.pen,
                      svgWidth: 45,
                      svgHeight: 45,
                    ),
                    addVerticalSpacing(25),
                    Text(
                      "Time to start your new adventure!",
                      style: Theme.of(context)
                          .textTheme
                          .displayMedium!
                          .copyWith(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: VmodelColors.primaryColor),
                    ),
                    addVerticalSpacing(25),
                    Padding(
                      padding:
                          const VWidgetsPagePadding.horizontalSymmetric(18),
                      child: VWidgetsPrimaryButton(
                        enableButton: true,
                        buttonColor: VmodelColors.primaryColor,
                        buttonTitle: "Start exploring",
                        onPressed: () {},
                      ),
                    )
                  ],
                ),
                addVerticalSpacing(20),
                Padding(
                  padding: const VWidgetsPagePadding.horizontalSymmetric(18),
                  child: Text(
                    "Past bookings",
                    style: Theme.of(context).textTheme.displayMedium!.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: VmodelColors.primaryColor),
                  ),
                ),
                addVerticalSpacing(10),
                Padding(
                  padding: const VWidgetsPagePadding.horizontalSymmetric(18),
                  child: ListView(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    children: const [
                      BookingItems(
                        image: 'assets/images/profile-image.png',
                        title: 'Georgina Powell',
                        location: 'Yonkers, New York, USA',
                        dateRange: '12 Oct 2023 - 16 Oct 2023',
                        timeRemaining: 'In 5 weeks',
                      ),
                      BookingItems(
                        image: 'assets/images/profile-image.png',
                        title: 'Georgina Powell',
                        location: 'Yonkers, New York, USA',
                        dateRange: '12 Oct 2023 - 16 Oct 2023',
                        timeRemaining: 'In 5 weeks',
                      ),
                      BookingItems(
                        image: 'assets/images/profile-image.png',
                        title: 'Georgina Powell',
                        location: 'Yonkers, New York, USA',
                        dateRange: '12 Oct 2023 - 16 Oct 2023',
                        timeRemaining: 'In 5 weeks',
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
