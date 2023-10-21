import 'package:flutter/material.dart';

class BrightnessToggle extends StatelessWidget {
  const BrightnessToggle({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return IconButton(
      onPressed: () {},
      icon: isDark
          ? const Icon(Icons.brightness_7)
          : const Icon(Icons.brightness_3),
    );
  }
}
