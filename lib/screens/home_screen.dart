// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:users_favorites_flutter/utils/favorite_handler.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isLoading = true;
  final favoriteHandler = FavoriteHandler();

  @override
  void initState() {
    super.initState();
    _loadUsers();
  }

  Future<void> _loadUsers() async {
    await favoriteHandler.fetchUsers();
    setState(() {
      _isLoading = false;
    });
  }

  void _toggleFavorite(int userId) async {
    await favoriteHandler.toggleFavorite(userId);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Favorite Users")),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _buildUserList(),
    );
  }

  Widget _buildUserList() {
    return ListView.builder(
      itemCount: favoriteHandler.users.length,
      itemBuilder: (context, index) {
        final user = favoriteHandler.users[index];
        return ListTile(
          title: Text(user.name),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(user.email),
              Text(user.phone),
            ],
          ),
          trailing: IconButton(
            icon: Icon(
              user.isFavorite ? Icons.favorite : Icons.favorite_border_sharp,
              color: user.isFavorite ? Colors.red : Colors.grey,
            ),
            onPressed: () => _toggleFavorite(user.id),
          ),
        );
      },
    );
  }
}
