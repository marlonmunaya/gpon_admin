import 'package:flutter/material.dart';
import 'package:gpon_admin/pages/login/login_provider.dart';
import 'package:gpon_admin/src/popup/popup_provider.dart';
import 'package:provider/provider.dart';
import 'package:gpon_admin/src/popup/editclient.dart';
import 'package:firebase_auth/firebase_auth.dart';

Widget buildHolidaysMarker() {
  return Icon(
    Icons.star_border,
    size: 20.0,
    color: Colors.blueGrey[800],
  );
}

Widget floatactionbutton(BuildContext context) {
  return FloatingActionButton(
    child:
        Tooltip(message: "Agregar un cliente", child: Icon(Icons.person_add)),
    onPressed: () async {
      await context.read<PopupProvider>().clearclient();
      context.read<PopupProvider>().setplan("RL-120");
      context.read<PopupProvider>().setplataforma("Recomendado");
      context.read<PopupProvider>().setdepartamento("Lima");
      context.read<PopupProvider>().setprovincia("Provin");
      context.read<PopupProvider>().setdistrito("Distrito");
      context.read<PopupProvider>().setvendedor("Vendedor");
      context.read<PopupProvider>().setfechainstalacion();
      context.read<PopupProvider>().setupdateguardar(false);
      await showDialog(
          context: context, builder: (BuildContext context) => EditClient());
    },
  );
}

Widget drawer(BuildContext context) {
  User user = context.watch<Loginprovider>().currentUser; //habilitar
  return Drawer(
      child: Container(
          color: Colors.blueGrey[400],
          child: Column(
            children: [
              UserAccountsDrawerHeader(
                  accountName: Text(
                    'Cliente Monitor',
                    style: TextStyle(color: Colors.white),
                  ),
                  accountEmail: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        '${user.email}', //habilitar
                        // 'G',
                        style: TextStyle(color: Colors.white),
                      ),
                      SizedBox(
                        width: 0.0,
                      ),
                      circlebutton(
                          icon: Icons.logout,
                          color: Colors.white.value.toString(),
                          onTap: () async =>
                              await context.read<Loginprovider>().logout()),
                    ],
                  ),
                  currentAccountPicture: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Image.asset(
                      'lib/src/assets/GPON_LOGO.png',
                      width: 50.0,
                      fit: BoxFit.fitWidth,
                    ),
                  )),
            ],
          )));
}

Widget circlebutton({IconData icon, String color, Function onTap}) {
  return Container(
    height: 24,
    margin: EdgeInsets.all(2),
    child: FloatingActionButton(
      backgroundColor: Color(int.parse(color)),
      foregroundColor: Colors.black,
      onPressed: onTap,
      child: Icon(icon, size: 15),
    ),
  );
}
