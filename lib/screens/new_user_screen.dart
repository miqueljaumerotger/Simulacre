// lib/new_user_screen.dart
import 'package:examen_practic_sim/models/user.dart';
import 'package:examen_practic_sim/services/user_service.dart';
import 'package:flutter/material.dart';

class NewUserScreen extends StatefulWidget {
  @override
  _NewUserScreenState createState() => _NewUserScreenState();
}

class _NewUserScreenState extends State<NewUserScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _addressController = TextEditingController();
  final _phoneController = TextEditingController();
  final _photoController = TextEditingController();

  bool _isLoading = false;

  void _submit() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      User newUser = User(
        id: '',
        name: _nameController.text,
        email: _emailController.text,
        address: _addressController.text,
        phone: _phoneController.text,
        photo: _photoController.text,
      );
      try {
        await UserService.createUser(newUser);
        Navigator.pop(context); // Torna al HomeScreen
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error creant l'usuari: $e")),
        );
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    _phoneController.dispose();
    _photoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Nou Usuari"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _isLoading 
          ? Center(child: CircularProgressIndicator())
          : Form(
              key: _formKey,
              child: ListView(
                children: [
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(labelText: "Nom"),
                    validator: (value) => value!.isEmpty ? "Introdueix el nom" : null,
                  ),
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(labelText: "Correu"),
                    validator: (value) => value!.isEmpty ? "Introdueix el correu" : null,
                  ),
                  TextFormField(
                    controller: _addressController,
                    decoration: InputDecoration(labelText: "Adreça"),
                    validator: (value) => value!.isEmpty ? "Introdueix l'adreça" : null,
                  ),
                  TextFormField(
                    controller: _phoneController,
                    decoration: InputDecoration(labelText: "Telèfon"),
                    validator: (value) => value!.isEmpty ? "Introdueix el telèfon" : null,
                  ),
                  TextFormField(
                    controller: _photoController,
                    decoration: InputDecoration(labelText: "URL de la imatge"),
                    validator: (value) => value!.isEmpty ? "Introdueix l'URL de la imatge" : null,
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _submit,
                    child: Text("Crear Usuari"),
                  ),
                ],
              ),
            ),
      ),
    );
  }
}
