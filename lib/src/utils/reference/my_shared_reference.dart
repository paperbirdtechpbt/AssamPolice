// Created by thakoranil0786@gmail.com

import 'dart:convert';

import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/models/responses/login_response.dart';

Future setupLocator() async {
  GetIt locator = GetIt.instance;
  var instance = await MySharedPreference.getInstance();
  locator.registerSingleton<MySharedPreference>(instance!);
}

class MySharedPreference {
  static MySharedPreference? classInstance;
  static SharedPreferences? preferences;

  static Future<MySharedPreference?> getInstance() async {
    classInstance ??= MySharedPreference();
    preferences ??= await SharedPreferences.getInstance();
    return classInstance;
  }

  _getFromDisk(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var value = prefs.get(key);
    return value;
  }

  Future<void> setString(String key, String content) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // print("Value Set ::::::" + content);
    prefs.setString(key, content);
  }

  Future<void> setBool(String key, bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // print("Value set ::::::" + value.toString());
    prefs.setBool(key, value);
  }

  getStringValue(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    String stringValue = prefs.getString(key) ?? "";
    print("Value set ::::::" + stringValue);
    return stringValue;
  }

  getBoolValue(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    bool? boolVal = prefs.getBool(key);
    print("Value get ::::::" + boolVal.toString());
    if (boolVal == null) {
      boolVal = false;
    }
    return boolVal;
  }

  // It clears preference data by unique key name
  Future<void> clearData(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }

  // It clears preference whole data
  Future<void> clear() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  // Used to save user's information
  setSignInModel(LoginData? model, String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, json.encode(model?.toJson()));
  }

  // Used to save user's information when user click on remember me
  setRememberModel(LoginData model, String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, json.encode(model.toJson()));
  }

  // Used to get user's information
  Future<LoginData?> getSignInModel(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var myJson = prefs.getString(key);
    if (myJson == null) {
      return null;
    }
    return LoginData.fromMap(json.decode(myJson));
  }

  // Used to get user's information
  Future<LoginData?> getRememberModel(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var myJson = prefs.getString(key);
    if (myJson == null) {
      return null;
    }
    return LoginData.fromMap(json.decode(myJson));
  }
}
