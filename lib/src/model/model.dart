import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String nombre;
  final String cedula;
  final String celular;
  final String fijo;
  final String direccion;
  final String email;
  final String plan;
  final DateTime fechainstalacion;
  final DateTime fechacaptacion;
  final String departamento;
  final String provincia;
  final String distrito;
  final String observacion;
  final String grupo;
  final String cableadoutp;
  final String deco;
  final String plataforma;
  final String cordenadas;
  final String vendedor;
  final DocumentReference reference;

  UserModel.fromMap(Map<String, dynamic> map, {this.reference})
      : nombre = map["nombre"],
        cedula = map["cedula"],
        celular = map["celular"],
        fijo = map["fijo"],
        direccion = map["direccion"],
        email = map["email"],
        plan = map["plan"],
        fechainstalacion = map["fechainstalacion"],
        fechacaptacion = map["fechacaptacion"],
        departamento = map["departamento"],
        provincia = map["provincia"],
        distrito = map["distrito"],
        observacion = map["observacion"],
        grupo = map["grupo"],
        cableadoutp = map["cableadoutp"],
        deco = map["deco"],
        plataforma = map["plataforma"],
        cordenadas = map["cordenadas"],
        vendedor = map["vendedor"];

  UserModel.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data(), reference: snapshot.reference);

  // String toString() => "$sales;$time\n";
}
