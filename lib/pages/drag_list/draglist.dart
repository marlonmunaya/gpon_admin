import 'dart:js';

import 'package:drag_and_drop_lists/drag_and_drop_lists.dart';
import 'package:gpon_admin/pages/Home/listclient_builpanel.dart';
import 'package:gpon_admin/pages/drag_list/draglist_provider.dart';
import 'package:gpon_admin/src/model/model.dart';
import 'package:gpon_admin/src/popup/popup_provider.dart';
import 'package:gpon_admin/src/responsive/responsive.dart';

import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:gpon_admin/pages/Home/home_provider.dart';

class DragHandleList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var backgroundColor = Color.fromARGB(255, 243, 242, 248);
    List<DragAndDropList> contents = [];
    List<Listagrupo> listgroup = context.watch<HomeProvider>().listgroup;

    contents = listgroup.map((e) {
      return DragAndDropList(
        header: Padding(
          padding: EdgeInsets.only(bottom: 8.0),
          child: Row(
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
            child: Row(
              children: [Expanded(child: BuildPanel(i)), SizedBox(width: 30)],
            ),
          );
        }).toList(),
      );
    }).toList();

    context.read<HomeProvider>().setcontent(contents);
    return DragAndDropLists(
      children: context.watch<HomeProvider>().contents,
      onItemReorder: (oldItemIndex, oldListIndex, newItemIndex, newListIndex) =>
          context.read<HomeProvider>().onItemReorder(
              oldItemIndex, oldListIndex, newItemIndex, newListIndex),
      onListReorder: (oldListIndex, newListIndex) => context
          .read<HomeProvider>()
          .onListReorder(oldListIndex, newListIndex),
      listPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      itemDivider: Divider(thickness: 2, height: 2, color: backgroundColor),
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
      lastItemTargetHeight: 10,
      listDragHandle: DragHandle(
        verticalAlignment: DragHandleVerticalAlignment.top,
        child: Padding(
          padding: EdgeInsets.only(right: 5),
          child: Icon(
            Icons.menu,
            color: Colors.black26,
          ),
        ),
      ),
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

  Widget selectedtecnicos(BuildContext context, List<String> tecnicos) {
    return Wrap(
      spacing: 5.0,
      runSpacing: 3.0,
      children: tecnicos.map<Chip>((String a) {
        return Chip(
          label: Text(a),
        );
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
    List<String> tec = context.watch<PopupProvider>().personal.tecnicos;
    List<String> selectedtec = context.watch<HomeProvider>().selectedtec;
    return AlertDialog(
      title: Column(
        children: [Text("Agrega los técnicos"), _creargrupo(context)],
      ),
      content: Wrap(
        spacing: 5.0,
        runSpacing: 3.0,
        children: tec.map<FilterChip>((String a) {
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
        });
  }
}
