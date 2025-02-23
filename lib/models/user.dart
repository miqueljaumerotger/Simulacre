// lib/models/user.dart
class User {
  final String id; // Identificador que ens dona Firebase (la clau del node)
  final String name;
  final String email;
  final String address;
  final String phone;
  final String photo;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.address,
    required this.phone,
    required this.photo,
  });

  // Crea un User a partir del JSON rebut. El paràmetre "id" el rebem de la clau
  factory User.fromJson(String id, Map<String, dynamic> json) {
    return User(
      id: id,
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      address: json['address'] ?? '',
      phone: json['phone'] ?? '',
      photo: json['photo'] ?? '',
    );
  }

  // Convertir un usuari a JSON per enviar-lo a Firebase
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'address': address,
      'phone': phone,
      'photo': photo,
    };
  }
}
