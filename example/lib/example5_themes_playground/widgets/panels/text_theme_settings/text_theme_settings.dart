import 'package:flutter/material.dart';

import '../../../../shared/controllers/theme_controller.dart';
import '../../../../shared/widgets/universal/showcase_material.dart';
import '../../shared/use_material3_text_theme.dart';
import '../../shared/use_tinted_text_theme.dart';
import 'use_app_font_switch_list_tile.dart';

class TextThemeSettings extends StatelessWidget {
  const TextThemeSettings(this.controller, {super.key});
  final ThemeController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const SizedBox(height: 8),
        UseMaterial3TextTheme(controller: controller),
        UseTinted3TextTheme(controller: controller),
        UseAppFontSwitchLisTile(controller: controller),
        const Padding(
          padding: EdgeInsets.all(16),
          child: TextThemeShowcase(),
        ),
      ],
    );
  }
}
