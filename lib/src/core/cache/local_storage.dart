import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VModelSharedPrefStorage {
  /// Get string value
  /// Argument [key]
  Future<String?> getString(key) async {
    Future<SharedPreferences> prefs1 = SharedPreferences.getInstance();
    final SharedPreferences prefs2 = await prefs1;
    String? res = prefs2.getString("$key");
    return res;
  }

  /// Get int value
  ///

  Future<int?> getInt(key) async {
    Future<SharedPreferences> prefs1 = SharedPreferences.getInstance();
    final SharedPreferences prefs2 = await prefs1;
    int? res = prefs2.getInt('$key');
    return res;
  }

  /// Get list or object
  /// Use import 'dart:convert'; for jsonEncode
  /// Argument [key]
  dynamic getJson(key) async {
    Future<SharedPreferences> prefs1 = SharedPreferences.getInstance();
    final SharedPreferences prefss = await prefs1;
    String jsonString = prefss.getString("$key")!;
    var res = jsonDecode(jsonString);
    return res;
  }

  /// Adding a string value
  Future<bool> putString(key, val) async {
    Future<SharedPreferences> pref3 = SharedPreferences.getInstance();
    final SharedPreferences prefsA = await pref3;
    var res = prefsA.setString("$key", val);
    return res;
  }

  /// Adding an int value
  ///
  Future<bool> putInt(key, val) async {
    Future<SharedPreferences> pref3 = SharedPreferences.getInstance();
    final SharedPreferences prefsA = await pref3;
    var res = prefsA.setInt("$key", val);
    return res;
  }

  /// Adding a bool value
  Future<bool> putBool(key, val) async {
    Future<SharedPreferences> prefs4 = SharedPreferences.getInstance();
    final SharedPreferences prefs = await prefs4;
    var res = prefs.setBool("$key", val);
    return res;
  }

  /// Adding a bool value
  Future<bool> getBool(key) async {
    Future<SharedPreferences> prefs5 = SharedPreferences.getInstance();
    final SharedPreferences prefs = await prefs5;
    var res = prefs.getBool("$key");
    return res ?? false;
  }

  /// Adding a list or object
  /// Use import 'dart:convert'; for jsonEncode
  dynamic putJson(key, val) async {
    Future<SharedPreferences> prefs6 = SharedPreferences.getInstance();
    final SharedPreferences prefs = await prefs6;
    var valString = jsonEncode(val);
    var res = prefs.setString("$key", valString);
    return res;
  }

//put object
  dynamic putObject(key, Object val) async {
    Future<SharedPreferences> prefs6 = SharedPreferences.getInstance();
    final SharedPreferences prefs = await prefs6;
    var valString = jsonEncode(val);
    var res = prefs.setString("$key", valString);
    return res;
  }

//getObject
  dynamic getObject(key) async {
    Future<SharedPreferences> prefs1 = SharedPreferences.getInstance();
    final SharedPreferences prefss = await prefs1;
    String jsonString = prefss.getString("$key")!;
    var res = jsonDecode(jsonString);
    return res;
  }

  dynamic clearObject(key) async {
    Future<SharedPreferences> prefs6 = SharedPreferences.getInstance();
    final SharedPreferences prefss = await prefs6;

    prefss.remove("$key");
  }
}

class VModelSecureStorage {
  // Create storage
  final storage = const FlutterSecureStorage();

// Read value
  dynamic getSecuredKeyStoreData(String sKey) async {
    String? value = await storage.read(key: sKey);
    return value;
  }

// Read all values
  dynamic readAllStoreData() async {
    Map<String, String> allValues = await storage.readAll();
    return allValues;
  }

// Delete value
  dynamic deleteKeyStoreData(String sKey) async {
    await storage.delete(key: sKey);
  }

// Delete all
  dynamic deleteAllStorageData() async {
    await storage.deleteAll();
  }

// Write value
  dynamic storeByKey(String sKey, dynamic valueToBeStored) async {
    await storage.write(key: sKey, value: valueToBeStored);
  }
}
