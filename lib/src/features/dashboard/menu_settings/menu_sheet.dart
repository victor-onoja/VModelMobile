import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vmodel/src/core/controller/user_prefs_controller.dart';
import 'package:vmodel/src/features/beta_dashboard/views/beta_dashboard_homepage.dart';
import 'package:vmodel/src/features/dashboard/creation_tools/creation_tools.dart';
import 'package:vmodel/src/features/faq_s/views/faqs_homepage.dart';
import 'package:vmodel/src/features/help_support/views/help_home.dart';
import 'package:vmodel/src/features/qr_code/views/qr_page.dart';
import 'package:vmodel/src/features/refer_and_earn/views/invite_and_earn_homepage.dart';
import 'package:vmodel/src/features/settings/views/settings_page.dart';
import 'package:vmodel/src/res/icons.dart';
import 'package:vmodel/src/res/res.dart';
import 'package:vmodel/src/shared/modal_pill_widget.dart';
import 'package:vmodel/src/shared/rend_paint/render_svg.dart';
import 'package:vmodel/src/vmodel.dart';

import '../../../core/network/urls.dart';
import '../../../core/utils/costants.dart';
import '../../../shared/popup_dialogs/confirmation_popup.dart';
import '../../../shared/switch/primary_switch.dart';
import '../../authentication/controller/auth_status_provider.dart';
import '../../beta_dashboard/views/beta_dashboard_browser.dart';
import '../../faq_s/views/popular_faqs_page.dart';
import '../../nothumbnail_posts/posts_with_no_thumbnail_listing.dart';
import '../../saved/views/boards_main.dart';
import '../../saved/views/delte_ml/views/example_del_ml_posts.dart';
import '../../shortcuts_tricks/shortcuts_tricks.dart';
import '../../suite/views/business_suite_homepage.dart';
import '../../vmodel_credits/views/vmodel_credits.dart';

class MenuSheet extends ConsumerWidget {
  final bool isNotTabSreen;
  const MenuSheet({super.key, this.isNotTabSreen = false});

  Widget _getLeadingIcon(Widget icon) => Container(
      padding: EdgeInsets.zero,
      margin: EdgeInsets.zero,
      alignment: Alignment.topCenter,
      child: icon);

  _MenuSettingsTileItem(
      BuildContext context, String title, String icon, Widget nextScreen) {
    return InkWell(
      onTap: () {
        navigateToRoute(context, nextScreen);
      },
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 6.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Flexible(
                    child: RenderSvg(
                      svgPath: icon,
                      svgHeight: 24,
                      svgWidth: 24,
                    ),
                  ),
                  addHorizontalSpacing(20),
                  Expanded(
                    child: Text(
                      title,
                      style: Theme.of(context).textTheme.displayLarge!.copyWith(
                          fontWeight: FontWeight.w700,
                          color: Theme.of(context).primaryColor),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _customMenuTile(
      BuildContext context, String icon, String title, Function() method) {
    return InkWell(
      onTap: method,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 6.0,
        ),
        child: Column(
          children: [
            Row(
                mainAxisAlignment: MainAxisAlignment.start,
                // mainAxisSize: MainAxisSize.max,
                children: [
                  Flexible(
                    child: RenderSvg(
                      svgPath: icon,
                      svgHeight: 24,
                      svgWidth: 24,
                      color: Theme.of(context).iconTheme.color,
                    ),
                  ),
                  addHorizontalSpacing(20),
                  Expanded(
                    child: Text(
                      title,
                      style:
                          Theme.of(context).textTheme.displayMedium!.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                    ),
                  ),
                ]),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(userPrefsProvider, (previous, next) {
      print("User config $next");
    });
    final userConfig = ref.watch(userPrefsProvider);
    final _isDark = userConfig.value!.themeMode == ThemeMode.dark;
    // final userPrefsConfig = ref.watch(userPrefsProvider);
    // final currentThemeMode = userPrefsConfig.value!.themeMode;
    // bool _isDark = currentThemeMode == Brightness.dark;
    // ignore: unused_local_variable
    // ref.watch(dashTabProvider);
    // final watchProvider = ref.watch(dashTabProvider.notifier);
    List menuItems = [
      // addVerticalSpacing(8),
      // _customMenuTile(_getLeadingIcon(homeIcon), 'Feed', () {
      //   if (isNotTabSreen == true) {
      //     watchProvider.changeIndexState(0);
      //     navigateAndRemoveUntilRoute(context, const DashBoardView());
      //   } else {
      //     Navigator.pop(context);
      //     watchProvider.changeIndexState(0);
      //   }
      // }, badge: '10'),
      // _customMenuTile(context, VIcons.verticalPostIcon, 'Discover', () {
      //   final watchProvider = ref.read(dashTabProvider.notifier);
      //   ref.read(feedProvider.notifier).isFeedPage(isNavigatoToDiscover: true);
      //   Navigator.pop(context);
      //   watchProvider.changeIndexState(0);
      // }),
      // _customMenuTile(
      //     _getLeadingIcon(settingsIcon), 'Shimmer look (Temporary field)', () {
      //   popSheet(context);
      //   navigateToRoute(context, const ShimmerDemoPage());
      // }),

      // _customMenuTile(
      //     _getLeadingIcon(settingsIcon), 'Profile (Temporary field)', () {
      //   popSheet(context);
      //   navigateToRoute(context, const ProfileBaseScreen());
      // }),

      // _customMenuTile(context, VIcons.menuPrint, 'Print...', () {
      //   navigateToRoute(context, const PrintHomepage());
      // }),

      _customMenuTile(context, VIcons.business, 'Business Hub', () {
        popSheet(context);
        navigateToRoute(context, const BusinessSuiteHomepage());
        // context.goNamed(BusinessSuiteHomepage.routeName);
      }),
     
      _customMenuTile(context, VIcons.magicpen, 'Creation Tools', () {
        popSheet(context);
        navigateToRoute(context, const CreationTools());
        // context.pushNamed(CreationTools.routeName);
      }),
      _customMenuTile(context, VIcons.menuSettings, 'Settings', () {
        popSheet(context);
        navigateToRoute(context, const SettingsSheet());
        // context.pushNamed(SettingsSheet.routeName);
      }),
      // _customMenuTile(context, VIcons.menuPrint, 'Print...', () {
      //   navigateToRoute(context, const PrintHomepage());
      // }),
      _customMenuTile(context, VIcons.menuSaved, 'Boards', () {
        navigateToRoute(context, const BoardsHomePageV3());
        // context.pushNamed(SavedHomePage.routeName);
      }),
      // _customMenuTile(_getLeadingIcon(archivedIcon), 'Archived', () {
      //   navigateToRoute(context, const ArchivedView());
      // }),
      // _customMenuTile(_getLeadingIcon(reviewIcon), 'Reviews', () {
      //   navigateToRoute(context, const ReviewsUI());
      // }),
      _customMenuTile(context, VIcons.menuQRCode, 'QR code', () {
        navigateToRoute(context, const ReferAndEarnQrPage());
        // navigateToRoute(context, const ReviewsUI());
      }),

      // _customMenuTile(_getLeadingIcon(editIcon), 'Bookings', () {
      //   navigateToRoute(context, const BookingsMenuView());
      // }, badge: '1'),

      // _customMenuTile(_getLeadingIcon(userIcon), 'Edit Polaroid', () {}),

      // _customMenuTile(
      //   _getLeadingIcon(requestIcon),
      //   'Requests',
      //   () {},
      // ),
      _customMenuTile(context, VIcons.menuReferAndEarn, 'Invite and Earn', () {
        navigateToRoute(context, const ReferAndEarnHomepage());
        // context.pushNamed(ReferAndEarnHomepage.routeName);
      }),
      _customMenuTile(context, VIcons.cpuIcon, 'Beta Dashboard', () {
        navigateToRoute(context, const BetaDashboardHomepage());
        // context.pushNamed(BetaDashboardHomepage.routeName);
      }),
      // _customMenuTile(context, VIcons.gameIcons, 'Games', () {
      //   navigateToRoute(context, const Games());
      //   // context.pushNamed(ShortcutsAndTricksHomepage.routeName);
      // }),
      _customMenuTile(context, VIcons.menuShortcuts, 'Shortcuts and Tricks',
          () {
        navigateToRoute(context, const ShortcutsAndTricksHomepage());
        // context.pushNamed(ShortcutsAndTricksHomepage.routeName);
      }),
      _customMenuTile(context, VIcons.helpandSupportIcon, 'Reports', () {
        navigateToRoute(context, const HelpAndSupportMainView());
        // context.pushNamed(HelpAndSupportMainView.routeName);
      }),
      //FAQs tile
      _customMenuTile(context, VIcons.menuFAQ, 'Help Centre', () {
        // navigateToRoute(context, const FAQsHomepage());
        navigateToRoute(context, const PopularFAQsHomepage());
        // context.pushNamed(FAQsHomepage.routeName);
      }),
      // _customMenuTile(context, VIcons.menuFAQ, 'Opening times', () {
      //   navigateToRoute(context, const FAQsHomepage());
      // }),
      _customMenuTile(context, VIcons.coinIcon, 'VModel Credits', () {
        navigateToRoute(context, const UserVModelCreditHomepage());
        // context.pushNamed(UserVModelCreditHomepage.routeName);
      }),

      _customMenuTile(context, VIcons.aboutIcon, 'About VModel', () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (builder) => const BetaDashBoardWeb(
                title: 'About VModel', url: VUrls.aboutUrl)));
      }),
      _customMenuTile(context, VIcons.aboutIcon, 'Terms of Use', () {
        navigateToRoute(context, const PopularFAQsHomepage());
      }),
      // _customMenuTile(context, VIcons.aboutIcon, 'Reposts', () {
      //   navigateToRoute(context, PostsWithoutThumbnails());
      // }),

      _customMenuTile(context, VIcons.closeSquareIcon, 'Logout', () {
        HapticFeedback.lightImpact();
        showDialog(
            context: context,
            builder: ((context) => VWidgetsConfirmationPopUp(
                  popupTitle: "Logout Confirmation",
                  popupDescription:
                      "Are you sure you want to logout from your account?",
                  onPressedYes: () async {
                    Navigator.of(context)
                      ..pop()
                      ..pop();
                    // await VModelSharedPrefStorage()
                    //     .clearObject(VSecureKeys.userTokenKey);
                    // await VModelSharedPrefStorage()
                    //     .clearObject(VSecureKeys.username);
                    ref.read(authenticationStatusProvider.notifier).logout();
                    // navigateAndRemoveUntilRoute(context, LoginPage());
                  },
                  onPressedNo: () {
                    Navigator.pop(context);
                  },
                )));
      }),
      addVerticalSpacing(24),
    ];
    return Container(
      height: MediaQuery.of(context).size.height / 1.15,
      // width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(13),
          topRight: Radius.circular(13),
        ),
      ),
      child: Column(
        children: [
          addVerticalSpacing(15),
          const Align(alignment: Alignment.center, child: VWidgetsModalPill()),
          addVerticalSpacing(25),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 18, vertical: 6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    RenderSvg(svgPath: VIcons.darkModeIcon),
                    addHorizontalSpacing(20),
                    Text(
                      "Dark Mode",
                      style: Theme.of(context).textTheme.displayLarge!.copyWith(
                            fontWeight: FontWeight.w600,
                            // color: Theme.of(context).primaryColor,
                          ),
                    ),
                  ],
                ),
                VWidgetsSwitch(
                    swicthValue: _isDark,
                    onChanged: (value) {
                      ref
                          .read(userPrefsProvider.notifier)
                          .addOrUpdatePrefsEntry(userConfig.value!.copyWith(
                              themeMode: _isDark
                                  ? ThemeMode.light
                                  : ThemeMode.dark //Do the toggle
                              ));
                    }),
              ],
            ),
          ),
          addVerticalSpacing(6),
          Expanded(
            child: ListView.separated(
                padding: const EdgeInsets.only(
                  left: 18,
                  right: 18,
                  bottom: VConstants.bottomPaddingForBottomSheets,
                ),
                itemBuilder: ((context, index) => menuItems[index]),
                separatorBuilder: (context, index) => Divider(
                      // color: Theme.of(context).dividerColor,
                      color: Colors.transparent,
                    ),
                itemCount: menuItems.length),
          ),
          // addVerticalSpacing(30),
        ],
      ),
    );
  }
}
