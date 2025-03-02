import 'dart:convert';
import 'package:users_favorites_flutter/utils/api_provider.dart';
import 'package:users_favorites_flutter/utils/pref_manager.dart';
import 'package:users_favorites_flutter/utils/user_data.dart';

class FavoriteHandler {
  List<UserData> _users = [];
  List<int> _favoriteIds = [];
  final _apiProvider = ApiProvider();
  final _prefManager = PrefManager();

  List<UserData> get users => _users;

  Future<void> fetchUsers() async {
    _users = await _apiProvider.getUsers(
        "https://jsonplaceholder.typicode.com", "Users");

    // get favorite IDs from SharedPreferences
    String favoriteData = await _prefManager.getFavorites();
    _favoriteIds = List<int>.from(json.decode(favoriteData));

    for (var user in _users) {
      user.isFavorite = _favoriteIds.contains(user.id);
    }
  }

  Future<void> toggleFavorite(int userId) async {
    final user = _users.firstWhere((user) => user.id == userId);
    user.isFavorite = !user.isFavorite;

    if (user.isFavorite) {
      _favoriteIds.add(userId);
      await _prefManager.addToFavorites(userId);
    } else {
      _favoriteIds.remove(userId);
      await _prefManager.removeFromFavorites(userId);
    }
  }
}
