import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gpon_admin/pages/login/login.dart';
import 'package:gpon_admin/pages/login/login_provider.dart';
import 'package:provider/provider.dart';

import 'package:gpon_admin/pages/Home/home.dart';
import 'package:gpon_admin/pages/Home/home_provider.dart';
import 'package:gpon_admin/src/popup/popup_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HomeProvider()),
        ChangeNotifierProvider(create: (_) => PopupProvider()),
        ChangeNotifierProvider(create: (_) => Loginprovider()),
      ],
      child: Consumer<Loginprovider>(builder: (context, user, _) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Gpon-Clients',
          theme: ThemeData(
              primarySwatch: Colors.blue,
              primaryIconTheme: IconThemeData(size: 12),
              textTheme: TextTheme(
                  headline1: TextStyle(fontSize: 12.0),
                  headline2: TextStyle(fontSize: 12.0),
                  subtitle1: TextStyle(fontSize: 12.0),
                  subtitle2: TextStyle(fontSize: 12.0),
                  caption: TextStyle(fontSize: 12.0),
                  bodyText1: TextStyle(fontSize: 12.0),
                  bodyText2: TextStyle(fontSize: 12.0))),
          routes: {
            '/': (BuildContext context) {
              Loginprovider state = context.watch<Loginprovider>();
              if (state.isLoggedIn) {
                return HomePage();
              } else {
                return LoginPage();
              }
            },
            'login': (BuildContext context) => LoginPage(),
          },
        );
      }),
    );
  }
}
