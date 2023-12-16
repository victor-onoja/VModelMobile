import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sizer/sizer.dart';
import 'package:vmodel/src/core/models/app_user.dart';
import 'package:vmodel/src/features/settings/views/booking_settings/views/availability_view.dart';
import 'package:vmodel/src/shared/buttons/primary_button.dart';

import '../../../core/controller/app_user_controller.dart';
import '../../../core/routing/navigator_1.0.dart';
import '../../../core/utils/shared.dart';
import '../../../res/colors.dart';
import '../../../res/gap.dart';
import '../../../res/icons.dart';
import '../../../shared/appbar/appbar.dart';
import '../../../shared/rend_paint/render_svg.dart';
import '../../applications/views/applications_page.dart';
import '../../dashboard/new_profile/profile_features/services/views/services_homepage.dart';
import '../../dashboard/new_profile/profile_features/user_jobs/views/user_jobs_homepage.dart';
import '../../dashboard/new_profile/user_offerings/views/tabbed_user_offerings.dart';
import '../../earnings/views/earnings_homepage.dart';
import '../../reviews/views/reviews_view.dart';
import '../../reviews/views/tabbed_bookings_view.dart';
import '../../settings/widgets/settings_submenu_tile_widget.dart';
import 'analytics.dart';
import 'business_opening_times/views/business_opening_times_form.dart';
import 'user_coupons.dart';

class BusinessSuiteHomepage extends ConsumerWidget {
  const BusinessSuiteHomepage({super.key});
  static const routeName = 'businessSuite';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    VAppUser? user;
    final appUser = ref.watch(appUserProvider);

    user = appUser.valueOrNull;
    List menuItems = [
      // VWidgetsSettingsSubMenuTileWidget(
      //     title: "Suggest a feature",
      //     onTap: () {
      //       navigateToRoute(title: 'Suggest a feature', url: 'https://vmodel.app/');
      //     }),
      VWidgetsSettingsSubMenuTileWidget(
          title: "VModel Stats",
          textColor: VmodelColors.appBarBackgroundColor,
          onTap: () {
            navigateToRoute(context, const Analytics());
          }),

      VWidgetsSettingsSubMenuTileWidget(
          title: "Bookings",
          textColor: VmodelColors.appBarBackgroundColor,
          onTap: () {
            // navigateToRoute(context, const BookingsMenuView());
            navigateToRoute(context, const BookingsTabbedView());
          }),
      VWidgetsSettingsSubMenuTileWidget(
          title: "Jobs",
          textColor: VmodelColors.appBarBackgroundColor,
          onTap: () {
            // navigateToRoute(context, const BusinessMyJobsPage());
            navigateToRoute(
                context, UserJobsPage(username: appUser.valueOrNull?.username));
          }),
      VWidgetsSettingsSubMenuTileWidget(
          title: "Services",
          textColor: VmodelColors.appBarBackgroundColor,
          onTap: () {
            navigateToRoute(
                context,
                ServicesHomepage(
                  username: user!.username,
                ));
          }),
      VWidgetsSettingsSubMenuTileWidget(
          title: "Applications",
          textColor: VmodelColors.appBarBackgroundColor,
          onTap: () {
            navigateToRoute(context, const ApplicationsPage());
          }),
      VWidgetsSettingsSubMenuTileWidget(
          title: "Reviews",
          textColor: VmodelColors.appBarBackgroundColor,
          onTap: () {
            navigateToRoute(context, const ReviewsUI());
          }),
      VWidgetsSettingsSubMenuTileWidget(
          title: "Earnings",
          textColor: VmodelColors.appBarBackgroundColor,
          onTap: () {
            navigateToRoute(context, const EarningsPage());
          }),
      VWidgetsSettingsSubMenuTileWidget(
          title: "Coupons",
          textColor: VmodelColors.appBarBackgroundColor,
          onTap: () {
            navigateToRoute(context, UserCoupons(username: user?.username));
          }),

      VWidgetsSettingsSubMenuTileWidget(
          title: "Invoice",
          textColor: VmodelColors.appBarBackgroundColor,
          onTap: () {
            navigateToRoute(context, const EarningsPage());
          }),
      VWidgetsSettingsSubMenuTileWidget(
          title: "Unavailability",
          textColor: VmodelColors.appBarBackgroundColor,
          onTap: () {
            navigateToRoute(context, const AvailabilityView());
          }),
      if (user?.isBusinessAccount ?? false)
        VWidgetsSettingsSubMenuTileWidget(
            title: "Business opening times",
            onTap: () {
              // navigateToRoute(context, const BusinessOpeningHours());
              navigateToRoute(context, const OpeningTimesHomepage());
            }),
    ];

    return Scaffold(
      appBar: VWidgetsAppBar(
        appbarTitle: "Business Hub",
        leadingIcon: const VWidgetsBackButton(),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(
            parent: BouncingScrollPhysics()),
        slivers: [
          SliverList.list(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Stack(
                  alignment: AlignmentDirectional.center,
                  children: [
                    Container(
                      height: 180,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                            image: AssetImage(
                                'assets/images/betaDashboardBanner.jpg'),
                            fit: BoxFit.cover),
                      ),
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: RenderSvg(
                          svgPath: VIcons.business,
                          color: VmodelColors.white,
                          svgWidth: 30,
                          svgHeight: 30,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 10,
                      left: 10,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Welcome to the Business Hub!",
                            style: Theme.of(context)
                                .textTheme
                                .displayLarge!
                                .copyWith(
                                  color: VmodelColors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12.sp,
                                ),
                          ),
                          addVerticalSpacing(4),
                          Text(
                            "Explore tools to boost your business",
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .displayMedium!
                                .copyWith(
                                  color: VmodelColors.white,
                                  fontSize: 12.sp,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              addVerticalSpacing(10),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: VWidgetsPrimaryButton(
                  onPressed: () {
                    navigateToRoute(
                      context,
                      UserOfferingsTabbedView(
                        username: user?.username,
                      ),
                      // ServicesHomepage(
                      //   username: user?.username,
                      // ),
                    );
                  },
                  buttonTitle: "My Offerings",
                  enableButton: true,
                  buttonColor:
                      Theme.of(context).buttonTheme.colorScheme?.background,
                ),
              ),
              addVerticalSpacing(10),
            ],
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            sliver: SliverGrid.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Number of columns
                  crossAxisSpacing: 15.0,
                  mainAxisSpacing: 15.0,
                  mainAxisExtent: 60),
              itemBuilder: (context, index) {
                final menuItem = menuItems[index];

                return Container(
                  decoration: BoxDecoration(
                    color:
                        Theme.of(context).buttonTheme.colorScheme?.background,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      child: menuItem),
                );
              },
              itemCount: menuItems.length,
            ),
          ),
          // SliverToBoxAdapter(child: addVerticalSpacing(24))
        ],
      ),
    );
  }
}
