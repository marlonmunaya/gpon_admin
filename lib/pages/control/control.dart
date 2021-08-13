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
        filter(context),
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
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Wrap(
            spacing: 4,
            runSpacing: 4,
            children: seguimiento == null
                ? [Center(child: CircularProgressIndicator())]
                : seguimiento.entries.map<Chip>((a) {
                    return Chip(
                      label: Text(
                        a.value["etiqueta"],
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      elevation: 3,
                      backgroundColor:
                          Color(int.parse(a.value["color"], radix: 16)),
                    );
                  }).toList(),
          ),
        ),
      ),
    );
  }

  Widget filter(BuildContext context) {
    List<dynamic> listdepart = context.watch<PopupProvider>().listdepart;
    return Card(
        child: listdepart == null
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ExpansionPanelList.radio(
                expandedHeaderPadding: EdgeInsets.all(0),
                elevation: 0,
                children: [
                    depart(context, listdepart),
                    area(context),
                  ]));
  }

  ExpansionPanelRadio depart(BuildContext context, List<dynamic> listdepart) {
    var provider = context.watch<HomeProvider>();

    return ExpansionPanelRadio(
      value: "321654",
      headerBuilder: (BuildContext context, bool isExpanded) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text('SELECIONAR DEPARTAMENTO:'),
            ),
          ],
        );
      },
      body: ListView.builder(
          shrinkWrap: true,
          itemCount: listdepart.length,
          itemBuilder: (context, int index) {
            return RadioListTile<String>(
                dense: true,
                title: Text(listdepart[index]),
                value: listdepart[index],
                groupValue: provider.selecteddepart,
                onChanged: provider.enabledepart
                    ? (v) {
                        context.read<HomeProvider>().filterdepartamento(v);
                      }
                    : null);
          }),
    );
  }

  ExpansionPanelRadio area(context) {
    return ExpansionPanelRadio(
        value: "11111",
        headerBuilder: (BuildContext context, bool isExpanded) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text('SELECIONAR ÁREA:'),
              ),
            ],
          );
        },
        body: Column(
          children: [Text("data")],
        ));
  }

  Widget descargar(BuildContext context) {
    var provider = Provider.of<HomeProvider>(context, listen: false);
    return ElevatedButton(
      child: Icon(Icons.download_rounded),
      onPressed: () => provider.downloaddata(),
    );
  }
}
