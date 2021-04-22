import 'package:flutter/material.dart';
import 'package:gpon_admin/src/api/data.dart';
import 'package:gpon_admin/src/model/utils_model.dart';
import 'package:gpon_admin/src/model/model.dart';
import 'package:gpon_admin/pages/Home/home_provider.dart';

class PopupProvider with ChangeNotifier {
  TextEditingController _cedula = TextEditingController();
  TextEditingController get cedula => _cedula;
  String _plataforma;
  String get plataforma => _plataforma;
  TextEditingController _nombre = TextEditingController();
  TextEditingController get nombre => _nombre;
  TextEditingController _celular = TextEditingController();
  TextEditingController get celular => _celular;
  String _plan;
  String get plan => _plan;
  TextEditingController _fijo = TextEditingController();
  TextEditingController get fijo => _fijo;
  TextEditingController _direccion = TextEditingController();
  TextEditingController get direccion => _direccion;
  TextEditingController _email = TextEditingController();
  TextEditingController get email => _email;
  TextEditingController _fechainstalacion = TextEditingController();
  TextEditingController get fechainstalacion => _fechainstalacion;
  TextEditingController _fechacaptacion = TextEditingController();
  TextEditingController get fechacaptacion => _fechacaptacion;
  DateTime _fechacaptaciond;
  DateTime get fechacaptaciond => _fechacaptaciond;
  TextEditingController _departamento = TextEditingController();
  TextEditingController get departamento => _departamento;
  TextEditingController _provincia = TextEditingController();
  TextEditingController get provincia => _provincia;
  TextEditingController _distrito = TextEditingController();
  TextEditingController get distrito => _distrito;
  TextEditingController _observacion = TextEditingController();
  TextEditingController get observacion => _observacion;
  TextEditingController _grupo = TextEditingController();
  TextEditingController get grupo => _grupo;
  TextEditingController _cableadoutp = TextEditingController();
  TextEditingController get cableadoutp => _cableadoutp;
  TextEditingController _deco = TextEditingController();
  TextEditingController get deco => _deco;
  TextEditingController _cordenadas = TextEditingController();
  TextEditingController get cordenadas => _cordenadas;
  TextEditingController _vendedor = TextEditingController();
  TextEditingController get vendedor => _vendedor;
  String _color;
  String get color => _color;
  UtilsModel _planes;
  UtilsModel get planes => _planes;
  UtilsModel _plataformas;
  UtilsModel get plataformas => _plataformas;
  UtilsModel _ubicaciones;
  UtilsModel get ubicaciones => _ubicaciones;
  UtilsModel _vendedores;
  UtilsModel get vendedores => _vendedores;
  String _planselected;
  String get planselected => _planselected;
  String _platselected;
  String get platselected => _platselected;
  DateTime _dateselected;
  DateTime get dateselected => _dateselected;
  TextEditingController _dateCtl = TextEditingController();
  TextEditingController get dateCtl => _dateCtl;
  static final _formKeysign = GlobalKey<FormState>();
  get formKeysign => _formKeysign;

  void guardar(context) {
    showsnackbar(context, "Validando");
    if (!_formKeysign.currentState.validate()) return;
    _formKeysign.currentState.save();
    notifyListeners();
    addClient();
    showsnackbar(context, "Guardado");
    Navigator.of(context).pop();
  }

  void showsnackbar(BuildContext context, String data) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(data),
      duration: Duration(seconds: 3),
    ));
  }

  void pickDateDialog(context) {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2018),
            lastDate: DateTime.now().add(Duration(days: 180)))
        .then((pickedDate) {
      //then usually do the future job
      if (pickedDate == null) {
        return;
      }
      _fechacaptaciond = pickedDate;
      _fechacaptacion.text =
          '${pickedDate.day}-${pickedDate.month}-${pickedDate.year}';
      // print(pickedDate);
      // print(dateCtl.text);
    });
    notifyListeners();
  }

  void pickColorDialog(context) {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2018),
            lastDate: DateTime.now().add(Duration(days: 180)))
        .then((pickedDate) {
      //then usually do the future job
      if (pickedDate == null) {
        return;
      }
      _fechacaptaciond = pickedDate;
      _fechacaptacion.text =
          '${pickedDate.day}-${pickedDate.month}-${pickedDate.year}';
      // print(pickedDate);
      // print(dateCtl.text);
    });
    notifyListeners();
  }

  Future<void> addClient() {
    final users = Backend().usersv1;
    return users
        .add({
          'nombre': _nombre.text,
          'cedula': _cedula.text,
          'celular': _celular.text,
          'fijo': "",
          'direccion': "",
          'email': "",
          'plan': _plan,
          'fechainstalacion': "",
          'fechacaptacion': "",
          'departamento': "",
          'provincia': "",
          'distrito': "",
          'observacion': "",
          'grupo': "",
          'cableadoutp': "",
          'deco': "",
          'plataforma': _plataforma,
          'cordenadas': "",
          'vendedor': "",
          'color': ""
        })
        .then((value) => print("Client Added"))
        .catchError((error) => print("Failes to ass user: $error"));
  }

  void getutils() async {
    print('obteniento planes');
    final snapplan = await Backend().utils.doc("plan").get();
    _planes = UtilsModel.fromMapPlan(snapplan.data());
    final snapplat = await Backend().utils.doc("plataforma").get();
    _plataformas = UtilsModel.fromMapPlat(snapplat.data());
    final snapubicaciones = await Backend().utils.doc("ubicaciones").get();
    _ubicaciones = UtilsModel.fromMapubicaciones(snapubicaciones.data());
    final snapvendedor = await Backend().utils.doc("vendedor").get();
    _vendedores = UtilsModel.fromMapVendedor(snapvendedor.data());
    print("Utilidades obtenidos");
    print(_ubicaciones.departamentos);
    notifyListeners();
  }

  void getoneclient(String refer) async {
    ClientModel ide;
    print('obteniento dato');
    final snapshot = await Backend().usersv1.doc(refer).get();
    ide = ClientModel.fromSnapshot(snapshot);
    _cedula.text = ide.cedula;
    _plan = ide.plan;
    _nombre.text = ide.nombre;
    _celular.text = ide.celular;
    _fijo.text = ide.fijo;
    _plataforma = ide.plataforma;
    _vendedor.text = ide.vendedor;
    _fechacaptacion.text = ide.fechacaptacion;
    _deco.text = ide.deco;
    _cableadoutp.text = ide.cableadoutp;
    _direccion.text = ide.direccion;
    _departamento.text = ide.departamento;
    _provincia.text = ide.provincia;
    _distrito.text = ide.distrito;
    _email.text = ide.email;
    _cordenadas.text = ide.cordenadas;
    _observacion.text = ide.observacion;
    // _cedula.text = ide.cedula;
    // _cedula.text = ide.cedula;
    print("cliente obtenido");
    notifyListeners();
  }

  Future updateonclient(context, String refer) async {
    final users = Backend().usersv1;
    await users
        .doc("$refer")
        .update({
          'observacion': obs.text,
        })
        .then((value) => print("Client updated"))
        .catchError((error) => print("Failes to ass user: $error"));
    showsnackbar(context, "Observación actualizada");
  }

  void setplan(String plan) {
    _plan = plan;
    notifyListeners();
  }

  void setplataforma(String plat) {
    _plataforma = plat;
    notifyListeners();
  }

  void setDateselected(DateTime date) {
    _dateselected = date;
    notifyListeners();
  }

  void setnombre(String data) {
    _nombre.text = data;
    notifyListeners();
  }

  void setcedula(String data) {
    _cedula.text = data;
    notifyListeners();
  }

  void setcell(String data) {
    _celular.text = data;
    notifyListeners();
  }

  void setdireccion(String data) {
    _direccion.text = data;
    notifyListeners();
  }

  void setemail(String data) {
    _email.text = data;
    notifyListeners();
  }

  void setfijo(String data) {
    _fijo.text = data;
    notifyListeners();
  }

  void setutp(String data) {
    _cableadoutp.text = data;
    notifyListeners();
  }

  void setdepartamento(String data) {
    _provincia.text = "Provin";
    _distrito.text = "Distrito";
    _departamento.text = data;
    notifyListeners();
  }

  void setprovincia(String data) {
    _provincia.text = data;
    notifyListeners();
  }

  void setdistrito(String data) {
    _distrito.text = data;
    notifyListeners();
  }

  void setdeco(String data) {
    _deco.text = data;
    notifyListeners();
  }

  void setvendedor(String data) {
    _vendedor.text = data;
    notifyListeners();
  }

  void setcordenadas(String data) {
    _cordenadas.text = data;
    notifyListeners();
  }
}
