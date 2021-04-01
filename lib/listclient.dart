import 'package:flutter/material.dart';
import 'package:gpon_admin/src/model/model.dart';

// class ClientList extends StatelessWidget {
//   const ClientList({Key key}) : super(key: key);

//   final List<ClientModel> lista = prov.model;
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//             child: Container(
//                 width: 0.68 * screensize.width,
//                 height: screensize.height,
//                 child: ListView.builder(
//                   itemCount: lista.length,
//                   itemBuilder: (context, index) {
//                     return ListTile(
//                       title: Text("${lista[index].fullname}"),
//                       leading: CircleAvatar(
//                         backgroundColor: Colors.red,
//                         // child: Container(
//                         //   color: Colors.red,
//                         // ),
//                       ),
//                       trailing: Wrap(
//                         spacing: 5,
//                         children: [
//                           Text("${lista[index].fullname}"),
//                           Container(
//                               width: 50,
//                               child: TextField(
//                                 maxLines: 2,
//                               ))
//                         ],
//                       ),
//                       subtitle: Row(
//                         children: [
//                           Text("${lista[index].age}"),
//                         ],
//                       ),
//                     );
//                     // return Text("data");
//                   },
//                 )),
//           );
//   }
// }