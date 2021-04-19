import 'dart:js';

import 'package:flutter/material.dart';
import 'package:gpon_admin/pages/Home/home_provider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'popup_provider.dart';

class EditClient2 extends StatelessWidget {
  const EditClient2({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Datos de Cliente',
        style: TextStyle(color: Theme.of(context).primaryColor),
      ),
      content: SingleChildScrollView(
        child: Form(
          key: context.watch<PopupProvider>().formKeysign,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _crearDni(context),
                  SizedBox(width: 10.0),
                  _crearPlataforma(context)
                ],
              ),
              SizedBox(height: 5.0),
              _crearNombre(context),
              SizedBox(height: 5.0),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _crearCelular(context),
                  SizedBox(width: 10.0),
                  _crearplan(context)
                ],
              ),
              SizedBox(height: 5.0),
              _crearFecha(context)
            ],
          ),
        ),
      ),
      actions: <Widget>[
        _cancelar(context),
        SizedBox(width: 10.0),
        _crearGuardar(context),
        SizedBox(width: 10.0),
      ],
    );
  }
}

Widget _crearCelular(BuildContext context) {
  return SizedBox(
    width: 130,
    child: TextFormField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: 'Celular',
        isDense: true,
        prefixIcon: Icon(Icons.smartphone),
        contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 0),
      ),
      onSaved: (value) {
        context.read<PopupProvider>().setcell(value);
      },
      validator: (value) {
        if (value.length < 9) {
          return 'Ingrese un número válido';
        } else {
          return null;
        }
      },
    ),
  );
}

Widget _crearFecha(BuildContext context) {
  return SizedBox(
    width: 120,
    child: TextFormField(
      controller: context.watch<PopupProvider>().dateCtl,
      readOnly: true,
      decoration: InputDecoration(
        labelText: 'Fecha',
        isDense: true,
        contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 0),
        suffixIcon: IconButton(
            tooltip: "Fecha",
            iconSize: 20,
            padding: EdgeInsets.all(0.0),
            icon: Icon(Icons.calendar_today),
            onPressed: () =>
                context.read<PopupProvider>().pickDateDialog(context)),
      ),
      onSaved: (value) {},
      validator: (value) {
        if (value.length < 9) {
          return 'Ingrese una Fecha válida';
        } else {
          return null;
        }
      },
    ),
  );
}

Widget _crearDni(BuildContext context) {
  return SizedBox(
    width: 160,
    child: TextFormField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: 'DNI/RUC/CEDULA',
        prefixIcon: Icon(Icons.person),
        isDense: true,
        contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 0),
        suffixIcon: Container(
          child: IconButton(
              tooltip: "Buscar",
              iconSize: 20,
              padding: EdgeInsets.all(0.0),
              icon: Icon(Icons.search),
              onPressed: () {
                print("tap search");
              }),
        ),
      ),
      onSaved: (value) {
        context.read<PopupProvider>().setcedula(value);
      },
      validator: (value) {
        if (value.length < 6) {
          return 'Ingrese número válido, min 6 caract';
        } else {
          return null;
        }
      },
    ),
  );
}

Widget _crearplan(BuildContext context) {
  return DropdownButton<String>(
    value: context.watch<PopupProvider>().planselected,
    onChanged: (String value) =>
        context.read<PopupProvider>().setplanselected(value),
    items: context
        .watch<PopupProvider>()
        .planes
        .planes
        .map<DropdownMenuItem<String>>((String value) {
      return DropdownMenuItem<String>(
        value: value,
        child: Text(value),
      );
    }).toList(),
  );
}

Widget _crearPlataforma(BuildContext context) {
  return DropdownButton<String>(
    value: context.watch<PopupProvider>().platselected,
    onChanged: (String value) =>
        context.read<PopupProvider>().setplatselected(value),
    items: context
        .watch<PopupProvider>()
        .plataformas
        .plataforma
        .map<DropdownMenuItem<String>>((String value) {
      return DropdownMenuItem<String>(
        value: value,
        child: Text(value),
      );
    }).toList(),
  );
}

Widget _crearNombre(BuildContext context) {
  return TextFormField(
    decoration: InputDecoration(
      labelText: 'Nombre completo',
      contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 0),
    ),
    onSaved: (value) {
      context.read<PopupProvider>().setnombre(value);
    },
    validator: (value) {
      if (value.length < 5) {
        return 'Ingrese nombre válido, min 5 carac';
      } else {
        return null;
      }
    },
  );
}

Widget _crearGuardar(BuildContext context) {
  return ElevatedButton(
    child: Text('Guardar'),
    onPressed: () {
      context.read<PopupProvider>().guardar(context);
      context.read<HomeProvider>().getclient();
    },
  );
}

Widget _cancelar(context) {
  return ElevatedButton(
      // textColor: Theme.of(context).primaryColor,
      child: Text('Cancelar'),
      onPressed: () => Navigator.of(context).pop());
}
