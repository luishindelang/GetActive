import 'package:flutter/material.dart';
import 'package:getactive/Components/c_activity_box.dart';
import 'package:getactive/Components/c_add_activity_done_popup.dart';
import 'package:getactive/Components/c_add_button.dart';
import 'package:getactive/Components/c_add_popup.dart';
import 'package:getactive/Components/c_edit_popup.dart';
import 'package:getactive/Components/c_info_popup.dart';
import 'package:getactive/Components/c_reorderable_list.dart';
import 'package:getactive/Components/c_top_search_bar.dart';
import 'package:getactive/DB/DataStrukture/ds_activity.dart';
import 'package:getactive/DB/DataStrukture/ds_activity_done.dart';
import 'package:getactive/DB/Service/s_uuid.dart';
import 'package:getactive/DB/Sqlite/Dao/dao_activity.dart';
import 'package:getactive/DB/Sqlite/Dao/dao_activity_done.dart';
import 'package:getactive/Pages/history.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<DsActivity> activities = [];
  String searchName = "";

  void pop() {
    Navigator.pop(context);
  }

  void add() {
    showDialog(
      context: context,
      builder: (BuildContext context) => CAddPopup(
        index: activities.length + 1,
      ),
    ).then(
      (value) => loadActivities(),
    );
  }

  void activity(DsActivity activity) async {
    DateTime dateTime = DateTime.now();
    showDialog(
      context: context,
      builder: (BuildContext context) => CAddActivityDonePopup(
          activity: activity,
          dateTime: dateTime,
          onPressed: (newDateTime) async {
            activity.setLastDone = newDateTime;
            await DaoActivity.updateActivity(activity);
            await DaoActivityDone.insertActivityDone(DsActivityDone(
              uuid(),
              activity.getName,
              activity.getLastDone,
              activity.getNotes,
            ));
            activities.remove(activity);
            activities.add(activity);
            await DaoActivity.updateActivityIndexes(activities);
            loadActivities();
            pop();
          }),
    );
  }

  void edit(DsActivity activity) {
    showDialog(
      context: context,
      builder: (BuildContext context) => CEditPopup(activity: activity),
    ).then(
      (value) => loadActivities(),
    );
  }

  void info(DsActivity activity) {
    showDialog(
      context: context,
      builder: (BuildContext context) => CInfoPopup(
        activity: activity,
        onHistoryPressed: () => routeEntries(activity.getName),
      ),
    ).then(
      (value) {
        loadActivities();
      },
    );
  }

  void routeEntries(String name) {
    var route = MaterialPageRoute(
      builder: (BuildContext context) => History(name: name),
    );
    Navigator.of(context).push(route);
  }

  void loadActivities() async {
    List<DsActivity> list = [];
    if (searchName.isEmpty) {
      list = await DaoActivity.getAllActivities();
    } else {
      list = await DaoActivity.searchActivity(searchName);
    }
    setState(() {
      activities = list;
    });
  }

  @override
  void initState() {
    loadActivities();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 247, 245, 246),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 247, 245, 246),
        title: CTopSearchBar(
          search: searchName,
          onSubmit: (value) {
            searchName = value;
            loadActivities();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              CReorderableList(
                list: activities,
                child: (value) {
                  return CActivityBox(
                    activity: value,
                    onActivityPressed: () => activity(value),
                    onEditPressed: () => edit(value),
                    onInfoPressed: () => info(value),
                  );
                },
                onChanged: () async {
                  await DaoActivity.updateActivityIndexes(activities);
                  loadActivities();
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: CAddButton(onPressed: () => add()),
    );
  }
}
