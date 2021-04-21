// import 'dart:js';
import 'package:flutter/material.dart';
import 'package:gpon_admin/pages/Home/home_provider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'popup_provider.dart';

class EditClient extends StatelessWidget {
  const EditClient({Key key}) : super(key: key);

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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _crearCedula(context),
                  // SizedBox(width: 10.0),
                  _crearPlataforma(context)
                ],
              ),
              SizedBox(height: 5.0),
              _crearNombre(context),
              SizedBox(height: 5.0),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _crearCelular(context),
                  SizedBox(width: 10.0),
                  _crearplan(context)
                ],
              ),
              SizedBox(height: 5.0),
              _crearFechacaptacion(context)
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

Widget _crearCedula(BuildContext context) {
  return SizedBox(
    width: 140,
    child: TextFormField(
      controller: context.read<PopupProvider>().cedula,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: 'dni/ruc/cedula',
        isDense: true,
        contentPadding: EdgeInsets.fromLTRB(5, 7, 5, 5),
        suffixIconConstraints: BoxConstraints(minHeight: 24, minWidth: 24),
        suffixIcon: GestureDetector(
          child: Tooltip(
            message: "Buscar",
            child: InkWell(
                child: Icon(Icons.search),
                onTap: () {
                  print("tap search");
                }),
          ),
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

Widget _crearPlataforma(BuildContext context) {
  return DropdownButton<String>(
    value: context.watch<PopupProvider>().plataforma,
    onChanged: (String value) =>
        context.read<PopupProvider>().setplataforma(value),
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
    controller: context.read<PopupProvider>().nombre,
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

Widget _crearCelular(BuildContext context) {
  return SizedBox(
    width: 130,
    child: TextFormField(
      controller: context.read<PopupProvider>().celular,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: 'Celular',
        isDense: true,
        contentPadding: EdgeInsets.fromLTRB(5, 7, 5, 5),
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

Widget _crearplan(BuildContext context) {
  return DropdownButton<String>(
    value: context.watch<PopupProvider>().plan,
    onChanged: (String value) => context.read<PopupProvider>().setplan(value),
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

Widget _crearFechacaptacion(BuildContext context) {
  return SizedBox(
    width: 120,
    child: TextFormField(
      controller: context.watch<PopupProvider>().fechacaptacion,
      readOnly: true,
      decoration: InputDecoration(
        labelText: 'Fecha',
        isDense: true,
        contentPadding: EdgeInsets.fromLTRB(5, 7, 5, 5),
        suffixIconConstraints: BoxConstraints(minHeight: 24, minWidth: 24),
        suffixIcon: GestureDetector(
          child: Tooltip(
            message: "Fecha",
            child: InkWell(
              child: Icon(Icons.calendar_today),
              onTap: () =>
                  context.read<PopupProvider>().pickDateDialog(context),
            ),
          ),
        ),
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
