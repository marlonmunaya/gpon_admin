import 'package:flutter/material.dart';

class Clients extends StatefulWidget {
  @override
  _ClientsState createState() => _ClientsState();
}

class _ClientsState extends State<Clients> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Card(
              shadowColor: Colors.black,
              elevation: 3,
              child: Center(
                  child: Row(
                children: [
                  Column(
                    children: [
                      Row(
                        children: [
                          Icon(Icons.person),
                          Text('Marlon Gabriel Munaya Lurita'),
                          Icon(Icons.smartphone),
                          Text("937535378"),
                          Icon(Icons.chrome_reader_mode),
                          Text("70513049"),
                          Icon(Icons.devices_sharp),
                          Text("Plan 30Mbps"),
                          Icon(Icons.report_sharp),
                          Text("Programación")
                        ],
                      ),
                      Row(
                        children: [
                          Icon(Icons.add_location),
                          Text('Av Retablo 375, Urb villasol'),
                        ],
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        child: TextField(),
                        height: 20,
                        width: 20,
                        color: Colors.red,
                      )
                    ],
                  ),
                ],
              )),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context);
        },
        tooltip: 'regresar',
        child: Icon(Icons.arrow_forward_ios),
      ), // This trai
    );
  }
}

// Text('Nombre'),
// Text('Celular'),
// Text('Dirección'),
// Text('Estado'),
// Text('DNI'),
// Text('Plan'),
