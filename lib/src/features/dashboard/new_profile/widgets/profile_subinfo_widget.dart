import 'package:vmodel/src/res/icons.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/shared/rend_paint/render_svg.dart';
import 'package:vmodel/src/vmodel.dart';

import '../../../create_coupons/widget/coupon_bottom_sheet.dart';
import '../profile_features/services/views/services_homepage.dart';
import '../profile_features/user_jobs/views/user_jobs_homepage.dart';

class VWidgetsProfileSubInfoDetails extends StatelessWidget {
  final String? stars;
  final String userName; //Todo comment out
  final String? userType; //Todo comment out
  final String? address;
  final bool hasService;
  final bool hasCoupon;
  final bool hasJob;
  final String? userRatingCount;
  final bool? isCurrentUser;
  final VoidCallback? onRatingTap;

  const VWidgetsProfileSubInfoDetails(
      {required this.stars,
      required this.userName,
      this.isCurrentUser,
      required this.userType,
      required this.userRatingCount,
      required this.address,
      required this.hasService,
      required this.hasCoupon,
      required this.hasJob,
      required this.onRatingTap,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // addVerticalSpacing(15),
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
        addVerticalSpacing(7),
        GestureDetector(
          onTap: onRatingTap,
          child: Row(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    Icons.star,
                    size: 24,
                  ),
                  addHorizontalSpacing(5),
                  Text(
                    "$stars ($userRatingCount)",
                    style: Theme.of(context).textTheme.displayMedium?.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                ],
              ),
              addHorizontalSpacing(10),
            ],
          ),
        ),
        addVerticalSpacing(5),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 0),
              child: RenderSvg(
                svgPath: VIcons.mapIcon,
                svgWidth: 18,
                svgHeight: 18,
                color: Theme.of(context).iconTheme.color,
              ),
            ),
            addHorizontalSpacing(10),
            Flexible(
              child: Text(
                address!,
                maxLines: 2,
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
              ),
            ),
          ],
        ),
        // addVerticalSpacing(6),
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
                        horizontal: 4,
                        vertical: 6,
                      ),
                      child: Text(
                        "${VMString.bullet} Services",
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              // fontWeight: FontWeight.w500,
                              // color: VmodelColors.primaryColor,
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
                              username: userName,
                              isCurrentUser: isCurrentUser ?? false,
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
                            color: Theme.of(context)
                                .primaryColor
                                .withOpacity(0.5)),
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
                                  .withOpacity(.5),
                            ),
                      ),
                    ),
                  ),
              ],
            ),

            // if (true) addHorizontalSpacing(0),

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
        addVerticalSpacing(2),
      ],
    );
  }
}
