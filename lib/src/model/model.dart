import 'package:cloud_firestore/cloud_firestore.dart';

class ClientModel {
  final String nombre;
  final String cedula;
  final String celular;
  final String fijo;
  final String direccion;
  final String email;
  final String plan;
  final String fechainstalacion;
  final String fechacaptacion;
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
  final String color;
  final DocumentReference reference;

  ClientModel.fromMap(Map<String, dynamic> map, {this.reference})
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
        vendedor = map["vendedor"],
        color = map["color"];

  ClientModel.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data(), reference: snapshot.reference);

  //" String toString() => "$sales;$time\n";

//  Map<String, dynamic> toMap(){
//         "nombre" = map["nombre"],
//         "cedula" = map["cedula"],
//         "celular" = map["celular"],
//         "fijo" = map["fijo"],
//         "direccion" = map["direccion"],
//         "email" = map["email"],
//         "plan" = map["plan"],
//         "fechainstalacion" = map["fechainstalacion"],
//         "fechacaptacion" = map["fechacaptacion"],
//         "departamento" = map["departamento"],
//         "provincia" = map["provincia"],
//         "distrito" = map["distrito"],
//         "observacion" = map["observacion"],
//         "grupo" = map["grupo"],
//         "cableadoutp" = map["cableadoutp"],
//         "deco" = map["deco"],
//         "plataforma" = map["plataforma"],
//         "cordenadas" = map["cordenadas"],
//         "vendedor" = map["vendedor"],
//         "color" = map["color"];

//  }

}

//  class Clientadd{

//   Clientadd.fromMapupdate(Map<String, dynamic> map,)
//       : "nombre" = map["nombre"],
//         "cedula" = map["cedula"],
//         "celular" = map["celular"],
//         "fijo" = map["fijo"],
//         "direccion" = map["direccion"],
//         "email" = map["email"],
//         "plan" = map["plan"],
//         "fechainstalacion" = map["fechainstalacion"],
//         "fechacaptacion" = map["fechacaptacion"],
//         "departamento" = map["departamento"],
//         "provincia" = map["provincia"],
//         "distrito" = map["distrito"],
//         "observacion" = map["observacion"],
//         "grupo" = map["grupo"],
//         "cableadoutp" = map["cableadoutp"],
//         "deco" = map["deco"],
//         "plataforma" = map["plataforma"],
//         "cordenadas" = map["cordenadas"],
//         "vendedor" = map["vendedor"],
//         "color" = map["color"];

// }
// // assert(map['fecha']  != null),
// // sales = map['var1valor'],
// // var2valor = map['var2valor'],
// // var1name = map['var1name'],
// // tiempo = map['fecha'],
// // time = (map['fecha']).toDate();
