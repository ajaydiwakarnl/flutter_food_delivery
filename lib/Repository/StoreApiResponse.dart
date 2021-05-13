
import 'package:shared_preferences/shared_preferences.dart';

class StoreApiResponse {

  read(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(value);
  }

  save(String key, value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(key, value);
  }

  remove(String key) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }
}