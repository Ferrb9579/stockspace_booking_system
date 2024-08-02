import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThemeController extends GetxController {
  RxList<ColorTheme> themes = [
    const ColorTheme(
      background: Colors.white,
      foreground: Color(0xFF31394F),
      primary: Color(0xFF7980FF),
      primaryForeground: Colors.white,
      secondary: Color(0xFFF8FAFC),
      secondaryForeground: Colors.grey,
    ),
    const ColorTheme(
      background: Colors.black,
      foreground: Color(0xFF31394F),
      primary: Color(0xFF7980FF),
      primaryForeground: Colors.white,
      secondary: Color(0xFFF8FAFC),
      secondaryForeground: Colors.grey,
    )
  ].obs;
  final currentThemeIndex = 0.obs;
  late Rx<ColorTheme> currentTheme = themes[currentThemeIndex.value].obs;

  void setThemes(List<ColorTheme> themes) {
    this.themes.value = themes;
  }

  void addTheme(ColorTheme theme) {
    themes.add(theme);
  }

  ColorTheme getCurrentTheme() {
    return themes[currentThemeIndex.value];
  }

  void setCurrentTheme(int index) {
    currentThemeIndex.value = index;
    currentTheme.value = getCurrentTheme();
  }

  void changeTheme() {
    setCurrentTheme(adjustInRange(currentThemeIndex.value, 0, themes.length - 1));
    print(currentThemeIndex.value);
  }

  int adjustInRange(int current, int min, int max, [int step = 1]) {
    if (min > max) {
      var temp = min;
      min = max;
      max = temp;
    }

    final rangeSize = max - min + 1;
    current = ((current - min) % rangeSize + rangeSize) % rangeSize + min;
    var newNum = current + step;

    if (newNum > max) {
      newNum = min + ((newNum - min) % rangeSize);
    } else if (newNum < min) {
      newNum = max - ((max - newNum) % rangeSize);
    }

    return newNum;
  }

  ThemeController() {
    currentTheme.value = getCurrentTheme();
  }
}

class ColorTheme {
  final Color background;
  final Color foreground;
  final Color primary;
  final Color primaryForeground;
  final Color secondary;
  final Color secondaryForeground;

  const ColorTheme({
    required this.background,
    required this.foreground,
    required this.primary,
    required this.primaryForeground,
    required this.secondary,
    required this.secondaryForeground,
  });

  factory ColorTheme.fromMap(Map<String, Color> map) {
    return ColorTheme(
      background: map['background']!,
      foreground: map['foreground']!,
      primary: map['primary']!,
      primaryForeground: map['primaryForeground']!,
      secondary: map['secondary']!,
      secondaryForeground: map['secondaryForeground']!,
    );
  }
}
