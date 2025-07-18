import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeCubit extends Cubit<bool> {
  static const String _themeKey = 'isDarkMode';

  ThemeCubit() : super(false) {
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final isDark = prefs.getBool(_themeKey) ?? false;
    emit(isDark);
  }

  Future<void> toggleTheme() async {
    final newMode = !state;
    emit(newMode);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_themeKey, newMode);
  }
}
