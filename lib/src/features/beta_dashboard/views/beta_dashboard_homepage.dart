import 'package:vmodel/src/features/beta_dashboard/views/beta_dashboard_browser.dart';
import 'package:vmodel/src/features/settings/widgets/settings_submenu_tile_widget.dart';
import 'package:vmodel/src/res/icons.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/shared/appbar/appbar.dart';
import 'package:vmodel/src/shared/rend_paint/render_svg.dart';
import 'package:vmodel/src/vmodel.dart';

class BetaDashboardHomepage extends StatelessWidget {
  const BetaDashboardHomepage({super.key});
  static const routeName = 'betaDashboard';

  @override
  Widget build(BuildContext context) {
    _navigateTo({required String title, required String url}) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (builder) => BetaDashBoardWeb(title: title, url: url)));
    }
//    Suggest a feature
// What can we improve on?
// Announcements
// Upcoming features
// Updates documentation
// App Documentation

    List betaDashboardItems = [
      // VWidgetsSettingsSubMenuTileWidget(
      //     title: "Suggest a feature",
      //     onTap: () {
      //       _navigateTo(title: 'Suggest a feature', url: 'https://vmodel.app/');
      //     }),
      // VWidgetsSettingsSubMenuTileWidget(
      //     title: "What can we improve on?",
      //     onTap: () {
      //       _navigateTo(
      //           title: 'What can we improve on?', url: 'https://vmodel.app/');
      //     }
      //     ),
      VWidgetsSettingsSubMenuTileWidget(
          title: "Announcements",
          onTap: () {
            _navigateTo(title: 'Announcements', url: 'https://vmodel.app/');
          }),
      VWidgetsSettingsSubMenuTileWidget(
          title: "Upcoming features",
          onTap: () {
            _navigateTo(title: 'Upcoming features', url: 'https://vmodel.app/');
          }),
      VWidgetsSettingsSubMenuTileWidget(
          title: "Updates documentation",
          onTap: () {
            _navigateTo(
                title: 'Updates documentation', url: 'https://vmodel.app/');
          }),
      VWidgetsSettingsSubMenuTileWidget(
          title: "App Documentation",
          onTap: () {
            _navigateTo(title: 'App Documentation', url: 'https://vmodel.app/');
          }),
    ];

    return Scaffold(
      appBar: const VWidgetsAppBar(
        appbarTitle: "Beta Dashboard",
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
                        image:
                            AssetImage('assets/images/betaDashboardBanner.jpg'),
                        fit: BoxFit.cover),
                  ),
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RenderSvg(
                      svgPath: VIcons.cpuIcon,
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
                        "Welcome to our BETA dashboard!",
                        style:
                            Theme.of(context).textTheme.displayLarge!.copyWith(
                                  color: VmodelColors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12.sp,
                                ),
                      ),
                      addVerticalSpacing(4),
                      Text(
                        "Drive improvements and accelerate growth \nwith our dashboard.",
                        // textAlign: TextAlign.center,
                        style:
                            Theme.of(context).textTheme.displayMedium!.copyWith(
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
          //           svgPath: VIcons.cpuIcon,
          //           color: VmodelColors.white,
          //           svgWidth: 50,
          //           svgHeight: 50,
          //         ),
          //         addVerticalSpacing(16),
          //         Text(
          //           "Welcome to our BETA dashboard!",
          //           style: Theme.of(context).textTheme.displayLarge!.copyWith(
          //                 color: VmodelColors.white,
          //                 fontWeight: FontWeight.w600,
          //                 fontSize: 14.sp,
          //               ),
          //         ),
          //         addVerticalSpacing(4),
          //         Text(
          //           "Drive improvements and accelerate growth \nwith our dashboard.",
          //           textAlign: TextAlign.center,
          //           style: Theme.of(context).textTheme.displayMedium!.copyWith(
          //                 color: VmodelColors.white,
          //               ),
          //         ),
          //       ],
          //     ),
          //   ],
          // ),

          addVerticalSpacing(20),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ListView.separated(
                  itemBuilder: ((context, index) => betaDashboardItems[index]),
                  separatorBuilder: (context, index) => const Divider(),
                  itemCount: betaDashboardItems.length),
            ),
          ),
        ],
      ),
    );
  }
}
