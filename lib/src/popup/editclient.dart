// import 'dart:js';
import 'package:flutter/material.dart';
import 'package:gpon_admin/pages/Home/home_provider.dart';
import 'package:provider/provider.dart';
import 'popup_provider.dart';

class EditClient extends StatelessWidget {
  const EditClient({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: 500),
      child: AlertDialog(
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
                _crearservicios(context),
                SizedBox(height: 5.0),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _crearCedula(context),
                    SizedBox(width: 10.0),
                    _crearplan(context)
                  ],
                ),
                _crearNombre(context),
                SizedBox(height: 5.0),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _crearCelular(context),
                    SizedBox(width: 10.0),
                    _crearfijo(context),
                  ],
                ),
                SizedBox(height: 5.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _crearPlataforma(context),
                    _crearvendedor(context)
                  ],
                ),
                _crearFechainstalacion(context),
                SizedBox(height: 5.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [_creardeco(context), _crearutp(context)],
                ),
                _creardireccion(context),
                SizedBox(height: 5.0),
                Row(
                  children: [
                    _creardepartamento(context),
                    SizedBox(width: 5.0),
                    context.watch<PopupProvider>().departamento.text == "Lima"
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              _crearprovincialima(context),
                              SizedBox(width: 5.0),
                              _creardistritoslima(context)
                            ],
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              _crearprovinciacusco(context),
                              SizedBox(width: 5.0),
                              _creardistritoscusco(context)
                            ],
                          ),
                  ],
                ),
                SizedBox(height: 5.0),
                _crearemail(context),
                SizedBox(height: 5.0),
                _crearcordenadas(context),
                SizedBox(height: 5.0),
                _crearcajanap(context),
                SizedBox(height: 5.0),
                _crearpuerto(context)
              ],
            ),
          ),
        ),
        actions: <Widget>[
          _cancelar(context),
          SizedBox(width: 10.0),
          _crearGuardar(context),
          SizedBox(width: 10.0)
        ],
      ),
    );
  }
}

Widget _crearCedula(BuildContext context) {
  final cedula = context.watch<PopupProvider>().cedula;
  return SizedBox(
    width: 140,
    child: TextFormField(
      controller: cedula,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: '*dni/ruc/cedula',
        isDense: true,
        contentPadding: EdgeInsets.fromLTRB(5, 7, 5, 5),
        suffixIconConstraints: BoxConstraints(minHeight: 24, minWidth: 24),
        suffixIcon: GestureDetector(
            child: Tooltip(
          message: "Buscar",
          child: InkWell(
            child: Icon(Icons.search),
            onTap: () => context.read<PopupProvider>().getcedula(cedula.text),
          ),
        )),
      ),
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
    controller: context.watch<PopupProvider>().nombre,
    decoration: InputDecoration(
      labelText: '*Nombre completo',
      contentPadding: EdgeInsets.fromLTRB(5, 7, 5, 5),
    ),
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
      controller: context.watch<PopupProvider>().celular,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: '*Celular',
        isDense: true,
        contentPadding: EdgeInsets.fromLTRB(5, 7, 5, 5),
      ),
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

Widget _crearFechainstalacion(BuildContext context) {
  return SizedBox(
    width: 150,
    child: TextFormField(
      controller: context.watch<PopupProvider>().fechainstalacion,
      readOnly: true,
      decoration: InputDecoration(
        labelText: '*Fecha',
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

Widget _creardireccion(BuildContext context) {
  return TextFormField(
    controller: context.watch<PopupProvider>().direccion,
    decoration: InputDecoration(
      labelText: 'Direccion',
      contentPadding: EdgeInsets.fromLTRB(5, 7, 5, 5),
    ),
  );
}

Widget _crearemail(BuildContext context) {
  return TextFormField(
    controller: context.watch<PopupProvider>().email,
    decoration: InputDecoration(
      labelText: 'Email',
      contentPadding: EdgeInsets.fromLTRB(5, 7, 5, 5),
    ),
  );
}

Widget _crearservicios(BuildContext context) {
  return TextFormField(
    controller: context.watch<PopupProvider>().servicios,
    decoration: InputDecoration(
      labelText: 'Servicios',
      contentPadding: EdgeInsets.fromLTRB(5, 7, 5, 5),
    ),
  );
}

Widget _crearfijo(BuildContext context) {
  return SizedBox(
    width: 100,
    child: TextFormField(
      controller: context.watch<PopupProvider>().fijo,
      decoration: InputDecoration(
        labelText: 'Fijo',
        contentPadding: EdgeInsets.fromLTRB(5, 7, 5, 5),
      ),
    ),
  );
}

Widget _crearutp(BuildContext context) {
  return SizedBox(
    width: 100,
    child: TextFormField(
      controller: context.watch<PopupProvider>().cableadoutp,
      decoration: InputDecoration(
        labelText: 'UTP',
        contentPadding: EdgeInsets.fromLTRB(5, 7, 5, 5),
      ),
    ),
  );
}

Widget _creardeco(BuildContext context) {
  return SizedBox(
    width: 100,
    child: TextFormField(
      controller: context.watch<PopupProvider>().deco,
      decoration: InputDecoration(
        labelText: 'Decodificador',
        contentPadding: EdgeInsets.fromLTRB(5, 7, 5, 5),
      ),
    ),
  );
}

Widget _creardepartamento(BuildContext context) {
  return DropdownButton<String>(
    value: context.watch<PopupProvider>().departamento.text,
    onChanged: (String value) =>
        context.read<PopupProvider>().setdepartamento(value),
    items: context
        .watch<PopupProvider>()
        .ubicaciones
        .departamentos
        .map<DropdownMenuItem<String>>((String value) {
      return DropdownMenuItem<String>(
        value: value,
        child: Text(value),
      );
    }).toList(),
  );
}

Widget _crearprovincialima(BuildContext context) {
  return DropdownButton<String>(
    value: context.watch<PopupProvider>().provincia.text,
    onChanged: (String value) =>
        context.read<PopupProvider>().setprovincia(value),
    items: context
        .watch<PopupProvider>()
        .ubicaciones
        .limaprovincias
        .map<DropdownMenuItem<String>>((String value) {
      return DropdownMenuItem<String>(
        value: value,
        child: Text(value),
      );
    }).toList(),
  );
}

Widget _crearprovinciacusco(BuildContext context) {
  return DropdownButton<String>(
    value: context.watch<PopupProvider>().provincia.text,
    onChanged: (String value) =>
        context.read<PopupProvider>().setprovincia(value),
    items: context
        .watch<PopupProvider>()
        .ubicaciones
        .cuscoprovincias
        .map<DropdownMenuItem<String>>((String value) {
      return DropdownMenuItem<String>(
        value: value,
        child: Text(value),
      );
    }).toList(),
  );
}

Widget _creardistritoslima(BuildContext context) {
  return DropdownButton<String>(
    value: context.watch<PopupProvider>().distrito.text,
    onChanged: (String value) =>
        context.read<PopupProvider>().setdistrito(value),
    items: context
        .watch<PopupProvider>()
        .ubicaciones
        .limadistritos
        .map<DropdownMenuItem<String>>((String value) {
      return DropdownMenuItem<String>(
        value: value,
        child: Text(value),
      );
    }).toList(),
  );
}

Widget _creardistritoscusco(BuildContext context) {
  return DropdownButton<String>(
    value: context.watch<PopupProvider>().distrito.text,
    onChanged: (String value) =>
        context.read<PopupProvider>().setdistrito(value),
    items: context
        .watch<PopupProvider>()
        .ubicaciones
        .cuscodistritos
        .map<DropdownMenuItem<String>>((String value) {
      return DropdownMenuItem<String>(
        value: value,
        child: Text(value),
      );
    }).toList(),
  );
}

Widget _crearvendedor(BuildContext context) {
  return DropdownButton<String>(
    value: context.watch<PopupProvider>().vendedor.text,
    onChanged: (String value) =>
        context.read<PopupProvider>().setvendedor(value),
    items: context
        .watch<PopupProvider>()
        .vendedores
        .vendedores
        .map<DropdownMenuItem<String>>((String value) {
      return DropdownMenuItem<String>(
        value: value,
        child: Text(value),
      );
    }).toList(),
  );
}

Widget _crearcordenadas(BuildContext context) {
  return TextFormField(
    controller: context.watch<PopupProvider>().cordenadas,
    decoration: InputDecoration(
      labelText: 'Cordenadas',
      contentPadding: EdgeInsets.fromLTRB(5, 7, 5, 5),
    ),
  );
}

Widget _crearcajanap(BuildContext context) {
  return TextFormField(
    controller: context.watch<PopupProvider>().cajanap,
    decoration: InputDecoration(
      labelText: 'Caja NAP',
      contentPadding: EdgeInsets.fromLTRB(5, 7, 5, 5),
    ),
  );
}

Widget _crearpuerto(BuildContext context) {
  return TextFormField(
    controller: context.watch<PopupProvider>().puerto,
    decoration: InputDecoration(
      labelText: 'Puerto',
      contentPadding: EdgeInsets.fromLTRB(5, 7, 5, 5),
    ),
  );
}

Widget _crearGuardar(BuildContext context) {
  return ElevatedButton(
      child: Text('Guardar'),
      onPressed: () async {
        await context.read<PopupProvider>().guardar(context);
        context.read<HomeProvider>().getclient();
      });
}

Widget _cancelar(context) {
  return ElevatedButton(
      // textColor: Theme.of(context).primaryColor,
      child: Text('Cancelar'),
      onPressed: () async {
        Navigator.of(context).pop();
      });
}
