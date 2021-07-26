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
        SizedBox(height: 8.0),
        seguimiento(context),
        SizedBox(height: 8.0),
        filterdepart(context),
        SizedBox(height: 8.0),
        descargar(context)
      ],
    );
  }

  Widget seguimiento(BuildContext context) {
    var seguimiento = context.watch<PopupProvider>().seguimiento?.seguimiento;
    return Container(
      width: double.maxFinite,
      child: Card(
        child: Wrap(
          spacing: 2.5,
          runSpacing: 2.5,
          children: seguimiento == null
              ? [Center(child: CircularProgressIndicator())]
              : seguimiento.entries.map<Padding>((a) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2.5),
                    child: Chip(
                      label: Text(
                        a.value["etiqueta"],
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      backgroundColor:
                          Color(int.parse(a.value["color"], radix: 16)),
                    ),
                  );
                }).toList(),
        ),
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
            : ExpansionPanelList.radio(
                expandedHeaderPadding: EdgeInsets.zero,
                elevation: 0,
                children: [
                    ExpansionPanelRadio(
                      value: "321654",
                      headerBuilder: (BuildContext context, bool isExpanded) {
                        return Text(
                          'SELECIONAR DEPARTAMENTO:',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        );
                      },
                      body: ListView.builder(
                          padding: EdgeInsets.all(0),
                          shrinkWrap: true,
                          itemCount: listdepart.length,
                          itemBuilder: (context, int index) {
                            return RadioListTile<String>(
                                contentPadding: EdgeInsets.all(0),
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
                    ),
                  ]));
  }

  Widget descargar(BuildContext context) {
    return ElevatedButton(
      child: Icon(Icons.download_rounded),
      onPressed: () =>
          Provider.of<HomeProvider>(context, listen: false).downloaddata(),
    );
  }
}
