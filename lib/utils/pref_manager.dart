import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class PrefManager {
  Future clear() async {
    SharedPreferences sharedPreference = await SharedPreferences.getInstance();
    return sharedPreference.clear();
  }

  Future addToFavorites(int id) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String favorites = await getFavorites();
    List<dynamic> favList = [];
    favList = json.decode(favorites);
    favList.add(id);
    await pref.setString("favorites", json.encode(favList));
  }

  Future removeFromFavorites(int id) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String favorites = await getFavorites();
    List<dynamic> favList = [];
    favList = json.decode(favorites);
    favList.remove(id);
    await pref.setString("favorites", json.encode(favList));
  }

  getFavorites() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString("favorites") ?? "[]";
  }
}
