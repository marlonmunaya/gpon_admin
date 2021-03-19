import 'package:cloud_firestore/cloud_firestore.dart';

class DevicesModel {
  final String fullname;
  final String company;
  final double age;
  // final double sales;
  // final double var2valor;
  // final String var1name;
  // final Timestamp tiempo;
  // final DateTime time;
  // final TimeSeriesSales serie;
  // final Timestamp
  final DocumentReference reference;

  DevicesModel.fromMap(Map<String, dynamic> map, {this.reference})
      :
        // assert(map['fecha']  != null),
        // sales = map['var1valor'],
        // var2valor = map['var2valor'],
        // var1name = map['var1name'],
        // tiempo = map['fecha'],
        // time = (map['fecha']).toDate();
        fullname = map["fullname"],
        company = map["company"],
        age = map["age"];

  DevicesModel.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data(), reference: snapshot.reference);

  // String toString() => "$sales;$time\n";
}
