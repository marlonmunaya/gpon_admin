import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:gpon_admin/pages/login/login_provider.dart';
import 'package:provider/provider.dart';

Widget fondo(double size, BuildContext context) {
  return Container(
      height: size,
      width: double.infinity,
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: <Color>[
        Theme.of(context).primaryColor,
        Theme.of(context).secondaryHeaderColor
      ], begin: Alignment.topLeft, end: Alignment.bottomRight)));
}

// Widget cajarosada(double height, double width) {
//   return Positioned(
//     top: -100.0,
//     child: Transform.rotate(
//       angle: 45.0,
//       child: Container(
//         height: height,
//         width: width,
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(80.0),
//           gradient: LinearGradient(
//             begin: FractionalOffset(0.0, 1.0),
//             end: FractionalOffset(1.0, 1.0),
//             colors: [
//               // Colors.brown[400],
//               // Colors.brown[600],
//               Colors.blueGrey[400],
//               Colors.blueGrey[300],
//             ],
//           ),
//         ),
//       ),
//     ),
//   );
// }

// Widget customAppbar1(BuildContext context, Widget titulo) {
//   return AppBar(
//     // Cambio para pruebas
//     //Esta es la rama de ACME
//     title: titulo,
//     actions: <Widget>[
//       PopupMenuButton(
//         onSelected: (choice) => choiceAction(choice, context),
//         icon: Icon(Icons.error),
//         itemBuilder: (BuildContext context) {
//           return Constants.choices.map((String choice) {
//             return PopupMenuItem<String>(
//               value: choice,
//               child: Text(
//                 choice,
//                 style: TextStyle(color: Theme.of(context).primaryColor),
//               ),
//             );
//           }).toList();
//         },
//       )
//     ],
//     // bottom: PreferredSize(
//     //   child: Column(
//     //     children: <Widget>[
//     //       Text(titulo, style: Theme.of(context).primaryTextTheme.title),
//     //       // SizedBox(height:15.0),
//     //     ],
//     //   ),
//     //   preferredSize: Size.fromHeight(0.0)
//     // ),
//   );
// }

// Widget header(context) {
//   User user = Provider.of<Loginprovider>(context).currentUser();
//   return UserAccountsDrawerHeader(
//     accountName: Text('${user.displayName}'),
//     accountEmail: Text('${user.email}'),
//     currentAccountPicture: CircleAvatar(
//       backgroundColor: Theme.of(context).secondaryHeaderColor,
//       // backgroundImage: NetworkImage('https://cdn.pixabay.com/photo/2012/04/13/21/07/user-33638__340.png'),
//       // backgroundImage: NetworkImage('${user.photoUrl}'),
//     ),
//   );
// }

// void choiceAction(String choice, context) {
//   if (choice == Constants.ChangeColor) {
//     // print('color');
//     // Provider.of<Userprovider>(context).switchTheme();
//   } else if (choice == Constants.Help) {
//     // if(choice == Constants.Help){
//     print('help');
//     showDialog(
//         context: context,
//         barrierDismissible: false,
//         builder: (BuildContext context) => ayudaDialog(context));
//   } else if (choice == Constants.SignOut) {
//     print('SignOut');
//     Provider.of<Loginprovider>(context).logout();
//   }
// }

// class Constants {
//   static const String ChangeColor = 'Cambiar Color';
//   static const String Help = 'Ayuda';
//   static const String SignOut = 'Salir';
//   static const List<String> choices = <String>[ChangeColor, Help, SignOut];
// }

// Widget ayudaDialog(BuildContext context) {
//   return new AlertDialog(
//     title: Text(
//       'Ayuda',
//       style: TextStyle(color: Theme.of(context).primaryColor),
//     ),
//     content: SingleChildScrollView(
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: <Widget>[
//           Text(
//               'Sigue estos pasos para poder enlazar tu dispositivo a este aplicativo:'),
//           SizedBox(height: 10.0),
//           Text('1.Tu dispositivo tiene que enviar los datos a este número'),
//           Container(
//             color: Colors.grey[300],
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: <Widget>[
//                 Text('  976453871'),
//                 IconButton(
//                   icon: Icon(Icons.content_copy),
//                   focusColor: Colors.grey,
//                   splashColor: Colors.grey,
//                   onPressed: () {
//                     Clipboard.setData(new ClipboardData(text: '976453871'));
//                   },
//                 ),
//               ],
//             ),
//           ),
//           Text('2.El mensaje tiene que seguir esta estructura'),
//           Container(
//             height: 80.0,
//             color: Colors.grey[300],
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: <Widget>[
//                 Expanded(
//                     child: Text(
//                         '-11.9603051*-77.0717579*01.01*02.02*03.03*04.04*05.05*06.06*07.07*08.08')),
//                 IconButton(
//                   icon: Icon(Icons.content_copy),
//                   focusColor: Colors.grey,
//                   splashColor: Colors.grey,
//                   onPressed: () {
//                     Clipboard.setData(new ClipboardData(
//                         text:
//                             '-11.9603051*-77.0717579*01.01*02.02*03.03*04.04*05.05*06.06*07.07*08.08'));
//                   },
//                 ),
//               ],
//             ),
//           ),
//           Text(
//               'Los datos son separados con * , el primer dato es la latitud, segundo  longitud, y sucesivamente son las variables.')
//         ],
//       ),
//     ),
//     actions: <Widget>[
//       ElevatedButton(
//           // textColor: Theme.of(context).primaryColor,
//           child: Text('Ok'),
//           onPressed: () => Navigator.of(context).pop()),
//     ],
//   );
// }
