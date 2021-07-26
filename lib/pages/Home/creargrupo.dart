import 'package:flutter/material.dart';
import 'package:gpon_admin/pages/Home/home_provider.dart';
import 'package:provider/provider.dart';

class Creargrupo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: "Agregar un nuevo grupo",
      child: InkWell(
          child: Icon(Icons.add_box_outlined),
          onTap: () => showDialog(
              context: context,
              builder: (BuildContext context1) => alertgrupo(context1))),
    );
  }

  Widget alertgrupo(BuildContext context) {
    return AlertDialog(
      title: Text("Agregar un nuevo grupo"),
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
