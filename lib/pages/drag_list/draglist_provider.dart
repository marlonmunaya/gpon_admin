import 'package:flutter/material.dart';

class DragListProvider with ChangeNotifier {
  void drag() {
    notifyListeners();
  }
}

// void main() {

//   List array=["","","g0","g0","g0","g1","g1","g1","g3","g1","g1","g1","g3","g7","g7","g7"];
//  Set dif = Set.from(array);
//  print(dif);
//  List numberSet = [];
//  dif.forEach ((a) {
//    int sumador=0;
//    array.forEach((e){
//      if(a== e){
//        sumador += 1 ;
//     }
//   });
//    numberSet.add(sumador);
//    print(numberSet);
//  });
// }
