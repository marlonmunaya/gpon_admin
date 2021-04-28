import 'package:flutter/material.dart';
import 'package:gpon_admin/pages/Home/listclient%20copy.dart';
import 'package:gpon_admin/pages/Home/listclient.dart';
import 'package:gpon_admin/pages/Home/widget.dart';
import 'package:gpon_admin/pages/Home/home_provider.dart';
import 'package:gpon_admin/pages/drag_list/draglist.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:gpon_admin/src/responsive/responsive.dart';
import 'package:gpon_admin/src/popup/editclient.dart';
import 'package:gpon_admin/src/popup/popup_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> with TickerProviderStateMixin {
  Map<DateTime, List> _events;
  List _selectedEvents;
  AnimationController _animationController;
  CalendarController _calendarController;
  GlobalKey<ScaffoldState> globalScaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    context.read<HomeProvider>().globalkey(globalScaffoldKey);
    context.read<PopupProvider>().globalkey(globalScaffoldKey);
    final provider = Provider.of<HomeProvider>(context, listen: false);
    print("conseguiendo");
    context.read<PopupProvider>().getutils();
    context.read<HomeProvider>().getclient();
    provider.setdate();
    // final _selectedDay = provider.selectedDay;
    _events = provider.eventos;
    _calendarController = CalendarController();
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 400));
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
    final prov = Provider.of<HomeProvider>(context);
    var screenSize = MediaQuery.of(context).size;

    return Scaffold(
        key: globalScaffoldKey,
        appBar: AppBar(
          title: Text("Administrador"),
          actions: [
            IconButton(
              icon: Icon(Icons.skip_next),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DragHandleExample()));
              },
            ),
            IconButton(
              icon: Icon(Icons.add_a_photo),
              onPressed: () {
                context.read<HomeProvider>().getlist();
              },
            )
          ],
        ),
        drawer: drawer(),
        body: ResponsiveWidget.isSmallScreen(context)
            ? SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    _buildTableCalendarWithBuilders(screenSize, prov),
                    const SizedBox(width: 8.0),
                    _buildButtons(),
                    const SizedBox(height: 8.0),
                    SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ClientListCopy(),
                          // ClientList()
                        ],
                      ),
                    ),
                  ],
                ),
              )
            : Row(
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      _buildTableCalendarWithBuilders(screenSize, prov),
                      const SizedBox(width: 8.0),
                      _buildButtons(),
                    ],
                  ),
                  SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ClientListCopy(),
                        // ClientList(),
                      ],
                    ),
                  )
                ],
              ),
        floatingActionButton: floatactionbutton(context));
  }

  // More advanced TableCalendar configuration (using Builders & Styles)
  Widget _buildTableCalendarWithBuilders(screenSize, prov) {
    return Card(
      child: Container(
        width: ResponsiveWidget.isSmallScreen(context)
            ? screenSize.width
            : screenSize.width * 0.29,
        child: TableCalendar(
            // locale: 'pl_PL',
            calendarController: _calendarController,
            events: prov.eventos,
            holidays: prov.holidays,
            initialCalendarFormat: CalendarFormat.week,
            formatAnimation: FormatAnimation.slide,
            startingDayOfWeek: StartingDayOfWeek.sunday,
            availableGestures: AvailableGestures.all,
            availableCalendarFormats: const {
              CalendarFormat.week: '',
              CalendarFormat.month: '',
            },
            calendarStyle: CalendarStyle(
                outsideDaysVisible: false,
                weekendStyle: TextStyle().copyWith(color: Colors.blue[800]),
                holidayStyle: TextStyle().copyWith(color: Colors.blue[800])),
            daysOfWeekStyle: DaysOfWeekStyle(
                weekendStyle: TextStyle().copyWith(color: Colors.blue[600])),
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
                    child: Text('${date.day}',
                        style: TextStyle().copyWith(fontSize: 16.0)),
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
                  child: Text('${date.day}',
                      style: TextStyle().copyWith(fontSize: 16.0)),
                );
              },
              markersBuilder: (context, date, events, holidays) {
                final children = <Widget>[];
                if (events.isNotEmpty) {
                  children.add(
                    Positioned(
                        right: 2,
                        bottom: 2,
                        child: _buildEventsMarker(date, events)),
                  );
                }
                if (holidays.isNotEmpty) {
                  children.add(
                    Positioned(
                        right: -2, top: -2, child: buildHolidaysMarker()),
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
            onCalendarCreated: prov.onCalendarCreated),
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

  Widget _buildButtons() {
    final dateTime = DateTime.now();
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        ElevatedButton(
          child: Text('Mes'),
          onPressed: () {
            setState(() {
              _calendarController.setCalendarFormat(CalendarFormat.month);
            });
          },
        ),
        box10(),
        ElevatedButton(
          child: Text('Semana'),
          onPressed: () {
            setState(() {
              _calendarController.setCalendarFormat(CalendarFormat.week);
            });
          },
        ),
        box10(),
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

  Widget box10() {
    return SizedBox(
      width: 10,
    );
  }
}
