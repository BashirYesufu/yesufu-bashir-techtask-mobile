import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../notifiers/theme_notifier.dart';

class AppProviders {
  static final themeProvider = ChangeNotifierProvider<ThemeNotifier>((themeNotifier) => ThemeNotifier());
}