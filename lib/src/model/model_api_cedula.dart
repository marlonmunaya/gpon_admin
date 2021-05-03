import 'package:flutter/material.dart';

class Cedula {
  final int cedula;
  final int id;
  final String status;

  Cedula({@required this.cedula, @required this.id, @required this.status});

  factory Cedula.fromJson(Map<String, dynamic> json) {
    return Cedula(
      cedula: json['userId'],
      id: json['id'],
      status: json['title'],
    );
  }
}
