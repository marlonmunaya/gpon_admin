import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gpon_admin/user_provider.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:gpon_admin/src/model.dart';

// Example holidays

class CalendarPage extends StatefulWidget {
  const CalendarPage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<CalendarPage>
    with TickerProviderStateMixin {
  Map<DateTime, List> _events;
  List _selectedEvents;
  AnimationController _animationController;
  CalendarController _calendarController;

  @override
  void initState() {
    super.initState();
    final provider = Provider.of<UserProvider>(context, listen: false);
    provider.setdate();
    provider.getcollectionmolycop();
    final _selectedDay = provider.selectedDay;
    _events = provider.eventos;

    _calendarController = CalendarController();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _calendarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<UserProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Calendar"),
        leading: IconButton(
            onPressed: () {
              prov.addUser("fullName", "company", "age");
            },
            icon: Icon(Icons.add)),
      ),
      body: Column(
        // mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildTableCalendarWithBuilders(prov),
              const SizedBox(width: 8.0),
              _buildButtons(),
            ],
          ),
          const SizedBox(height: 8.0),
          Expanded(child: _buildEventList2(prov)),
          // Expanded(child: _buildEventList(prov)),
          Expanded(child: _buildEventListmodel(prov)),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          prov.getcollectionmolycop();
        },
      ),
    );
  }

  // More advanced TableCalendar configuration (using Builders & Styles)
  Widget _buildTableCalendarWithBuilders(prov) {
    return Card(
      child: Container(
        height: 270,
        width: 270,
        child: TableCalendar(
          // locale: 'pl_PL',
          calendarController: _calendarController,
          events: prov.eventos,
          holidays: prov.holidays,
          initialCalendarFormat: CalendarFormat.month,
          formatAnimation: FormatAnimation.slide,
          startingDayOfWeek: StartingDayOfWeek.sunday,
          availableGestures: AvailableGestures.all,
          availableCalendarFormats: const {
            CalendarFormat.month: '',
            CalendarFormat.week: '',
          },
          calendarStyle: CalendarStyle(
            outsideDaysVisible: false,
            weekendStyle: TextStyle().copyWith(color: Colors.blue[800]),
            holidayStyle: TextStyle().copyWith(color: Colors.blue[800]),
          ),
          daysOfWeekStyle: DaysOfWeekStyle(
            weekendStyle: TextStyle().copyWith(color: Colors.blue[600]),
          ),
          headerStyle: HeaderStyle(
            centerHeaderTitle: true,
            formatButtonVisible: false,
          ),
          builders: CalendarBuilders(
            selectedDayBuilder: (context, date, _) {
              return FadeTransition(
                opacity:
                    Tween(begin: 0.0, end: 1.0).animate(_animationController),
                child: Container(
                  margin: const EdgeInsets.all(4.0),
                  padding: const EdgeInsets.only(top: 5.0, left: 6.0),
                  color: Colors.deepOrange[300],
                  width: 100,
                  height: 100,
                  child: Text(
                    '${date.day}',
                    style: TextStyle().copyWith(fontSize: 16.0),
                  ),
                ),
              );
            },
            todayDayBuilder: (context, date, _) {
              return Container(
                margin: const EdgeInsets.all(4.0),
                padding: const EdgeInsets.only(top: 5.0, left: 6.0),
                color: Colors.amber[400],
                width: 100,
                height: 100,
                child: Text(
                  '${date.day}',
                  style: TextStyle().copyWith(fontSize: 16.0),
                ),
              );
            },
            markersBuilder: (context, date, events, holidays) {
              final children = <Widget>[];
              if (events.isNotEmpty) {
                children.add(
                  Positioned(
                    right: 2,
                    bottom: 2,
                    child: _buildEventsMarker(date, events),
                  ),
                );
              }

              if (holidays.isNotEmpty) {
                children.add(
                  Positioned(
                    right: -2,
                    top: -2,
                    child: _buildHolidaysMarker(),
                  ),
                );
              }
              return children;
            },
          ),
          onDaySelected: (date, events, holidays) {
            prov.onDaySelected(date, events, holidays);
            _animationController.forward(from: 0.0);
          },
          onVisibleDaysChanged: prov.onVisibleDaysChanged,
          onCalendarCreated: prov.onCalendarCreated,
        ),
      ),
    );
  }

  Widget _buildEventsMarker(DateTime date, List events) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: _calendarController.isSelected(date)
            ? Colors.brown[500]
            : _calendarController.isToday(date)
                ? Colors.brown[300]
                : Colors.blue[400],
      ),
      width: 12.0,
      height: 12.0,
      child: Center(
        child: Text(
          '${events.length}',
          style: TextStyle().copyWith(
            color: Colors.white,
            fontSize: 12.0,
          ),
        ),
      ),
    );
  }

  Widget _buildHolidaysMarker() {
    return Icon(
      Icons.star_border,
      size: 20.0,
      color: Colors.blueGrey[800],
    );
  }

  Widget _buildButtons() {
    final dateTime = DateTime.now();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        ElevatedButton(
          child: Text('Mes'),
          onPressed: () {
            setState(() {
              _calendarController.setCalendarFormat(CalendarFormat.month);
            });
          },
        ),
        ElevatedButton(
          child: Text('Semana'),
          onPressed: () {
            setState(() {
              _calendarController.setCalendarFormat(CalendarFormat.week);
            });
          },
        ),
        ElevatedButton(
          child: Column(
            children: [
              Text("Hoy día"),
              Text('${dateTime.day}-${dateTime.month}-${dateTime.year}'),
            ],
          ),
          onPressed: () {
            _calendarController.setSelectedDay(
              DateTime(dateTime.year, dateTime.month, dateTime.day),
              runCallback: true,
            );
          },
        ),
      ],
    );
  }

  Widget _buildEventList(prov) {
    final List<dynamic> lista = prov.selectedEventos;
    return ListView(
      children: lista
          .map((event) => Container(
                decoration: BoxDecoration(
                  border: Border.all(width: 0.8),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                margin:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                child: ListTile(
                  title: Text(event.toString()),
                  onTap: () => print('$event tapped!'),
                ),
              ))
          .toList(),
    );
  }

  Widget _buildEventListmodel(prov) {
    final List<DevicesModel> lista = prov.model;
    if (lista == null) {
      return CircularProgressIndicator();
    } else {
      return ListView(
        children: lista
            .map((event) => Container(
                  decoration: BoxDecoration(
                    border: Border.all(width: 0.8),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  margin: const EdgeInsets.symmetric(
                      horizontal: 8.0, vertical: 4.0),
                  child: ListTile(
                    title: Text("hola"),
                    // title: Text(event.age),
                    onTap: () => print('tapped!'),
                  ),
                ))
            .toList(),
      );
    }
  }

  Widget _buildEventList2(context) {
    return DataTable(
      columnSpacing: 20,
      dataRowHeight: 20,
      headingRowHeight: 25,
      columns: <DataColumn>[
        DataColumn(
          label: Row(
            children: [
              Icon(Icons.report_sharp),
            ],
          ),
        ),
        DataColumn(
          label: Icon(Icons.person),
        ),
        DataColumn(
          label: Icon(Icons.smartphone),
        ),
        DataColumn(
          label: Icon(Icons.chrome_reader_mode),
        ),
        DataColumn(
          label: Icon(Icons.search),
        ),
      ],
      rows: <DataRow>[
        DataRow(
          cells: <DataCell>[
            DataCell(
              DropdownButton<String>(
                style: TextStyle(fontSize: 12),
                value: "One",
                onChanged: (String newValue) {
                  setState(() {
                    // dropdownValue = newValue;
                  });
                },
                items: <String>['One', 'Two', 'Free', 'Four']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
            DataCell(TextField(
              style: TextStyle(fontSize: 12),
              decoration:
                  InputDecoration(hintText: "Marlon Gabriel Munaya Lurita"),
            )),
            DataCell(TextField(
              // controller: context.watch<UserProvider>().counter,
              // controller: context.watch<UserProvider>().counter,
              style: TextStyle(fontSize: 12),
              keyboardType: TextInputType.name,
              decoration: InputDecoration(hintText: "937535378"),
            )),
            DataCell(TextField(
              style: TextStyle(fontSize: 12),
              decoration: InputDecoration(hintText: "70105063"),
            )),
            DataCell(IconButton(
              padding: EdgeInsets.all(0),
              icon: Icon(Icons.search),
              onPressed: () => context.increment(),
            )),
          ],
        ),
      ],
    );
  }
}
