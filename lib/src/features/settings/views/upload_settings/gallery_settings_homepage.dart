import 'package:flutter/material.dart';
import 'package:vmodel/src/core/routing/navigator_1.0.dart';
import 'package:vmodel/src/core/utils/shared.dart';
import 'package:vmodel/src/features/settings/views/booking_settings/widgets/booking_settings_card.dart';
import 'package:vmodel/src/features/settings/views/upload_settings/portfolio_galleries_settings_homepage.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/shared/appbar/appbar.dart';

import '../../../../core/utils/enum/album_type.dart';

class GallerySettingsHomepage extends StatefulWidget {
  const GallerySettingsHomepage({super.key});

  @override
  State<GallerySettingsHomepage> createState() =>
      _GallerySettingsHomepageState();
}

class _GallerySettingsHomepageState extends State<GallerySettingsHomepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const VWidgetsAppBar(
        appbarTitle: "Gallery Settings",
        leadingIcon: VWidgetsBackButton(),
      ),
      body: SingleChildScrollView(
        padding: const VWidgetsPagePadding.horizontalSymmetric(16),
        child: Column(children: [
          addVerticalSpacing(20),
          VWidgetsBookingSettingsCard(
            title: "Portfolio Galleries",
            onTap: () {
              navigateToRoute(
                context,
                const PortfolioGalleriesSettingsHomepage(
                  title: "Portfolio Galleries",
                  galleryType: AlbumType.portfolio,
                ),
              );
            },
          ),
          VWidgetsBookingSettingsCard(
            title: "Polaroid Galleries",
            onTap: () {
              navigateToRoute(
                context,
                const PortfolioGalleriesSettingsHomepage(
                  title: "Portfolio Galleries",
                  galleryType: AlbumType.polaroid,
                ),
              );
              // navigateToRoute(context, const PolaroidGalleriesSettingsHomepage());
            },
          ),
        ]),
      ),
    );
  }
}
