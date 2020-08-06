import 'package:flutter/material.dart';

class ThemeChanger with ChangeNotifier {
  bool _darkTheme = false;
  bool _customTheme = false;

  ThemeData _currentTheme;

  bool get darkTheme => this._darkTheme;
  bool get customTheme => this._customTheme;
  ThemeData get currentTheme => this._currentTheme;

  ThemeChanger(int theme) {
    switch (theme) {
      case 1: // Light
        darkTheme = false;
        break;
      case 2: // Dark
        darkTheme = true;
        break;
      case 3: // Custom
        customTheme = true;
        break;
      default:
        darkTheme = false;
    }
  }

  set darkTheme(bool value) {
    this._customTheme = false;
    this._darkTheme = value;

    if (value) {
      _currentTheme = ThemeData.dark();
    } else {
      _currentTheme = ThemeData.light();
    }

    notifyListeners();
  }

  set customTheme(bool value) {
    this._darkTheme = false;
    this._customTheme = value;

    if (value) {
      _currentTheme = ThemeData.dark().copyWith(
          accentColor: Color(0xff48A0EB),
          primaryColorLight: Colors.white,
          scaffoldBackgroundColor: Color(0xff16202B),
          textTheme: TextTheme(bodyText2: TextStyle(color: Colors.white30))
// unselectedWidgetColor
// textTheme.bodyText2.color
// buttonColor
// dividerColor
          );
    } else {
      _currentTheme = ThemeData.light();
    }

    notifyListeners();
  }
}
