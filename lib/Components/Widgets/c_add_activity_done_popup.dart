import 'package:flutter/material.dart';
import 'package:getactive/Components/Widgets/c_edit_box.dart';
import 'package:getactive/Components/Elements/c_text_button.dart';
import 'package:getactive/Components/Widgets/c_date_picker.dart';
import 'package:getactive/Components/Widgets/c_time_picker.dart';
import 'package:getactive/DB/DataStrukture/ds_activity.dart';
import 'package:getactive/Style/colors.dart';

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
      backgroundColor: boxBackground,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          Text(
            widget.activity.getName,
            style: TextStyle(
              color: pinkText,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CTextButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => CDatePicker(initialDate: d),
                  ).then((date) {
                    if (date != null) {
                      setState(() {
                        String newDate = date.toString().split(" ")[0];
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
                  showDialog(
                    context: context,
                    builder: (context) => CTimePicker(initialTime: time),
                  ).then((time) {
                    if (time != null) {
                      setState(() {
                        d = DateTime(
                          d.year,
                          d.month,
                          d.day,
                          time.hour,
                          time.minute,
                        );
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
          CEditBox(
            activity: widget.activity,
            onHistoryPressed: () {},
            showHistory: false,
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
