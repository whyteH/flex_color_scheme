import 'package:flutter/material.dart';

import '../../shared/const/app_data.dart';

//Function that returns the passed in Flutter ColorScheme object as Dart code
String generateColorSchemeDartCode(ColorScheme scheme) {
  final String schemeName = scheme.brightness == Brightness.light
      ? 'flexSchemeLight'
      : 'flexSchemeDark';
  final String code = '''
// ColorScheme made by FlexColorScheme version ${AppData.packageVersion}.
// This ColorScheme object requires Flutter 3.7 or later.
const ColorScheme $schemeName = ColorScheme(
  brightness: ${scheme.brightness},
  primary: ${scheme.primary},
  onPrimary: ${scheme.onPrimary},
  primaryContainer: ${scheme.primaryContainer},
  onPrimaryContainer: ${scheme.onPrimaryContainer},
  secondary: ${scheme.secondary},
  onSecondary: ${scheme.onSecondary},
  secondaryContainer: ${scheme.secondaryContainer},
  onSecondaryContainer: ${scheme.onSecondaryContainer},
  tertiary: ${scheme.tertiary},
  onTertiary: ${scheme.onTertiary},
  tertiaryContainer: ${scheme.tertiaryContainer},
  onTertiaryContainer: ${scheme.onTertiaryContainer},
  error: ${scheme.error},
  onError: ${scheme.onError},
  errorContainer: ${scheme.errorContainer},
  onErrorContainer: ${scheme.onErrorContainer},
  background: ${scheme.background},
  onBackground: ${scheme.onBackground},
  surface: ${scheme.surface},
  onSurface: ${scheme.onSurface},
  surfaceVariant: ${scheme.surfaceVariant},
  onSurfaceVariant: ${scheme.onSurfaceVariant},
  outline: ${scheme.outline},
  outlineVariant: ${scheme.outlineVariant},
  shadow: ${scheme.shadow},
  scrim: ${scheme.scrim},
  inverseSurface: ${scheme.inverseSurface},
  onInverseSurface: ${scheme.onInverseSurface},
  inversePrimary: ${scheme.inversePrimary},
  surfaceTint: ${scheme.surfaceTint},
);
''';
  return code;
}
