import 'dart:html';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:gpon_admin/user_provider.dart';
import 'package:gpon_admin/src/popup/client_provider.dart';
import 'package:gpon_admin/calendar.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HomeProvider()),
        ChangeNotifierProvider(create: (_) => ClientProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Gpon-Clients',
        theme: ThemeData(
            primarySwatch: Colors.blue,
            // iconTheme: IconThemeData(size: 12),
            accentIconTheme: IconThemeData(size: 12),
            primaryIconTheme: IconThemeData(size: 12),
            textTheme: TextTheme(
                headline1: TextStyle(fontSize: 12.0),
                headline2: TextStyle(fontSize: 12.0),
                subtitle1: TextStyle(fontSize: 11.0),
                subtitle2: TextStyle(fontSize: 11.0),
                caption: TextStyle(fontSize: 12.0),
                bodyText1: TextStyle(fontSize: 11.0),
                bodyText2: TextStyle(fontSize: 11.0)
                // bodyText1: TextStyle(fontSize: 11.0)
                )),
        home: CalendarPage(),
      ),
    );
  }
}
