import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Loginprovider with ChangeNotifier {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwdController = TextEditingController();
  TextEditingController get emailController => _emailController;
  TextEditingController get passwdController => _passwdController;

  static final _formKeysign = GlobalKey<FormState>();
  get formKeysign => _formKeysign;

  //// Estado de Autenticación///
  //// Autenticacion via email////
  bool _loggedIn = false; //colocar en false para producción.
  bool get isLoggedIn => _loggedIn;
  bool _loading = false;
  bool get isLoading => _loading;
  User _user;
  User get currentUser => _user;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  ////////User Login ///////////
  Future<void> login(BuildContext context) async {
    if (!formKeysign.currentState.validate()) return;
    formKeysign.currentState.save(); //validar campos
    _loading = true; //cargando
    /// intenta logearse con email y pass
    try {
      _user = (await _auth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwdController.text,
      ))
          .user;
      notifyListeners();
    } catch (e) {
      ///muestra popup con mensaje de error.
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Error"),
              content: Text(
                  "El usuario o contraseña ha sido mal ingresado, intente de nuevo."),
              actions: [
                ElevatedButton(
                    child: Text("Ok"),
                    onPressed: () => Navigator.of(context).pop())
              ],
            );
          });
    }

    print("========");
    print(_user.email);
    print("========");
    _loading = false;
    if (_user.email != null && _auth.currentUser != null) {
      _loggedIn = true;
    } else {
      _loggedIn = false;
      notifyListeners();
    }
  }

  Future<void> logout() async {
    await _auth.signOut();
    _loggedIn = false;
    _emailController.text = "";
    _passwdController.text = "";
    notifyListeners();
    print("Log out");
    print(_loggedIn.toString());
  }
}
