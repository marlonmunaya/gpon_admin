import 'dart:ui';
import 'package:flutter/material.dart';

import 'package:gpon_admin/src/model/model.dart';
import 'package:gpon_admin/src/popup/editclient.dart';
import 'package:gpon_admin/src/popup/popup_provider.dart';
import 'package:gpon_admin/pages/Home/home_provider.dart';
import 'package:gpon_admin/src/responsive/responsive.dart';

import 'package:provider/provider.dart';
import 'package:o_color_picker/o_color_picker.dart';

class BuildPanel extends StatelessWidget {
  final ClientModel i;

  BuildPanel(this.i);
  final Color currentColor = Colors.lightGreen[300];
  @override
  Widget build(BuildContext context) {
    final TextEditingController observacion = TextEditingController();
    observacion.text = i.observacion;
    return ExpansionPanelList.radio(
        expandedHeaderPadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
        elevation: 0,
        children: [
          ExpansionPanelRadio(
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
                      styledrop(context, Icons.quick_contacts_mail_outlined,
                          i.cedula),
                      styledrop(context, Icons.location_city,
                          "${i.direccion} - ${i.distrito} - ${i.provincia} - ${i.departamento}"),
                    ],
                  ),
                  trailing: ResponsiveWidget.isSmallScreen(context)
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            saveobs(context, i, observacion),
                            edit(context, i),
                            opickcolor(context, i)
                          ],
                        )
                      : SizedBox(
                          width: 230,
                          child: Row(
                            children: [
                              crearobs(observacion),
                              SizedBox(width: 10),
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  saveobs(context, i, observacion),
                                  edit(context, i),
                                  opickcolor(context, i)
                                ],
                              )
                            ],
                          ),
                        ),
                );
              },
              body: ListTile(
                  title: Column(
                    children: [
                      styledrop(context, Icons.request_quote_outlined, i.plan),
                      styledrop(context, Icons.live_tv_rounded, i.deco),
                      styledrop(context, Icons.account_tree, i.cableadoutp),
                      styledrop(context, Icons.email, i.email),
                      styledrop(context, Icons.phonelink, i.plataforma),
                      styledrop(
                          context, Icons.record_voice_over_sharp, i.vendedor),
                      styledrop(context, Icons.group, i.grupo),
                      styledrop(context, Icons.local_phone, i.fijo),
                      styledrop(context, Icons.location_on_sharp, i.cordenadas),
                      styledrop(context, Icons.location_on_sharp,
                          i.fechacaptacion.toString()),
                    ],
                  ),
                  trailing: ResponsiveWidget.isSmallScreen(context)
                      ? SizedBox(
                          height: 50,
                          child: crearobs(observacion),
                        )
                      : delete(context, i))),
        ]);
  }

  Widget crearobs(TextEditingController observacion) {
    return SizedBox(
      width: 200,
      child: TextField(
          controller: observacion,
          scrollPadding: EdgeInsets.all(0.0),
          expands: true,
          maxLines: null,
          minLines: null),
    );
  }

  Widget styledrop(context, IconData icon, String data) {
    return Row(
      children: [
        Icon(icon, size: 14, color: Theme.of(context).disabledColor),
        SizedBox(width: 5),
        Flexible(child: SelectableText(data, maxLines: 2, minLines: 1))
      ],
    );
  }

  Widget saveobs(
      BuildContext context, ClientModel i, TextEditingController obs) {
    return InkWell(
        child: Icon(Icons.save, size: 14),
        onTap: () {
          context.read<PopupProvider>().setupdateguardar(false);
          context
              .read<HomeProvider>()
              .updateobservacion(i.reference.id, obs.text);
        });
  }

  Widget edit(BuildContext context, ClientModel i) {
    return InkWell(
      child: Icon(Icons.edit, size: 14),
      onTap: () async {
        await context
            .read<PopupProvider>()
            .getoneclient(context, i.reference.id);
        await showDialog(
            context: context, builder: (BuildContext context) => EditClient());
      },
    );
  }

  Widget opickcolor(BuildContext context, ClientModel i) {
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
              context
                  .read<HomeProvider>()
                  .updatecolor(i.reference.id, color.value.toString());
              Navigator.of(context).pop();
            },
          ),
        ),
      ),
    );
  }

  Widget delete(BuildContext context, ClientModel i) {
    return InkWell(
      child: Icon(Icons.delete, size: 14),
      onTap: () {
        print("Delete");
      },
    );
  }
}
