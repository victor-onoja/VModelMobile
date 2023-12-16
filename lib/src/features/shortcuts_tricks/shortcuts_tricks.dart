import 'package:vmodel/src/features/beta_dashboard/views/beta_dashboard_browser.dart';
import 'package:vmodel/src/features/settings/widgets/settings_submenu_tile_widget.dart';
import 'package:vmodel/src/res/icons.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/shared/appbar/appbar.dart';
import 'package:vmodel/src/shared/rend_paint/render_svg.dart';
import 'package:vmodel/src/vmodel.dart';

class ShortcutsAndTricksHomepage extends StatelessWidget {
  const ShortcutsAndTricksHomepage({super.key});
  static const routeName = 'shortcutsAndTricks';

  @override
  Widget build(BuildContext context) {
    _navigateTo({required String title, required String url}) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (builder) => BetaDashBoardWeb(title: title, url: url)));
    }

    List shortcutTitles = [
      "Double tap on the feed icon to go to the content screen",
      "Tap and hold your username to change it",
      "Tap and hold your display name to change it",
      "Tap and hold your bio to change it",
      "Tap, hold and move your gallery in portfolio to change its position.",
      // "Hold feed for slides",
      "Double tap on jobs market icon for all jobs",
      "Hold job cards to save them",
      "In the middle of a feed, explore portfolio, and discover, press icon to go back",
      "Hold discover icon to go to explore",
      // "Hold feed icon to go to Content",
      "Tap the film icon on your feed  to open Slides",
      "Hold your profile headshot to expand it",
      "Tap on others profile headshot to expand it",
    ];

    return Scaffold(
        appBar: const VWidgetsAppBar(
          appbarTitle: "Shortcuts and Tricks",
          leadingIcon: VWidgetsBackButton(),
        ),
        body: Column(
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
                        svgPath: VIcons.menuShortcuts,
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
                          "Shortcuts and Tricks",
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
                          "Learn time-saving shortcuts and expert tricks.",
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

            // Stack(
            //   alignment: AlignmentDirectional.center,
            //   children: [
            //     Container(
            //       height: 180,
            //       decoration: const BoxDecoration(
            //         image: DecorationImage(
            //             image:
            //                 AssetImage('assets/images/betaDashboardBanner.jpg'),
            //             fit: BoxFit.cover),
            //       ),
            //     ),
            //     Column(
            //       crossAxisAlignment: CrossAxisAlignment.center,
            //       children: [
            //         RenderSvg(
            //           svgPath: VIcons.menuShortcuts,
            //           color: VmodelColors.white,
            //           svgWidth: 50,
            //           svgHeight: 50,
            //         ),
            //         addVerticalSpacing(16),
            //         Text(
            //           "Shortcuts and Tricks",
            //           style: Theme.of(context).textTheme.displayLarge!.copyWith(
            //                 color: VmodelColors.white,
            //                 fontWeight: FontWeight.w600,
            //                 fontSize: 14.sp,
            //               ),
            //         ),
            //         addVerticalSpacing(4),
            //         Text(
            //           "Learn time-saving shortcuts and expert tricks.",
            //           textAlign: TextAlign.center,
            //           style:
            //               Theme.of(context).textTheme.displayMedium!.copyWith(
            //                     color: VmodelColors.white,
            //                   ),
            //         ),
            //       ],
            //     ),
            //   ],
            // ),

            addVerticalSpacing(20),
            Expanded(
              child: ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  itemBuilder: ((context, index) {
                    return Padding(
                      padding: EdgeInsets.only(
                          bottom:
                              (index == shortcutTitles.length - 1) ? 25 : 0),
                      child: VWidgetsSettingsSubMenuTileWidget(
                          title: shortcutTitles[index],
                          onTap: () {
                            //   _navigateTo(
                            //       title: 'What can we improve on?',
                            //       url: 'https://vmodel.app/');
                            // });
                          }),
                    );
                  }),
                  separatorBuilder: (context, index) => const Divider(),
                  itemCount: shortcutTitles.length),
            ),
          ],
        ));
  }
}
