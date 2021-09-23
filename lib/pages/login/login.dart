import 'package:gpon_admin/pages/Home/home_provider.dart';
import 'package:gpon_admin/pages/login/login_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:gpon_admin/pages/login/login_provider.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    context.read<HomeProvider>().getprofile();
    return Scaffold(
        body: Container(
      child: Consumer<Loginprovider>(
        builder: (BuildContext context, Loginprovider value, Widget child) {
          if (value.isLoading) {
            return Container(
              height: size.height * 0.5,
              child: Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                      Theme.of(context).primaryColor),
                ),
              ),
            );
          } else {
            return child;
          }
        },
        child: Stack(
          children: <Widget>[
            _crearfondo(context),
            _loginform(context),
          ],
        ),
      ),
    ));
  }

  Widget _crearfondo(context) {
    final size = MediaQuery.of(context).size;
    return Stack(
      children: <Widget>[
        fondo(size.height, context),
        Container(
          padding: EdgeInsets.only(top: 80.0),
          child: Column(
            children: <Widget>[
              Icon(
                Icons.person_pin_circle,
                color: Colors.white,
                size: 100.0,
              ),
              SizedBox(
                height: 10.0,
                width: double.infinity,
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget _loginform(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SizedBox(
            child: Container(
              height: size.height * 0.25,
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
            margin: EdgeInsets.symmetric(vertical: 20.0),
            width: size.width * 0.85,
            constraints: BoxConstraints(maxWidth: 500),
            height: 350.0,
            decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.black26,
                      blurRadius: 3.0,
                      offset: Offset(0.0, 5.0),
                      spreadRadius: 3.0)
                ],
                borderRadius: BorderRadius.circular(10.0)),
            child: Form(
              key: context.watch<Loginprovider>().formKeysign,
              child: Column(
                children: <Widget>[
                  SizedBox(height: 30.0),
                  _crearEmail(context),
                  SizedBox(height: 30.0),
                  _crearPassword(context),
                  SizedBox(height: 30.0),
                  _crearboton(context),
                  SizedBox(height: 10.0),
                ],
              ),
            ),
          ),
          ElevatedButton(child: Text('Crear cuenta'), onPressed: () {}),
        ],
      ),
    );
  }

  Widget _crearEmail(BuildContext context) {
    return TextFormField(
      controller: context.watch<Loginprovider>().emailController,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        icon: Icon(
          Icons.alternate_email,
          color: Theme.of(context).primaryColor,
        ),
        hintText: 'ejemplo@email.com',
        labelText: 'Email',
      ),
      validator: (value) {
        if (value.length < 5) {
          return 'Ingrese un correo válido';
        } else {
          return null;
        }
      },
    );
  }

  Widget _crearPassword(BuildContext context) {
    return Container(
        child: TextFormField(
            controller: context.watch<Loginprovider>().passwdController,
            decoration: InputDecoration(
              icon: Icon(
                Icons.lock_outline,
                color: Theme.of(context).primaryColor,
              ),
              labelText: 'Password',
            ),
            obscureText: true,
            validator: (value) {
              if (value.length < 6) {
                return 'Contraseña mínimo 6 caractéres';
              } else {
                return null;
              }
            }));
  }

  Widget _crearboton(BuildContext context) {
    return ElevatedButton(
        child: Container(
          width: 250,
          alignment: Alignment.center,
          child: Text(
            'Ingresar',
            style: TextStyle(color: Colors.white, fontSize: 18.0),
          ),
        ),
        onPressed: () async {
          final String operador =
              Provider.of<Loginprovider>(context, listen: false)
                  .emailController
                  .text;
          context.read<HomeProvider>().selectoperadorhome(operador);
          await context.read<Loginprovider>().login(context);
        });
  }
}
