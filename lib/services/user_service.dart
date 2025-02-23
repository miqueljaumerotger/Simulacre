// lib/services/user_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user.dart';

class UserService {
  static const String baseUrl = 'https://examen-practic-sim-default-rtdb.europe-west1.firebasedatabase.app';

  // Obtenir tots els usuaris
  static Future<List<User>> getUsers() async {
    final response = await http.get(Uri.parse('$baseUrl/users.json'));
    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      List<User> users = [];
      // Cada entrada té una clau (id) i els seus valors
      data.forEach((key, value) {
        users.add(User.fromJson(key, value));
      });
      return users;
    } else {
      throw Exception('Error carregant els usuaris');
    }
  }

  // Crear un nou usuari
  static Future<User> createUser(User user) async {
    final response = await http.post(
      Uri.parse('$baseUrl/users.json'),
      body: json.encode(user.toJson()),
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      // Firebase retorna per exemple: { "name": "-MQ..."}
      final data = json.decode(response.body);
      String newId = data['name'];
      return User(
        id: newId,
        name: user.name,
        email: user.email,
        address: user.address,
        phone: user.phone,
        photo: user.photo,
      );
    } else {
      throw Exception('Error creant l’usuari');
    }
  }

  // Esborrar un usuari
  static Future<void> deleteUser(String id) async {
    final response = await http.delete(Uri.parse('$baseUrl/users/$id.json'));
    if (response.statusCode != 200) {
      throw Exception('Error esborrant l’usuari');
    }
  }
}
