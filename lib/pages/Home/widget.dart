import 'package:flutter/material.dart';
import 'package:gpon_admin/pages/Home/home_provider.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:gpon_admin/src/model/model.dart';
import 'package:gpon_admin/pages/login/login_provider.dart';
import 'package:gpon_admin/src/popup/popup_provider.dart';

Widget buildHolidaysMarker() {
  return Icon(
    Icons.star_border,
    size: 20.0,
    color: Colors.blueGrey[800],
  );
}

Widget drawer(BuildContext context) {
  User user = context.watch<Loginprovider>()?.currentUser;
  return Drawer(
      child: Container(
          color: Colors.blueGrey[400],
          child: Column(
            children: [
              UserAccountsDrawerHeader(
                  accountName: Text(
                    'Operador',
                    style: TextStyle(color: Colors.white),
                  ),
                  accountEmail: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        user == null ? 'None' : '${user.email}',
                        style: TextStyle(color: Colors.white),
                      ),
                      SizedBox(
                        width: 0.0,
                      ),
                      circlebutton(
                          icon: Icons.logout,
                          color: Colors.white.value.toString(),
                          onTap: () async =>
                              await context.read<Loginprovider>().logout()),
                    ],
                  ),
                  currentAccountPicture: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Image.asset(
                      'lib/src/assets/GPON_LOGO.png',
                      width: 50.0,
                      fit: BoxFit.fitWidth,
                    ),
                  )),
              Text("1.2.5"),
              ElevatedButton(
                onPressed: () {
                  // Navigator.of(context).push(
                  // MaterialPageRoute(builder: (context) => TermPage()));
                },
                child: Text("Terminal"),
              )
            ],
          )));
}

Widget circlebutton({IconData icon, String color, Function onTap}) {
  return Container(
    height: 24,
    margin: EdgeInsets.all(2),
    child: FloatingActionButton(
      backgroundColor: Color(int.parse(color)),
      foregroundColor: Colors.black,
      onPressed: onTap,
      child: Icon(icon, size: 15),
    ),
  );
}

Widget appbar(BuildContext context) {
  return AppBar(
    title: Text("Administrador"),
    actions: [
      // IconButton(
      //   icon: Icon(Icons.search),
      //   onPressed: () {
      //     showSearch(
      //       context: context,
      //       delegate: CustomSearchDelegate(),
      //     );
      //   },
      // ),
    ],
  );
}

Widget buildFloatingSearchBar(BuildContext context) {
  List<ClientModel> model = [];
  FloatingSearchBarController barcontroller = FloatingSearchBarController();
  return FloatingSearchBar(
    hint: 'Buscar...',
    scrollPadding: const EdgeInsets.only(top: 16, bottom: 56),
    transitionDuration: const Duration(milliseconds: 300),
    transitionCurve: Curves.easeInOut,
    physics: const BouncingScrollPhysics(),
    axisAlignment: 1.0,
    openAxisAlignment: 1.0,
    width: 400,
    debounceDelay: const Duration(milliseconds: 300),
    onQueryChanged: (query) async {
      await context.read<HomeProvider>().getsearch(query);
    },
    controller: barcontroller,
    transition: CircularFloatingSearchBarTransition(),
    automaticallyImplyDrawerHamburger: false,
    actions: [
      FloatingSearchBarAction(
        showIfOpened: true,
        showIfClosed: false,
        child: CircularButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            context.read<HomeProvider>().clear();
            barcontroller.close();
          },
        ),
      ),
    ],
    builder: (context, transition) {
      final formato = context.watch<PopupProvider>().formatocompleto;
      return ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Material(
          color: Colors.white,
          elevation: 4.0,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: context.watch<HomeProvider>().searched.map((model) {
              return ListTile(
                title: Text(model.nombre),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(model.cedula),
                    Text(model.celular),
                  ],
                ),
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(formato.format(model.fechainstalacion)),
                    Text(model.departamento),
                  ],
                ),
                onTap: () {
                  context
                      .read<HomeProvider>()
                      .onDaySelected(model.fechainstalacion, [], []);
                  barcontroller.close();
                },
              );
            }).toList(),
          ),
        ),
      );
    },
  );
}
