import 'dart:io';

import 'package:desktop_window/desktop_window.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_portal/flutter_portal.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:vmodel/src/app_locator.dart';
import 'package:vmodel/src/core/utils/helper_functions.dart';
import 'package:vmodel/src/features/vmodel_credits/views/vmc_history_main.dart';
import 'package:vmodel/src/shared/response_widgets/toast.dart';

import 'firebase_options.dart';
import 'src/core/cache/credentials.dart';
import 'src/core/cache/hive_provider.dart';
import 'src/core/cache/local_storage.dart';
import 'src/core/controller/user_prefs_controller.dart';
import 'src/core/utils/enum/vmodel_app_themes.dart';
import 'src/features/splash/views/new_splash.dart';
import 'src/res/res.dart';
import 'src/vmodel.dart';

final navigatorKey = GlobalKey<NavigatorState>();
void main() async {
  //removes the native white splashscreen that comes with the flutter sdk [a better way than tweaking the AndroidManifest file]
  WidgetsBinding widgetFlutterBinding =
      WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
      name: Platform.isIOS ? 'ios' : "android");
  // await FirebaseApi().initNotification();
  await Hive.initFlutter();

  FlutterNativeSplash.preserve(widgetsBinding: widgetFlutterBinding);
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await dotenv.load(fileName: '.env');
  if (Platform.isMacOS) {
    await DesktopWindow.setWindowSize(const Size(375, 812));
    await DesktopWindow.setMinWindowSize(const Size(375, 812));
    await DesktopWindow.setMaxWindowSize(const Size(375, 812));
  }
  runApp(const ProviderScope(child: VAppProduction()));
}

class VAppProduction extends ConsumerStatefulWidget {
  const VAppProduction({super.key});

  @override
  ConsumerState<VAppProduction> createState() => _VAppProductionState();
}

class _VAppProductionState extends ConsumerState<VAppProduction> {
  // late final UserPrefsConfig prefsConfig;

  @override
  void initState() {
    runInit();
    // setupInteractedMessage();
    super.initState();
  }

  // Future<void> setupInteractedMessage() async {
  //   // Get any messages which caused the application to open from
  //   // a terminated state.
  //   await FirebaseMessaging.instance
  //       .setForegroundNotificationPresentationOptions(
  //     alert: true, // Required to display a heads up notification
  //     badge: true,
  //     sound: true,
  //   );
  //   const AndroidNotificationChannel channel = AndroidNotificationChannel(
  //     'high_importance_channel', // id
  //     'High Importance Notifications', // title
  //     importance: Importance.max,
  //   );
  //   final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  //       FlutterLocalNotificationsPlugin();
  //   await flutterLocalNotificationsPlugin
  //       .resolvePlatformSpecificImplementation<
  //           AndroidFlutterLocalNotificationsPlugin>()
  //       ?.createNotificationChannel(channel);
  //   RemoteMessage? initialMessage =
  //       await FirebaseMessaging.instance.getInitialMessage();
  //   FirebaseMessaging.onMessage.listen((RemoteMessage message) {
  //     RemoteNotification notification = message.notification!;
  //     AndroidNotification android = message.notification!.android!;
  //     // If `onMessage` is triggered with a notification, construct our own
  //     // local notification to show to users using the created channel.
  //     flutterLocalNotificationsPlugin.show(
  //         notification.hashCode,
  //         notification.title,
  //         notification.body,
  //         NotificationDetails(
  //           android: AndroidNotificationDetails(
  //             channel.id,
  //             channel.name,
  //             icon: android.smallIcon,
  //             // other properties...
  //           ),
  //         ));
  //   });
  //   String? token = await FirebaseMessaging.instance.getToken();
  //   if (token != null) {
  //     ref.watch(pushNotificationProvider).sendFCMToken(token);
  //   }
  //   // If the message also contains a data property with a "type" of "chat",
  //   // navigate to a chat screen
  //   if (initialMessage != null) {
  //     _handleMessage(initialMessage);
  //   }
  //   // Also handle any interaction when the app is in the background via a
  //   // Stream listener
  //   FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
  // }
  // void _handleMessage(RemoteMessage message) {
  //   // listen to notifications
  // }

  // ThemeMode _currentThemeMode = ThemeMode.system;

  runInit() async {
    // await clearCache();
    getUserProfileDetails(onComplete: (token, username) {
      globalUsername = username;
      print('my auth token $token');
      // final userState = ref.watch(appUserProvider);
      // ref.read(authProvider.notifier).getUser(globalUsername!).listen((event) {
      //   print("before splash: $event");
      // });
    }).whenComplete(() async {
      print("running when future completes");
      ref.watch(hiveStoreProvider);
      // _currentThemeMode =
      //     await ref.watch(configProvider.selectAsync((data) => data.themeMode));
    });
  }

  Future<void> clearCache() async {
    // await VCredentials.inst.storeUserCredentials(json.encode({
    //   'username': null,
    //   'password': null,
    // }));

    userIDPk = null;
    globalUsername = null;
    final storeUsername =
        VModelSharedPrefStorage().putString(VSecureKeys.username, null);

    // Commenting this out. Token shouldn't be stored in SharedPreferences
    final storeToken =
        VModelSharedPrefStorage().putString(VSecureKeys.userTokenKey, null);
    await VCredentials.inst.storeUserCredentials(null);

    await Future.wait([storeToken, storeUsername]);
    await VModelSharedPrefStorage().clearObject(VSecureKeys.userTokenKey);
    await VModelSharedPrefStorage().clearObject(VSecureKeys.username);
    await VCredentials.inst.deleteAll();

    await VModelSharedPrefStorage().clearObject(VSecureKeys.userTokenKey);
    await VModelSharedPrefStorage().clearObject(VSecureKeys.username);

    VWidgetShowResponse.showToast(ResponseEnum.warning,
        message: "Cleared prefs and credentials");
  }

  @override
  Widget build(BuildContext context) {
    final prefsConfigs = ref.watch(userPrefsProvider);
    FlutterNativeSplash.remove();
    return LayoutBuilder(builder: (context, constraints) {
      return OrientationBuilder(builder: (context, orientation) {
        return Sizer(builder: (context, orientation, deviceType) {
          return prefsConfigs.maybeWhen(
              data: (items) => MaterialApp(
                    debugShowCheckedModeBanner: false,
                    builder: (context, child) {
                      return ScrollConfiguration(
                        behavior: MyBehavior(),
                        child: child!,
                      );
                    },
                    title: VMString.appName,
                    navigatorKey: AppNavigatorKeys.instance.navigatorKey,
                    scaffoldMessengerKey: AppNavigatorKeys.instance.scaffoldKey,
                    themeMode: items.themeMode,
                    theme: getSelectedTheme(items.preferredLightTheme),
                    darkTheme: VModelTheme.darkTheme,
                    home: const Portal(child: NewSplash()),
                    routes: {
                      NotificationMain.route: (context) =>
                          const NotificationMain()
                    },
                  ),
              orElse: () {
                return MaterialApp(
                  debugShowCheckedModeBanner: false,
                  builder: (context, child) {
                    return ScrollConfiguration(
                      behavior: MyBehavior(),
                      child: child!,
                    );
                  },
                  title: VMString.appName,
                  navigatorKey: AppNavigatorKeys.instance.navigatorKey,
                  scaffoldMessengerKey: AppNavigatorKeys.instance.scaffoldKey,
                  // themeMode: ThemeMode.dark,
                  // themeMode: isDarkMode
                  //     ? ThemeMode.dark
                  //     : ThemeMode.light,
                  theme: VModelTheme.lightMode,
                  darkTheme: VModelTheme.darkTheme,
                  home: const Portal(child: NewSplash()),
                  routes: {
                    NotificationMain.route: (context) =>
                        const NotificationMain()
                  },
                );
              });
        });
      });
    });
  }

  ThemeData getSelectedTheme(VModelAppThemes theme) {
    switch (theme) {
      // case VModelAppThemes.pink:
      //   return VModelTheme.pinkMode;
      case VModelAppThemes.dark:
        return VModelTheme.darkTheme;
      default:
        return VModelTheme.lightMode;
    }
  }

// Create a provider for the theme mode
  // final themeProvider = StateProvider<bool>((ref) {
  //   // You can set an initial value here, e.g., based on user preferences.
  //   return false; // Use 'false' for light mode and 'true' for dark mode.
  // });
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
