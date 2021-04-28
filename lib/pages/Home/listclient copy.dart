import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:gpon_admin/pages/drag_list/draglist.dart';
import 'package:gpon_admin/src/model/model.dart';
import 'package:gpon_admin/pages/Home/home_provider.dart';
import 'package:gpon_admin/src/responsive/responsive.dart';

class ClientListCopy extends StatelessWidget {
  ClientListCopy({Key key}) : super(key: key);
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
          SizedBox(height: 10),
          Text('${date.day}-${date.month}-${date.year}',
              style: TextStyle(fontSize: 24)),
          SizedBox(height: 10),
          Container(
              width: ResponsiveWidget.isSmallScreen(context)
                  ? _screensize.width
                  : 0.68 * _screensize.width,
              child: lista == null
                  ? Center(child: CircularProgressIndicator())
                  : SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                            height: 900,
                            child: DragHandleExample(),
                          )
                        ],
                      ),
                    )),
        ],
      ),
    );
  }
}
