import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gpon_admin/src/model.dart';
import 'package:table_calendar/table_calendar.dart';

///Librerias para la conexion DB
import 'package:cloud_firestore/cloud_firestore.dart';

class UserProvider with ChangeNotifier {
  int _count = 0;
  int get count => _count;
  DateTime _selectedDay = DateTime.now();
  DateTime get selectedDay => _selectedDay;
  List<dynamic> _selectedEventos;
  List<dynamic> get selectedEventos => _selectedEventos;
  Map<DateTime, List> _eventos;
  Map<DateTime, List> get eventos => _eventos;
  List<DevicesModel> _model;
  List<DevicesModel> get model => _model;

  // TextEditingController get counter => _counter;
  void setdate() {
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
  }

  void increment() {
    _count++;
    print(_count);
    notifyListeners();
  }

  void onDaySelected(DateTime day, List events, List holidays) {
    _selectedEventos = events;
    _count++;
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

  // void getcollectionmolycop(start, end) async {
  //   print('obteniento datos');
  //   final snapshot = await FirebaseFirestore.instance
  //       .collection('users')
  //       .where('fecha', isGreaterThanOrEqualTo: start)
  //       .where('fecha', isLessThanOrEqualTo: end)
  //       .orderBy('fecha', descending: true)
  //       .getDocuments();
  //   _model =
  //       snapshot.documents.map((e) => DevicesModel.fromSnapshot(e)).toList();
  //   print(_model);
  //   notifyListeners();
  // }

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
