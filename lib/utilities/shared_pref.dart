import 'package:shared_preferences/shared_preferences.dart';

class _SharedPrefKeys {
  static const String prefsUserTheme = "prefs_user_theme";
}

class SharedPref {

  static void saveUserTheme({required String theme}) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(_SharedPrefKeys.prefsUserTheme, theme);
  }

  static Future<String> getUserTheme() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final value = prefs.getString(_SharedPrefKeys.prefsUserTheme);
    if(value==null){
      return "";
    }
    return value;
  }
}