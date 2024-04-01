import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DbClient {
  setData({required String dbKey, required String value}) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(dbKey, value);
  }

  removeData({required String dbkey}) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(dbkey);
  }

  getData({required var dbKey}) async {
    final prefs = await SharedPreferences.getInstance();
    final result = prefs.getString(dbKey);
    return result ?? '';
  }

  resetData({required String dbKey}) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
}
final dbClientprovider  = Provider<DbClient>((ref) {
  return DbClient();
});