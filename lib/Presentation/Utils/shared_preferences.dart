import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  static SharedPreferences? preferences;
  static const _keyIsLoggedIn = 'IsLoggedIn';
  static const _keyPin = 'Pin';
  static Future init() async =>
      preferences = await SharedPreferences.getInstance();
  static Future setIsLoggedIn(bool IsLoggedIn) async =>
      preferences!.setBool(_keyIsLoggedIn, IsLoggedIn);
  static bool? getIsLoggedIn() => preferences!.getBool(_keyIsLoggedIn);
  static setPin(int pin) async => preferences!.setInt(_keyPin, pin);
  static int? getPin() => preferences!.getInt(_keyPin);
}
