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
  final String servicios;
  final String provincia;
  final String distrito;
  final String cajanap;
  final String puerto;
  final String grupo;
  final String cableadoutp;
  final String deco;
  final String plataforma;
  final String cordenadas;
  final String vendedor;
  final String color;
  final List<String> tecnicos;
  final DocumentReference reference;
  final List<String> observaciones;
  final String repetidor;
  final String operador;
  final String seguimiento;

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
        cajanap = map["cajanap"],
        puerto = map["puerto"],
        grupo = map["grupo"],
        cableadoutp = map["cableadoutp"],
        deco = map["deco"],
        repetidor = (map["repetidor"] == null) ? "0" : map["repetidor"],
        plataforma = map["plataforma"],
        cordenadas = map["cordenadas"],
        vendedor = map["vendedor"],
        color = map["color"],
        servicios = map["servicios"],
        tecnicos = List.from(map["tecnicos"]),
        observaciones = List.from(map["observaciones"]),
        operador = (map["operador"] == null) ? "None" : map["operador"],
        seguimiento = (map["seguimiento"] == null) ? "" : map["seguimiento"];

  ClientModel.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data(), reference: snapshot.reference);
}

class Listagrupo {
  final String grupo;
  final List<ClientModel> lista;
  final List<String> tecnicos;

  Listagrupo(this.grupo, this.lista, this.tecnicos);
}
