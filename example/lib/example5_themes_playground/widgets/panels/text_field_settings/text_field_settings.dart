import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';

import '../../../../shared/const/app.dart';
import '../../../../shared/controllers/theme_controller.dart';
import '../../../../shared/widgets/universal/list_tile_reveal.dart';
import '../../../../shared/widgets/universal/showcase_material.dart';
import '../../../../shared/widgets/universal/switch_list_tile_reveal.dart';
import '../../dialogs/set_text_field_to_m3_dialog.dart';
import '../../shared/color_scheme_popup_menu.dart';

class TextFieldSettings extends StatelessWidget {
  const TextFieldSettings(this.controller, {super.key});
  final ThemeController controller;

  Future<void> _handleSetToM3(BuildContext context) async {
    final bool? reset = await showDialog<bool?>(
      context: context,
      builder: (BuildContext context) {
        return const SetTextFieldToM3Dialog();
      },
    );
    if (reset ?? false) {
      await controller.setTextFieldToM3();
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final bool useMaterial3 = theme.useMaterial3;
    final bool isLight = theme.brightness == Brightness.light;

    final String thinBorderDefaultLabel =
        controller.inputDecoratorBorderWidth == null &&
                controller.thinBorderWidth == null
            ? 'default 1'
            : controller.inputDecoratorBorderWidth == null &&
                    controller.thinBorderWidth != null
                ? 'global ${controller.thinBorderWidth!.toStringAsFixed(1)}'
                : '';
    final String thickBorderDefaultLabel =
        controller.inputDecoratorFocusedBorderWidth == null &&
                controller.thickBorderWidth == null
            ? 'default 2'
            : controller.inputDecoratorFocusedBorderWidth == null &&
                    controller.thickBorderWidth != null
                ? 'global ${controller.thickBorderWidth!.toStringAsFixed(1)}'
                : '';

    // Get effective platform default global radius.
    final double? effectiveRadius = App.effectiveRadius(controller);
    final String decoratorRadiusDefaultLabel =
        controller.inputDecoratorBorderRadius == null && effectiveRadius == null
            ? controller.useMaterial3
                ? 'default 4'
                : 'default 10'
            : controller.inputDecoratorBorderRadius == null &&
                    effectiveRadius != null
                ? 'global ${effectiveRadius.toStringAsFixed(0)}'
                : '';

    // Default decorator alpha values and labels
    final double defaultBackgroundAlpha = useMaterial3
        ? 0xFF // Light M3 default
        : isLight
            ? 0x0D // Light FCS own M2 default
            : 0x14; // Dark FCS own M2 default

    final String lightBackgroundLabel = (controller
                        .inputDecoratorBackgroundAlphaLight ??
                    -1) >=
                0 &&
            controller.useSubThemes &&
            controller.useFlexColorScheme
        // ignore: lines_longer_than_80_chars
        ? '0x${controller.inputDecoratorBackgroundAlphaLight?.toRadixString(16).toUpperCase()}'
        : 'Default 0x'
            '${defaultBackgroundAlpha.toInt().toRadixString(16).toUpperCase()}';
    final String lightBackgroundLabelOpacity =
        controller.inputDecoratorBackgroundAlphaLight != null
            ? (controller.inputDecoratorBackgroundAlphaLight! / 255 * 100)
                .toStringAsFixed(1)
            : (defaultBackgroundAlpha / 255 * 100).toStringAsFixed(1);

    final String darkBackgroundLabel = (controller
                    .inputDecoratorBackgroundAlphaDark ??
                -1) <
            0
        ? useMaterial3
            ? 'Default (0xFF)' // Dark M3 default
            : 'Default (0x14)' // Dark FCS own M2 default
        // ignore: lines_longer_than_80_chars
        : '0x${controller.inputDecoratorBackgroundAlphaDark?.toRadixString(16).toUpperCase()}';
    final String darkBackgroundLabelOpacity =
        controller.inputDecoratorBackgroundAlphaDark != null
            ? (controller.inputDecoratorBackgroundAlphaDark! / 255 * 100)
                .toStringAsFixed(1)
            : (defaultBackgroundAlpha / 255 * 100).toStringAsFixed(1);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const SizedBox(height: 8),
        ListTileReveal(
            enabled: useMaterial3,
            title: const Text('Use Material 3 default TextField style?'),
            subtitleDense: true,
            subtitle: const Text('Update settings below to match M3 default '
                'values.\n'),
            trailing: FilledButton(
              onPressed: useMaterial3
                  ? () async {
                      await _handleSetToM3(context);
                    }
                  : null,
              child: const Text('Set to M3'),
            ),
            onTap: () async {
              await _handleSetToM3(context);
            }),
        const Padding(
          padding: EdgeInsets.all(16),
          child: TextInputField(),
        ),
        if (isLight)
          ColorSchemePopupMenu(
            title: const Text('Light theme base color'),
            labelForDefault: controller.useMaterial3
                ? 'default (primary & surfaceVariant)'
                : 'default (primary)',
            index: controller.inputDecoratorSchemeColorLight?.index ?? -1,
            onChanged: controller.useSubThemes && controller.useFlexColorScheme
                ? (int index) {
                    if (index < 0 || index >= SchemeColor.values.length) {
                      controller.setInputDecoratorSchemeColorLight(null);
                    } else {
                      controller.setInputDecoratorSchemeColorLight(
                          SchemeColor.values[index]);
                    }
                  }
                : null,
          )
        else
          ColorSchemePopupMenu(
            title: const Text('Dark theme base color'),
            labelForDefault: controller.useMaterial3
                ? 'default (primary & surfaceVariant)'
                : 'default (primary)',
            index: controller.inputDecoratorSchemeColorDark?.index ?? -1,
            onChanged: controller.useSubThemes && controller.useFlexColorScheme
                ? (int index) {
                    if (index < 0 || index >= SchemeColor.values.length) {
                      controller.setInputDecoratorSchemeColorDark(null);
                    } else {
                      controller.setInputDecoratorSchemeColorDark(
                          SchemeColor.values[index]);
                    }
                  }
                : null,
          ),
        SwitchListTileReveal(
          title: const Text('Use base color as background fill'),
          subtitleDense: true,
          subtitle: const Text('TIP: If you leave this OFF, you can still '
              'theme the fill color and turn it ON using widget level '
              "'filled: true' property, and wise versa.\n"),
          value: controller.inputDecoratorIsFilled &&
              controller.useSubThemes &&
              controller.useFlexColorScheme,
          onChanged: controller.useSubThemes && controller.useFlexColorScheme
              ? controller.setInputDecoratorIsFilled
              : null,
        ),
        if (isLight)
          ColorSchemePopupMenu(
            title: const Text('Light theme focused prefix icon color'),
            labelForDefault: controller.useMaterial3
                ? 'default (onSurface)'
                // ignore: lines_longer_than_80_chars
                : 'default (${controller.inputDecoratorSchemeColorLight?.name ?? 'primary'})',
            index: controller.inputDecoratorPrefixIconSchemeColor?.index ?? -1,
            onChanged: controller.useSubThemes && controller.useFlexColorScheme
                ? (int index) {
                    if (index < 0 || index >= SchemeColor.values.length) {
                      controller.setInputDecoratorPrefixIconSchemeColor(null);
                    } else {
                      controller.setInputDecoratorPrefixIconSchemeColor(
                          SchemeColor.values[index]);
                    }
                  }
                : null,
          )
        else
          ColorSchemePopupMenu(
            title: const Text('Dark theme focused prefix icon color'),
            labelForDefault: controller.useMaterial3
                ? 'default (onSurface)'
                // ignore: lines_longer_than_80_chars
                : 'default (${controller.inputDecoratorSchemeColorDark?.name ?? 'primary'})',
            index:
                controller.inputDecoratorPrefixIconDarkSchemeColor?.index ?? -1,
            onChanged: controller.useSubThemes && controller.useFlexColorScheme
                ? (int index) {
                    if (index < 0 || index >= SchemeColor.values.length) {
                      controller
                          .setInputDecoratorPrefixIconDarkSchemeColor(null);
                    } else {
                      controller.setInputDecoratorPrefixIconDarkSchemeColor(
                          SchemeColor.values[index]);
                    }
                  }
                : null,
          ),
        if (isLight) ...<Widget>[
          ListTile(
            enabled: controller.useSubThemes && controller.useFlexColorScheme,
            title: const Text('Light theme background alpha'),
            subtitle: Text('Current alpha as opacity is '
                '$lightBackgroundLabelOpacity%'),
          ),
          ListTile(
            enabled: controller.useSubThemes && controller.useFlexColorScheme,
            title: Slider(
              min: -1,
              max: 255,
              divisions: 256,
              label: lightBackgroundLabel,
              value: controller.useSubThemes && controller.useFlexColorScheme
                  ? controller.inputDecoratorBackgroundAlphaLight?.toDouble() ??
                      -1
                  : -1,
              onChanged:
                  controller.useSubThemes && controller.useFlexColorScheme
                      ? (double value) {
                          controller.setInputDecoratorBackgroundAlphaLight(
                              value < 0 ? null : value.toInt());
                        }
                      : null,
            ),
            trailing: Padding(
              padding: const EdgeInsetsDirectional.only(end: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'ALPHA',
                    style: theme.textTheme.bodySmall,
                  ),
                  Text(
                    lightBackgroundLabel,
                    style: theme.textTheme.bodySmall!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          )
        ] else ...<Widget>[
          ListTile(
            enabled: controller.useSubThemes && controller.useFlexColorScheme,
            title: const Text('Dark theme background alpha'),
            subtitle: Text('Current alpha as opacity is '
                '$darkBackgroundLabelOpacity%'),
          ),
          ListTile(
            enabled: controller.useSubThemes && controller.useFlexColorScheme,
            title: Slider(
              min: -1,
              max: 255,
              divisions: 256,
              label: darkBackgroundLabel,
              value: controller.useSubThemes && controller.useFlexColorScheme
                  ? controller.inputDecoratorBackgroundAlphaDark?.toDouble() ??
                      -1
                  : -1,
              onChanged:
                  controller.useSubThemes && controller.useFlexColorScheme
                      ? (double value) {
                          controller.setInputDecoratorBackgroundAlphaDark(
                              value < 0 ? null : value.toInt());
                        }
                      : null,
            ),
            trailing: Padding(
              padding: const EdgeInsetsDirectional.only(end: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'ALPHA',
                    style: theme.textTheme.bodySmall,
                  ),
                  Text(
                    darkBackgroundLabel,
                    style: theme.textTheme.bodySmall!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          )
        ],
        SwitchListTile(
          title: const Text(
            'Border style',
          ),
          subtitle: const Text(
            'ON for outline | OFF for underline',
          ),
          value: controller.inputDecoratorBorderType ==
                  FlexInputBorderType.outline &&
              controller.useSubThemes &&
              controller.useFlexColorScheme,
          onChanged: controller.useSubThemes && controller.useFlexColorScheme
              ? (bool isOn) {
                  if (isOn) {
                    controller.setInputDecoratorBorderType(
                        FlexInputBorderType.outline);
                  } else {
                    controller.setInputDecoratorBorderType(
                        FlexInputBorderType.underline);
                  }
                }
              : null,
        ),
        ListTile(
          enabled: controller.useSubThemes && controller.useFlexColorScheme,
          title: const Text('Border radius'),
          subtitle: Slider(
            min: -1,
            max: 40,
            divisions: 41,
            label: controller.useSubThemes && controller.useFlexColorScheme
                ? controller.inputDecoratorBorderRadius == null ||
                        (controller.inputDecoratorBorderRadius ?? -1) < 0
                    ? decoratorRadiusDefaultLabel
                    : (controller.inputDecoratorBorderRadius
                            ?.toStringAsFixed(0) ??
                        '')
                : 'default 4',
            value: controller.useSubThemes && controller.useFlexColorScheme
                ? controller.inputDecoratorBorderRadius ?? -1
                : -1,
            onChanged: controller.useSubThemes && controller.useFlexColorScheme
                ? (double value) {
                    controller.setInputDecoratorBorderRadius(
                        value < 0 ? null : value.roundToDouble());
                  }
                : null,
          ),
          trailing: Padding(
            padding: const EdgeInsetsDirectional.only(end: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  'RADIUS',
                  style: theme.textTheme.bodySmall,
                ),
                Text(
                  controller.useSubThemes && controller.useFlexColorScheme
                      ? controller.inputDecoratorBorderRadius == null ||
                              (controller.inputDecoratorBorderRadius ?? -1) < 0
                          ? decoratorRadiusDefaultLabel
                          : (controller.inputDecoratorBorderRadius
                                  ?.toStringAsFixed(0) ??
                              '')
                      : 'default 4',
                  style: theme.textTheme.bodySmall!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
        SwitchListTile(
          title: const Text('Unfocused field has a border'),
          value: controller.inputDecoratorUnfocusedHasBorder &&
              controller.useSubThemes &&
              controller.useFlexColorScheme,
          onChanged: controller.useSubThemes && controller.useFlexColorScheme
              ? controller.setInputDecoratorUnfocusedHasBorder
              : null,
        ),
        SwitchListTile(
          title: const Text('Unfocused border is colored'),
          value: controller.inputDecoratorUnfocusedBorderIsColored &&
              controller.inputDecoratorUnfocusedHasBorder &&
              controller.useSubThemes &&
              controller.useFlexColorScheme,
          onChanged: controller.useSubThemes &&
                  controller.inputDecoratorUnfocusedHasBorder &&
                  controller.useFlexColorScheme
              ? controller.setInputDecoratorUnfocusedBorderIsColored
              : null,
        ),
        if (isLight)
          ColorSchemePopupMenu(
            title: const Text('Light theme border color'),
            labelForDefault: 'default (base color)',
            index: controller.inputDecoratorBorderSchemeColorLight?.index ?? -1,
            onChanged: controller.useSubThemes &&
                    controller.useFlexColorScheme &&
                    !(!controller.inputDecoratorFocusedHasBorder &&
                        (!controller.inputDecoratorUnfocusedHasBorder ||
                            !controller.inputDecoratorUnfocusedBorderIsColored))
                ? (int index) {
                    if (index < 0 || index >= SchemeColor.values.length) {
                      controller.setInputDecoratorBorderSchemeColorLight(null);
                    } else {
                      controller.setInputDecoratorBorderSchemeColorLight(
                          SchemeColor.values[index]);
                    }
                  }
                : null,
          )
        else
          ColorSchemePopupMenu(
            title: const Text('Dark theme border color'),
            labelForDefault: 'default (base color)',
            index: controller.inputDecoratorBorderSchemeColorDark?.index ?? -1,
            onChanged: controller.useSubThemes &&
                    controller.useFlexColorScheme &&
                    !(!controller.inputDecoratorFocusedHasBorder &&
                        (!controller.inputDecoratorUnfocusedHasBorder ||
                            !controller.inputDecoratorUnfocusedBorderIsColored))
                ? (int index) {
                    if (index < 0 || index >= SchemeColor.values.length) {
                      controller.setInputDecoratorBorderSchemeColorDark(null);
                    } else {
                      controller.setInputDecoratorBorderSchemeColorDark(
                          SchemeColor.values[index]);
                    }
                  }
                : null,
          ),
        ListTile(
          title: const Text('Unfocused border width'),
          enabled: controller.useSubThemes &&
              controller.useFlexColorScheme &&
              controller.inputDecoratorUnfocusedHasBorder,
          subtitle: Slider(
            min: 0,
            max: 5,
            divisions: 10,
            label: controller.useSubThemes &&
                    controller.useFlexColorScheme &&
                    controller.inputDecoratorUnfocusedHasBorder
                ? controller.inputDecoratorBorderWidth == null ||
                        (controller.inputDecoratorBorderWidth ?? 0) <= 0
                    ? thinBorderDefaultLabel
                    : (controller.inputDecoratorBorderWidth
                            ?.toStringAsFixed(1) ??
                        '')
                : controller.inputDecoratorUnfocusedHasBorder ||
                        !controller.useSubThemes ||
                        !controller.useFlexColorScheme
                    ? 'default 1'
                    : 'none',
            value: controller.useSubThemes &&
                    controller.useFlexColorScheme &&
                    controller.inputDecoratorUnfocusedHasBorder
                ? controller.inputDecoratorBorderWidth ?? 0
                : 0,
            onChanged: controller.useSubThemes &&
                    controller.useFlexColorScheme &&
                    controller.inputDecoratorUnfocusedHasBorder
                ? (double value) {
                    controller.setInputDecoratorBorderWidth(
                        value <= 0 ? null : value);
                  }
                : null,
          ),
          trailing: Padding(
            padding: const EdgeInsetsDirectional.only(end: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  'WIDTH',
                  style: theme.textTheme.bodySmall,
                ),
                Text(
                  controller.useSubThemes &&
                          controller.useFlexColorScheme &&
                          controller.inputDecoratorUnfocusedHasBorder
                      ? controller.inputDecoratorBorderWidth == null ||
                              (controller.inputDecoratorBorderWidth ?? 0) <= 0
                          ? thinBorderDefaultLabel
                          : (controller.inputDecoratorBorderWidth
                                  ?.toStringAsFixed(1) ??
                              '')
                      : controller.inputDecoratorUnfocusedHasBorder ||
                              !controller.useSubThemes ||
                              !controller.useFlexColorScheme
                          ? 'default 1'
                          : 'none',
                  style: theme.textTheme.bodySmall!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
        SwitchListTile(
          title: const Text('Focused field has a border'),
          value: controller.inputDecoratorFocusedHasBorder &&
              controller.useSubThemes &&
              controller.useFlexColorScheme,
          onChanged: controller.useSubThemes && controller.useFlexColorScheme
              ? controller.setInputDecoratorFocusedHasBorder
              : null,
        ),
        ListTile(
          enabled: controller.useSubThemes &&
              controller.useFlexColorScheme &&
              controller.inputDecoratorFocusedHasBorder,
          title: const Text('Focused border width'),
          subtitle: Slider(
            min: 0,
            max: 5,
            divisions: 10,
            label: controller.useSubThemes &&
                    controller.useFlexColorScheme &&
                    controller.inputDecoratorFocusedHasBorder
                ? controller.inputDecoratorFocusedBorderWidth == null ||
                        (controller.inputDecoratorFocusedBorderWidth ?? 0) <= 0
                    ? thickBorderDefaultLabel
                    : (controller.inputDecoratorFocusedBorderWidth
                            ?.toStringAsFixed(1) ??
                        '')
                : controller.inputDecoratorFocusedHasBorder ||
                        !controller.useSubThemes ||
                        !controller.useFlexColorScheme
                    ? 'default 2'
                    : 'none',
            value: controller.useSubThemes &&
                    controller.useFlexColorScheme &&
                    controller.inputDecoratorFocusedHasBorder
                ? controller.inputDecoratorFocusedBorderWidth ?? 0
                : 0,
            onChanged: controller.useSubThemes &&
                    controller.useFlexColorScheme &&
                    controller.inputDecoratorFocusedHasBorder
                ? (double value) {
                    controller.setInputDecoratorFocusedBorderWidth(
                        value <= 0 ? null : value);
                  }
                : null,
          ),
          trailing: Padding(
            padding: const EdgeInsetsDirectional.only(end: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  'WIDTH',
                  style: theme.textTheme.bodySmall,
                ),
                Text(
                  controller.useSubThemes &&
                          controller.useFlexColorScheme &&
                          controller.inputDecoratorFocusedHasBorder
                      ? controller.inputDecoratorFocusedBorderWidth == null ||
                              (controller.inputDecoratorFocusedBorderWidth ??
                                      0) <=
                                  0
                          ? thickBorderDefaultLabel
                          : (controller.inputDecoratorFocusedBorderWidth
                                  ?.toStringAsFixed(1) ??
                              '')
                      : controller.inputDecoratorFocusedHasBorder ||
                              !controller.useSubThemes ||
                              !controller.useFlexColorScheme
                          ? 'default 2'
                          : 'none',
                  style: theme.textTheme.bodySmall!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
        const Divider(),
        const ListTileReveal(
          title: Text('DropdownMenu'),
          subtitleDense: true,
          subtitle: Text('The DropDownMenu has a text entry used to select '
              'an option in a dropdown menu by typing in the selection. '
              'The text entry part matches the used input decoration '
              'in FCS by default.\n'),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: DropDownMenuShowcase(),
        ),
        const ListTileReveal(
          title: Text('DropdownButtonFormField'),
          subtitleDense: true,
          subtitle: Text('An older Material widget, it also uses the text '
              'input decoration theme. Tt does not work well with high '
              'border radius. Prefer using the DropdownMenu widget instead.\n'),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: DropDownButtonFormField(),
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}
