import 'dart:core';
import 'package:flutter/material.dart';
import 'package:gpon_admin/pages/Home/home_provider.dart';
import 'package:provider/provider.dart';
import 'popup_provider.dart';
import 'package:flutter/services.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

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
              children: <Widget>[
                Row(
                  children: [
                    Expanded(flex: 6, child: _crearCedula(context)),
                    SizedBox(width: 5.0),
                    Expanded(flex: 4, child: _crearCelular(context)),
                  ],
                ),
                _crearNombre(context),
                SizedBox(height: 5.0),
                _creardireccion(context),
                SizedBox(height: 5.0),
                Row(
                  children: [
                    _creardepartamento(context),
                    SizedBox(width: 5.0),
                    _crearprovincia(context),
                    SizedBox(width: 5.0),
                    _creardistrito(context)
                  ],
                ),
                _crearemail(context),
                SizedBox(height: 5.0),
                Row(
                  children: [
                    Expanded(flex: 6, child: _crearcordenadas(context)),
                    SizedBox(width: 5.0),
                    Expanded(flex: 4, child: _crearfijo(context)),
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
                //////////////// SERVICIOS///////////////////
                Text(
                  'Servicio',
                  style: TextStyle(color: Theme.of(context).primaryColor),
                ),
                _crearservicios(context),
                SizedBox(height: 5.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(child: _crearFechainstalacion(context)),
                    SizedBox(width: 15.0),
                    _crearplan(context),
                  ],
                ),
                SizedBox(height: 5.0),
                Row(
                  children: [
                    Expanded(child: _creardeco(context)),
                    SizedBox(width: 5.0),
                    Expanded(child: _crearrepe(context)),
                    SizedBox(width: 5.0),
                    Expanded(child: _crearutp(context))
                  ],
                ),
                SizedBox(height: 5.0),
                Row(
                  children: [
                    Expanded(flex: 7, child: _crearcajanap(context)),
                    SizedBox(width: 5.0),
                    Expanded(flex: 4, child: _crearpuerto(context))
                  ],
                ),
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
  return TextFormField(
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
  return TextFormField(
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
  );
}

Widget _crearplan(BuildContext context) {
  final provider = context.watch<PopupProvider>();
  return DropdownButton<String>(
    value: context.watch<PopupProvider>().plan,
    onChanged: (String value) => context.read<PopupProvider>().setplan(value),
    items: provider
        .ubicaciones?.ubicaciones[provider.departamento.text]['planes']
        .map<DropdownMenuItem<String>>((dynamic value) {
      return DropdownMenuItem<String>(
        value: value,
        child: Text(value),
      );
    }).toList(),
  );
}

Widget _crearFechainstalacion(BuildContext context) {
  return TextFormField(
    controller: context.watch<PopupProvider>().fechainstalacion,
    readOnly: true,
    decoration: InputDecoration(
      labelText: '*Fecha',
      isDense: true,
      contentPadding: EdgeInsets.fromLTRB(5, 7, 5, 5),
      suffixIconConstraints: BoxConstraints(minHeight: 24, minWidth: 24),
      suffixIcon: Tooltip(
        message: "Fecha",
        child: InkWell(
          child: Icon(Icons.calendar_today),
          onTap: () => context.read<PopupProvider>().pickDateDialog(context),
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
  );
}

Widget _creardireccion(BuildContext context) {
  return TextFormField(
    controller: context.watch<PopupProvider>().direccion,
    decoration: InputDecoration(
      labelText: 'Dirección',
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
  List<String> listaString = [];
  final provider = context.watch<PopupProvider>();
  final List<dynamic> lista = provider
      .ubicaciones?.ubicaciones[provider.departamento.text]['servicios'];
  listaString = lista.cast<String>();

  return TypeAheadField(
    textFieldConfiguration: TextFieldConfiguration(
      controller: provider.servicios,
      decoration: InputDecoration(
        labelText: 'Servicios',
        contentPadding: EdgeInsets.fromLTRB(5, 7, 5, 5),
      ),
    ),
    suggestionsCallback: (pattern) {
      if (pattern == '') {
        return [];
      }
      return listaString.where((option) {
        return option.toLowerCase().contains(pattern.toLowerCase());
      });
    },
    noItemsFoundBuilder: (context) => null,
    itemBuilder: (context, suggestion) => ListTile(title: Text(suggestion)),
    onSuggestionSelected: (suggestion) {
      context.read<PopupProvider>().setservicios(suggestion);
    },
  );
}

Widget _crearfijo(BuildContext context) {
  return _crearcampo(
    context.watch<PopupProvider>().fijo,
    'Fijo',
  );
}

Widget _crearutp(BuildContext context) {
  return _crearcampo(
    context.watch<PopupProvider>().cableadoutp,
    'UTP',
  );
}

Widget _creardeco(BuildContext context) {
  final provivder = context.read<PopupProvider>();
  return _crearcampoupdown(
      controller: context.watch<PopupProvider>().deco,
      label: 'Deco',
      up: () => provivder.setdeco(1),
      down: () => provivder.setdeco(-1));
}

Widget _crearrepe(BuildContext context) {
  final provivder = context.read<PopupProvider>();
  return _crearcampoupdown(
      controller: context.watch<PopupProvider>().repetidor,
      label: 'Repe',
      up: () => provivder.setrepetidor(1),
      down: () => provivder.setrepetidor(-1));
}

Widget _creardepartamento(BuildContext context) {
  final provider = context.watch<PopupProvider>();
  final providerread = context.read<PopupProvider>();
  return DropdownButton<String>(
    value: provider.departamento.text,
    onChanged: (String value) {
      providerread.setdepartamento(value);
      providerread.setprovincia("Provin");
      providerread.setdistrito("Distrito");
      providerread.setvendedor("Vendedor");
    },
    items: provider.ubicaciones.ubicaciones.entries
        .map<DropdownMenuItem<String>>((value) {
      return DropdownMenuItem<String>(
        value: value.key,
        child: Text(value.key),
      );
    }).toList(),
  );
}

Widget _crearprovincia(BuildContext context) {
  final provider = context.watch<PopupProvider>();
  return DropdownButton<String>(
    value: provider.provincia.text,
    onChanged: (String value) =>
        context.read<PopupProvider>().setprovincia(value),
    items: provider
        .ubicaciones?.ubicaciones[provider.departamento.text]['provincias']
        .map<DropdownMenuItem<String>>((dynamic value) {
      return DropdownMenuItem<String>(
        value: value,
        child: Text(value),
      );
    }).toList(),
  );
}

Widget _creardistrito(BuildContext context) {
  final provider = context.watch<PopupProvider>();
  return DropdownButton<String>(
    value: provider.distrito.text,
    onChanged: (String value) =>
        context.read<PopupProvider>().setdistrito(value),
    items: provider
        .ubicaciones?.ubicaciones[provider.departamento.text]['distritos']
        .map<DropdownMenuItem<String>>((dynamic value) {
      return DropdownMenuItem<String>(
        value: value,
        child: Text(value),
      );
    }).toList(),
  );
}

Widget _crearvendedor(BuildContext context) {
  final provider = context.watch<PopupProvider>();
  return DropdownButton<String>(
    value: provider.vendedor.text,
    onChanged: (String value) =>
        context.read<PopupProvider>().setvendedor(value),
    items: provider
        .ubicaciones?.ubicaciones[provider.departamento.text]['vendedores']
        .map<DropdownMenuItem<String>>((dynamic value) {
      return DropdownMenuItem<String>(
        value: value,
        child: Text(value),
      );
    }).toList(),
  );
}

Widget _crearcordenadas(BuildContext context) {
  return _crearcampo(
    context.watch<PopupProvider>().cordenadas,
    'Cordenadas',
  );
}

Widget _crearcajanap(BuildContext context) {
  return _crearcampo(
    context.watch<PopupProvider>().cajanap,
    'Caja NAP',
  );
}

Widget _crearpuerto(BuildContext context) {
  final provivder = context.read<PopupProvider>();
  return _crearcampoupdown(
    controller: context.watch<PopupProvider>().puerto,
    label: 'Puerto',
    up: () => provivder.setpuerto(1),
    down: () => provivder.setpuerto(-1),
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
    child: Text('Cancelar'),
    onPressed: () => Navigator.of(context).pop(),
  );
}

Widget _crearcampo(TextEditingController controller, String label) {
  return TextFormField(
    controller: controller,
    decoration: InputDecoration(
      labelText: label,
      contentPadding: EdgeInsets.fromLTRB(5, 7, 5, 5),
    ),
  );
}

Widget _crearcampoupdown(
    {TextEditingController controller,
    String label,
    Function up,
    Function down}) {
  return TextFormField(
    controller: controller,
    keyboardType: TextInputType.number,
    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
    decoration: InputDecoration(
      labelText: label,
      contentPadding: EdgeInsets.fromLTRB(5, 7, 5, 5),
      suffixIcon: Container(
        height: 4,
        child: Column(
          children: [
            Expanded(
                child: InkWell(
                    child: Icon(Icons.arrow_drop_up_outlined), onTap: up)),
            Expanded(
                child: InkWell(
                    child: Icon(Icons.arrow_drop_down_outlined), onTap: down)),
          ],
        ),
      ),
    ),
  );
}
