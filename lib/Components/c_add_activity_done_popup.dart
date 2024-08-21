import 'package:flutter/material.dart';
import 'package:getactive/Components/c_text_button.dart';
import 'package:getactive/DB/DataStrukture/ds_activity.dart';

class CAddActivityDonePopup extends StatefulWidget {
  const CAddActivityDonePopup({
    super.key,
    required this.activity,
    required this.dateTime,
    required this.onPressed,
  });

  final DsActivity activity;
  final DateTime dateTime;
  final Function(DateTime) onPressed;

  @override
  State<CAddActivityDonePopup> createState() => _CAddActivityDonePopupState();
}

class _CAddActivityDonePopupState extends State<CAddActivityDonePopup> {
  late String date;
  late String time;
  late DateTime d;

  void setDate() {
    String month = d.month.toString().padLeft(2, "0");
    String day = d.day.toString().padLeft(2, "0");
    date = "$day.$month.${d.year}";

    String hour = d.hour.toString().padLeft(2, "0");
    String min = d.minute.toString().padLeft(2, "0");
    time = "$hour:$min";
  }

  @override
  void initState() {
    d = widget.dateTime;
    setDate();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CTextButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) => DatePickerDialog(
                      initialDate: d,
                      firstDate: d.subtract(const Duration(days: 365 * 2)),
                      lastDate: d.add(const Duration(days: 365 * 5)),
                    ),
                  ).then((value) {
                    if (value != null) {
                      setState(() {
                        String newDate = value.toString().split(" ")[0];
                        String oldTime =
                            widget.dateTime.toString().split(" ")[1];
                        d = DateTime.parse("$newDate $oldTime");
                        setDate();
                      });
                    }
                  });
                },
                text: date,
              ),
              CTextButton(
                onPressed: () {
                  TimeOfDay time = TimeOfDay.fromDateTime(d);
                  showTimePicker(
                    context: context,
                    initialTime: time,
                  ).then((newTime) {
                    if (newTime != null) {
                      setState(() {
                        d = DateTime(d.year, d.month, d.day, newTime.hour,
                            newTime.minute);
                        setDate();
                      });
                    }
                  });
                },
                text: time,
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CTextButton(
                onPressed: () => Navigator.pop(context),
                text: "Cancel",
              ),
              CTextButton(
                onPressed: () => widget.onPressed(d),
                text: "DO IT",
              ),
            ],
          ),
        ],
      ),
    );
  }
}
