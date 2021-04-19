import 'package:flutter/material.dart';
import 'package:gpon_admin/src/model/model.dart';
import 'package:gpon_admin/src/model/panel_model.dart';
import 'package:provider/provider.dart';
import 'package:gpon_admin/pages/Home/home_provider.dart';

class ClientList extends StatelessWidget {
  ClientList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<HomeProvider>(context);
    final List<ClientModel> lista = prov.model;
    var _screensize = MediaQuery.of(context).size;
    return Card(
      child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Text(
              '${prov.selectedDay.day}-${prov.selectedDay.month}-${prov.selectedDay.year}'),
          SizedBox(
            height: 10,
          ),
          Container(
              width: 0.68 * _screensize.width,
              height: _screensize.height - 100,
              child: lista == null
                  ? Center(child: CircularProgressIndicator())
                  : Column(
                      children: [
                        buildPanel(lista),
                      ],
                    )),
        ],
      ),
    );
  }

  Widget buildPanel(List<ClientModel> lista) {
    return ExpansionPanelList.radio(
      expandedHeaderPadding: EdgeInsets.all(0),
      initialOpenPanelValue: 2,
      elevation: 0,
      children: lista.map<ExpansionPanelRadio>((ClientModel i) {
        return ExpansionPanelRadio(
            canTapOnHeader: true,
            value: i.reference,
            headerBuilder: (BuildContext context, bool isExpanded) {
              return ListTile(
                title: Text(i.nombre),
                leading: CircleAvatar(
                  backgroundColor: Colors.red,
                  child: Container(
                    color: Colors.red,
                  ),
                ),
                trailing: Wrap(
                  spacing: 5,
                  children: [
                    Text("${i.celular}"),
                    Container(
                        width: 50,
                        child: TextField(
                          maxLines: 2,
                        ))
                  ],
                ),
                subtitle: Row(
                  children: [
                    Text("${i.fechainstalacion}"),
                  ],
                ),
              );
            },
            body: ListTile(
                title: Text(i.cedula),
                subtitle: Column(
                  children: [
                    Text('To delete this panel, tap the trash can icon'),
                  ],
                ),
                trailing: const Icon(Icons.delete),
                onTap: () {
                  // .removeWhere((Item currentItem) => item == currentItem);
                }));
      }).toList(),
    );
  }
}
