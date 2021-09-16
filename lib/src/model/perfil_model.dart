import 'package:cloud_firestore/cloud_firestore.dart';

class Profile {
  final String usuario;
  final String nombre;
  final String celular;
  final String email;
  final List<String> role;
  final List<String> departamento;
  DocumentReference reference;

  Profile(
      {this.usuario,
      this.nombre,
      this.celular,
      this.email,
      this.role,
      this.departamento});

  Profile.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data(), reference: snapshot.reference);

  Profile.fromMap(Map<String, dynamic> map, {this.reference})
      : usuario = map['usuario'],
        nombre = map['nombre'],
        celular = map['celular'],
        email = map['email'],
        departamento = List.from(map['departamento']),
        role = List.from(map['role']);

  Map<String, dynamic> toJson() {
    return {
      'usuario': usuario,
      'nombre': nombre,
      'phone': celular,
      'email': email,
      'role': role,
      'departamento': departamento
    };
  }

  String fullname() => nombre;
  bool isAdmin() => role.contains("admin");
  bool isOper() => role.contains("operador");
}
