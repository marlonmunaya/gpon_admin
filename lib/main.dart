import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gpon_admin/pages/login/login.dart';
import 'package:gpon_admin/pages/login/login_provider.dart';
import 'package:provider/provider.dart';

import 'package:gpon_admin/pages/Home/home.dart';
import 'package:gpon_admin/pages/Home/home_provider.dart';
import 'package:gpon_admin/src/popup/popup_provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: "AIzaSyCnGwm1aFg6hvgVcZcDJSTu9an62w1kqWk",
          appId: "1:286689828550:web:8477380ad7f6b9899841c7",
          messagingSenderId: "286689828550",
          projectId: "gpon-peru"));
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
        context.read<PopupProvider>().getutils();
        context.read<HomeProvider>().getutilshome();
        return MaterialApp(
          localizationsDelegates: [
            // ... delegado[s] de localización específicos de la app aquí
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          supportedLocales: [const Locale('es')],
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
