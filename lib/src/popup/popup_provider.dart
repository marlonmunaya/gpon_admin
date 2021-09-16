import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gpon_admin/src/api/data.dart';
import 'package:gpon_admin/src/model/model_api_cedula.dart';
import 'package:gpon_admin/src/model/utils_model.dart';
import 'package:gpon_admin/src/model/model.dart';

import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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
  DateTime _fechainstalaciond;
  DateTime get fechainstalaciond => _fechainstalaciond;
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
  TextEditingController _cajanap = TextEditingController();
  TextEditingController get cajanap => _cajanap;
  TextEditingController _puerto = TextEditingController();
  TextEditingController get puerto => _puerto;
  TextEditingController _servicios = TextEditingController();
  TextEditingController get servicios => _servicios;
  TextEditingController _repetidor = TextEditingController();
  TextEditingController get repetidor => _repetidor;
  String _color;
  String get color => _color;
  String _operador;
  String get operador => _operador;
  UtilsModel _planes;
  UtilsModel get planes => _planes;
  UtilsModel _plataformas;
  UtilsModel get plataformas => _plataformas;
  UtilsModel _ubicaciones;
  UtilsModel get ubicaciones => _ubicaciones;
  UtilsModel _vendedores;
  UtilsModel get vendedores => _vendedores;
  UtilsModel _seguimiento;
  UtilsModel get seguimiento => _seguimiento;
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
  DateFormat _formatocompleto = DateFormat('dd/MM/yyyy HH:mm');
  DateFormat get formatocompleto => _formatocompleto;
  DateFormat _formatohora = DateFormat('HH:mm');
  DateFormat get formatohora => _formatohora;
  ///////Estado de onTapDown/////////
  OverlayEntry _overlayEntry;
  OverlayEntry get overlay => _overlayEntry;
  OverlayState _overlayState;
  OverlayState get overlayState => _overlayState;
  bool _buttonState = true;
  bool get buttonState => _buttonState;
  List<dynamic> _listdepart;
  List<dynamic> get listdepart => _listdepart;
  int _seguimientoIndex = 0;
  int get seguimientoIndex => _seguimientoIndex;

  //Opcion flotante
  void removeoverlay() {
    _overlayEntry.remove();
    _buttonState = true;
    print("removiendo");
  }

  void insertoverlay(overlay) {
    _overlayEntry = overlay;
    _buttonState = false;
    print("ingresado");
  }

  //Funcion guardar del Popup Edit
  Future<void> guardar(BuildContext context) async {
    // showsnackbar("Validando");
    print("Validando");
    if (!_formKeysign.currentState.validate()) return;
    _formKeysign.currentState.save();
    notifyListeners();
    _updateguardar ? await updateClient() : addClient();
    Navigator.of(_globalScaffoldKey.currentContext).pop();
  }

  //Muestra showsnackbar
  void showsnackbar(String data) async {
    final context = globalScaffoldKey.currentContext;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(data),
      duration: Duration(seconds: 2),
    ));
  }

  void pickDateDialog(context) async {
    final selectdate = await showDatePicker(
        context: context,
        initialDate: _fechainstalaciond,
        firstDate: DateTime(2018),
        lastDate: DateTime.now().add(Duration(days: 180)));
    if (selectdate == null) return;
    final selecttime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay(
            hour: _fechainstalaciond.hour, minute: _fechainstalaciond.hour));
    if (selecttime == null) return;
    _fechainstalaciond = DateTime(
      selectdate.year,
      selectdate.month,
      selectdate.day,
      selecttime.hour,
      selecttime.minute,
    );
    _fechainstalacion.text =
        '${_fechainstalaciond.day}-${_fechainstalaciond.month}-${_fechainstalaciond.year}' +
            ' ${_fechainstalaciond.hour}:${_fechainstalaciond.minute}';

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
          'servicios': _servicios.text,
          'fechainstalacion': _fechainstalaciond,
          'fechacaptacion': DateTime.now(),
          'operador': _operador,
          'departamento': _departamento.text,
          'provincia': _provincia.text,
          'distrito': _distrito.text,
          'cajanap': _cajanap.text,
          'puerto': _puerto.text,
          'seguimiento': "Pendiente",
          'grupo': "Vacío",
          'tecnicos': [],
          'observaciones': [""],
          'cableadoutp': _cableadoutp.text,
          'deco': _deco.text,
          'repetidor': _repetidor.text,
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
          'servicios': _servicios.text,
          'fechainstalacion': _fechainstalaciond,
          'fechacaptacion': _fechacaptaciond,
          'departamento': _departamento.text,
          'provincia': _provincia.text,
          'distrito': _distrito.text,
          'cajanap': _cajanap.text,
          'puerto': _puerto.text,
          'repetidor': _repetidor.text,
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
    print('obteniento utils');
    final snapplan = await Backend().utils.doc("plan").get();
    _planes = UtilsModel.fromMapPlan(snapplan.data());

    final snapplat = await Backend().utils.doc("plataforma").get();
    _plataformas = UtilsModel.fromMapPlat(snapplat.data());

    final snapubicaciones = await Backend().utils.doc("ubicaciones").get();
    _ubicaciones = UtilsModel.fromMapubicaciones(snapubicaciones.data());

    final snapseguimiento = await Backend().utils.doc("seguimiento").get();
    _seguimiento = UtilsModel.fromMapseguimiento(snapseguimiento.data());
    print("Utilidades obtenidos");
    notifyListeners();
    listdepartamento();
  }

  void listdepartamento() {
    _listdepart = _ubicaciones.ubicaciones.entries.map((e) => e.key).toList();
    _listdepart.remove('Depart');
    notifyListeners();
  }

  void listvendedor(data) {
    List<dynamic> rutavendedor =
        _ubicaciones.ubicaciones[_departamento.text]['vendedores'];
    List<dynamic> vendedores = rutavendedor;
    Set<dynamic> ven = vendedores.toSet();
    ven.add(data);
    List<dynamic> ven1 = ven.toList();
    _ubicaciones.ubicaciones[_departamento.text]['vendedores'] = ven1;
    notifyListeners();
  }

  Future<void> getoneclient(context, String data) async {
    refer = data;
    print('obteniento dato');
    _updateguardar = true;
    final snapshot = await Backend().usersv1.doc(refer).get();
    final ide = ClientModel.fromSnapshot(snapshot);
    _cedula.text = ide.cedula;
    _plan = ide.plan;
    _nombre.text = ide.nombre;
    _celular.text = ide.celular;
    _fijo.text = ide.fijo;
    _plataforma = ide.plataforma;
    _servicios.text = ide.servicios;
    _fechainstalacion.text = _formatocompleto.format(ide.fechainstalacion);
    _fechainstalaciond = ide.fechainstalacion;
    _fechacaptaciond = ide.fechacaptacion;
    _fechacaptacion.text = _formatocompleto.format(ide.fechacaptacion);
    _deco.text = ide.deco;
    _cableadoutp.text = ide.cableadoutp;
    _direccion.text = ide.direccion;
    _repetidor.text = ide.repetidor;
    _departamento.text = ide.departamento;
    _provincia.text = ide.provincia;
    _distrito.text = ide.distrito;
    _email.text = ide.email;
    _cordenadas.text = ide.cordenadas;
    _cajanap.text = ide.cajanap;
    _puerto.text = ide.puerto;
    _color = ide.color;
    _grupo.text = ide.grupo;
    listvendedor(ide.vendedor);
    _vendedor.text = ide.vendedor;
    // showsnackbar("cliente para actualizar");
  }

  Future<void> clearclient() async {
    _vendedor.text = "";
    _cedula.text = "";
    _plan = "";
    _nombre.text = "";
    _celular.text = "";
    _fijo.text = "";
    _plataforma = "";
    _servicios.text = "";
    // _fechainstalacion.text = "";
    _deco.text = "0";
    _repetidor.text = "0";
    _cableadoutp.text = "";
    _direccion.text = "";
    _departamento.text = "";
    _provincia.text = "";
    _distrito.text = "";
    _email.text = "";
    _cordenadas.text = "";
    _cajanap.text = "";
    _puerto.text = "0";
    _color = "";
    _grupo.text = ""; //falta verificar.
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

  Future setfechainstalacion(DateTime now) async {
    final DateTime date = DateTime(now.year, now.month, now.day, 00, 00);
    print(date);
    _fechainstalaciond = date;
    _fechainstalacion.text =
        '${_fechainstalaciond.day}-${_fechainstalaciond.month}-${_fechainstalaciond.year}' +
            ' ${00}:${00}';
    // notifyListeners();
    print(_fechainstalacion.text);
  }

  void setdepartamento(String data) {
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

  void setservicios(String data) {
    _servicios.text = data;
    // notifyListeners();
  }

  void setvendedor(String data) {
    _vendedor.text = data;
    notifyListeners();
  }

  void setseguimientoindex(int index) {
    _seguimientoIndex = index;
    notifyListeners();
  }

  void setoperador(String data) {
    _operador = data.split("@")[0];
  }

  void setgrupo(String data) {
    _grupo.text = data;
    notifyListeners();
  }

  void setdeco(int data) {
    try {
      int deco = int.parse(_deco.text);
      deco += data;
      if (deco.isNegative) {
        deco = 0;
      }
      _deco.text = deco.toString();
      notifyListeners();
    } catch (_) {}
    notifyListeners();
  }

  void setpuerto(int data) {
    try {
      int puerto = int.parse(_puerto.text);
      puerto += data;
      if (puerto.isNegative) {
        puerto = 0;
      }
      _puerto.text = puerto.toString();
      notifyListeners();
    } catch (_) {}
    notifyListeners();
  }

  void setrepetidor(int data) {
    try {
      int repetidor = int.parse(_repetidor.text);
      repetidor += data;
      if (repetidor.isNegative) {
        repetidor = 0;
      }
      _repetidor.text = repetidor.toString();
      notifyListeners();
    } catch (_) {}
    notifyListeners();
  }

  void setupdateguardar(bool data) {
    _updateguardar = data;
    notifyListeners();
  }

  void globalkey(data) {
    _globalScaffoldKey = data;
  }

  Future getcedula(String cedula) async {
    Map<String, dynamic> _cliente;
    final token =
        "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJlbWFpbCI6Im1hcmxvbm11bmF5YUBob3RtYWlsLmNvbSJ9.xLMtYfO2BmErMB-7RDc_n0RGxCm5_2B5vl0cAFIoHlE";
    final apidni = 'https://dniruc.apisperu.com/api/v1/dni/';
    final apiruc = 'https://dniruc.apisperu.com/api/v1/ruc/';

    if (cedula.length < 11) {
      oldclient(cedula);
      await http
          .get(Uri.parse(apidni + '$cedula' + '?token=$token'))
          .then((value) {
        _cliente = jsonDecode(value.body);
        _nombre.text = _cliente['nombres'] +
            ' ' +
            _cliente['apellidoPaterno'] +
            ' ' +
            _cliente['apellidoMaterno'];
      }).catchError((e) {
        showsnackbar("No encontrado");
        return null;
      });
      notifyListeners();
    } else {
      oldclient(cedula);
      await http
          .get(Uri.parse(apiruc + '$cedula' + '?token=$token'))
          .then((value) {
        _cliente = jsonDecode(value.body);
        _nombre.text = _cliente['razonSocial'];
        _direccion.text =
            _cliente['direccion'] == null ? '' : _cliente['direccion'];
      }).catchError((e) => showsnackbar("No encontrado"));
      notifyListeners();
    }
  }

  void newpreregistro(ClientModel i) async {
    Map<String, dynamic> preregistro;
    String urlpreregistro = 'https://oficina.gpon.pe/api/v1/NewPreRegistro';

    http.Response response = await http
        .post(Uri.parse(urlpreregistro),
            headers: <String, String>{
              'Content-Type': 'application/json',
              'Access-Control-Allow-Origin': '*',
              'Access-Control-Allow-Methods': "GET,HEAD,OPTIONS,POST,PUT",
              "Access-Control-Allow-Headers":
                  "Origin, X-Requested-With, Content-Type, Accept, Authorization"
            },
            body: jsonEncode(<String, String>{
              "token": "cFhtUEdjTFlVMWpXY3FXUjR1Rmxzdz09",
              "cliente": i.nombre,
              "cedula": i.cedula,
              "direccion": i.direccion.toUpperCase(),
              "telefono": i.fijo,
              "movil": i.celular,
              "email": i.email,
              "fecha_instalacion": i.fechainstalacion.toString(),
              "vendedor": i.vendedor
            }))
        .then((value) {
      preregistro = jsonDecode(value.body);
      preregistro["estado"] == "exito"
          ? showsnackbar("Cliente se registró en Pre-Registro(Instalación)")
          : showsnackbar("Cliente ya existe");
    }).catchError((e) {
      showsnackbar("Falló la operación");
      print(e.toString());
    });
  }

  void oldclient(String cedula) async {
    Map<String, dynamic> oldclient;
    String urlcliente = 'https://oficina.gpon.pe/api/v1/GetClientsDetails';

    http.Response response = await http
        .post(Uri.parse(urlcliente),
            headers: <String, String>{
              'Content-Type': 'application/json',
              'Access-Control-Allow-Origin': '*',
              'Access-Control-Allow-Methods': "GET,HEAD,OPTIONS,POST,PUT",
              "Access-Control-Allow-Headers":
                  "Origin, X-Requested-With, Content-Type, Accept, Authorization"
            },
            body: jsonEncode(<String, String>{
              "token": "cFhtUEdjTFlVMWpXY3FXUjR1Rmxzdz09",
              "cedula": cedula,
            }))
        .then((value) {
      oldclient = jsonDecode(value.body);
      if (oldclient["estado"] == "exito") {
        _nombre.text = oldclient['datos'][0]["nombre"];
        _cordenadas.text = oldclient['datos'][0]["servicios"][0]["coordenadas"];
        _direccion.text = oldclient['datos'][0]["servicios"][0]["direccion"];
        _celular.text = oldclient['datos'][0]["movil"];
        _cedula.text = oldclient['datos'][0]["cedula"];

        print(oldclient['datos'][0]["nombre"]);
        print(oldclient['datos'][0]["servicios"][0]["direccion"]);
        print(oldclient['datos'][0]["movil"]);
        print(oldclient['datos'][0]["cedula"]);
        print(oldclient['datos'][0]["servicios"][0]["coordenadas"]);
        // showsnackbar("Cliente se registró en Pre-Registro(Instalación)");
      } else {
        // print(oldclient);
        showsnackbar("No esta registrado");
      }
    }).catchError((e) {
      showsnackbar("Falló la operación");
      print(e.toString());
    });
  }
}
