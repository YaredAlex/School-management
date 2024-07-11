import 'package:flutter/material.dart';

class CSwitchListTheme {
  CSwitchListTheme._();
  static SwitchThemeData lightSwitchList = SwitchThemeData(
    thumbColor:
        MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
      if (states.contains(MaterialState.selected)) {
        return Colors.white; // Color when the switch is on
      }
      return null; // Use the default color when the switch is off
    }),
    trackColor:
        MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
      if (states.contains(MaterialState.selected)) {
        return Colors.blue; // Color when the switch is on
      }
      return null; // Use the default color when the switch is off
    }),
  );
  static SwitchThemeData darkSwitchList = SwitchThemeData(
    thumbColor:
        MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
      if (states.contains(MaterialState.selected)) {
        return Colors.white; // Color when the switch is on
      }
      return null; // Use the default color when the switch is off
    }),
    trackColor:
        MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
      if (states.contains(MaterialState.selected)) {
        return Colors.blue; // Color when the switch is on
      }
      return null; // Use the default color when the switch is off
    }),
  );
}
