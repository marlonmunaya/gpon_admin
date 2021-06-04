import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

import 'package:gpon_admin/pages/Home/home_provider.dart';
import 'package:gpon_admin/src/popup/popup_provider.dart';
import 'package:gpon_admin/pages/Home/widget.dart';

class CalendarComponent extends StatefulWidget {
  @override
  _CalendarComponentState createState() => _CalendarComponentState();
}

class _CalendarComponentState extends State<CalendarComponent>
    with TickerProviderStateMixin {
  Map<DateTime, List> _events;
  AnimationController _animationController;
  CalendarController _calendarController;

  @override
  void initState() {
    super.initState();
    final provider = Provider.of<HomeProvider>(context, listen: false);
    print("conseguiendo");
    provider.setdate();
    context.read<PopupProvider>().getutils();
    context.read<HomeProvider>().getclient();
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
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        _calendar(prov),
        SizedBox(width: 8.0),
        _buildButtons(),
        SizedBox(width: 8.0),
        seguimiento(context)
      ],
    );
  }

  Widget _calendar(prov) {
    return Card(
      child: TableCalendar(
          locale: 'es',
          calendarController: _calendarController,
          events: prov.eventos,
          holidays: prov.holidays,
          initialCalendarFormat: CalendarFormat.week,
          formatAnimation: FormatAnimation.slide,
          startingDayOfWeek: StartingDayOfWeek.monday,
          availableGestures: AvailableGestures.all,
          availableCalendarFormats: {
            CalendarFormat.week: '',
            CalendarFormat.month: ''
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
                  constraints: BoxConstraints.expand(),
                  margin: const EdgeInsets.all(4.0),
                  padding: const EdgeInsets.all(5.0),
                  color: Theme.of(context).primaryColor,
                  child: Text('${date.day}',
                      style: TextStyle().copyWith(fontSize: 18.0)),
                ),
              );
            },
            todayDayBuilder: (context, date, _) {
              return Container(
                constraints: BoxConstraints.expand(),
                margin: const EdgeInsets.all(4.0),
                padding: const EdgeInsets.all(5.0),
                color: Theme.of(context).disabledColor,
                child: Text('${date.day}',
                    style: TextStyle().copyWith(fontSize: 18.0)),
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
                  Positioned(right: -2, top: -2, child: buildHolidaysMarker()),
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
    );
  }

  Widget _buildEventsMarker(DateTime date, List events) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: _calendarController.isSelected(date)
            ? Theme.of(context).disabledColor
            : _calendarController.isToday(date)
                ? Theme.of(context).disabledColor
                : Theme.of(context).primaryColor,
      ),
      width: 14.0,
      height: 14.0,
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
        SizedBox(width: 10),
        ElevatedButton(
          child: Text('Semana'),
          onPressed: () {
            setState(() {
              _calendarController.setCalendarFormat(CalendarFormat.week);
            });
          },
        ),
        SizedBox(width: 10),
        ElevatedButton(
          child: Column(
            children: [
              Text("Hoy día"),
              Text('${dateTime.day}-${dateTime.month}-${dateTime.year}'),
            ],
          ),
          onPressed: () => _calendarController.setSelectedDay(
            DateTime(dateTime.year, dateTime.month, dateTime.day),
            runCallback: true,
          ),
        ),
      ],
    );
  }

  Widget seguimiento(BuildContext context) {
    var seguimiento = context.watch<PopupProvider>().seguimiento?.seguimiento;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: Wrap(
        spacing: 5.0,
        runSpacing: 5.0,
        children: seguimiento == null
            ? []
            : seguimiento.entries.map<Chip>((a) {
                return Chip(
                  label: Text(
                    a.value["etiqueta"],
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  backgroundColor:
                      Color(int.parse(a.value["color"], radix: 16)),
                );
              }).toList(),
      ),
    );
  }
}
