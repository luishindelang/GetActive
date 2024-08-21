import 'package:flutter/material.dart';
import 'package:getactive/DB/DataStrukture/ds_activity_done.dart';

class CHistoryBox extends StatelessWidget {
  const CHistoryBox({
    super.key,
    required this.activity,
    required this.onPressed,
  });

  final DsActivityDone activity;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    DateTime d = activity.getDate;
    String month = d.month.toString().padLeft(2, "0");
    String day = d.day.toString().padLeft(2, "0");
    String date = "$day.$month.${d.year}";

    String hour = d.hour.toString().padLeft(2, "0");
    String min = d.minute.toString().padLeft(2, "0");
    String time = "$hour:$min";
    return Container(
      margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(5),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 1,
            spreadRadius: 1,
            offset: Offset(2, 2),
          )
        ],
      ),
      child: TextButton(
        style: ButtonStyle(
          overlayColor:
              WidgetStateProperty.all(Colors.pink[100]!.withOpacity(0.2)),
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
        ),
        onPressed: () => onPressed(),
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Row(
            children: [
              Text(
                date,
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.pink[200]!,
                ),
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(width: 20),
              Text(
                time,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.pink[100]!,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
