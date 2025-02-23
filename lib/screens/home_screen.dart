// lib/home_screen.dart
import 'package:examen_practic_sim/models/user.dart';
import 'package:examen_practic_sim/screens/new_user_screen.dart';
import 'package:examen_practic_sim/screens/user_detail_screen.dart';
import 'package:examen_practic_sim/services/user_service.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<User>> _usersFuture;

  @override
  void initState() {
    super.initState();
    _usersFuture = UserService.getUsers();
  }

  // Refrescar la llista d'usuaris
  void _refreshUsers() {
    setState(() {
      _usersFuture = UserService.getUsers();
    });
  }

  // Esborrar un usuari i refrescar
  void _deleteUser(String id) async {
    await UserService.deleteUser(id);
    _refreshUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Usuaris"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () async {
              // Navega a la pantalla per crear un nou usuari
              await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NewUserScreen()),
              );
              _refreshUsers();
            },
          )
        ],
      ),
      body: FutureBuilder<List<User>>(
        future: _usersFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return Center(child: CircularProgressIndicator());
          else if (snapshot.hasError)
            return Center(child: Text("Error: ${snapshot.error}"));
          else if (!snapshot.hasData || snapshot.data!.isEmpty)
            return Center(child: Text("No hi ha usuaris."));
          else {
            final users = snapshot.data!;
            return ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                final user = users[index];
                return ListTile(
                  title: Text(user.name),
                  subtitle: Text(user.email),
                  onTap: () {
                    // Navega a la pantalla de detall de l’usuari
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UserDetailScreen(user: user),
                      ),
                    );
                  },
                  trailing: IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      _deleteUser(user.id);
                    },
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
