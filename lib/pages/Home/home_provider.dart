import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:drag_and_drop_lists/drag_and_drop_lists.dart';

import 'package:gpon_admin/src/api/data.dart';
import 'package:gpon_admin/src/model/model.dart';
import 'package:table_calendar/table_calendar.dart';

///Librerias para la conexion DB
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeProvider with ChangeNotifier {
  Size _screenSize;
  Size get screenSize => _screenSize;
  DateTime _selectedDay;
  DateTime get selectedDay => _selectedDay;
  CalendarController _calendarController;
  CalendarController get calendarController => _calendarController;
  List<dynamic> _selectedEventos;
  List<dynamic> get selectedEventos => _selectedEventos;
  Map<DateTime, List> _eventos;
  Map<DateTime, List> get eventos => _eventos;
  Map<DateTime, List> _holidays;
  Map<DateTime, List> get holidays => _holidays;
  List<ClientModel> _model;
  List<ClientModel> get model => _model;
  GlobalKey<ScaffoldState> globalScaffoldKey;
  Set<String> _group;
  Set<String> get group => _group;
  List<String> _totalgrupo = [];
  List<DragAndDropList> _contents = [];
  List<DragAndDropList> get contents => _contents;
  List<Listagrupo> _listgroup = [];
  List<Listagrupo> get listgroup => _listgroup;
  void setdate() {
    _selectedDay = DateTime.now();
    _eventos = {
      _selectedDay.subtract(Duration(days: 16)): ['Event A3', 'Event B3'],
      _selectedDay.subtract(Duration(days: 10)): [
        'Event A4',
        'Event B4',
        'Event C4'
      ],
      _selectedDay.subtract(Duration(days: 4)): [
        'Event A5',
        'Event B5',
        'Event C5'
      ],
      _selectedDay.subtract(Duration(days: 2)): ['Event A6', 'Event B6'],
      _selectedDay: ['Event A7', 'Event B7', 'Event C7'],
      _selectedDay.add(Duration(days: 1)): [
        'Event A8',
        'Event B8',
        'Event C8',
        'Event D8'
      ],
    };
    _selectedEventos = _eventos[_selectedDay] ?? [];
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

  void setscreensize(screensize) {
    _screenSize = screensize;
    print(_screenSize.toString());
    notifyListeners();
  }

  void onDaySelected(DateTime day, List events, List holidays) {
    _selectedEventos = events;
    _selectedDay = day;
    print('CALLBACK provider : _onDaySelected');
    print(_selectedEventos);
    notifyListeners();
  }

  void onVisibleDaysChanged(
      DateTime first, DateTime last, CalendarFormat format) {
    print('CALLBACK: _onVisibleDaysChanged');
  }

  void onCalendarCreated(DateTime first, DateTime last, CalendarFormat format) {
    print('CALLBACK: _onCalendarCreated');
  }

  Future getclient() async {
    print('obteniento datos');
    final snapshot = await Backend().usersv1.get();
    // .where('fecha', isGreaterThanOrEqualTo: start)
    // .where('fecha', isLessThanOrEqualTo: end)
    // .orderBy('fecha', descending: true)
    // .getDocuments();
    // _model = DocumentSnapshot.documents.map((e) => DevicesModel.fromSnapshot(e)).toList();
    await tomodel(snapshot);
    // await getgroup(); // _model = snapshot.docs.map((e) => ClientModel.fromSnapshot(e)).toList();
    await getgroup();
    await getlist();
    notifyListeners();
  }

  Future<void> tomodel(QuerySnapshot snapshot) {
    _model = snapshot.docs.map((e) => ClientModel.fromSnapshot(e)).toList();
  }

  Future<void> getgroup() async {
    await Future(() {
      _model.forEach((e) {
        _totalgrupo.add(e.grupo);
      });
      _group = Set.from(_totalgrupo);
      // getlist();
    });
    notifyListeners();
  }

  Future<void> getlist() async {
    await Future(() {
      _listgroup = [];
      _group.forEach((e) {
        List<ClientModel> lis = _model.where((i) => i.grupo == e).toList();
        _listgroup.add(Listagrupo(e, lis));
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
        .update({
          'color': color,
        })
        .then((value) => print("Client color updated"))
        .catchError((error) => print("Failes to ass user: $error"));
    showsnackbar("Color actualizado");
    getclient();
  }

  void updateobservacion(String i, obs) async {
    final users = Backend().usersv1;
    await users
        .doc(i)
        .update({
          'observacion': obs,
        })
        .then((value) => showsnackbar("Obervacion actualizada"))
        .catchError((error) => print("Failes to ass user: $error"));
    await getclient();
  }

  void updategroup(String i, gp) async {
    final users = Backend().usersv1;
    await users
        .doc(i)
        .update({
          'grupo': gp,
        })
        .then((value) => showsnackbar("grupo actualizado"))
        .catchError((error) => print("Failes to ass user: $error"));
    await getclient();
  }

  void globalkey(data) {
    globalScaffoldKey = data;
  }

  void onItemReorder(
      int oldItemIndex, int oldListIndex, int newItemIndex, int newListIndex) {
    final i = _listgroup[oldListIndex].lista[oldItemIndex].reference.id;
    final gp = _listgroup.elementAt(newListIndex).grupo;
    print(i);
    print(gp);
    updategroup(i, gp);
  }

  void onListReorder(int oldListIndex, int newListIndex) {
    var movedList = _contents.removeAt(oldListIndex);
    _contents.insert(newListIndex, movedList);
  }

  void setcontent(List<DragAndDropList> data) {
    _contents = data;
    // _listgroup = [];
  }
}
