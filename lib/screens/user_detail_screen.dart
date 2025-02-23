// lib/user_detail_screen.dart
import 'package:examen_practic_sim/models/user.dart';
import 'package:flutter/material.dart';

class UserDetailScreen extends StatelessWidget {
  final User user;

  const UserDetailScreen({required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(user.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Visualitza la imatge
              Image.network(
                user.photo,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 16),
              Text("Nom: ${user.name}", style: TextStyle(fontSize: 18)),
              Text("Correu: ${user.email}", style: TextStyle(fontSize: 18)),
              Text("Adreça: ${user.address}", style: TextStyle(fontSize: 18)),
              Text("Telèfon: ${user.phone}", style: TextStyle(fontSize: 18)),
            ],
          ),
        ),
      ),
    );
  }
}
