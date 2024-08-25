import 'package:flutter/material.dart';
import 'package:getactive/Components/Widgets/c_history_box.dart';
import 'package:getactive/Components/Widgets/c_history_popup.dart';
import 'package:getactive/DB/DataStrukture/ds_activity_done.dart';
import 'package:getactive/DB/Sqlite/Dao/dao_activity_done.dart';
import 'package:getactive/Style/colors.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendar extends StatefulWidget {
  const Calendar({
    super.key,
    required this.data,
  });

  final List<DsActivityDone> data;

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  final DateTime _now = DateTime.now();
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();

  List<DsActivityDone> _eventList = [];

  Map<DateTime, List<String>> getEvents() {
    Map<DateTime, List<String>> events = {};

    for (var value in widget.data) {
      int year = value.getDate.year;
      int month = value.getDate.month;
      int day = value.getDate.day;
      DateTime utc = DateTime.utc(year, month, day);
      if (events.containsKey(utc)) {
        events[utc]!.add("");
      } else {
        events.addAll({
          utc: [""]
        });
      }
    }
    return events;
  }

  void loadEvents(String date) async {
    var data = await DaoActivityDone.getActivitesByDate(date);
    setState(() {
      _eventList = data;
    });
  }

  void info(DsActivityDone activity) {
    showDialog(
      context: context,
      builder: (BuildContext context) => CHistoryPopup(
        activity: activity,
      ),
    );
  }

  @override
  void initState() {
    loadEvents(_focusedDay.toString().split(" ")[0]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: pageBackground,
      appBar: AppBar(
        foregroundColor: pinkForground,
        backgroundColor: pageBackground,
        title: const Text("Calendar"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TableCalendar(
              focusedDay: _focusedDay,
              availableCalendarFormats: const {CalendarFormat.month: "Month"},
              firstDay: _now.subtract(const Duration(days: 365 * 5)),
              lastDay: _now.add(const Duration(days: 365 * 1)),
              startingDayOfWeek: StartingDayOfWeek.monday,
              selectedDayPredicate: (day) {
                return isSameDay(_selectedDay, day);
              },
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                  String date = focusedDay.toString().split(" ")[0];
                  loadEvents(date);
                });
              },
              eventLoader: (day) {
                return getEvents()[day] ?? [];
              },
              calendarStyle: CalendarStyle(
                todayDecoration: BoxDecoration(
                  color: pinkBackgound,
                  shape: BoxShape.circle,
                ),
                selectedDecoration: BoxDecoration(
                  color: pinkForground,
                  shape: BoxShape.circle,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Column(
              children: _eventList
                  .map(
                    (value) => CHistoryBox(
                      activity: value,
                      onPressed: () => info(value),
                      showName: true,
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
