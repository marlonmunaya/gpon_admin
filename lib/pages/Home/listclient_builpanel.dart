import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:o_color_picker/o_color_picker.dart';

import 'package:gpon_admin/src/model/model.dart';
import 'package:gpon_admin/src/popup/editclient.dart';
import 'package:gpon_admin/src/popup/popup_provider.dart';
import 'package:gpon_admin/pages/Home/home_provider.dart';
import 'package:gpon_admin/src/responsive/responsive.dart';

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
                  title: Wrap(
                    children: [
                      styledrop(context, Icons.account_circle, i.nombre),
                      styledrop(context, Icons.location_city,
                          "${i.direccion} - ${i.distrito} - ${i.provincia} - ${i.departamento}"),
                      styledrop(context, Icons.request_quote_outlined, i.plan),
                      styledrop(context, Icons.live_tv_rounded, i.deco),
                      styledrop(context, Icons.account_tree, i.cableadoutp),
                    ],
                  ),
                  trailing: ResponsiveWidget.isSmallScreen(context)
                      ? setting(context, i, observacion)
                      : Wrap(children: [
                          SizedBox(height: 40, child: crearobs(observacion)),
                          setting(context, i, observacion)
                        ]));
            },
            body: ListTile(
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    styledrop(context, Icons.smartphone, i.celular),
                    styledrop(
                        context, Icons.quick_contacts_mail_outlined, i.cedula),
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
                    ? crearobs(observacion)
                    : SizedBox()),
          )
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
            minLines: null));
  }

  Widget styledrop(context, IconData icon, String data) {
    return Wrap(
      children: [
        Icon(icon, size: 14),
        SizedBox(width: 5),
        SelectableText(data, maxLines: 2, minLines: 1)
      ],
    );
  }

  Widget setting(
      BuildContext context, ClientModel i, TextEditingController obs) {
    return GestureDetector(
      child: InkWell(
        radius: 10,
        child: Icon(Icons.more_vert_outlined, size: 18),
        onTap: () {},
      ),
      onTapDown: (TapDownDetails details) {
        _onTapDown(details, context, i, obs);
      },
    );
  }

  _onTapDown(TapDownDetails details, BuildContext context, ClientModel i,
      TextEditingController obs) async {
    var x = details.globalPosition.dx + 5;
    var y = details.globalPosition.dy;
    OverlayState overlayState = Overlay.of(context);

    OverlayEntry overlayEntry = OverlayEntry(
        builder: (context) => Positioned(
              top: y,
              left: x,
              child: Wrap(
                direction: Axis.vertical,
                children: [
                  saveobs(context, i, obs),
                  edit(context),
                  selectcolor(context),
                  copy()
                ],
              ),
            ));

    overlayState.insert(overlayEntry);
    await Future.delayed(Duration(seconds: 3));
    overlayEntry.remove();
  }

  Widget copy() {
    return button(
      icon: Icons.copy_rounded,
      color: i.color,
      onTap: () {
        Clipboard.setData(ClipboardData(
            text: "NOMBRE: ${i.nombre}\n" +
                "DNI: ${i.cedula}\n" +
                "CELULAR: ${i.celular}\n" +
                "PLAN: ${i.plan}\n" +
                "DIRECCION: ${i.plan}\n" +
                "GPS: https://maps.google.com/?q=${i.cordenadas}\n" +
                "DECOFICADOR: ${i.deco}\n" +
                "UTP: ${i.cableadoutp}\n"));
      },
    );
  }

  Widget selectcolor(BuildContext context) {
    return button(
      icon: Icons.color_lens_outlined,
      color: i.color,
      onTap: () => showDialog<void>(
          context: context,
          builder: (contextdialog) => AlertDialog(
                content: OColorPicker(
                  spacing: 3,
                  boxBorder: OColorBoxBorder(color: Colors.black12, width: 1),
                  selectedColor: currentColor,
                  colors: primaryColorsPalette,
                  onColorChange: (color) {
                    contextdialog
                        .read<HomeProvider>()
                        .updatecolor(i.reference.id, color.value.toString());
                    Navigator.of(contextdialog).pop();
                  },
                ),
              )),
    );
  }

  Widget edit(BuildContext context) {
    return button(
        icon: Icons.edit,
        color: i.color,
        onTap: () async {
          await context
              .read<PopupProvider>()
              .getoneclient(context, i.reference.id);
          await showDialog(
              context: context,
              builder: (BuildContext context1) => EditClient());
        });
  }

  Widget saveobs(
      BuildContext context, ClientModel i, TextEditingController obs) {
    return button(
        icon: Icons.save,
        color: i.color,
        onTap: () {
          context.read<PopupProvider>().setupdateguardar(false);
          context
              .read<HomeProvider>()
              .updateobservacion(i.reference.id, obs.text);
        });
  }

  Widget button({IconData icon, String color, Function onTap}) {
    return Container(
      height: 24,
      margin: EdgeInsets.all(2),
      child: FloatingActionButton(
        backgroundColor: Color(int.parse(color)),
        foregroundColor: Colors.black,
        onPressed: onTap,
        child: Icon(
          icon,
          size: 15,
        ),
      ),
    );
  }
}
