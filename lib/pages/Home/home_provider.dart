import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:gpon_admin/src/api/data.dart';
import 'package:gpon_admin/src/model/model.dart';
import 'package:table_calendar/table_calendar.dart';

///Librerias para la conexion DB
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeProvider with ChangeNotifier {
  Size _screenSize;
  Size get screenSize => _screenSize;
  DateTime _selectedDay = DateTime.now();
  DateTime get selectedDay => _selectedDay;
  CalendarController _calendarController;
  CalendarController get calendarController => _calendarController;
  Map<DateTime, List> _eventos;
  Map<DateTime, List> get eventos => _eventos;
  Map<DateTime, List> _holidays;
  Map<DateTime, List> get holidays => _holidays;
  List<ClientModel> _model;
  List<ClientModel> get model => _model;
  GlobalKey<ScaffoldState> globalScaffoldKey;
  TextEditingController _nombregrupo = TextEditingController();
  TextEditingController get nombregrupo => _nombregrupo;
  TextEditingController _nuevogrupo = TextEditingController();
  TextEditingController get nuevogrupo => _nuevogrupo;
  Set<String> _group;
  Set<String> get group => _group;
  List<String> _totalgrupo = [];
  List<Listagrupo> _listgroup = [];
  List<Listagrupo> get listgroup => _listgroup;
  List<String> _selectedtec = [];
  List<String> get selectedtec => _selectedtec;

  void setdate() {
    _selectedDay = DateTime.now();
    _eventos = {
      // _selectedDay.subtract(Duration(days: 16)): ['Event A3', 'Event B3'],
      // _selectedDay.subtract(Duration(days: 10)): [
      //   'Event A4',
      //   'Event B4',
      //   'Event C4'
      // ],
      // _selectedDay.subtract(Duration(days: 4)): [
      //   'Event A5',
      //   'Event B5',
      //   'Event C5'
      // ],
      // _selectedDay.subtract(Duration(days: 2)): ['Event A6', 'Event B6'],
      _selectedDay: ['Event A7', 'Event B7', 'Event C7'],
      // _selectedDay.add(Duration(days: 1)): [
      //   'Event A8',
      //   'Event B8',
      //   'Event C8',
      //   'Event D8'
      // ],
    };

    _holidays = {
      DateTime(2021, 1, 1): ['New Year\'s Day'],
      DateTime(2021, 1, 6): ['Epiphany'],
      DateTime(2021, 2, 14): ['Valentine\'s Day'],
      DateTime(2021, 4, 21): ['Easter Sunday'],
      DateTime(2021, 4, 22): ['Easter Monday'],
    };
  }

  void showsnackbar(String data) {
    final context = globalScaffoldKey.currentContext;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(data),
      duration: Duration(seconds: 3),
    ));
  }

  void edittec(item) {
    _selectedtec.contains(item)
        ? _selectedtec.remove(item)
        : _selectedtec.add(item);
    notifyListeners();
  }

  void setnamegrouptec(Listagrupo e) {
    _nombregrupo.text = e.grupo;
    _selectedtec = e.tecnicos;
    print(_nombregrupo.text);
  }

  void adddgroup() {
    _nuevogrupo.text.isEmpty
        ? print("vacio")
        : _listgroup.add(Listagrupo(_nuevogrupo.text, [], []));
    print("Grupo agregado");
    // getlist();
    notifyListeners();
  }

  void setscreensize(screensize) {
    _screenSize = screensize;
    print(_screenSize.toString());
    notifyListeners();
  }

  void onDaySelected(DateTime day, List events, List holidays) {
    // _selectedEventos = events;
    _selectedDay = day;
    print('CALLBACK provider : _onDaySelected');
    // print(_selectedEventos);
    notifyListeners();
    getclient();
  }

  void onVisibleDaysChanged(
      DateTime first, DateTime last, CalendarFormat format) {
    print('CALLBACK: _onVisibleDaysChanged');
  }

  void onCalendarCreated(DateTime first, DateTime last, CalendarFormat format) {
    print('CALLBACK: _onCalendarCreated');
  }

  Future getclient() async {
    DateTime _start =
        DateTime(_selectedDay.year, _selectedDay.month, _selectedDay.day, 0, 0);
    DateTime _end = DateTime(
        _selectedDay.year, _selectedDay.month, _selectedDay.day, 23, 59, 59);

    print('obteniento datos');
    final snapshot = await Backend()
        .usersv1
        .where('fechainstalacion', isGreaterThanOrEqualTo: _start)
        .where('fechainstalacion', isLessThanOrEqualTo: _end)
        .get();

    await tomodel(snapshot);
    await getgroup();
    await getlist();
    notifyListeners();
  }

  Future<void> tomodel(QuerySnapshot snapshot) {
    _model = snapshot.docs.map((e) => ClientModel.fromSnapshot(e)).toList();
  }

  //Función para actualizar el grupo a los clientes seleccionados
  Future updategroups(nombre) async {
    final snapshot =
        await Backend().usersv1.where('grupo', isEqualTo: nombre).get();
    snapshot.docs.forEach((e) {
      print(e.reference.id.toString());
      updateonegroup(e.reference.id, _nombregrupo.text, selectedtec);
    });
    await getclient();
  }

  Future<void> getgroup() async {
    await Future(() {
      _totalgrupo = _model.map((e) => e.grupo).toList();
      _group = Set.from(_totalgrupo);
    });
    notifyListeners();
  }

  Future<void> getlist() async {
    await Future(() {
      _listgroup = [];
      _group.forEach((e) {
        List<ClientModel> lis = _model.where((i) => i.grupo == e).toList();
        List<String> listtecnicos = lis[0].tecnicos;
        _listgroup.add(Listagrupo(e, lis, listtecnicos));
        // print(lis);
      });
    });
    notifyListeners();
  }

  Future deleteclient(reference) async {
    final snapshot =
        await Backend().usersv1.doc(reference).delete().then((value) => null);
    notifyListeners();
  }

  Future updatecolor(String refer, String color) async {
    final users = Backend().usersv1;
    await users
        .doc("$refer")
        .update({'color': color})
        .then((value) => print("Client color actualizado"))
        .catchError((error) => print("Failes to ass user: $error"));
    showsnackbar("Color actualizado");
    getclient();
  }

  Future updateobservaciones(String refer, List<String> obser) async {
    final users = Backend().usersv1;
    await users
        .doc("$refer")
        .update({'observaciones': obser})
        .then((value) => print("Client observacione actualizado"))
        .catchError((error) => print("Failes to ass user: $error"));
    showsnackbar("Observaciones actualizado");
    getclient();
  }

  Future updatefechainst(BuildContext context, ClientModel i) async {
    final selecttime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay(
            hour: i.fechainstalacion.hour, minute: i.fechainstalacion.hour));
    if (selecttime == null) return;
    final fechainstalacion = DateTime(
      i.fechainstalacion.year,
      i.fechainstalacion.month,
      i.fechainstalacion.day,
      selecttime.hour,
      selecttime.minute,
    );

    final users = Backend().usersv1;
    await users
        .doc("${i.reference.id}")
        .update({'fechainstalacion': fechainstalacion})
        .then((value) => print("Fecha updated"))
        .catchError((error) => print("Failes to ass user: $error"));
    showsnackbar("Fecha actualizada");
    getclient();
  }

  //Función para actualizar el grupo de 01 cliente
  Future updateonegroup(String i, gp, tecnicos) async {
    final users = Backend().usersv1;
    await users
        .doc(i)
        .update({
          'grupo': gp,
          'tecnicos': tecnicos,
        })
        .then((value) => print("actualizado $i"))
        .catchError((error) => print("Failes to ass user: $error"));
  }

  void globalkey(data) {
    globalScaffoldKey = data;
  }

  void onItemReorder(int oldItemIndex, int oldListIndex, int newItemIndex,
      int newListIndex) async {
    final i = _listgroup[oldListIndex].lista[oldItemIndex].reference.id;
    var movedItem = _listgroup[oldListIndex].lista.removeAt(oldItemIndex);
    _listgroup[newListIndex].lista.insert(newItemIndex, movedItem);
    notifyListeners();
    final gp = _listgroup.elementAt(newListIndex).grupo;
    final tecnicos = _listgroup.elementAt(newListIndex).tecnicos;
    await updateonegroup(i, gp, tecnicos);
    await getclient();
  }

  void onListReorder(int oldListIndex, int newListIndex) {
    // var movedList = _contents.removeAt(oldListIndex);
    // _contents.insert(newListIndex, movedList);
  }
}
