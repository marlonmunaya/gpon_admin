import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:gpon_admin/pages/drag_list/draglist.dart';
import 'package:gpon_admin/src/model/model.dart';
import 'package:gpon_admin/pages/Home/home_provider.dart';

class ClientList extends StatelessWidget {
  ClientList({Key key}) : super(key: key);
  final Color currentColor = Colors.lightGreen[300];
  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<HomeProvider>(context);
    final List<ClientModel> lista = prov.model;
    var _screensize = MediaQuery.of(context).size;
    final date = context.watch<HomeProvider>().selectedDay;

    return Card(
      child: Column(
        children: [
          SizedBox(height: 5),
          Text('${date.day}-${date.month}-${date.year}',
              style: TextStyle(fontSize: 24)),
          lista == null
              ? Center(child: CircularProgressIndicator())
              : Expanded(child: DragHandleList()),
          addgrupo(context),
        ],
      ),
    );
  }

  Widget addgrupo(BuildContext context) {
    return InkWell(
        child: Icon(Icons.add_box_outlined),
        onTap: () {
          showDialog(
              context: context,
              builder: (BuildContext context1) => alertgrupo(context1));
        });
  }

  Widget alertgrupo(BuildContext context) {
    return AlertDialog(
      title: Text("Agrega un nuevo grupo"),
      content: _creargrupo(context),
      actions: [_crearGuardar(context)],
    );
  }

  Widget _creargrupo(BuildContext context) {
    return TextField(
      controller: context.read<HomeProvider>().nuevogrupo,
      decoration: InputDecoration(
        labelText: 'Grupo',
        contentPadding: EdgeInsets.fromLTRB(5, 7, 5, 5),
      ),
    );
  }

  Widget _crearGuardar(BuildContext context) {
    return ElevatedButton(
        child: Text('Agregar'),
        onPressed: () async {
          context.read<HomeProvider>().adddgroup();
          Navigator.of(context).pop();
        });
  }
}
