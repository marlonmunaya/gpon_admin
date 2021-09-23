import 'package:cloud_firestore/cloud_firestore.dart';

class Profile {
  final String usuario;
  final String nombre;
  final String celular;
  final String email;
  final List<String> role;
  final List<String> departamento;
  final List<String> area;
  DocumentReference reference;

  Profile(
      {this.usuario,
      this.nombre,
      this.celular,
      this.email,
      this.role,
      this.area,
      this.departamento});

  Profile.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data(), reference: snapshot.reference);

  Profile.fromMap(Map<String, dynamic> map, {this.reference})
      : usuario = map['usuario'],
        nombre = map['nombre'],
        celular = map['celular'],
        email = map['email'],
        departamento = List.from(map['departamento']),
        area = List.from(map['area']),
        role = List.from(map['role']);

  Map<String, dynamic> toJson() {
    return {
      'usuario': usuario,
      'nombre': nombre,
      'phone': celular,
      'email': email,
      'role': role,
      'area': area,
      'departamento': departamento
    };
  }

  Profile userdefault() {
    return Profile(
      usuario: "default",
      nombre: "Default",
      celular: "963963963",
      email: "default@gpon.pe",
      departamento: [""],
      role: [""],
      area: [""],
    );
  }

  String fullname() => nombre;
  bool isAdmin() => role.contains("admin");
  bool isOper() => role.contains("operador");
}
