import 'package:flutter/material.dart';

Widget buildAboutDialog(
    {BuildContext context,
    Function submit,
    key,
    Function onSavednumero,
    Function onSavednombre,
    String name}) {
  return new AlertDialog(
    title: Text(
      'Agrega un dispositivo',
      style: TextStyle(color: Theme.of(context).primaryColor),
    ),
    content: SingleChildScrollView(
      child: Form(
        key: key,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Aquí podras agregar un dispositivo a tu cuenta'),
            _crearNombre(context, onSavednombre, name),
            SizedBox(height: 10.0),
            _crearCelular(context, onSavednumero),
            SizedBox(height: 0.0),
          ],
        ),
      ),
    ),
    actions: <Widget>[
      _cancelar(context),
      SizedBox(width: 20.0),
      _crearGuardar(context, submit),
      SizedBox(width: 10.0),
    ],
  );
}

Widget _cancelar(context) {
  return ElevatedButton(
      // textColor: Theme.of(context).primaryColor,
      child: Text('Cancelar'),
      onPressed: () => Navigator.of(context).pop());
}

Widget _crearNombre(context, Function savednombre, name) {
  return TextFormField(
    initialValue: name,
    decoration: InputDecoration(
      labelText: 'Ingresa un nombre',
    ),
    onSaved: savednombre,
    validator: (value) {
      if (value.length < 3) {
        return 'Ingrese el nombre del producto';
      } else {
        return null;
      }
    },
  );
}

Widget _crearCelular(context, savednumero) {
  return TextFormField(
    keyboardType: TextInputType.number,
    decoration: InputDecoration(
      hintText: '912-345-678',
      labelText: 'Ingresa un número',
    ),
    onSaved: savednumero,
    validator: (value) {
      if (value.length < 9) {
        return 'Ingrese el número válido';
      } else {
        return null;
      }
    },
  );
}

Widget _crearGuardar(context, submit) {
  return ElevatedButton(
    style: ButtonStyle(
        // backgroundColor: Theme.of(context).primaryColor,
        // backgroundColor: MaterialStateProperty()
        ),
    //   alignment: ),
    // textColor: Colors.white,
    child: Text('Guardar'),
    // shape: RoundedRectangleBorder(
    //       borderRadius: BorderRadius.circular(5.0)),
    onPressed: submit,
  );
}
