import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';

import '../../../../shared/const/adaptive_theme.dart';
import '../../../../shared/const/app_color.dart';
import '../../../../shared/controllers/theme_controller.dart';
import '../../../../shared/utils/link_text_span.dart';
import '../../../../shared/widgets/universal/list_tile_reveal.dart';
import '../../../../shared/widgets/universal/showcase_material.dart';
import '../../../../shared/widgets/universal/switch_list_tile_reveal.dart';
import '../../shared/adaptive_theme_popup_menu.dart';
import '../../shared/color_scheme_popup_menu.dart';
import 'app_bar_style_popup_menu.dart';

class AppBarSettings extends StatelessWidget {
  const AppBarSettings(this.controller, {super.key});
  final ThemeController controller;

  static final Uri _fcsFlutterFix117082 = Uri(
    scheme: 'https',
    host: 'github.com',
    path: 'flutter/flutter/pull/117082',
  );
  static final Uri _fcsFlutterIssue110951 = Uri(
    scheme: 'https',
    host: 'github.com',
    path: 'flutter/flutter/issues/110951',
  );
  static final Uri _fcsFlutterIssue123943 = Uri(
    scheme: 'https',
    host: 'github.com',
    path: 'flutter/flutter/issues/123943',
  );
  static final Uri _fcsFlutterIssue126623 = Uri(
    scheme: 'https',
    host: 'github.com',
    path: 'flutter/flutter/issues/126623',
  );

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final bool isLight = theme.brightness == Brightness.light;
    final TextStyle spanTextStyle = theme.textTheme.bodySmall!;
    final TextStyle linkStyle = theme.textTheme.bodySmall!.copyWith(
        color: theme.colorScheme.primary, fontWeight: FontWeight.bold);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const SizedBox(height: 8),
        if (isLight)
          AppBarStylePopupMenu(
            title: const Text('Light AppBarStyle'),
            labelForDefault: 'default',
            index: controller.appBarStyleLight?.index ?? -1,
            onChanged: controller.useFlexColorScheme &&
                    controller.appBarBackgroundSchemeColorLight == null
                ? (int index) {
                    if (index < 0 || index >= FlexAppBarStyle.values.length) {
                      controller.setAppBarStyleLight(null);
                    } else {
                      controller
                          .setAppBarStyleLight(FlexAppBarStyle.values[index]);
                    }
                  }
                : null,
            // To access the custom color we defined for AppBars in this
            // PopupMenu buttons widget, we have to pass it along, or the
            // entire controller. We chose the color in this case. It is not
            // carried with the theme, so we cannot get it from there in
            // the widget. FlexColorScheme knows the color when
            // you make a theme with it. This color is used to show the
            // correct color on the AppBar custom color option for the not
            // built-in custom color scheme.
            // In our examples we only actually have a custom app bar
            // color in the three custom color examples, and we want to
            // show them as well on the PopupMenu button.
            customAppBarColor: AppColor.scheme(controller).light.appBarColor,
          )
        else
          AppBarStylePopupMenu(
            title: const Text('Dark AppBarStyle'),
            labelForDefault: 'default',
            index: controller.appBarStyleDark?.index ?? -1,
            onChanged: controller.useFlexColorScheme &&
                    controller.appBarBackgroundSchemeColorDark == null
                ? (int index) {
                    if (index < 0 || index >= FlexAppBarStyle.values.length) {
                      controller.setAppBarStyleDark(null);
                    } else {
                      controller
                          .setAppBarStyleDark(FlexAppBarStyle.values[index]);
                    }
                  }
                : null,
            customAppBarColor: AppColor.scheme(controller).dark.appBarColor,
          ),
        SwitchListTileReveal(
          title: const Text('One colored AppBar on Android'),
          subtitleDense: true,
          subtitle: const Text(
            'ON  No scrim on the top status bar\n'
            'OFF Use a two toned AppBar with a scrim on top status bar\n',
          ),
          value:
              controller.transparentStatusBar && controller.useFlexColorScheme,
          onChanged: controller.useFlexColorScheme
              ? controller.setTransparentStatusBar
              : null,
        ),
        const SizedBox(height: 8),
        Card(
          elevation: 0.7,
          shadowColor: Colors.transparent,
          margin: const EdgeInsets.symmetric(horizontal: 16),
          color: theme.colorScheme.surfaceVariant,
          child: const Padding(
            padding: EdgeInsets.all(16.0),
            child: AppBarShowcase(),
          ),
        ),
        if (isLight) ...<Widget>[
          ListTile(
            enabled: controller.useFlexColorScheme,
            title: const Text('Light mode elevation'),
            subtitle: Slider(
              min: -0.5,
              max: 20,
              divisions: 41,
              label: controller.useFlexColorScheme
                  ? controller.appBarElevationLight == null ||
                          (controller.appBarElevationLight ?? -0.5) < 0
                      ? 'default 0'
                      : controller.appBarElevationLight!.toStringAsFixed(1)
                  : controller.useMaterial3
                      ? 'default 0'
                      : 'default 4',
              value: controller.useFlexColorScheme
                  ? controller.appBarElevationLight ?? -0.5
                  : -0.5,
              onChanged: controller.useFlexColorScheme
                  ? (double value) {
                      controller
                          .setAppBarElevationLight(value < 0 ? null : value);
                    }
                  : null,
            ),
            trailing: Padding(
              padding: const EdgeInsetsDirectional.only(end: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'ELEV',
                    style: theme.textTheme.bodySmall,
                  ),
                  Text(
                    controller.useFlexColorScheme
                        ? controller.appBarElevationLight == null ||
                                (controller.appBarElevationLight ?? -0.5) < 0
                            ? 'default 0'
                            : controller.appBarElevationLight!
                                .toStringAsFixed(1)
                        : controller.useMaterial3
                            ? 'default 0'
                            : 'default 4',
                    style: theme.textTheme.bodySmall!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
          ListTileReveal(
            enabled: controller.useFlexColorScheme,
            title: const Text('Light opacity'),
            subtitleDense: true,
            subtitle: const Text('To use themed opacity, try 85% to 98%\n'),
          ),
          ListTile(
            title: Slider(
              max: 100,
              divisions: 100,
              label: (controller.appBarOpacityLight * 100).toStringAsFixed(0),
              value: controller.appBarOpacityLight * 100,
              onChanged: controller.useFlexColorScheme
                  ? (double value) {
                      controller.setAppBarOpacityLight(value / 100);
                    }
                  : null,
            ),
            trailing: Padding(
              padding: const EdgeInsetsDirectional.only(end: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'OPACITY',
                    style: theme.textTheme.bodySmall,
                  ),
                  Text(
                    // ignore: lines_longer_than_80_chars
                    '${(controller.appBarOpacityLight * 100).toStringAsFixed(0)} %',
                    style: theme.textTheme.bodySmall!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
          ListTile(
            enabled: controller.useFlexColorScheme &&
                controller.useSubThemes &&
                controller.useMaterial3,
            title: const Text('Light mode scrolled under elevation'),
            subtitle: Slider(
              min: -0.5,
              max: 20,
              divisions: 41,
              label: controller.useFlexColorScheme && controller.useSubThemes
                  ? controller.appBarScrolledUnderElevationLight == null ||
                          (controller.appBarScrolledUnderElevationLight ??
                                  -0.5) <
                              0
                      ? controller.useMaterial3
                          ? 'default 3'
                          : controller.useSubThemes
                              // ignore: lines_longer_than_80_chars
                              ? 'default ${(controller.appBarElevationLight ?? 0).toStringAsFixed(1)}'
                              : 'default 4'
                      : (controller.appBarScrolledUnderElevationLight
                              ?.toStringAsFixed(1) ??
                          '')
                  : controller.useMaterial3
                      ? 'default 3'
                      : !controller.useSubThemes
                          // ignore: lines_longer_than_80_chars
                          ? 'default ${(controller.appBarElevationLight ?? 0).toStringAsFixed(1)}'
                          : 'default 4',
              value: controller.useFlexColorScheme &&
                      controller.useSubThemes &&
                      controller.useMaterial3
                  ? controller.appBarScrolledUnderElevationLight ?? -0.5
                  : -0.5,
              onChanged: controller.useFlexColorScheme &&
                      controller.useSubThemes &&
                      controller.useMaterial3
                  ? (double value) {
                      controller.setAppBarScrolledUnderElevationLight(
                          value < 0 ? null : value);
                    }
                  : null,
            ),
            trailing: Padding(
              padding: const EdgeInsetsDirectional.only(end: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'ELEV',
                    style: theme.textTheme.bodySmall,
                  ),
                  Text(
                    controller.useFlexColorScheme && controller.useSubThemes
                        ? controller.appBarScrolledUnderElevationLight ==
                                    null ||
                                (controller.appBarScrolledUnderElevationLight ??
                                        -0.5) <
                                    0
                            ? controller.useMaterial3
                                ? 'default 3'
                                // ignore: lines_longer_than_80_chars
                                : 'default ${(controller.appBarElevationLight ?? 0).toStringAsFixed(1)}'
                            : !controller.useMaterial3
                                // ignore: lines_longer_than_80_chars
                                ? 'default ${(controller.appBarElevationLight ?? 0).toStringAsFixed(1)}'
                                : controller.appBarScrolledUnderElevationLight
                                        ?.toStringAsFixed(1) ??
                                    ''
                        : controller.useMaterial3
                            ? 'default 3'
                            : !controller.useSubThemes
                                // ignore: lines_longer_than_80_chars
                                ? 'default ${(controller.appBarElevationLight ?? 0).toStringAsFixed(1)}'
                                : 'default 4',
                    style: theme.textTheme.bodySmall!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
          AdaptiveThemePopupMenu(
            title: const Text('Light mode platform adaptive M3 AppBar scroll '
                'under tint removal'),
            index: controller.adaptiveAppBarScrollUnderOffLight?.index ?? -1,
            onChanged: controller.useFlexColorScheme &&
                    controller.useSubThemes &&
                    controller.useMaterial3
                ? (int index) {
                    if (index < 0 || index >= AdaptiveTheme.values.length) {
                      controller.setAdaptiveAppBarScrollUnderOffLight(null);
                    } else {
                      controller.setAdaptiveAppBarScrollUnderOffLight(
                          AdaptiveTheme.values[index]);
                    }
                  }
                : null,
          ),
          ColorSchemePopupMenu(
            title: const Text('Light custom background color'),
            labelForDefault: controller.useFlexColorScheme
                ? 'default (AppBarStyle)'
                : 'default (primary)',
            index: controller.appBarBackgroundSchemeColorLight?.index ?? -1,
            onChanged: controller.useSubThemes && controller.useFlexColorScheme
                ? (int index) {
                    if (index < 0 || index >= SchemeColor.values.length) {
                      controller.setAppBarBackgroundSchemeColorLight(null);
                    } else {
                      controller.setAppBarBackgroundSchemeColorLight(
                          SchemeColor.values[index]);
                    }
                  }
                : null,
          )
        ] else ...<Widget>[
          ListTile(
            enabled: controller.useFlexColorScheme,
            title: const Text('Dark mode elevation'),
            subtitle: Slider(
              min: -0.5,
              max: 20,
              divisions: 41,
              label: controller.useFlexColorScheme
                  ? controller.appBarElevationDark == null ||
                          (controller.appBarElevationDark ?? -0.5) < 0
                      ? 'default 0'
                      : controller.appBarElevationDark!.toStringAsFixed(1)
                  : controller.useMaterial3
                      ? 'default 0'
                      : 'default 4',
              value: controller.useFlexColorScheme
                  ? controller.appBarElevationDark ?? -0.5
                  : -0.5,
              onChanged: controller.useFlexColorScheme
                  ? (double value) {
                      controller
                          .setAppBarElevationDark(value < 0 ? null : value);
                    }
                  : null,
            ),
            trailing: Padding(
              padding: const EdgeInsetsDirectional.only(end: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'ELEV',
                    style: theme.textTheme.bodySmall,
                  ),
                  Text(
                    controller.useFlexColorScheme
                        ? controller.appBarElevationDark == null ||
                                (controller.appBarElevationDark ?? -0.5) < 0
                            ? 'default 0'
                            : controller.appBarElevationDark!.toStringAsFixed(1)
                        : controller.useMaterial3
                            ? 'default 0'
                            : 'default 4',
                    style: theme.textTheme.bodySmall!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
          ListTileReveal(
            enabled: controller.useFlexColorScheme,
            title: const Text('Dark opacity'),
            subtitleDense: true,
            subtitle: const Text('To use themed opacity, try 85% to 98%\n'),
          ),
          ListTile(
            title: Slider(
              max: 100,
              divisions: 100,
              label: (controller.appBarOpacityDark * 100).toStringAsFixed(0),
              value: controller.appBarOpacityDark * 100,
              onChanged: controller.useFlexColorScheme
                  ? (double value) {
                      controller.setAppBarOpacityDark(value / 100);
                    }
                  : null,
            ),
            trailing: Padding(
              padding: const EdgeInsetsDirectional.only(end: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'OPACITY',
                    style: theme.textTheme.bodySmall,
                  ),
                  Text(
                    '${(controller.appBarOpacityDark * 100).toStringAsFixed(0)}'
                    ' %',
                    style: theme.textTheme.bodySmall!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
          ListTile(
            enabled: controller.useFlexColorScheme && controller.useSubThemes,
            title: const Text('Dark mode scrolled under elevation'),
            subtitle: Slider(
              min: -0.5,
              max: 20,
              divisions: 41,
              label: controller.useFlexColorScheme && controller.useSubThemes
                  ? controller.appBarScrolledUnderElevationDark == null ||
                          (controller.appBarScrolledUnderElevationDark ??
                                  -0.5) <
                              0
                      ? controller.useMaterial3
                          ? 'default 3'
                          : controller.useSubThemes
                              // ignore: lines_longer_than_80_chars
                              ? 'default ${(controller.appBarElevationDark ?? 0).toStringAsFixed(1)}'
                              : 'default 4'
                      : (controller.appBarScrolledUnderElevationDark
                              ?.toStringAsFixed(1) ??
                          '')
                  : controller.useMaterial3
                      ? 'default 3'
                      : !controller.useSubThemes
                          // ignore: lines_longer_than_80_chars
                          ? 'default ${(controller.appBarElevationDark ?? 0).toStringAsFixed(1)}'
                          : 'default 4',
              value: controller.useFlexColorScheme &&
                      controller.useSubThemes &&
                      controller.useMaterial3
                  ? controller.appBarScrolledUnderElevationDark ?? -0.5
                  : -0.5,
              onChanged: controller.useFlexColorScheme &&
                      controller.useSubThemes &&
                      controller.useMaterial3
                  ? (double value) {
                      controller.setAppBarScrolledUnderElevationDark(
                          value < 0 ? null : value);
                    }
                  : null,
            ),
            trailing: Padding(
              padding: const EdgeInsetsDirectional.only(end: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'ELEV',
                    style: theme.textTheme.bodySmall,
                  ),
                  Text(
                    controller.useFlexColorScheme && controller.useSubThemes
                        ? controller.appBarScrolledUnderElevationDark == null ||
                                (controller.appBarScrolledUnderElevationDark ??
                                        -0.5) <
                                    0
                            ? controller.useMaterial3
                                ? 'default 3'
                                // ignore: lines_longer_than_80_chars
                                : 'default ${(controller.appBarElevationDark ?? 0).toStringAsFixed(1)}'
                            : !controller.useMaterial3
                                // ignore: lines_longer_than_80_chars
                                ? 'default ${(controller.appBarElevationDark ?? 0).toStringAsFixed(1)}'
                                : controller.appBarScrolledUnderElevationDark
                                        ?.toStringAsFixed(1) ??
                                    ''
                        : controller.useMaterial3
                            ? 'default 3'
                            : !controller.useSubThemes
                                // ignore: lines_longer_than_80_chars
                                ? 'default ${(controller.appBarElevationDark ?? 0).toStringAsFixed(1)}'
                                : 'default 4',
                    style: theme.textTheme.bodySmall!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
          AdaptiveThemePopupMenu(
            title: const Text('Dark mode platform adaptive M3 AppBar scroll '
                'under tint removal'),
            index: controller.adaptiveAppBarScrollUnderOffDark?.index ?? -1,
            onChanged: controller.useFlexColorScheme &&
                    controller.useSubThemes &&
                    controller.useMaterial3
                ? (int index) {
                    if (index < 0 || index >= AdaptiveTheme.values.length) {
                      controller.setAdaptiveAppBarScrollUnderOffDark(null);
                    } else {
                      controller.setAdaptiveAppBarScrollUnderOffDark(
                          AdaptiveTheme.values[index]);
                    }
                  }
                : null,
          ),
          ColorSchemePopupMenu(
            title: const Text('Dark custom background color'),
            labelForDefault: controller.useFlexColorScheme
                ? 'default (AppBarStyle)'
                : 'default (surface)',
            index: controller.appBarBackgroundSchemeColorDark?.index ?? -1,
            onChanged: controller.useSubThemes && controller.useFlexColorScheme
                ? (int index) {
                    if (index < 0 || index >= SchemeColor.values.length) {
                      controller.setAppBarBackgroundSchemeColorDark(null);
                    } else {
                      controller.setAppBarBackgroundSchemeColorDark(
                          SchemeColor.values[index]);
                    }
                  }
                : null,
          ),
        ],
        const ListTileReveal(
          dense: true,
          title: Text('Background color'),
          subtitle: Text('With component themes enabled you can select scheme '
              'color for the AppBar background color. '
              'Using AppBarStyle is convenient and does not require activating '
              'FlexColorScheme component themes, but this offers more choices. '
              'Selecting a color, overrides used AppBarStyle. Set it back '
              'to default to use AppBarStyle again. Using AppBarStyle also '
              'offers Scaffold background color as AppBar color, which when '
              'using FCS surface blends can be different from ColorScheme '
              'surface and background colors.\n'),
        ),
        ListTileReveal(
          dense: true,
          title: const Text('Known issues'),
          subtitle: RichText(
            text: TextSpan(
              children: <TextSpan>[
                TextSpan(
                  style: spanTextStyle,
                  text: 'When using SliverAppBar.large or '
                      'SliverAppBar.medium, the foreground color cannot be '
                      'changed with widget or theme, see ',
                ),
                LinkTextSpan(
                  style: linkStyle,
                  uri: _fcsFlutterIssue110951,
                  text: 'issue #110951',
                ),
                TextSpan(
                    style: spanTextStyle,
                    text: '. This is fixed in 3.10, but not in 3.7. '
                        'The theming and defaults are also incorrect for the '
                        'action icons, see '),
                LinkTextSpan(
                  style: linkStyle,
                  uri: _fcsFlutterIssue123943,
                  text: 'issue #123943',
                ),
                TextSpan(
                  style: spanTextStyle,
                  text: '. There is a fix in master, but it it not available '
                      'in Flutter 3.7 or 3.10.\n',
                ),
              ],
            ),
          ),
        ),
        const Divider(),
        const ListTileReveal(
          title: Text('SearchBar'),
          subtitle: Text('The SearchBar with SearchView is new in Flutter '
              '3.10. A convenient way to create a search bar with a '
              'view is with the factory SearchAnchor.bar.\n'
              '\n'
              'FCS does not provide any convenience theming features for '
              'the search bar in current version, but may add some later.\n'),
        ),
        const SearchBarShowcase(),
        // _fcsFlutterIssue126623
        ListTileReveal(
          dense: true,
          title: const Text('Known issues'),
          subtitle: RichText(
            text: TextSpan(
              children: <TextSpan>[
                TextSpan(
                  style: spanTextStyle,
                  text: 'The InputDecoration theme leeks through into '
                      'SearchBar and SearchView. From the SearchView it cannot '
                      'even be removed with a Theme wrapper. For more '
                      'information, see ',
                ),
                LinkTextSpan(
                  style: linkStyle,
                  uri: _fcsFlutterIssue126623,
                  text: 'issue #126623',
                ),
                TextSpan(
                    style: spanTextStyle,
                    text: '. The Themes Playground '
                        'uses a Theme wrapper to remove it above, but it is '
                        'still visible in the view. In the simulator using the '
                        'Flutter official M3 demo, you can see the issue on '
                        'both SearchBar and the SearchView.\n '),
              ],
            ),
          ),
        ),
        const Divider(),
        const ListTileReveal(
          title: Text('BottomAppBar'),
          subtitle: Text('A BottomAppBar is typically used with '
              'Scaffold.bottomNavigationBar. '
              'Its elevation in FCS defaults to AppBar elevation in M2 mode, '
              'when using M3 it defaults to 3 and gets elevation tint.\n'),
        ),
        if (isLight) ...<Widget>[
          ListTile(
            enabled: controller.useFlexColorScheme,
            title: const Text('Light BottomAppBar elevation'),
            subtitle: Slider(
              min: -0.5,
              max: 20,
              divisions: 41,
              label: controller.useFlexColorScheme
                  ? controller.bottomAppBarElevationLight == null ||
                          (controller.bottomAppBarElevationLight ?? -0.5) < 0
                      ? controller.useMaterial3
                          ? 'default 3'
                          // ignore: lines_longer_than_80_chars
                          : 'default ${(controller.appBarElevationLight ?? 0).toStringAsFixed(1)}'
                      : (controller.bottomAppBarElevationLight
                              ?.toStringAsFixed(1) ??
                          '')
                  : controller.useMaterial3
                      ? 'default 3'
                      : 'default 8',
              value: controller.useFlexColorScheme
                  ? controller.bottomAppBarElevationLight ?? -0.5
                  : -0.5,
              onChanged: controller.useFlexColorScheme
                  ? (double value) {
                      controller.setBottomAppBarElevationLight(
                          value < 0 ? null : value);
                    }
                  : null,
            ),
            trailing: Padding(
              padding: const EdgeInsetsDirectional.only(end: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'ELEV',
                    style: theme.textTheme.bodySmall,
                  ),
                  Text(
                    controller.useFlexColorScheme
                        ? controller.bottomAppBarElevationLight == null ||
                                (controller.bottomAppBarElevationLight ??
                                        -0.5) <
                                    0
                            ? controller.useMaterial3
                                ? 'default 3'
                                // ignore: lines_longer_than_80_chars
                                : 'default ${(controller.appBarElevationLight ?? 0).toStringAsFixed(1)}'
                            : (controller.bottomAppBarElevationLight
                                    ?.toStringAsFixed(1) ??
                                '')
                        : controller.useMaterial3
                            ? 'default 3'
                            : 'default 8',
                    style: theme.textTheme.bodySmall!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        ] else ...<Widget>[
          ListTile(
            enabled: controller.useFlexColorScheme,
            title: const Text('Dark BottomAppBar elevation'),
            subtitle: Slider(
              min: -0.5,
              max: 20,
              divisions: 41,
              label: controller.useFlexColorScheme
                  ? controller.bottomAppBarElevationDark == null ||
                          (controller.bottomAppBarElevationDark ?? -0.5) < 0
                      ? controller.useMaterial3
                          ? 'default 3'
                          // ignore: lines_longer_than_80_chars
                          : 'default ${(controller.appBarElevationDark ?? 0).toStringAsFixed(1)}'
                      : (controller.bottomAppBarElevationDark
                              ?.toStringAsFixed(1) ??
                          '')
                  : controller.useMaterial3
                      ? 'default 3'
                      : 'default 8',
              value: controller.useFlexColorScheme
                  ? controller.bottomAppBarElevationDark ?? -0.5
                  : -0.5,
              onChanged: controller.useFlexColorScheme
                  ? (double value) {
                      controller.setBottomAppBarElevationDark(
                          value < 0 ? null : value);
                    }
                  : null,
            ),
            trailing: Padding(
              padding: const EdgeInsetsDirectional.only(end: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'ELEV',
                    style: theme.textTheme.bodySmall,
                  ),
                  Text(
                    controller.useFlexColorScheme
                        ? controller.bottomAppBarElevationDark == null ||
                                (controller.bottomAppBarElevationDark ?? -0.5) <
                                    0
                            ? controller.useMaterial3
                                ? 'default 3'
                                // ignore: lines_longer_than_80_chars
                                : 'default ${(controller.appBarElevationDark ?? 0).toStringAsFixed(1)}'
                            : (controller.bottomAppBarElevationDark
                                    ?.toStringAsFixed(1) ??
                                '')
                        : controller.useMaterial3
                            ? 'default 3'
                            : 'default 8',
                    style: theme.textTheme.bodySmall!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        ],
        ColorSchemePopupMenu(
          title: const Text('Background color for light and dark mode'),
          labelForDefault: 'default (surface)',
          index: controller.bottomAppBarSchemeColor?.index ?? -1,
          onChanged: controller.useSubThemes && controller.useFlexColorScheme
              ? (int index) {
                  if (index < 0 || index >= SchemeColor.values.length) {
                    controller.setBottomAppBarSchemeColor(null);
                  } else {
                    controller
                        .setBottomAppBarSchemeColor(SchemeColor.values[index]);
                  }
                }
              : null,
        ),
        const SizedBox(height: 8),
        Card(
          elevation: 0,
          margin: const EdgeInsets.symmetric(horizontal: 16),
          color: theme.colorScheme.surfaceVariant,
          child: const Padding(
            padding: EdgeInsets.all(16.0),
            child: BottomAppBarShowcase(explain: false),
          ),
        ),
        const ListTileReveal(
          dense: true,
          title: Text('Theming info'),
          subtitle: Text(
              'Flutter M2 past default color is ThemeData.bottomAppBarColor '
              '(deprecated in Flutter 3.7) now colorScheme.surface and '
              'elevation 8. In M3 it defaults to colorScheme.surface '
              'color, elevation 3, no shadow, but with surface elevation '
              'tint.\n'
              '\n'
              'The color of the items in a BottomAppBar cannot be themed. If '
              'you use a background color that requires other contrasting '
              'color than what works on surface and background colors, you '
              'will have to color the content on widget level.\n'),
        ),
        ListTileReveal(
          dense: true,
          title: const Text('Known issues'),
          subtitle: RichText(
            text: TextSpan(
              children: <TextSpan>[
                TextSpan(
                  style: spanTextStyle,
                  text: 'In Flutter 3.7 the BottomAppBar '
                      'color cannot be changed due to the issue described in ',
                ),
                LinkTextSpan(
                  style: linkStyle,
                  uri: _fcsFlutterFix117082,
                  text: 'FIX PR #117082.',
                ),
                TextSpan(
                  style: spanTextStyle,
                  text: '. The fix is available in Flutter 3.10 '
                      'and later.\n',
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
