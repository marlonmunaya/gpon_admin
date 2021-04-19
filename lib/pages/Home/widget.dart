import 'package:flutter/material.dart';
import 'package:gpon_admin/src/popup/popup_provider.dart';
import 'package:provider/provider.dart';
import 'package:gpon_admin/src/popup/editclient.dart';

Widget buildHolidaysMarker() {
  return Icon(
    Icons.star_border,
    size: 20.0,
    color: Colors.blueGrey[800],
  );
}

Widget floatactionbutton(BuildContext context) {
  return FloatingActionButton(
    child: Icon(Icons.person_add),
    onPressed: () {
      context.read<PopupProvider>().setplanselected("RL-120");
      context.read<PopupProvider>().setplatselected("Recomendado");
      showDialog(
          context: context, builder: (BuildContext context) => EditClient2());
    },
  );
}

Widget drawer() {
  return Drawer(
      child: Container(
    color: Colors.amber,
    child: Column(),
  ));
}
