import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'home_page.dart';

// ignore_for_file: unused_import
// ignore_for_file: lines_longer_than_80_chars
// ignore_for_file: unreachable_from_main

// -----------------------------------------------------------------------------
/// EXAMPLE: COPY-PASTE PLAYGROUND
//
// Use this example to via copy-paste test a theme using code generated by
// the Themes PlayGround found at:
// https://rydmike.com/flexcolorscheme/themesplayground-v7
// -----------------------------------------------------------------------------
void main() => runApp(const DemoApp());

class DemoApp extends StatefulWidget {
  const DemoApp({super.key});

  @override
  State<DemoApp> createState() => _DemoAppState();
}

class _DemoAppState extends State<DemoApp> {
  ThemeMode themeMode = ThemeMode.system;

  // ignore: unused_field
  late final String? _fontFamily = GoogleFonts.notoSans().fontFamily;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Copy Playground',
      // To use this app with the Flutter SDK default theme and default
      // Material Design 2 color scheme, uncomment and use the theme setup below
      // and comment the copy-pasted themes further below,
      // theme: ThemeData(
      //   useMaterial3: false,
      //   colorScheme: const ColorScheme.light(),
      //   typography: Typography.material2018(platform: defaultTargetPlatform),
      // ),
      // darkTheme: ThemeData(
      //   useMaterial3: false,
      //   colorScheme: const ColorScheme.dark(),
      //   typography: Typography.material2018(platform: defaultTargetPlatform),
      // ),

      // This is where you would put a copy-pasted theme definition from
      // the Themes Playground. There is already one example below, but do
      // try your own copy-paste new setup code from the
      // Themes Playground app available at:
      // https://rydmike.com/flexcolorscheme/themesplayground-v7
      // And do remember to comment the default Flutter theme above.

      theme: FlexThemeData.light(
        useMaterial3: true,
        scheme: FlexScheme.flutterDash,
        blendLevel: 2,
        appBarOpacity: 0.98,
        subThemesData: const FlexSubThemesData(
          inputDecoratorRadius: 8,
          inputDecoratorPrefixIconSchemeColor: SchemeColor.primary,
          inputDecoratorSchemeColor: SchemeColor.primary,
          inputDecoratorBackgroundAlpha: 0x18,
          inputDecoratorUnfocusedHasBorder: false,
          appBarScrolledUnderElevation: 6,
          popupMenuOpacity: 0.96,
          bottomNavigationBarOpacity: 0.96,
          navigationBarOpacity: 0.96,
          navigationRailOpacity: 0.96,
        ),
        visualDensity: FlexColorScheme.comfortablePlatformDensity,
        fontFamily: GoogleFonts.notoSans().fontFamily,
      ),
      darkTheme: FlexThemeData.dark(
        useMaterial3: true,
        scheme: FlexScheme.flutterDash,
        blendLevel: 14,
        appBarStyle: FlexAppBarStyle.background,
        appBarOpacity: 0.96,
        subThemesData: const FlexSubThemesData(
          inputDecoratorRadius: 8,
          inputDecoratorPrefixIconSchemeColor: SchemeColor.primary,
          inputDecoratorSchemeColor: SchemeColor.primary,
          inputDecoratorBackgroundAlpha: 0x22,
          inputDecoratorUnfocusedHasBorder: false,
          popupMenuOpacity: 0.96,
          bottomNavigationBarOpacity: 0.96,
          navigationBarOpacity: 0.96,
          navigationRailOpacity: 0.96,
          navigationRailLabelType: NavigationRailLabelType.none,
        ),
        visualDensity: FlexColorScheme.comfortablePlatformDensity,
        fontFamily: GoogleFonts.notoSans().fontFamily,
      ),

      // If you want to use ThemeData.from a ColorScheme based on a ColorScheme
      // from FlexColorScheme, then comment the other two theme setups above and
      // uncomment the theme setup below, and copy-paste the generated
      // ColorScheme code from the Themes Playground app at
      // https://rydmike.com/flexcolorscheme/themesplayground-v7
      // over the example ColorSchemes further below, with copy-pasted schemes.
      // This will give you the same colors as with FlexColorScheme, but no
      // other theme customizations FlexColorScheme does when it creates
      // its ThemeData with FlexColorScheme.toTheme or using its
      // FlexThemeData extensions and opinionated component themes. You will
      // need to customize ThemeData yourself and adjust all its quirks.
      //
      // theme: ThemeData(
      //   useMaterial3: true,
      //   colorScheme: flexSchemeLight,
      // ),
      // darkTheme: ThemeData(
      //   useMaterial3: true,
      //   colorScheme: flexSchemeDark,
      // ),

      // ThemeMode toggle via callback
      themeMode: themeMode,
      home: HomePage(
        themeMode: themeMode,
        onThemeModeChanged: (ThemeMode mode) {
          setState(() {
            themeMode = mode;
          });
        },
      ),
    );
  }
}

// Copy-paste the code for a light ColorScheme you want from the
// Themes Playground here and try it with plain vanilla
// ThemeData.from(colorScheme: flexSchemeLight) light by uncommenting
// that section further above.
const ColorScheme flexSchemeLight = ColorScheme(
  brightness: Brightness.light,
  primary: Color(0xff00497c),
  onPrimary: Color(0xffe8f1ff),
  primaryContainer: Color(0xff9acaff),
  onPrimaryContainer: Color(0xff001d36),
  secondary: Color(0xff4f599d),
  onSecondary: Color(0xffefefff),
  secondaryContainer: Color(0xffbac3ff),
  onSecondaryContainer: Color(0xff041157),
  tertiary: Color(0xff6c5b51),
  onTertiary: Color(0xffffede2),
  tertiaryContainer: Color(0xffd8c2b6),
  onTertiaryContainer: Color(0xff251911),
  error: Color(0xffba1b1b),
  onError: Color(0xffffede9),
  errorContainer: Color(0xffffb4a9),
  onErrorContainer: Color(0xff410001),
  outline: Color(0xff6b7889),
  background: Color(0xffcdd6e3),
  onBackground: Color(0xff171c22),
  surface: Color(0xffe3eaf5),
  onSurface: Color(0xff171c22),
  surfaceVariant: Color(0xffb2c3d7),
  onSurfaceVariant: Color(0xff243140),
  inverseSurface: Color(0xff3f474f),
  onInverseSurface: Color(0xffedf1fa),
  inversePrimary: Color(0xff9acaff),
  shadow: Color(0xff000000),
);

// Copy-paste the code for a dark ColorScheme you want from the
// Themes Playground here and try it with plain vanilla
// ThemeData.from(colorScheme: flexSchemeLight) light by uncommenting
// that section further above.
//
// Normally it would be the matching pair to the light one, but it does not
// have to be. Same applies when you use FlexColorScheme to make your
// ThemeData.
const ColorScheme flexSchemeDark = ColorScheme(
  brightness: Brightness.dark,
  primary: Color(0xff9acaff),
  onPrimary: Color(0xff001d36),
  primaryContainer: Color(0xff0061a2),
  onPrimaryContainer: Color(0xffcfe4ff),
  secondary: Color(0xffbac3ff),
  onSecondary: Color(0xff041157),
  secondaryContainer: Color(0xff4f599d),
  onSecondaryContainer: Color(0xffdde0ff),
  tertiary: Color(0xffd8c2b6),
  onTertiary: Color(0xff251911),
  tertiaryContainer: Color(0xff6c5b51),
  onTertiaryContainer: Color(0xfff5ded1),
  error: Color(0xffffb4a9),
  onError: Color(0xff680003),
  errorContainer: Color(0xff930006),
  onErrorContainer: Color(0xffffdad4),
  outline: Color(0xff8492a4),
  background: Color(0xff323a42),
  onBackground: Color(0xffdfe3ec),
  surface: Color(0xff1a2028),
  onSurface: Color(0xffc3c7cf),
  surfaceVariant: Color(0xff536173),
  onSurfaceVariant: Color(0xffd6e4f7),
  inverseSurface: Color(0xffeaeffa),
  onInverseSurface: Color(0xff42474e),
  inversePrimary: Color(0xff0061a2),
  shadow: Color(0xff000000),
);
