import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gpon_admin/src/api/data.dart';
import 'package:gpon_admin/src/model/utils_model.dart';
import 'package:gpon_admin/src/model/model.dart';
import 'package:gpon_admin/pages/Home/home_provider.dart';
import 'package:gpon_admin/src/popup/editclient.dart';

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
  UtilsModel _personal;
  UtilsModel get personal => _personal;
  String _planselected;
  String get planselected => _planselected;
  String _platselected;
  String get platselected => _platselected;
  DateTime _dateselected;
  DateTime get dateselected => _dateselected;
  bool _updateguardar; //1=update,0=guardar
  bool get updateguardar => _updateguardar;
  TextEditingController _dateCtl = TextEditingController();
  TextEditingController get dateCtl => _dateCtl;
  static final _formKeysign = GlobalKey<FormState>();
  get formKeysign => _formKeysign;
  String refer;
  GlobalKey<ScaffoldState> _globalScaffoldKey;
  get globalScaffoldKey => _globalScaffoldKey;

  Future<void> guardar(BuildContext context) async {
    // showsnackbar("Validando");
    print("Validando");
    if (!_formKeysign.currentState.validate()) return;
    _formKeysign.currentState.save();
    notifyListeners();
    _updateguardar ? await updateClient() : addClient();
    Navigator.of(_globalScaffoldKey.currentContext).pop();
  }

  void showsnackbar(String data) async {
    final context = globalScaffoldKey.currentContext;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(data),
      duration: Duration(seconds: 2),
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
    });
    notifyListeners();
  }

  Future<void> addClient() {
    CollectionReference users;
    users = Backend().usersv1;
    return users
        .add({
          'nombre': _nombre.text,
          'cedula': _cedula.text,
          'celular': _celular.text,
          'fijo': _fijo.text,
          'direccion': _direccion.text,
          'email': _email.text,
          'plan': _plan,
          'fechainstalacion': _fechacaptaciond,
          'fechacaptacion': _fechacaptaciond,
          'departamento': _departamento.text,
          'provincia': _provincia.text,
          'distrito': _distrito.text,
          'observacion': _observacion.text,
          'grupo': "Vacío",
          'tecnicos': [],
          'cableadoutp': _cableadoutp.text,
          'deco': _deco.text,
          'plataforma': _plataforma,
          'cordenadas': _cordenadas.text,
          'vendedor': _vendedor.text,
          'color': Colors.white60.value.toString()
        })
        // .then((value) => showsnackbar("Cliente agregado"))
        .then((value) => print("Cliente agregado"))
        .catchError((error) => print("Failes to add user: $error"));
  }

  Future updateClient() async {
    CollectionReference users;
    users = Backend().usersv1;
    await users
        .doc(refer)
        .update({
          'nombre': _nombre.text,
          'cedula': _cedula.text,
          'celular': _celular.text,
          'fijo': _fijo.text,
          'direccion': _direccion.text,
          'email': _email.text,
          'plan': _plan,
          'fechainstalacion': _fechacaptaciond,
          'fechacaptacion': _fechacaptaciond,
          'departamento': _departamento.text,
          'provincia': _provincia.text,
          'distrito': _distrito.text,
          'observacion': _observacion.text,
          // 'grupo': _grupo.text,
          'cableadoutp': _cableadoutp.text,
          'deco': _deco.text,
          'plataforma': _plataforma,
          'cordenadas': _cordenadas.text,
          'vendedor': _vendedor.text,
          'color': _color,
        })
        // .then((value) => showsnackbar("Cliente actualizado"))
        .then((value) => print("Cliente actualizado"))
        .catchError((error) => print("Failes to update user: $error"));
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
    final snappersonal = await Backend().utils.doc("grupos").get();
    _personal = UtilsModel.fromMappersonal(snappersonal.data());
    print("Utilidades obtenidos");
    print(_vendedores.vendedores);
    notifyListeners();
  }

  Future<void> getoneclient(context, String data) async {
    refer = data;
    print('obteniento dato');
    _updateguardar = true;
    final snapshot = await Backend().usersv1.doc(refer).get();
    final ide = ClientModel.fromSnapshot(snapshot);
    _vendedor.text = ide.vendedor;
    _cedula.text = ide.cedula;
    _plan = ide.plan;
    _nombre.text = ide.nombre;
    _celular.text = ide.celular;
    _fijo.text = ide.fijo;
    _plataforma = ide.plataforma;
    _fechacaptaciond = ide.fechacaptacion;
    _fechacaptacion.text =
        '${_fechacaptaciond.day}-${_fechacaptaciond.month}-${_fechacaptaciond.year}';
    _fechainstalacion.text =
        '${_fechacaptaciond.day}-${_fechacaptaciond.month}-${_fechacaptaciond.year}';
    _deco.text = ide.deco;
    _cableadoutp.text = ide.cableadoutp;
    _direccion.text = ide.direccion;
    _departamento.text = ide.departamento;
    _provincia.text = ide.provincia;
    _distrito.text = ide.distrito;
    _email.text = ide.email;
    _cordenadas.text = ide.cordenadas;
    _observacion.text = ide.observacion;
    _color = ide.color;
    _grupo.text = ide.grupo; //falta verificar.
    // _fechainstalacion.text = ide.cedula; //falta verificar.
    showsnackbar("cliente para actualizar");
  }

  Future<void> clearclient() async {
    _vendedor.text = "";
    _cedula.text = "";
    _plan = "";
    _nombre.text = "";
    _celular.text = "";
    _fijo.text = "";
    _plataforma = "";
    _fechacaptacion.text = "";
    _deco.text = "";
    _cableadoutp.text = "";
    _direccion.text = "";
    _departamento.text = "";
    _provincia.text = "";
    _distrito.text = "";
    _email.text = "";
    _cordenadas.text = "";
    _observacion.text = "";
    _color = "";
    _grupo.text = ""; //falta verificar.
    _fechainstalacion.text = ""; //falta verificar.
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

  void setcelular(String data) {
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

  void setvendedor(String data1) {
    _vendedor.text = data1;
    notifyListeners();
  }

  void setcordenadas(String data) {
    _cordenadas.text = data;
    notifyListeners();
  }

  void setobservacion(String data) {
    _observacion.text = data;
    notifyListeners();
  }

  void setgrupo(String data) {
    _grupo.text = data;
    notifyListeners();
  }

  void setupdateguardar(bool data) {
    _updateguardar = data;
    notifyListeners();
  }

  void setcolor(String data) {
    _color = data;
    notifyListeners();
  }

  void globalkey(data) {
    _globalScaffoldKey = data;
  }
}
