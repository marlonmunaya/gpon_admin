import 'package:cloud_firestore/cloud_firestore.dart';

class ClientModel {
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
  final String color;
  final List<String> tecnicos;
  final DocumentReference reference;

  ClientModel.fromMap(Map<String, dynamic> map, {this.reference})
      : nombre = map["nombre"],
        cedula = map["cedula"],
        celular = map["celular"],
        fijo = map["fijo"],
        direccion = map["direccion"],
        email = map["email"],
        plan = map["plan"],
        fechainstalacion = map["fechainstalacion"].toDate(),
        fechacaptacion = map["fechacaptacion"].toDate(),
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
        color = map["color"],
        tecnicos = List.from(map["tecnicos"]);

  ClientModel.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data(), reference: snapshot.reference);
}

class Listagrupo {
  final String grupo;
  final List<ClientModel> lista;
  final List<String> tecnicos;

  Listagrupo(this.grupo, this.lista, this.tecnicos);
}
