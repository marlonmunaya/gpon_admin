import 'package:cloud_firestore/cloud_firestore.dart';


class Backend  {
  
  CollectionReference users = FirebaseFirestore.instance.collection('user');
  CollectionReference utils = FirebaseFirestore.instance.collection('utils');


}
  
