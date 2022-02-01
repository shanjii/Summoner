import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert' as convert;

class LocalStorage {
  static writeString(location, string) async {
    var prefs = await SharedPreferences.getInstance();
    var data = prefs.setString(location, string);
    return data;
  }

  static writeEncoded(location, data) async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setString(location, convert.jsonEncode(data));
  }

  static readString(location) async {
    var prefs = await SharedPreferences.getInstance();
    var data = prefs.getString(location);
    return data;
  }

  static readDecoded(location) async {
    var prefs = await SharedPreferences.getInstance();
    var data = prefs.getString(location);

    if (data != null) {
      return convert.jsonDecode(data);
    } else {
      return [];
    }
  }

  static clear(location) async {
    var prefs = await SharedPreferences.getInstance();
    prefs.remove(location);
  }
}
