import 'package:cloud_firestore/cloud_firestore.dart';

// class ClientModel {
//   final String nombre;
//   final String cedula;
//   final String celular;
//   final String fijo;
//   final String direccion;
//   final String email;
//   final String fechainstalacion;
//   final String fechacaptacion;
//   final String departamento;
//   final String provincia;
//   final String distrito;
//   final String observacion;
//   final DocumentReference reference;

//   ClientModel.fromMap(Map<String, dynamic> map, {this.reference})
//       : nombre = map["full_name"],
//         cedula = map["full_name"],
//         celular = map["full_name"],
//         fijo = map["full_name"],
//         direccion = map["full_name"],
//         email = map["full_name"],
//         fechainstalacion = map["full_name"],
//         fechacaptacion = map["full_name"],
//         observacion = map["full_name"];

//   ClientModel.fromSnapshot(DocumentSnapshot snapshot)
//       : this.fromMap(snapshot.data(), reference: snapshot.reference);

//   // String toString() => "$sales;$time\n";
// }
