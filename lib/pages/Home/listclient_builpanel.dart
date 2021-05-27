import 'dart:ui';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gpon_admin/pages/Home/widget.dart';
import 'package:provider/provider.dart';
import 'package:o_color_picker/o_color_picker.dart';

import 'package:gpon_admin/src/model/model.dart';
import 'package:gpon_admin/src/popup/editclient.dart';
import 'package:gpon_admin/src/popup/popup_provider.dart';
import 'package:gpon_admin/pages/Home/home_provider.dart';
import 'package:gpon_admin/src/responsive/responsive.dart';
import 'package:url_launcher/url_launcher.dart';

class BuildPanel extends StatelessWidget {
  final ClientModel i;
  BuildPanel(this.i);
  final Color currentColor = Colors.lightGreen[300];
  @override
  Widget build(BuildContext context) {
    final formato = context.watch<PopupProvider>().formatocompleto;
    OverlayEntry overlayEntry = context.watch<PopupProvider>().overlay;

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
                leading: fechainsta(context, i),
                title: Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          styledrop(Icons.miscellaneous_services_rounded,
                              i.servicios),
                          styledrop(Icons.account_circle, i.nombre),
                          styledrop(Icons.location_city,
                              "${i.direccion} - ${i.distrito} - ${i.provincia} - ${i.departamento}"),
                          styledrop(Icons.request_quote_outlined, i.plan),
                          styledrop(Icons.live_tv_rounded, i.deco),
                          styledrop(Icons.account_tree, i.cableadoutp),
                        ],
                      ),
                    ),
                    SizedBox(width: 5),
                    ResponsiveWidget.isSmallScreen(context)
                        ? SizedBox()
                        : Expanded(
                            flex: 1,
                            child: lastobs(i.observaciones.isEmpty
                                ? ""
                                : i.observaciones.last))
                  ],
                ),
                trailing: setting(context, i, overlayEntry),
              );
            },
            body: Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        styledrop(Icons.smartphone, i.celular),
                        styledrop(Icons.quick_contacts_mail_outlined, i.cedula),
                        styledrop(Icons.email, i.email),
                        styledrop(Icons.phonelink, i.plataforma),
                        styledrop(Icons.record_voice_over_sharp, i.vendedor),
                        styledrop(Icons.group, i.grupo),
                        styledrop(Icons.local_phone, i.fijo),
                        linkstyledrop(Icons.location_on_sharp, i.cordenadas),
                        styledrop(Icons.power_outlined, i.puerto),
                        linkstyledrop(Icons.check_box_outline_blank, i.cajanap),
                        styledrop(Icons.date_range_rounded,
                            formato.format(i.fechacaptacion)),
                      ],
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(child: observaciones(context, i)),
                ],
              ),
            ),
          )
        ]);
  }

  Widget observaciones(BuildContext context, ClientModel i) {
    List<String> observacioneslist = i.observaciones;
    return Container(
        height: 150,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Wrap(
                runSpacing: 3.0,
                children: observacioneslist.map<Row>((String a) {
                  final TextEditingController texto = TextEditingController();
                  texto.text = a;
                  return Row(
                    children: [
                      Expanded(
                        child: Chip(
                            label: TextField(
                                maxLines: 2,
                                minLines: 1,
                                readOnly: true,
                                decoration: InputDecoration(
                                  isDense: true,
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide.none),
                                  contentPadding:
                                      EdgeInsets.fromLTRB(6, 0, 0, 6),
                                ),
                                controller: texto)),
                      ),
                      circlebutton(
                          icon: Icons.close,
                          color: i.color,
                          onTap: () async {
                            observacioneslist.remove(a);
                            await context
                                .read<HomeProvider>()
                                .updateobservaciones(
                                    i.reference.id, observacioneslist);
                          })
                    ],
                  );
                }).toList(),
              ),
              crearobs(context, i)
            ],
          ),
        ));
  }

  Widget crearobs(BuildContext context, ClientModel i) {
    final TextEditingController ctlobs = TextEditingController();
    return Container(
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: ctlobs,
              decoration: InputDecoration(
                  hintText: "Ingresa la observación", isDense: true),
            ),
          ),
          saveobs(context, i, ctlobs)
        ],
      ),
    );
  }

  Widget styledrop(IconData icon, String data) {
    return Text.rich(
      TextSpan(children: [
        WidgetSpan(child: Icon(icon, size: 14)),
        WidgetSpan(child: SelectableText(' ' + data)),
      ]),
    );
  }

  Widget linkstyledrop(IconData icon, String link) {
    return Text.rich(TextSpan(children: [
      WidgetSpan(child: Icon(icon, size: 14)),
      TextSpan(
        text: link.toString(),
        style: TextStyle(fontSize: 12, color: Colors.blue),
        recognizer: TapGestureRecognizer()
          ..onTap = () async {
            String url = "https://maps.google.com/?q=$link";
            if (await canLaunch(url)) {
              await launch(url);
            } else {
              throw 'Could not launch $url';
            }
          },
      )
    ]));
  }

  Widget lastobs(String a) {
    final TextEditingController texto = TextEditingController();
    texto.text = a;
    return ConstrainedBox(
      constraints: BoxConstraints(minWidth: 200),
      child: Chip(
          label: TextField(
              maxLines: 2,
              minLines: 1,
              readOnly: true,
              decoration: InputDecoration(
                isDense: true,
                border: OutlineInputBorder(borderSide: BorderSide.none),
                contentPadding: EdgeInsets.fromLTRB(6, 0, 0, 6),
              ),
              controller: texto)),
    );
  }

  Widget setting(
      BuildContext context, ClientModel i, OverlayEntry overlayEntry) {
    return GestureDetector(
      child: circlebutton(
        icon: Icons.more_vert_outlined,
        color: i.color,
        onTap: () {},
      ),
      onTapDown: (TapDownDetails details) {
        context.read<PopupProvider>().buttonState
            ? _onTapDown(details, context, i, overlayEntry)
            : print("");
      },
    );
  }

  _onTapDown(TapDownDetails details, BuildContext context, ClientModel i,
      OverlayEntry overlay) async {
    var x = details.globalPosition.dx + 5;
    var y = details.globalPosition.dy;
    OverlayState overlayState = Overlay.of(context);

    overlay = OverlayEntry(
        builder: (context) => Positioned(
              top: y,
              left: x,
              child: Wrap(
                direction: Axis.vertical,
                children: [
                  edit(context),
                  selectcolor(context),
                  copy(context),
                  // createAlbum(context)
                ],
              ),
            ));

    overlayState.insert(overlay);
    context.read<PopupProvider>().insertoverlay(overlay);
    delay(context);
  }

  void delay(BuildContext context) {
    Future.delayed(Duration(seconds: 3), () {
      if (context.read<PopupProvider>().buttonState == false) {
        context.read<PopupProvider>().removeoverlay();
        print("Inicio");
      } else {
        print("finished");
      }
    });
  }

  Widget copy(BuildContext context) {
    final formato = context.watch<PopupProvider>().formatocompleto;
    return circlebutton(
      icon: Icons.copy_rounded,
      color: i.color,
      onTap: () {
        context.read<PopupProvider>().removeoverlay();
        final String obs = i.observaciones.isEmpty ? "" : i.observaciones.last;
        Clipboard.setData(ClipboardData(
            text: "*----  HORARIO: ${formato.format(i.fechainstalacion)}  ----*\n" +
                "*SERVICIO: ${i.servicios}*\n" +
                "*NOMBRE:* ${i.nombre}\n" +
                "*DNI:* ${i.cedula}\n" +
                "*CELULAR:* ${i.celular}\n" +
                "*PLAN:* ${i.plan}\n" +
                "*DIRECCION:* ${i.direccion} - ${i.distrito}\n" +
                "*GPS:* https://maps.google.com/?q=${i.cordenadas}\n" +
                "*DECOFICADOR:* ${i.deco}\n" +
                "*UTP:* ${i.cableadoutp}\n" +
                "*CAJA NAP:* https://maps.google.com/?q=${i.cajanap}\n" +
                "*PUERTO:* ${i.puerto}\n" +
                "*OBSERVACION:* $obs\n" +
                "*cliente-NAP:* https://www.google.com/maps/dir/${i.cordenadas}/${i.cajanap}//@${i.cordenadas},17z"));
      },
    );
  }

  Widget selectcolor(BuildContext context) {
    return circlebutton(
        icon: Icons.color_lens_outlined,
        color: i.color,
        onTap: () {
          showDialog<void>(
              context: context,
              builder: (contextdialog) => AlertDialog(
                    content: OColorPicker(
                      spacing: 3,
                      boxBorder:
                          OColorBoxBorder(color: Colors.black12, width: 1),
                      selectedColor: currentColor,
                      colors: primaryColorsPalette,
                      onColorChange: (color) {
                        contextdialog.read<HomeProvider>().updatecolor(
                            i.reference.id, color.value.toString());
                        Navigator.of(contextdialog).pop();
                      },
                    ),
                  ));
          context.read<PopupProvider>().removeoverlay();
        });
  }

  Widget edit(BuildContext context) {
    return circlebutton(
        icon: Icons.edit,
        color: i.color,
        onTap: () async {
          // context.read<PopupProvider>().removeoverlay();
          await context
              .read<PopupProvider>()
              .getoneclient(context, i.reference.id);
          await showDialog(
              context: context,
              builder: (BuildContext context1) => EditClient());
        });
  }

  Widget createAlbum(BuildContext context) {
    return circlebutton(
        icon: Icons.settings_ethernet_rounded,
        color: i.color,
        onTap: () async {
          // context.read<PopupProvider>().fetching();
        });
  }

  Widget saveobs(
      BuildContext context, ClientModel i, TextEditingController ctlobs) {
    return circlebutton(
        icon: Icons.send,
        color: i.color,
        onTap: () {
          List<String> observaciones = i.observaciones;
          observaciones.insert(i.observaciones.length, ctlobs.text);
          context
              .read<HomeProvider>()
              .updateobservaciones(i.reference.id, observaciones);
          ctlobs.text = "";
        });
  }

  Widget fechainsta(BuildContext context, ClientModel i) {
    final formatohora = context.watch<PopupProvider>().formatohora;
    return FloatingActionButton(
        backgroundColor:
            i.color.isEmpty ? Colors.white60 : Color(int.parse(i.color)),
        foregroundColor: Colors.black,
        child: Text(formatohora.format(i.fechainstalacion)),
        onPressed: () =>
            context.read<HomeProvider>().updatefechainst(context, i));
  }
}
