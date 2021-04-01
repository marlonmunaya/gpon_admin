import 'package:cloud_firestore/cloud_firestore.dart';


class Backend  {
  
  CollectionReference users = FirebaseFirestore.instance.collection('user');
  CollectionReference usersv1 = FirebaseFirestore.instance.collection('userv1');
  CollectionReference utils = FirebaseFirestore.instance.collection('utils');


}
  
