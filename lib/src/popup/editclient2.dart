import 'package:flutter/material.dart';

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
          key: key,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _crearDni(),
              SizedBox(height: 5.0),
              _crearNombre(context),
              SizedBox(height: 5.0),
              _crearCelular(),
              SizedBox(height: 5.0),
              _crearplan()
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

Widget _crearCelular() {
  return TextFormField(
    scrollPadding: EdgeInsets.all(10),
    keyboardType: TextInputType.number,
    decoration: InputDecoration(
      hintText: '912-345-678',
      labelText: 'Ingresa un número',
    ),
    onSaved: (value) {},
    validator: (value) {
      if (value.length < 9) {
        return 'Ingrese el número válido';
      } else {
        return null;
      }
    },
  );
}

Widget _crearDni() {
  return Container(
    child: SizedBox(
      width: 200,
      child: TextFormField(
        scrollPadding: EdgeInsets.all(0),
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          isDense: true,
          contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 0),
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
            borderSide: const BorderSide(
              color: Colors.grey,
            ),
          ),
          prefixIcon: Icon(Icons.person),
          suffixIcon: IconButton(
              tooltip: "Buscar",
              iconSize: 20,
              padding: EdgeInsets.all(0.0),
              icon: Icon(Icons.search),
              onPressed: () {
                print("tap search");
              }),
          hintText: '12345678',
          labelText: 'DNI',
        ),
        onSaved: (value) {},
        validator: (value) {
          if (value.length < 8) {
            return 'Ingrese el número válido';
          } else {
            return null;
          }
        },
      ),
    ),
  );
}

Widget _crearplan() {
  return DropdownButton<String>(
    value: "One",
    onChanged: (String newValue) {},
    items: <String>['One', 'Two', 'Free', 'Four']
        .map<DropdownMenuItem<String>>((String value) {
      return DropdownMenuItem<String>(
        value: value,
        child: Text(value),
      );
    }).toList(),
  );
}

_crearNombre(context) {
  return TextFormField(
    scrollPadding: EdgeInsets.all(10),
    initialValue: "name",
    decoration: InputDecoration(
      labelText: 'Ingresa un nombre',
    ),
    onSaved: (value) {},
    validator: (value) {
      if (value.length < 9) {
        return 'Ingrese el número válido';
      } else {
        return null;
      }
    },
  );
}

Widget _crearGuardar(context) {
  return ElevatedButton(
    child: Text('Guardar'),
    onPressed: () {},
  );
}

Widget _cancelar(context) {
  return ElevatedButton(
      // textColor: Theme.of(context).primaryColor,
      child: Text('Cancelar'),
      onPressed: () => Navigator.of(context).pop());
}
