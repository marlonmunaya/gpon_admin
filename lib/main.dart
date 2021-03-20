import 'dart:html';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:gpon_admin/user_provider.dart';
import 'package:gpon_admin/calendar.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Gpon-Clients',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: CalendarPage(),
      ),
    );
  }
}
