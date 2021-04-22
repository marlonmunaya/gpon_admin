// import 'dart:html';

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

  // TextEditingController get counter => _counter;
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
    getclient();
  }

  void showsnackbar(BuildContext context, String data) {
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

  void getclient() async {
    print('obteniento datos');
    final snapshot = await Backend().usersv1.get();
    // .where('fecha', isGreaterThanOrEqualTo: start)
    // .where('fecha', isLessThanOrEqualTo: end)
    // .orderBy('fecha', descending: true)
    // .getDocuments();
    // _model = DocumentSnapshot.documents.map((e) => DevicesModel.fromSnapshot(e)).toList();
    _model = snapshot.docs.map((e) => ClientModel.fromSnapshot(e)).toList();
    print("Lista obtenida");
    notifyListeners();
  }

  Future updatecolor(context, String refer, String color) async {
    final users = Backend().usersv1;
    await users
        .doc("$refer")
        .update({
          'color': color,
        })
        .then((value) => print("Client color updated"))
        .catchError((error) => print("Failes to ass user: $error"));
    showsnackbar(context, "Color actualizado");
    getclient();
  }

  Future<void> addUser(fullName, company, age) {
    CollectionReference users = FirebaseFirestore.instance.collection('user');
    return users
        .add({
          'full_name': fullName, // John Doe
          'company': company, // Stokes and Sons
          'age': age
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failes to ass user: $error"));
  }
}
