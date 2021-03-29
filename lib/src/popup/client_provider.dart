import 'package:flutter/material.dart';
import 'package:gpon_admin/src/data.dart';
import 'package:gpon_admin/src/model/utils_model.dart';
class ClientProvider with ChangeNotifier {
  String _nombre = "";
  String _dni = "";
  String _celular = "";
  String _fijo = "";
  String _direccion = "";
  String _email = "";
  String _fechainstalacion = "";
  String _fechacaptacion = "";
  String _observacion = "";
  String get nombre => _nombre;
  String get dni => _dni;
  String get celular => _celular;

  DateTime _selectedDate;
  DateTime get selectedDate => _selectedDate;
  UtilsModel _planes ;
  UtilsModel get planes => _planes;
  UtilsModel _plats ;
  UtilsModel get plataformas => _plats;
  String _planselected ;
  String get planselected => _planselected;
  String _platselected ;
  String get platselected => _platselected;

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
  
  Future<void> addUser1(fullName, company, age) {
    final users = Backend().users;
    return users
        .add({
          'full_name': fullName, // John Doe
          'company': company, // Stokes and Sons
          'age': age
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failes to ass user: $error"));
  }

  void getplanes() async {
    print('obteniento planes');
    final snapplan = await Backend().utils.doc("plan").get();
    _planes = UtilsModel.fromMapPlan(snapplan.data());
    final snapplat = await Backend().utils.doc("plataforma").get();
    _plats = UtilsModel.fromMapPlat(snapplat.data());
    print(_planes.planes.toString());
    print(_plats.plataforma.toString());
    notifyListeners();
  }

  void setplanselected(String plan) {
    _planselected = plan;
    notifyListeners();
  }

  void setplatselected(String plat) {
    _platselected = plat;
    notifyListeners();
  }

}

