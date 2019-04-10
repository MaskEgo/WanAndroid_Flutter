import 'package:flutter/material.dart' show Colors, Color;

class ThemeUtil {
  // 默认主题色
  static const Color defaultColor = const Color(0xFF63CA6C);

  // 可选的主题色
  static const Map<String, Color> supportColors = {
    'defaultColor':defaultColor,
    'purple': Colors.purple,
    'orange': Colors.orange,
    'deepPurpleAccent': Colors.deepPurpleAccent,
    'amber': Colors.amber,
    'green': Colors.green,
    'lime': Colors.lime,
    'indigo': Colors.indigo,
    'cyan': Colors.cyan,
    'redAccent': Colors.redAccent,
    'blue': Colors.blue,
    'teal': Colors.teal
  };
}
