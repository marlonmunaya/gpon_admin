import 'package:flutter/material.dart';
import 'package:gpon_admin/pages/Home/home_provider.dart';
import 'package:provider/provider.dart';
import 'package:gpon_admin/src/popup/popup_provider.dart';

class SeguimientoPage extends StatelessWidget {
  final String id;
  SeguimientoPage({this.id});
  int indexado = 0;

  @override
  Widget build(BuildContext context) {
    var seguimiento = context.watch<PopupProvider>().seguimiento?.seguimiento;
    return AlertDialog(
      title: Text(
        'Estado del servicio',
        style: TextStyle(color: Theme.of(context).primaryColor),
      ),
      content: widgetseguimiento(context, seguimiento),
      actions: [
        ElevatedButton(
            child: Text('Guardar'),
            onPressed: () {
              String color = seguimiento.values.elementAt(indexado)["color"];
              String colordec = int.parse(color, radix: 16).toString();
              String seg = seguimiento.values.elementAt(indexado)["etiqueta"];
              context.read<HomeProvider>().updatecolor(id, colordec, seg);
              Navigator.of(context).pop();
            })
      ],
    );
  }

  Widget widgetseguimiento(BuildContext context, Map seguimiento) {
    return Container(
      width: double.minPositive,
      height: seguimiento.length * 32.0,
      child: ListView.builder(
          itemCount: seguimiento.length,
          itemBuilder: (BuildContext context, int index) {
            String color = seguimiento.values.elementAt(index)["color"];
            String colors = "80" + color.substring(2); //difuminar el color
            return Padding(
              padding: const EdgeInsets.all(2.0),
              child: ChoiceChip(
                label: Text(
                  seguimiento.values.elementAt(index)['etiqueta'],
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
                elevation: 3,
                backgroundColor: Color(int.parse(colors, radix: 16)),
                selectedColor: Color(int.parse(color, radix: 16)),
                selected: indexado == index,
                onSelected: (v) {
                  context.read<PopupProvider>().setseguimientoindex(index);
                  indexado = index;
                },
              ),
            );
          }),
    );
  }
}
