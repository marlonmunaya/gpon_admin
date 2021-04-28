import 'package:drag_and_drop_lists/drag_and_drop_lists.dart';
import 'package:gpon_admin/src/model/model.dart';

import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:gpon_admin/pages/Home/home_provider.dart';

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
          padding: EdgeInsets.only(left: 8, bottom: 4),
          child: Text('Header ${e.grupo}',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        ),
        children: e.lista.map<DragAndDropItem>((ClientModel i) {
          return DragAndDropItem(
            child: Row(
              children: [
                Padding(
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                    child: Text(i.nombre)),
              ],
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
      listInnerDecoration: BoxDecoration(
        color: Theme.of(context).canvasColor,
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
      lastItemTargetHeight: 8,
      addLastItemTargetHeightToTop: true,
      lastListTargetSize: 40,
      listDragHandle: DragHandle(
        verticalAlignment: DragHandleVerticalAlignment.top,
        child: Padding(
          padding: EdgeInsets.only(right: 10),
          child: Icon(
            Icons.menu,
            color: Colors.black26,
          ),
        ),
      ),
      itemDragHandle: DragHandle(
        child: Padding(
          padding: EdgeInsets.only(right: 10),
          child: Icon(
            Icons.menu,
            color: Colors.blueGrey,
          ),
        ),
      ),
    );
  }
}
