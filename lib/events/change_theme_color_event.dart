import 'package:flutter/material.dart' show Color, required;

///改变主题色 event
class ChangeThemeColorEvent {
  Color color;

  ChangeThemeColorEvent({@required this.color});
}
