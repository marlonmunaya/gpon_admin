import 'dart:js';

import 'package:drag_and_drop_lists/drag_and_drop_lists.dart';
import 'package:gpon_admin/pages/Home/listclient_builpanel.dart';
import 'package:gpon_admin/src/model/model.dart';
import 'package:gpon_admin/src/popup/popup_provider.dart';
import 'package:gpon_admin/src/responsive/responsive.dart';

import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:gpon_admin/pages/Home/home_provider.dart';
import 'package:gpon_admin/pages/Home/listclient.dart';

class DragHandleExample extends StatelessWidget {
  DragHandleExample({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var backgroundColor = Color.fromARGB(255, 243, 242, 248);
    List<DragAndDropList> contents = [];
    List<Listagrupo> listgroup = context.watch<HomeProvider>().listgroup;

    listgroup.forEach((e) {
      contents.add(DragAndDropList(
        header: Padding(
          padding: EdgeInsets.only(bottom: 8.0),
          child: Row(
            children: [
              Text(e.grupo,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
              SizedBox(width: 10),
              addtecnicos(context),
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
      ));
    });
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
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 3,
              offset: Offset(0, 0)),
        ],
      ),
      lastItemTargetHeight: 55,
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

  Widget addtecnicos(BuildContext context) {
    return InkWell(
      child: Icon(Icons.group_add_rounded),
      onTap: () => showDialog(
          context: context,
          builder: (BuildContext context) => tecnicos(context)),
    );
  }

  Widget tecnicos(BuildContext context) {
    List<String> tec = context.watch<PopupProvider>().personal.tecnicos;
    return AlertDialog(
        title: Text("Agrega los técnicos"),
        content: Wrap(
          children: tec.map<Chip>((String a) {
            return Chip(
              label: Text(a),
            );
          }).toList(),
        ));
  }
}
