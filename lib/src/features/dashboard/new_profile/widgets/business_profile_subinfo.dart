import 'package:vmodel/src/features/dashboard/new_profile/profile_features/user_jobs/views/user_jobs_homepage.dart';
import 'package:vmodel/src/res/icons.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/shared/rend_paint/render_svg.dart';
import 'package:vmodel/src/vmodel.dart';

import '../../../create_coupons/widget/coupon_bottom_sheet.dart';
import '../profile_features/services/views/services_homepage.dart';

class VWidgetsBusinessProfileSubInfoDetails extends StatelessWidget {
  final String? stars;
  final String? userName;
  final String? userType;
  final String? address;
  final bool hasService;
  final bool hasCoupon;
  final bool hasJob;
  // final String? companyUrl;
  // final VoidCallback? onPressedCompanyURL;
  final bool isCurrentUser;
  final VoidCallback? onRatingTap;

  const VWidgetsBusinessProfileSubInfoDetails(
      {required this.stars,
      required this.userName,
      required this.userType,
      required this.address,
      // required this.companyUrl,
      // required this.onPressedCompanyURL,
      required this.onRatingTap,
      required this.hasService,
      required this.hasCoupon,
      required this.hasJob,
      required this.isCurrentUser,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        addVerticalSpacing(15),
        // Text(
        //   userType!.toUpperCase(),
        //   style: Theme.of(context).textTheme.displayMedium?.copyWith(
        //         color: Theme.of(context).primaryColor.withOpacity(0.5),
        //         // fontWeight: FontWeight.w500,
        //       ),
        // ),
        // addVerticalSpacing(6),
        // Text(
        //   userName!,
        //   style: Theme.of(context).textTheme.displayMedium?.copyWith(
        //         fontWeight: FontWeight.w600,
        //         color: Theme.of(context).primaryColor.withOpacity(1),
        //       ),
        // ),
        // addVerticalSpacing(6),
        GestureDetector(
          onTap: onRatingTap,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const RenderSvg(
                svgPath: VIcons.star,
                svgWidth: 18,
                svgHeight: 18,
              ),
              addHorizontalSpacing(8),
              Text(
                stars!,
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).primaryColor.withOpacity(1),
                    ),
              ),
            ],
          ),
        ),
        addVerticalSpacing(6),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 1.0),
              child: RenderSvg(
                svgPath: VIcons.mapIcon,
                svgWidth: 20,
                svgHeight: 20,
              ),
            ),
            addHorizontalSpacing(6),
            Flexible(
              child: Text(
                address!,
                maxLines: 2,
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).primaryColor.withOpacity(1),
                    ),
              ),
            ),
          ],
        ),
        addVerticalSpacing(6),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // const RenderSvg(
                //   svgPath: VIcons.coinIcon,
                //   svgWidth: 18,
                //   svgHeight: 19,
                // ),
                // addHorizontalSpacing(8),

                if (hasService)
                  GestureDetector(
                    // splashColor: Colors.red,
                    onTap: () {
                      navigateToRoute(
                          context, ServicesHomepage(username: userName));
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 4, vertical: 6),
                      child: Text(
                        "${VMString.bullet} services",
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              // fontWeight: FontWeight.w500,
                              // color: VmodelColors.primaryColor,
                              // Theme.of(context).primaryColor.withOpacity(0.3),
                              color: Theme.of(context)
                                  .primaryColor
                                  .withOpacity(0.5),
                            ),
                      ),
                    ),
                  ),

                if (hasService) addHorizontalSpacing(6),
                if (hasCoupon)
                  GestureDetector(
                    onTap: () {
                      // _showBottomSheet(context,
                      //     title: "Coupons", content: '40% of nike');

                      // CouponNotifier _createCoupon = CouponNotifier();

                      // final data = await _createCoupon.getCoupon('markshire');
                      // print('----------------------------');
                      // print('-----$data-------');

                      //     _createCoupon.

                      showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          builder: (context) {
                            return CouponBottomSheet(
                              title: 'Coupons',
                              username: userName!,
                            );
                          });
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 4, vertical: 6),
                      child: Text(
                        "${VMString.bullet} Coupons",
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              // fontWeight: FontWeight.w500,
                              // color: VmodelColors.primaryColor,

                              color: Theme.of(context)
                                  .primaryColor
                                  .withOpacity(0.5),
                              // Theme.of(context).primaryColor.withOpacity(0.3),
                            ),
                      ),
                    ),
                  ),

                if (hasJob) addHorizontalSpacing(6),
                if (hasJob)
                  GestureDetector(
                    onTap: () {
                      navigateToRoute(
                          context, UserJobsPage(username: userName));
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 4, vertical: 6),
                      child: Text(
                        "${VMString.bullet} Jobs",
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              // fontWeight: FontWeight.w500,
                              // color: VmodelColors.primaryColor,
                              // Theme.of(context).primaryColor.withOpacity(0.3),
                              color: Theme.of(context)
                                  .primaryColor
                                  .withOpacity(0.5),
                            ),
                      ),
                    ),
                  ),
              ],
            ),

            //!Complete ID verification functionality implementation
            // Container(
            //   padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 4),
            //   decoration: BoxDecoration(
            //       borderRadius: BorderRadius.circular(6),
            //       border: Border.all(
            //           color: VmodelColors.primaryColor.withOpacity(0.5))),
            //   child: Text(
            //     "ID VERIFIED",
            //     style: Theme.of(context).textTheme.displaySmall?.copyWith(
            //           color: Theme.of(context).primaryColor.withOpacity(0.5),
            //           // fontWeight: FontWeight.w500,
            //         ),
            //   ),
            // ),
          ],
        ),
        // if (companyUrl != null)
        //   GestureDetector(
        //     onTap: onPressedCompanyURL,
        //     child: Text(
        //       "$companyUrl",
        //       overflow: TextOverflow.ellipsis,
        //       maxLines: 1,
        //       style: Theme.of(context).textTheme.displayMedium?.copyWith(
        //             fontSize: 11.sp,
        //             fontWeight: FontWeight.w500,
        //             color: Theme.of(context).primaryColor.withOpacity(0.3),
        //           ),
        //     ),
        //   ),
        addVerticalSpacing(10),
      ],
    );
  }
}
