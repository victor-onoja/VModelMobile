// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:vmodel/src/features/authentication/login/views/sign_in.dart';
import 'package:vmodel/src/features/authentication/register/views/sign_up.dart';

import 'src/features/authentication/new_Login_screens/login_screen.dart';
import 'src/features/authentication/new_Login_screens/new_user_onboarding.dart';
import 'src/features/beta_dashboard/views/beta_dashboard_homepage.dart';
import 'src/features/dashboard/creation_tools/creation_tools.dart';
import 'src/features/dashboard/dash/go_dashboard_ui.dart';
import 'src/features/dashboard/discover/views/discover_main_screen.dart';
import 'src/features/dashboard/discover/views/sub_screens/view_all.dart';
import 'src/features/dashboard/feed/views/feed_main.dart';
import 'src/features/dashboard/new_profile/views/new_profile_homepage.dart';
import 'src/features/faq_s/views/faqs_homepage.dart';
import 'src/features/help_support/views/help_home.dart';
import 'src/features/jobs/job_market/views/all_jobs.dart';
import 'src/features/jobs/job_market/views/business_user/market_place.dart';
import 'src/features/jobs/job_market/views/coupons.dart';
import 'src/features/jobs/job_market/views/local_services.dart';
import 'src/features/refer_and_earn/views/invite_and_earn_homepage.dart';
import 'src/features/qr_code/views/qr_page.dart';
import 'src/features/saved/views/boards_search.dart';
import 'src/features/settings/views/settings_page.dart';
import 'src/features/shortcuts_tricks/shortcuts_tricks.dart';
import 'src/features/splash/views/new_splash.dart';
import 'src/features/suite/views/business_suite_homepage.dart';
import 'src/features/vmodel_credits/views/vmc_history_main.dart';
import 'src/features/vmodel_credits/views/vmodel_credits.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');
final GlobalKey<NavigatorState> _sectionANavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'sectionANav');

final routesProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/',
    // initialLocation: '/${FeedMainUI.path}',
    debugLogDiagnostics: true,
    routes: <RouteBase>[
      GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) => NewSplash(),
        routes: <RouteBase>[
          GoRoute(
            path: 'login',
            name: LoginPage.name,
            builder: (BuildContext context, GoRouterState state) => LoginPage(),
          ),
          GoRoute(
            path: 'onboarding',
            name: OnBoardingPage.name,
            builder: (BuildContext context, GoRouterState state) =>
                const OnBoardingPage(),
          ),
          GoRoute(
              path: 'signup',
              name: UserOnBoardingPage.name,
              builder: (BuildContext context, GoRouterState state) =>
                  const UserOnBoardingPage(),
              routes: [
                GoRoute(
                  path: 'details',
                  name: SignUpPage.routeName,
                  builder: (BuildContext context, GoRouterState state) =>
                      const SignUpPage(),
                ),
              ]),
          // GoRoute(
          //   path: AuthWidgetPage.path,
          //   builder: (BuildContext context, GoRouterState state) =>
          //       const AuthWidgetPage(),
          // ),
          // GoRoute(
          //   path: '${AuthWidgetPage.path}',
          //   builder: (BuildContext context, GoRouterState state) =>
          //       const AuthWidgetPage(),
          // ),
          StatefulShellRoute.indexedStack(
            builder: (BuildContext context, GoRouterState state,
                StatefulNavigationShell navigationShell) {
              // Return the widget that implements the custom shell (in this case
              // using a BottomNavigationBar). The StatefulNavigationShell is passed
              // to be able access the state of the shell and to navigate to other
              // branches in a stateful way.
              // return ScaffoldWithNavBar(navigationShell: navigationShell);
              return GoDashBoardView(navigationShell: navigationShell);
            },
            branches: <StatefulShellBranch>[
              // The route branch for the first tab of the bottom navigation bar.

              // const ContentView(),

              // Consumer(builder: (_, userRef, __) {
              //   final appUser = userRef.watch(appUserProvider);
              //   final isBusinessAccount = appUser.valueOrNull?.isBusinessAccount ?? false;

              //   if (isBusinessAccount) {
              //     return LocalBusinessProfileBaseScreen(
              //         username: appUser.valueOrNull!.username, isCurrentUser: true);
              //   } else {
              //     return const ProfileBaseScreen(isCurrentUser: true);
              //   }
              // }),

              // The route branch for the second tab of the bottom navigation bar.
              StatefulShellBranch(
                // It's not necessary to provide a navigatorKey if it isn't also
                // needed elsewhere. If not provided, a default key will be used.
                navigatorKey: _sectionANavigatorKey,
                routes: <RouteBase>[
                  GoRoute(
                    // The screen to display as the root in the second tab of the
                    // bottom navigation bar.
                    path: 'feed',
                    name: '${FeedMainUI.routeName}',
                    builder: (BuildContext context, GoRouterState state) =>
                        const FeedMainUI(),
                    routes: <RouteBase>[
                      GoRoute(
                          path: 'notifications',
                          name: NotificationMain.route,
                          builder:
                              (BuildContext context, GoRouterState state) =>
                                  NotificationMain()),
                      // GoRoute(
                      //   path: 'details/:param',
                      //   builder: (BuildContext context, GoRouterState state) =>
                      //       DetailsScreen(
                      //     label: 'B',
                      //     param: state.pathParameters['param'],
                      //   ),
                      // ),
                    ],
                  ),
                ],
              ),
              StatefulShellBranch(
                // It's not necessary to provide a navigatorKey if it isn't also
                // needed elsewhere. If not provided, a default key will be used.
                routes: <RouteBase>[
                  GoRoute(
                    // The screen to display as the root in the second tab of the
                    // bottom navigation bar.
                    path: 'discover',
                    name: '${DiscoverView.routeName}',
                    builder: (BuildContext context, GoRouterState state) =>
                        const DiscoverView(),
                    routes: <RouteBase>[
                      GoRoute(
                        path: ':title/all',
                        name: ViewAllScreen.routeName,
                        builder: (BuildContext context, GoRouterState state) =>
                            ViewAllScreen(
                          title: state.pathParameters['title']!,
                          // dataList: discoverItems.featuredTalents,
                          // getList: DiscoverController().feaaturedList,
                          // onItemTap: (value) =>
                          //     _navigateToUserProfile(value, isViewAll: true),
                        ),
                      ),
                      // GoRoute(
                      //   path: 'details/:param',
                      //   builder: (BuildContext context, GoRouterState state) =>
                      //       DetailsScreen(
                      //     label: 'B',
                      //     param: state.pathParameters['param'],
                      //   ),
                      // ),
                    ],
                  ),
                ],
              ),
              StatefulShellBranch(
                // It's not necessary to provide a navigatorKey if it isn't also
                // needed elsewhere. If not provided, a default key will be used.
                routes: <RouteBase>[
                  GoRoute(
                    // The screen to display as the root in the second tab of the
                    // bottom navigation bar.
                    path: 'marketplace',
                    name: '${BusinessMyJobsPageMarketplace.routeName}',
                    builder: (BuildContext context, GoRouterState state) =>
                        const BusinessMyJobsPageMarketplace(), //const BusinessMyJobsPage(),
                    routes: <RouteBase>[
                      GoRoute(
                          path: 'services',
                          name: LocalServices.routeName,
                          builder:
                              (BuildContext context, GoRouterState state) =>
                                  LocalServices()),
                      GoRoute(
                          path: 'jobs',
                          name: AllJobs.routeName,
                          builder:
                              (BuildContext context, GoRouterState state) =>
                                  AllJobs(
                                    title: 'Hello',
                                  )),
                      GoRoute(
                        path: 'coupons',
                        name: Coupons.routeName,
                        builder: (BuildContext context, GoRouterState state) =>
                            Coupons(
                                // title: state.pathParameters['title']!,
                                // dataList: discoverItems.featuredTalents,
                                // getList: DiscoverController().feaaturedList,
                                // onItemTap: (value) =>
                                //     _navigateToUserProfile(value, isViewAll: true),
                                ),
                      ),
                      // GoRoute(
                      //   path: 'details/:param',
                      //   builder: (BuildContext context, GoRouterState state) =>
                      //       DetailsScreen(
                      //     label: 'B',
                      //     param: state.pathParameters['param'],
                      //   ),
                      // ),
                    ],
                  ),
                ],
              ),

              // The route branch for the third tab of the bottom navigation bar.
              StatefulShellBranch(
                routes: <RouteBase>[
                  GoRoute(
                    // The screen to display as the root in the third tab of the
                    // bottom navigation bar.
                    path: 'profile',
                    name: '${ProfileBaseScreen.routeName}',
                    builder: (BuildContext context, GoRouterState state) =>
                        const ProfileBaseScreen(isCurrentUser: true),
                    routes: <RouteBase>[
                      GoRoute(
                        path: 'business-suite',
                        name: BusinessSuiteHomepage.routeName,
                        builder: (BuildContext context, GoRouterState state) =>
                            BusinessSuiteHomepage(),
                      ),
                      // GoRoute(
                      //   path: 'details',
                      //   builder: (BuildContext context, GoRouterState state) =>
                      //       DetailsScreen(
                      //     label: 'C',
                      //     extra: state.extra,
                      //   ),
                      // ),
                    ],
                  ),
                ],
              ),
            ],
          ),

          GoRoute(
            path: 'creation-tools',
            name: CreationTools.routeName,
            builder: (BuildContext context, GoRouterState state) =>
                CreationTools(),
          ),
          GoRoute(
            path: 'settings',
            name: SettingsSheet.routeName,
            builder: (BuildContext context, GoRouterState state) =>
                SettingsSheet(),
          ),
          GoRoute(
            path: 'boards',
            name: BoardsSearchPage.routeName,
            builder: (BuildContext context, GoRouterState state) =>
                BoardsSearchPage(),
          ),
          GoRoute(
            path: 'qr',
            name: ReferAndEarnQrPage.routeName,
            builder: (BuildContext context, GoRouterState state) =>
                ReferAndEarnQrPage(),
          ),
          GoRoute(
            path: 'invite-and-earn',
            name: ReferAndEarnHomepage.routeName,
            builder: (BuildContext context, GoRouterState state) =>
                ReferAndEarnHomepage(),
          ),
          GoRoute(
            path: 'beta-dashboard',
            name: BetaDashboardHomepage.routeName,
            builder: (BuildContext context, GoRouterState state) =>
                BetaDashboardHomepage(),
          ),
          GoRoute(
            path: 'shortcuts',
            name: ShortcutsAndTricksHomepage.routeName,
            builder: (BuildContext context, GoRouterState state) =>
                ShortcutsAndTricksHomepage(),
          ),
          GoRoute(
            path: 'help-and-support',
            name: HelpAndSupportMainView.routeName,
            builder: (BuildContext context, GoRouterState state) =>
                HelpAndSupportMainView(),
          ),
          GoRoute(
            path: 'faqs',
            name: FAQsHomepage.routeName,
            builder: (BuildContext context, GoRouterState state) =>
                FAQsHomepage(),
          ),
          GoRoute(
            path: 'vmc',
            name: UserVModelCreditHomepage.routeName,
            builder: (BuildContext context, GoRouterState state) =>
                UserVModelCreditHomepage(),
          ),
        ],
      ),
    ],
  );
});

// This example demonstrates how to setup nested navigation using a
// BottomNavigationBar, where each bar item uses its own persistent navigator,
// i.e. navigation state is maintained separately for each item. This setup also
// enables deep linking into nested pages.

/// Builds the "shell" for the app by building a Scaffold with a
/// BottomNavigationBar, where [child] is placed in the body of the Scaffold.
class ScaffoldWithNavBar extends StatelessWidget {
  /// Constructs an [ScaffoldWithNavBar].
  const ScaffoldWithNavBar({
    required this.navigationShell,
    Key? key,
  }) : super(key: key ?? const ValueKey<String>('ScaffoldWithNavBar'));

  /// The navigation shell and container for the branch Navigators.
  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        // Here, the items of BottomNavigationBar are hard coded. In a real
        // world scenario, the items would most likely be generated from the
        // branches of the shell route, which can be fetched using
        // `navigationShell.route.branches`.
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Section A'),
          BottomNavigationBarItem(icon: Icon(Icons.work), label: 'Section B'),
          BottomNavigationBarItem(icon: Icon(Icons.tab), label: 'Section C'),
        ],
        currentIndex: navigationShell.currentIndex,
        onTap: (int index) => _onTap(context, index),
      ),
    );
  }

  /// Navigate to the current location of the branch at the provided index when
  /// tapping an item in the BottomNavigationBar.
  void _onTap(BuildContext context, int index) {
    // When navigating to a new branch, it's recommended to use the goBranch
    // method, as doing so makes sure the last navigation state of the
    // Navigator for the branch is restored.
    navigationShell.goBranch(
      index,
      // A common pattern when using bottom navigation bars is to support
      // navigating to the initial location when tapping the item that is
      // already active. This example demonstrates how to support this behavior,
      // using the initialLocation parameter of goBranch.
      initialLocation: index == navigationShell.currentIndex,
    );
  }
}
