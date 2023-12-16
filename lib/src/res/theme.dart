import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:vmodel/src/res/res.dart';

class VModelTheme {
  /**
  //Not an actual theme for the app. For debugging purposes

  static ThemeData get pinkMode => ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: VmodelColors.pinkColor,
          primary: VmodelColors.pinkColor,
          // secondary: VmodelColors.white,
          secondary: VmodelColors.pinkColor,
          tertiary: VmodelColors.pinkColor,
          surface: VmodelColors.white,

          onSurface: VmodelColors.pinkColor,
          surfaceVariant: VmodelColors.surfaceVariantLight,
          onSurfaceVariant: VmodelColors.onSurfaceVariantLight,
        ),
        splashColor: Colors.transparent,
        primaryColor: VmodelColors.pinkColor,
        scaffoldBackgroundColor: VmodelColors.background,
        primarySwatch: VmodelColors.vModelprimarySwatch,
        fontFamily: VModelTypography1.primaryfontName,
        indicatorColor: VmodelColors.mainColor,
        dividerColor: VmodelColors.divideColor,
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            backgroundColor: VmodelColors.pinkColor),
        tabBarTheme: TabBarTheme(
          unselectedLabelColor: VmodelColors.black,
          labelColor: VmodelColors.unselectedText,
        ),
        buttonTheme: ButtonThemeData(
          colorScheme: ColorScheme(
            brightness: Brightness.light,
            primary: VmodelColors.pinkColor,
            onPrimary: VmodelColors.white,
            secondary: VmodelColors.buttonBgColor,
            tertiary: VmodelColors.white,
            onSecondary: VmodelColors.pinkColor,
            error: VmodelColors.pinkColor,
            onError: VmodelColors.pinkColor,
            background: VmodelColors.pinkColor,
            onBackground: VmodelColors.pinkColor,
            surface: VmodelColors.pinkColor,
            onSurface: VmodelColors.pinkColor,
          ),
        ),
        iconTheme: const IconThemeData(color: VmodelColors.pinkColor),
        appBarTheme: const AppBarTheme(
            backgroundColor: VmodelColors.appBarBackgroundColor),
        textTheme: TextTheme(
          displayLarge: VModelTypography1.normalTextStyle,
          displayMedium: VModelTypography1.mediumTextStyle,
          displaySmall: VModelTypography1.smallTextStyle,
          titleLarge: VModelTypography1.normalTextStyle,
          titleMedium: VModelTypography1.normalTextStyle,
          titleSmall: VModelTypography1.normalTextStyle,
          // bodyLarge: VModelTypography1.normalTextStyle,
          // bodyMedium: VModelTypography1.mediumTextStyle,
          // bodySmall: VModelTypography1.smallTextStyle,
          bodyLarge: ThemeData.light()
              .textTheme
              .bodyLarge
              ?.copyWith(color: VmodelColors.pinkColor),
          // ?.copyWith(color: Colors.amber),
          bodyMedium: ThemeData.light()
              .textTheme
              .bodyMedium
              ?.copyWith(color: VmodelColors.pinkColor),
          // ?.copyWith(color: Colors.amber),
          bodySmall: ThemeData.light()
              .textTheme
              .bodySmall
              ?.copyWith(color: VmodelColors.pinkColor),
          // ?.copyWith(color: Colors.amber),
        ),
        chipTheme: ChipThemeData.fromDefaults(
          primaryColor: VmodelColors.pinkColor,

          //Definitely needs updating but for now just keep brown as default
          secondaryColor: VmodelColors.pinkColor,
          labelStyle: const TextStyle(
            color: VmodelColors.pinkColor,
          ),
        ),
        switchTheme: ThemeData.light().switchTheme.copyWith(
          trackColor: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) {
            if (states.contains(MaterialState.selected)) {
              return VmodelColors.pinkColor;
            }
            if (states.contains(MaterialState.disabled)) {
              return VmodelColors.pinkColor.withOpacity(0.3);
            }
            return Colors.grey.withOpacity(.48);
          }),
        ),
      );
 */

  static ThemeData get lightMode => ThemeData(
        brightness: Brightness.light,
        colorScheme: ColorScheme.fromSeed(
          seedColor: VmodelColors.primaryColor,
          primary: VmodelColors.primaryColor,
          // secondary: VmodelColors.white,
          // secondary: VmodelColors.primaryColor,
          secondary: Color(0xFFD9D9D9),
          tertiary: VmodelColors.primaryColor,
          surface: VmodelColors.white,
          onSecondary: VmodelColors.white,
          onSurface: VmodelColors.primaryColor,
          surfaceVariant: VmodelColors.surfaceVariantLight,
          onSurfaceVariant: VmodelColors.onSurfaceVariantLight,
          onBackground: VmodelColors.greyLightColor,
        ),
        splashColor: Colors.transparent,
        primaryColor: VmodelColors.primaryColor,
        scaffoldBackgroundColor: VmodelColors.background,
        primarySwatch: VmodelColors.vModelprimarySwatch,
        fontFamily: VModelTypography1.primaryfontName,
        indicatorColor: VmodelColors.mainColor,
        dividerColor: VmodelColors.divideColor,
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: VmodelColors.primaryColor,
          selectedItemColor: VmodelColors.primaryColor,
        ),
        tabBarTheme: TabBarTheme(
          unselectedLabelColor: VmodelColors.primaryColor.withOpacity(0.4),
          labelColor: VmodelColors.primaryColor,
        ),
        //   navigationBarTheme: NavigationBarThemeData(
        //     iconTheme: MaterialStateProperty.all(
        //   IconThemeData(
        //     color: VmodelColors.white.withOpacity(.6),
        //   ),
        // )),

        buttonTheme: ButtonThemeData(
          colorScheme: ColorScheme(
            brightness: Brightness.light,
            primary: VmodelColors.primaryColor,
            onPrimary: VmodelColors.white,
            secondary: VmodelColors.buttonBgColor,
            tertiary: VmodelColors.white,
            onSecondary: VmodelColors.primaryColor,
            error: VmodelColors.primaryColor,
            onError: VmodelColors.primaryColor,
            background: VmodelColors.primaryColor,
            onBackground: VmodelColors.primaryColor,
            surface: VmodelColors.primaryColor,
            onSurface: VmodelColors.primaryColor,
          ),
        ),
        iconTheme: const IconThemeData(color: VmodelColors.primaryColor),
        appBarTheme: const AppBarTheme(
            backgroundColor: VmodelColors.appBarBackgroundColor),
        textTheme: TextTheme(
          displayLarge: VModelTypography1.normalTextStyle,
          displayMedium: VModelTypography1.mediumTextStyle,
          displaySmall: VModelTypography1.smallTextStyle,
          titleLarge: VModelTypography1.normalTextStyle,
          titleMedium: VModelTypography1.normalTextStyle,
          titleSmall: VModelTypography1.normalTextStyle,
          // bodyLarge: VModelTypography1.normalTextStyle,
          // bodyMedium: VModelTypography1.mediumTextStyle,
          // bodySmall: VModelTypography1.smallTextStyle,
          bodyLarge: ThemeData.light()
              .textTheme
              .bodyLarge
              ?.copyWith(color: VmodelColors.primaryColor),
          // ?.copyWith(color: Colors.amber),
          bodyMedium: ThemeData.light()
              .textTheme
              .bodyMedium
              ?.copyWith(color: VmodelColors.primaryColor),
          // ?.copyWith(color: Colors.amber),
          bodySmall: ThemeData.light()
              .textTheme
              .bodySmall
              ?.copyWith(color: VmodelColors.primaryColor, fontSize: 10.sp),
          // ?.copyWith(color: Colors.amber),
        ),
        chipTheme: ChipThemeData.fromDefaults(
          primaryColor: VmodelColors.primaryColor,

          //Definitely needs updating but for now just keep brown as default
          secondaryColor: VmodelColors.primaryColor,
          labelStyle: const TextStyle(
            color: VmodelColors.primaryColor,
          ),
        ),
        switchTheme: ThemeData.light().switchTheme.copyWith(
          trackColor: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) {
            if (states.contains(MaterialState.selected)) {
              return VmodelColors.primaryColor;
            }
            if (states.contains(MaterialState.disabled)) {
              return VmodelColors.primaryColor.withOpacity(0.3);
            }
            return Colors.grey.withOpacity(.48);
          }),
        ),
        pageTransitionsTheme: PageTransitionsTheme(
          builders: Map<TargetPlatform, PageTransitionsBuilder>.fromIterable(
            TargetPlatform.values,
            value: (dynamic _) => const ZoomPageTransitionsBuilder(),
          ),
        ),
      );

  static ThemeData get darkTheme => ThemeData.dark().copyWith(
        brightness: Brightness.dark,
        splashColor: Colors.transparent,
        // colorScheme:
        // const ColorScheme.dark(primary: VmodelColors.darkScaffoldBackround),
        colorScheme: ColorScheme.fromSeed(
          // seedColor: const Color.fromRGBO(55, 71, 79, 1),
          seedColor: VmodelColors.darkPrimaryColor,
          primary: VmodelColors.darkPrimaryColor,
          secondary: VmodelColors.darkPrimaryColor,
          // secondary: VmodelColors.blueColor9D,
          tertiary: VmodelColors.blueColor9D,
          // surface: VmodelColors.blueColor9D,
          // onSecondary: VmodelColors.blueColor9D,
          onSecondary: VmodelColors.darkPrimaryColor,
          surface: VmodelColors.darkScaffoldBackround,
          onSurface: VmodelColors.darkOnSurfaceColor,
          surfaceVariant: VmodelColors.surfaceVariantLight.withOpacity(0.2),
          onSurfaceVariant:
              VmodelColors.onSurfaceVariantLight.withOpacity(0.25),
        ),
        scaffoldBackgroundColor: VmodelColors.darkScaffoldBackround,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        dividerColor: VmodelColors.darkOnSurfaceColor.withOpacity(0.1),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: VmodelColors.white.withOpacity(.8),
          selectedItemColor: VmodelColors.darkSecondaryButtonColor,
          unselectedItemColor: VmodelColors.white.withOpacity(.5),
          unselectedIconTheme:
              IconThemeData(color: VmodelColors.white.withOpacity(.5)),
          selectedIconTheme:
              IconThemeData(color: VmodelColors.darkSecondaryButtonColor),
        ),
        tabBarTheme: TabBarTheme(
            unselectedLabelColor:
                VmodelColors.darkPrimaryColorWhite.withOpacity(.5),
            labelColor: VmodelColors.white),
        primaryColor: VmodelColors.darkPrimaryColorWhite,
        // primarySwatch: VmodelColors.vModelprimarySwatch,
        indicatorColor: VmodelColors.white,
        // fontFamily: VModelDarkTheme.primaryfontName,
        buttonTheme: ButtonThemeData(
          buttonColor: VmodelColors.darkButtonColor,
          disabledColor: VmodelColors.darkSecondaryButtonColor,
          colorScheme: ColorScheme(
            brightness: Brightness.dark,
            primary: VmodelColors.darkButtonColor,
            onPrimary: VmodelColors.white,
            // secondary: VmodelColors.darkSecondaryButtonColor,
            secondary: VmodelColors.greyColor.withOpacity(0.2),
            onSecondary: VmodelColors.white,
            tertiary: VmodelColors.darkSecondaryButtonColor,
            onTertiary: VmodelColors.white,
            error: VmodelColors.darkButtonColor,
            onError: VmodelColors.darkButtonColor,
            background: VmodelColors.darkButtonColor,
            onBackground: VmodelColors.greyLightColor,
            surface: VmodelColors.darkButtonColor,
            onSurface: VmodelColors.darkButtonColor,
          ),
        ),
        textSelectionTheme: const TextSelectionThemeData(
          // cursorColor: Colors.yellow,
          selectionColor: VmodelColors.darkSecondaryButtonColor,
          selectionHandleColor: VmodelColors.darkSecondaryButtonColor,
        ),
        navigationBarTheme: NavigationBarThemeData(
            iconTheme: MaterialStateProperty.all(
          IconThemeData(
            color: VmodelColors.white.withOpacity(.6),
          ),
        )),
        appBarTheme: const AppBarTheme(
            backgroundColor: VmodelColors.darkScaffoldBackround),
        iconTheme:
            const IconThemeData(color: VmodelColors.darkPrimaryColorWhite),
        textTheme: TextTheme(
          displayLarge: VModelDarkTheme.normalTextStyle,
          displayMedium: VModelDarkTheme.mediumTextStyle,
          displaySmall: VModelDarkTheme.smallTextStyle,
          titleLarge: VModelDarkTheme.normalTextStyle,
          titleMedium: VModelDarkTheme.normalTextStyle,
          titleSmall: VModelDarkTheme.normalTextStyle,
          // bodyLarge: VModelTypography1.normalTextStyle,
          // bodyMedium: VModelDarkTheme.mediumTextStyle,
          // bodySmall: VModelDarkTheme.smallTextStyle,
          bodyLarge: ThemeData.dark()
              .textTheme
              .bodyLarge
              ?.copyWith(color: VmodelColors.darkOnPrimaryColor),
          bodyMedium: ThemeData.dark()
              .textTheme
              .bodyMedium
              ?.copyWith(color: VmodelColors.darkOnPrimaryColor),
          bodySmall: ThemeData.dark()
              .textTheme
              .bodySmall
              ?.copyWith(color: VmodelColors.darkOnPrimaryColor),
        ),
        cardTheme: ThemeData.dark()
            .cardTheme
            .copyWith(color: VmodelColors.darkPrimaryColor),
        bottomSheetTheme: ThemeData.dark().bottomSheetTheme.copyWith(
              backgroundColor: VmodelColors.darkScaffoldBackround,
            ),
        chipTheme: ChipThemeData.fromDefaults(
          brightness: Brightness.dark,
          // primaryColor: VmodelColors.darkSecondaryButtonColor,
          secondaryColor: VmodelColors.darkSecondaryButtonColor,
          labelStyle: const TextStyle(
            color: VmodelColors.darkSecondaryButtonColor,
          ),
        ),
        switchTheme: ThemeData.dark().switchTheme.copyWith(
          trackColor: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) {
            if (states.contains(MaterialState.selected)) {
              return VmodelColors.darkSecondaryButtonColor;
            }
            if (states.contains(MaterialState.disabled)) {
              return VmodelColors.darkSecondaryButtonColor.withOpacity(0.3);
            }
            return Colors.grey.withOpacity(.48);
          }),
        ),
        pageTransitionsTheme: PageTransitionsTheme(
          builders: Map<TargetPlatform, PageTransitionsBuilder>.fromIterable(
            TargetPlatform.values,
            value: (dynamic _) => const ZoomPageTransitionsBuilder(),
          ),
        ),
      );
}
