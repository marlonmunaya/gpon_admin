import 'package:drag_and_drop_lists/drag_and_drop_lists.dart';
import 'package:gpon_admin/pages/Home/creargrupo.dart';
import 'package:gpon_admin/pages/Home/listclient_builpanel.dart';

import 'package:gpon_admin/src/model/model.dart';
import 'package:gpon_admin/src/popup/popup_provider.dart';

import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:gpon_admin/pages/Home/home_provider.dart';

class DragHandleList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<DragAndDropList> contents = [];
    List<Listagrupo> listgroup = context.watch<HomeProvider>().listgroup;
    listgroup.sort((a, b) => a.grupo.compareTo(b.grupo));
    final List<ClientModel> lista = context.watch<HomeProvider>().model;
    final date = context.watch<HomeProvider>().selectedDay;

    contents = listgroup.map((e) {
      return DragAndDropList(
        header: Padding(
          padding: EdgeInsets.only(bottom: 5.0, top: 5.0),
          child: Wrap(
            children: [
              Text(e.grupo,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
              SizedBox(width: 10),
              selectedtecnicos(context, e.tecnicos),
              e.grupo.contains("Vacío") ? SizedBox() : addtecnicos(context, e),
            ],
          ),
        ),
        children: e.lista.map<DragAndDropItem>((ClientModel i) {
          return DragAndDropItem(
            child: Padding(
              padding: EdgeInsets.only(right: 30),
              child: Row(
                children: [
                  Expanded(child: BuildPanel(i)),
                ],
              ),
            ),
          );
        }).toList(),
      );
    }).toList();

    return Card(
      child: Column(
        children: [
          SizedBox(height: 5),
          Text('${date.day}-${date.month}-${date.year}',
              style: TextStyle(fontSize: 24)),
          Expanded(
              child: lista == null
                  ? Center(child: CircularProgressIndicator())
                  : context.watch<HomeProvider>().transicion
                      ? Center(child: CircularProgressIndicator())
                      : draganddroplists(context, contents)),
          Creargrupo()
        ],
      ),
    );
  }

  Widget draganddroplists(
      BuildContext context, List<DragAndDropList> contents) {
    return DragAndDropLists(
      contentsWhenEmpty: Text("Libre"),
      children: contents,
      onItemReorder: (oldItemIndex, oldListIndex, newItemIndex, newListIndex) =>
          context.read<HomeProvider>().onItemReorder(
              oldItemIndex, oldListIndex, newItemIndex, newListIndex),
      onListReorder: (oldListIndex, newListIndex) => context
          .read<HomeProvider>()
          .onListReorder(oldListIndex, newListIndex),
      listPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
      itemDivider:
          Divider(thickness: 2, height: 2, color: Colors.blueGrey[100]),
      itemDecorationWhileDragging: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
              color: Colors.grey.withOpacity(1),
              spreadRadius: 2,
              blurRadius: 3,
              offset: Offset(0, 0)),
        ],
      ),
      lastItemTargetHeight: 80,
      lastListTargetSize: 0,
      itemDragHandle: DragHandle(
        child: Padding(
          padding: EdgeInsets.only(right: 5),
          child: Icon(
            Icons.vertical_align_center_rounded,
            color: Theme.of(context).primaryColor,
          ),
        ),
      ),
    );
  }
}

Widget selectedtecnicos(BuildContext context, List<String> tecnicos) {
  return Wrap(
    spacing: 5.0,
    runSpacing: 3.0,
    children: tecnicos.map<Chip>((String a) {
      return Chip(label: Text(a));
    }).toList(),
  );
}

Widget addtecnicos(BuildContext context, Listagrupo e) {
  return InkWell(
      child: Icon(Icons.edit_attributes_rounded),
      onTap: () {
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (BuildContext context1) => tecnicos(context1, e.grupo));
        context.read<HomeProvider>().setnamegrouptec(e);
      });
}

Widget tecnicos(BuildContext context, nombre) {
  var provider = context.watch<PopupProvider>();
  List<dynamic> tec = provider.ubicaciones
      .ubicaciones[context.watch<HomeProvider>().selecteddepart]["tecnicos"];

  List<String> selectedtec = context.watch<HomeProvider>().selectedtec;
  return AlertDialog(
    title: Column(
      children: [Text("Agrega los técnicos"), _creargrupo(context)],
    ),
    content: Wrap(
      spacing: 5.0,
      runSpacing: 3.0,
      children: tec.map<FilterChip>((dynamic a) {
        bool contain = selectedtec.contains(a);
        return FilterChip(
          selected: contain,
          label: Text(a),
          checkmarkColor: contain ? Colors.white : Colors.black,
          labelStyle: TextStyle(color: contain ? Colors.white : Colors.black),
          selectedColor: Theme.of(context).primaryColor,
          onSelected: (selctd) {
            Provider.of<HomeProvider>(context, listen: false).edittec(a);
          },
        );
      }).toList(),
    ),
    actions: [_crearGuardar(context, nombre)],
  );
}

Widget _creargrupo(BuildContext context) {
  return TextField(
    controller: context.read<HomeProvider>().nombregrupo,
    decoration: InputDecoration(
      labelText: 'Grupo',
      contentPadding: EdgeInsets.fromLTRB(5, 7, 5, 5),
    ),
  );
}

Widget _crearGuardar(BuildContext context, nombre) {
  return ElevatedButton(
      child: Text('Guardar'),
      onPressed: () async {
        await context.read<HomeProvider>().updategroups(nombre);
        Navigator.of(context).pop();
        await context.read<HomeProvider>().getclient();
      });
}
