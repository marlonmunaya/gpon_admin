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
    onPressed: () async {
      await context.read<PopupProvider>().clearclient();
      context.read<PopupProvider>().setplan("RL-120");
      context.read<PopupProvider>().setplataforma("Recomendado");
      context.read<PopupProvider>().setdepartamento("Lima");
      context.read<PopupProvider>().setprovincia("Provin");
      context.read<PopupProvider>().setdistrito("Distrito");
      context.read<PopupProvider>().setvendedor("Vendedor");
      context.read<PopupProvider>().setfechacaptacion();
      context.read<PopupProvider>().setupdateguardar(false);
      await showDialog(
          context: context, builder: (BuildContext context) => EditClient());
    },
  );
}

Widget drawer() {
  return Drawer(child: Container(color: Colors.amber, child: Column()));
}
