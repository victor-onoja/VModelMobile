import 'package:flutter/material.dart';
import 'package:vmodel/src/core/routing/navigator_1.0.dart';
import 'package:vmodel/src/features/create_posts/views/create_post_with_images.dart';
import 'package:vmodel/src/features/jobs/create_jobs/views/create_job_view_first.dart';
import 'package:vmodel/src/features/settings/widgets/settings_submenu_tile_widget_with_icon.dart';
import 'package:vmodel/src/res/icons.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/shared/modal_pill_widget.dart';
import '../../create_coupons/add_coupons.dart';
import '../../settings/views/booking_settings/views/new_add_services_homepage.dart';

class VWidgetsVModelMainButtonFunctionality extends StatelessWidget {
  const VWidgetsVModelMainButtonFunctionality({super.key});

  @override
  Widget build(BuildContext context) {
    List vModelButtonItems = [
      VWidgetsSettingsSubMenuWithSuffixTileWidget(
        title: "Create a Post",
        svgPath: VIcons.galleryAddIcon,
        onTap: () {
          // popSheet(context);
          popSheet(context);
          navigateToRoute(
              AppNavigatorKeys.instance.navigatorKey.currentContext!,
              const CreatePostWithImagesMediaPicker());
        },
      ),
      VWidgetsSettingsSubMenuWithSuffixTileWidget(
        title: "Create a Job",
        svgPath: VIcons.alignVerticalIcon,
        onTap: () {
          popSheet(context);
          navigateToRoute(context, const CreateJobFirstPage());
        },
      ),
      VWidgetsSettingsSubMenuWithSuffixTileWidget(
        title: "Create a Service",
        svgPath: VIcons.addServiceOutline,
        //  const Icon(Iconsax.shop_add),
        onTap: () {
          popSheet(context);

          navigateToRoute(
              context, const AddNewServicesHomepage(servicePackage: null));
        },
      ),
      VWidgetsSettingsSubMenuWithSuffixTileWidget(
        title: "Create a Coupon",
        svgPath: VIcons.couponIcon,
        //  const Icon(Iconsax.shop_add),
        onTap: () {
          popSheet(context);

          navigateToRoute(
              context,
              AddNewCouponHomepage(
                context,
                servicePackage: null,
              ));
        },
      ),
      addVerticalSpacing(25),
    ];
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
      ),

      //shadowColor: Colors.black,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          addVerticalSpacing(15),
          const Align(alignment: Alignment.center, child: VWidgetsModalPill()),
          addVerticalSpacing(25),
          Flexible(
            child: ListView.separated(
              physics: NeverScrollableScrollPhysics(),
              itemCount: vModelButtonItems.length,
              shrinkWrap: true,
              itemBuilder: ((context, index) => vModelButtonItems[index]),
              separatorBuilder: (context, index) => const Divider(),
            ),
          ),
          // ...vModelButtonItems,
          // addVerticalSpacing(25),
        ],
      ),
    );
  }
}
