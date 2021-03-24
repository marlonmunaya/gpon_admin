import 'package:flutter/material.dart';

class ClientProvider with ChangeNotifier {
  String _nombre = "";
  String _dni = "";
  String _celular = "";
  String _fijo = "";
  String _direccion = "";
  String _email = "";
  String _plan = "";
  String _fechainstalacion = "";
  String _fechacaptacion = "";
  String _observacion = "";
  String get nombre => _nombre;
  String get dni => _dni;
  String get celular => _celular;

  void guardar() {
    notifyListeners();
  }
}
