import 'package:shared_preferences/shared_preferences.dart';

class NewSession {
  static late SharedPreferences sp;

  static Future<void> init() async {
    sp = await SharedPreferences.getInstance();
  }

  // -----------------------------
  // SAFE SAVE (ignores null values)
  // -----------------------------
  static Future<void> save<T>(String key, T? value) async {
    if (value == null) return; // ⛔ do not save null

    if (value is String) {
      sp.setString(key, value);
    } else if (value is int) {
      sp.setInt(key, value);
    } else if (value is double) {
      sp.setDouble(key, value);
    } else if (value is bool) {
      sp.setBool(key, value);
    } else if (value is List<String>) {
      sp.setStringList(key, value);
    } else {
      throw ArgumentError('Unsupported type for key: $key');
    }
  }

  // -----------------------------
  // GET (already safe)
  // -----------------------------
  static T get<T>(String key, T def) {
    if (def is String) {
      return (sp.getString(key) ?? def) as T;
    } else if (def is int) {
      return (sp.getInt(key) ?? def) as T;
    } else if (def is double) {
      return (sp.getDouble(key) ?? def) as T;
    } else if (def is bool) {
      return (sp.getBool(key) ?? def) as T;
    } else if (def is List<String>) {
      return (sp.getStringList(key) ?? def) as T;
    } else {
      throw ArgumentError('Unsupported type for key: $key');
    }
  }

  static void remove(String key) {
    sp.remove(key);
  }
}
