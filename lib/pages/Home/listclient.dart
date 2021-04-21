import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:gpon_admin/src/model/model.dart';
import 'package:gpon_admin/src/popup/editclient.dart';
import 'package:gpon_admin/src/popup/popup_provider.dart';
import 'package:provider/provider.dart';
import 'package:gpon_admin/pages/Home/home_provider.dart';
import 'package:gpon_admin/src/responsive/responsive.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:o_color_picker/o_color_picker.dart';

class ClientList extends StatelessWidget {
  ClientList({Key key}) : super(key: key);
  final Color currentColor = Colors.lightGreen[300];
  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<HomeProvider>(context);
    final List<ClientModel> lista = prov.model;
    var _screensize = MediaQuery.of(context).size;
    final date = prov.selectedDay;
    return Card(
      child: Column(
        children: [
          SizedBox(height: 10),
          Text(
            '${date.day}-${date.month}-${date.year}',
            style: TextStyle(fontSize: 24),
          ),
          SizedBox(height: 10),
          Container(
              width: ResponsiveWidget.isSmallScreen(context)
                  ? _screensize.width
                  : 0.68 * _screensize.width,
              height: _screensize.height - 100,
              child: lista == null
                  ? Center(child: CircularProgressIndicator())
                  : SingleChildScrollView(
                      child: Column(
                        children: [
                          buildPanel(context, lista),
                        ],
                      ),
                    )),
        ],
      ),
    );
  }

  Widget buildPanel(context, List<ClientModel> lista) {
    return ExpansionPanelList.radio(
      expandedHeaderPadding: EdgeInsets.all(0),
      initialOpenPanelValue: 2,
      elevation: 0,
      children: lista.map<ExpansionPanelRadio>((ClientModel i) {
        final desctl = TextEditingController();
        desctl.text = i.observacion;
        return ExpansionPanelRadio(
            backgroundColor:
                i.color.isEmpty ? Colors.white60 : Color(int.parse(i.color)),
            canTapOnHeader: true,
            value: i.reference,
            headerBuilder: (BuildContext context, bool isExpanded) {
              return ListTile(
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    styledrop(context, Icons.smartphone, i.celular),
                    styledrop(context, Icons.account_circle, i.nombre),
                    styledrop(
                        context, Icons.quick_contacts_mail_outlined, i.cedula)
                  ],
                ),
                trailing: ResponsiveWidget.isSmallScreen(context)
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          saveobs(context, i, desctl),
                          edit(context, i),
                          o_pickcolor(context, i)
                        ],
                      )
                    : SizedBox(
                        width: 220,
                        child: Row(
                          children: [
                            SizedBox(
                              width: 200,
                              child: TextField(
                                controller: desctl,
                                scrollPadding: EdgeInsets.all(0.0),
                                expands: true,
                                maxLines: null,
                                minLines: null,
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                saveobs(context, i, desctl),
                                edit(context, i),
                                o_pickcolor(context, i)
                              ],
                            )
                          ],
                        ),
                      ),
                subtitle: styledrop(
                  context,
                  Icons.location_city,
                  "${i.direccion} - ${i.distrito} - ${i.provincia} - ${i.departamento}",
                ),
              );
            },
            body: ListTile(
              subtitle: Column(
                children: [
                  styledrop(context, Icons.account_tree, i.cableadoutp),
                  styledrop(context, Icons.phonelink, i.plataforma),
                  styledrop(context, Icons.local_phone, i.fijo),
                  styledrop(context, Icons.location_on_sharp, i.cordenadas),
                  styledrop(context, Icons.request_quote_outlined, i.plan),
                  styledrop(context, Icons.record_voice_over_sharp, i.vendedor),
                  styledrop(context, Icons.group, i.grupo),
                  styledrop(context, Icons.email, i.email),
                ],
              ),
              trailing: const Icon(Icons.delete),
              // onTap: () {
              //   // .removeWhere((Item currentItem) => item == currentItem);
              // }
            ));
      }).toList(),
    );
  }

  Widget styledrop(context, IconData icon, String data) {
    return Row(
      children: [
        Icon(icon, size: 14, color: Theme.of(context).disabledColor),
        SizedBox(width: 5),
        Flexible(
          child: SelectableText(data, maxLines: 2, minLines: 1),
        )
      ],
    );
  }

  Widget saveobs(
      BuildContext context, ClientModel i, TextEditingController ctl) {
    return InkWell(
      child: Icon(Icons.save, size: 14),
      onTap: () => context.read<HomeProvider>().updateObs(i.reference.id, ctl),
    );
  }

  Widget edit(BuildContext context, ClientModel i) {
    return InkWell(
      child: Icon(Icons.edit, size: 14),
      onTap: () {
        context.read<PopupProvider>().getoneclient(i.reference.id);
        showDialog(
            context: context, builder: (BuildContext context) => EditClient());
      },
    );
  }

  Widget o_pickcolor(BuildContext context, ClientModel i) {
    return InkWell(
      child: Icon(Icons.color_lens_outlined, size: 14),
      onTap: () => showDialog<void>(
        context: context,
        builder: (_) => AlertDialog(
          content: OColorPicker(
            spacing: 3,
            boxBorder: OColorBoxBorder(color: Colors.black12, width: 1),
            selectedColor: currentColor,
            colors: primaryColorsPalette,
            onColorChange: (color) {
              print(color);
              context
                  .read<HomeProvider>()
                  .updatecolor(context, i.reference.id, color.value.toString());
              Navigator.of(context).pop();
            },
          ),
        ),
      ),
    );
  }
}
