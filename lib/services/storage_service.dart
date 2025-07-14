import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class StorageKeys {
  static const String token = "user_token";
  static const String themeMode = "theme_mode";
  static const String refreshToken = "refresh_token";
}

class StorageService extends GetxService {
  late final SharedPreferences _preferences;

  Future<StorageService> init() async {
    _preferences = await SharedPreferences.getInstance();
    return this;
  }

  Future<bool> setValue<T>(String key, T value) async {
    try {
      if (value is String) {
        return await _preferences.setString(key, value);
      } else if (value is int) {
        return await _preferences.setInt(key, value);
      } else if (value is double) {
        return await _preferences.setDouble(key, value);
      } else if (value is bool) {
        return await _preferences.setBool(key, value);
      } else if (value is List<String>) {
        return await _preferences.setStringList(key, value);
      } else {
        throw ArgumentError(
          "Shared Preferences SetValue Kısmında desteklenemeyen veri türü.",
        );
      }
    } catch (e) {
      print("Shared Preferences SetValue kısmında hata fırlatıldı.");
      return false;
    }
  }

  T? getValue<T>(String key) {
    try {
      if (T == String) {
        return _preferences.getString(key) as T;
      } else if (T == int) {
        return _preferences.getInt(key) as T;
      } else if (T == double) {
        return _preferences.getDouble(key) as T;
      } else if (T == bool) {
        return _preferences.getBool(key) as T;
      } else if (T == List<String>) {
        return _preferences.getStringList(key) as T;
      }
    } catch (e) {
      print("Veri storegedan okunurken hata çıktı.");
      return null;
    }
  }

  Future<bool> remove(String key) async {
    try {
      return _preferences.remove(key);
    } catch (e) {
      print("Kayıt local storagedan silinirken bir hata oluştu $e");
      return false;
    }
  }

  Future<bool> clear() async {
    try {
      return _preferences.clear();
    } catch (e) {
      print(
        "Bütün veriler local storagedan clear edilirken bir sorun oluştu $e",
      );
      return false;
    }
  }

  bool hasKey(String key) {
    return _preferences.containsKey(key);
  }

  T getValueOrDefault<T>(String key, T defaultValue) {
    return getValue<T>(key) ?? defaultValue;
  }

  Map<String, dynamic> getAllValues() {
    final keys = _preferences.getKeys();
    final map = <String, dynamic>{};

    for (var key in keys) {
      map[key] = _preferences.get(key);
    }
    return map;
  }
}
