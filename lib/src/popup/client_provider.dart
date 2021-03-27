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

  DateTime _selectedDate;
  DateTime get selectedDate => _selectedDate;

  void guardar() {
    notifyListeners();
  }

  void pickDateDialog(context) {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2018),
            lastDate: DateTime
                .now()) //what will be the up to supported date in picker
        .then((pickedDate) {
      //then usually do the future job
      if (pickedDate == null) {
        //if user tap cancel then this function will stop
        return;
      }
      _selectedDate = pickedDate;
      print(pickedDate);
      print("pickedDate");
    });
    notifyListeners();
  }
  
}
