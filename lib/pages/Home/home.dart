import 'package:flutter/material.dart';
import 'package:gpon_admin/pages/Home/home_provider.dart';
import 'package:gpon_admin/pages/calendar/calendar.dart';
import 'package:provider/provider.dart';
import 'package:gpon_admin/pages/Home/listclient.dart';
import 'package:gpon_admin/pages/Home/widget.dart';
import 'package:gpon_admin/src/popup/popup_provider.dart';
import 'package:gpon_admin/src/responsive/responsive.dart';

class HomePage extends StatelessWidget {
  final GlobalKey<ScaffoldState> globalScaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    context.read<HomeProvider>().globalkey(globalScaffoldKey);
    context.read<PopupProvider>().globalkey(globalScaffoldKey);
    var _screensize = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.blueGrey[50],
        key: globalScaffoldKey,
        appBar: AppBar(
          title: Text("Administrador"),
          actions: [],
        ),
        drawer: drawer(),
        body: ResponsiveWidget(
          smallScreen: Column(children: [
            CalendarComponent(),
            Expanded(
                flex: 28,
                child:
                    Container(height: _screensize.height, child: ClientList()))
          ]),
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
