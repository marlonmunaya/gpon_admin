import 'package:flutter/material.dart';
import 'package:gpon_admin/pages/calendar/calendar.dart';

import 'package:gpon_admin/pages/Home/listclient.dart';
import 'package:gpon_admin/pages/Home/widget.dart';
import 'package:gpon_admin/src/responsive/responsive.dart';

class HomePage extends StatelessWidget {
  GlobalKey<ScaffoldState> globalScaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return Scaffold(
        backgroundColor: Colors.blueGrey[50],
        key: globalScaffoldKey,
        appBar: AppBar(
          title: Text("Administrador"),
          actions: [],
        ),
        drawer: drawer(),
        body: ResponsiveWidget(
          smallScreen: Column(children: [CalendarComponent(), ClientList()]),
          mediumScreen: Row(
            children: [
              Expanded(flex: 3, child: CalendarComponent()),
              Expanded(flex: 7, child: ClientList())
            ],
          ),
          largeScreen: Row(
            children: [
              Expanded(flex: 3, child: CalendarComponent()),
              Expanded(flex: 8, child: ClientList())
            ],
          ),
        ),
        floatingActionButton: floatactionbutton(context));
  }
}
