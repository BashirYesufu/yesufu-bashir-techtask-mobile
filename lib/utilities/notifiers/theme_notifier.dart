import 'package:flutter/cupertino.dart';

import '../shared_pref.dart';
import '../theme_manager.dart';

class ThemeNotifier extends ChangeNotifier {

  AppTheme _themeMode = AppTheme.SYSTEM;
  AppTheme get theme => _themeMode;

  ThemeNotifier() {
    getTheme();
  }

  Future<AppTheme> getTheme()async {
    String theme = await SharedPref.getUserTheme();
    switch (theme) {
      case 'LIGHT':{
        _themeMode = AppTheme.LIGHT;
        return AppTheme.LIGHT;
      }
      case 'DARK':{
        _themeMode = AppTheme.DARK;
        return AppTheme.DARK;
      }
      default: {
        _themeMode = AppTheme.SYSTEM;
        return AppTheme.SYSTEM;
      }
    }
  }

  void setThemeMode (AppTheme theme){
    SharedPref.saveUserTheme(theme: AppTheme.rawValue(theme));
    _themeMode = theme;
    notifyListeners();
  }

}