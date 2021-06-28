import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:gpon_admin/pages/Home/home_provider.dart';
import 'package:gpon_admin/src/popup/popup_provider.dart';

class ControlPage extends StatelessWidget {
  const ControlPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(width: 8.0),
        seguimiento(context),
        SizedBox(width: 8.0),
        filterdepart(context)
      ],
    );
  }

  Widget seguimiento(BuildContext context) {
    var seguimiento = context.watch<PopupProvider>().seguimiento?.seguimiento;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: Wrap(
        spacing: 5.0,
        runSpacing: 5.0,
        children: seguimiento == null
            ? [
                Center(
                  child: CircularProgressIndicator(),
                )
              ]
            : seguimiento.entries.map<Chip>((a) {
                return Chip(
                  label: Text(
                    a.value["etiqueta"],
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  backgroundColor:
                      Color(int.parse(a.value["color"], radix: 16)),
                );
              }).toList(),
      ),
    );
  }

  Widget filterdepart(BuildContext context) {
    List<dynamic> listdepart = context.watch<PopupProvider>().listdepart;
    var provider = context.watch<HomeProvider>();
    return Card(
      child: listdepart == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Wrap(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 8, 0, 4),
                  child: Text(
                    'Seleccionar Departamento:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                ListView.builder(
                    shrinkWrap: true,
                    itemCount: listdepart.length,
                    itemBuilder: (context, int index) {
                      return RadioListTile<String>(
                          title: Text(listdepart[index]),
                          value: listdepart[index],
                          groupValue: provider.selecteddepart,
                          onChanged: provider.enabledepart
                              ? (v) {
                                  context
                                      .read<HomeProvider>()
                                      .filterdepartamento(v);
                                }
                              : null);
                    }),
              ],
            ),
    );
  }
}
