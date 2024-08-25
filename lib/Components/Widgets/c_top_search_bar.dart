import 'package:flutter/material.dart';
import 'package:getactive/DB/Sqlite/Dao/dao_activity_done.dart';
import 'package:getactive/Pages/calendar.dart';
import 'package:getactive/Style/colors.dart';

class CTopSearchBar extends StatelessWidget {
  const CTopSearchBar({
    super.key,
    required this.onSubmit,
    required this.search,
  });

  final Function(String) onSubmit;
  final String search;

  @override
  Widget build(BuildContext context) {
    void pop(route) {
      Navigator.of(context).push(route);
    }

    var controller = TextEditingController(text: search);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(width: 5),
            SizedBox(
              width: 250,
              child: Theme(
                data: Theme.of(context).copyWith(
                  textSelectionTheme: TextSelectionThemeData(
                    cursorColor: pinkForground,
                    selectionColor: pinkForground,
                    selectionHandleColor: pinkForground,
                  ),
                ),
                child: TextField(
                  style: TextStyle(
                    color: pinkText,
                  ),
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: const EdgeInsets.only(bottom: 0),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(width: 2, color: pinkForground),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(width: 2, color: pinkForground),
                    ),
                  ),
                  controller: controller,
                  onSubmitted: (value) => onSubmit(value),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, top: 5),
              child: IconButton(
                onPressed: () => onSubmit(controller.text),
                icon: Icon(
                  Icons.search_rounded,
                  size: 30,
                  color: pinkForground,
                ),
              ),
            ),
          ],
        ),
        IconButton(
          onPressed: () async {
            final data = await DaoActivityDone.getAllActivities();
            var route = MaterialPageRoute(
              builder: (BuildContext context) => Calendar(
                data: data,
              ),
            );
            pop(route);
          },
          icon: Icon(
            Icons.calendar_month_outlined,
            color: pinkForground,
            size: 30,
          ),
        )
      ],
    );
  }
}
