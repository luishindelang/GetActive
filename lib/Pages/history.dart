import 'package:flutter/material.dart';
import 'package:getactive/Components/Widgets/c_history_box.dart';
import 'package:getactive/Components/Widgets/c_history_popup.dart';
import 'package:getactive/DB/DataStrukture/ds_activity_done.dart';
import 'package:getactive/DB/Sqlite/Dao/dao_activity_done.dart';
import 'package:getactive/Style/colors.dart';

class History extends StatefulWidget {
  const History({
    super.key,
    required this.name,
  });

  final String name;

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  List<DsActivityDone> activities = [];
  void loadHistory() async {
    List<DsActivityDone> list =
        await DaoActivityDone.getActivitiesByName(widget.name);
    setState(() {
      activities = list;
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
    loadHistory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: pageBackground,
      appBar: AppBar(
        foregroundColor: pinkForground,
        backgroundColor: pageBackground,
        title: Text("History of ${widget.name}"),
      ),
      body: Column(
        children: activities
            .map((value) => CHistoryBox(
                  activity: value,
                  onPressed: () => info(value),
                ))
            .toList(),
      ),
    );
  }
}
