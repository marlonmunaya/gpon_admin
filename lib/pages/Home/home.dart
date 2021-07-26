import 'package:flutter/material.dart';
import 'package:gpon_admin/pages/Home/home_provider.dart';
import 'package:gpon_admin/pages/calendar/calendar.dart';
import 'package:gpon_admin/src/popup/popup_provider.dart';
import 'package:gpon_admin/pages/login/login_provider.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:gpon_admin/pages/Home/widget.dart';
import 'package:gpon_admin/pages/drag_list/draglist.dart';
import 'package:gpon_admin/src/responsive/responsive.dart';
import 'package:gpon_admin/src/popup/editclient.dart';

class HomePage extends StatelessWidget {
  final GlobalKey<ScaffoldState> globalScaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    User user = context.watch<Loginprovider>()?.currentUser;
    String operador = user == null ? 'None' : '${user.email}';
    context.read<PopupProvider>().setoperador(operador);
    context.read<HomeProvider>().globalkey(globalScaffoldKey);
    context.read<PopupProvider>().globalkey(globalScaffoldKey);
    var _screensize = MediaQuery.of(context).size;

    return Scaffold(
        backgroundColor: Colors.blueGrey[50],
        key: globalScaffoldKey,
        appBar: appbar(context),
        drawer: drawer(context),
        body: Stack(
          children: [
            ResponsiveWidget(
              smallScreen: SingleChildScrollView(
                child: Column(children: [
                  CalendarComponent(),
                  Container(
                    height: _screensize.height,
                    child: DragHandleList(),
                  ),
                ]),
              ),
              mediumScreen: Row(
                children: [
                  Expanded(flex: 3, child: CalendarComponent()),
                  Expanded(flex: 7, child: DragHandleList())
                ],
              ),
              largeScreen: Row(
                children: [
                  Expanded(flex: 3, child: CalendarComponent()),
                  Expanded(flex: 8, child: DragHandleList())
                ],
              ),
            ),
            buildFloatingSearchBar(context),
          ],
        ),
        floatingActionButton: floatactionbutton(context, operador));
  }

  Widget floatactionbutton(BuildContext context, String operador) {
    String depart = context.watch<HomeProvider>().selecteddepart;
    return FloatingActionButton(
      child:
          Tooltip(message: "Agregar un cliente", child: Icon(Icons.person_add)),
      onPressed: () async {
        await context.read<PopupProvider>().clearclient();
        context.read<PopupProvider>().setplan("Plan");
        context.read<PopupProvider>().setplataforma("Recomendado");
        context.read<PopupProvider>().setdepartamento(depart);
        context.read<PopupProvider>().setprovincia("Provin");
        context.read<PopupProvider>().setdistrito("Distrito");
        context.read<PopupProvider>().setvendedor("Vendedor");
        context.read<PopupProvider>().setupdateguardar(false);
        await showDialog(
            context: context, builder: (BuildContext context) => EditClient());
      },
    );
  }
}
