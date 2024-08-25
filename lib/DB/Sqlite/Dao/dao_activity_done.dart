import 'package:getactive/DB/DataStrukture/ds_activity_done.dart';
import 'package:getactive/DB/Sqlite/Tables/t_activity_done.dart';
import 'package:getactive/DB/Sqlite/sql_connection.dart';

class DaoActivityDone {
  static Future<void> insertActivityDone(DsActivityDone activityDone) async {
    final db = await SqlConnection.instance.database;

    await db.insert(TActivityDone.tableName, {
      TActivityDone.id: activityDone.getId,
      TActivityDone.name: activityDone.getName,
      TActivityDone.date: activityDone.getDate.toString(),
      TActivityDone.notes: activityDone.getNotes,
    });
  }

  static Future<void> updateNotes(DsActivityDone activityDone) async {
    final db = await SqlConnection.instance.database;

    await db.update(
      TActivityDone.tableName,
      {TActivityDone.notes: activityDone.getNotes},
      where: "${TActivityDone.id} = ?",
      whereArgs: [activityDone.getId],
    );
  }

  static Future<List<DsActivityDone>> getAllActivities() async {
    final db = await SqlConnection.instance.database;
    List<DsActivityDone> finalData = [];

    List<Map> rawData = await db.query(TActivityDone.tableName);
    for (var value in rawData) {
      finalData.add(DsActivityDone(
        value[TActivityDone.id],
        value[TActivityDone.name],
        DateTime.parse(value[TActivityDone.date]),
        value[TActivityDone.notes],
      ));
    }
    return finalData;
  }

  static Future<List<DsActivityDone>> getActivitiesByName(String name) async {
    final db = await SqlConnection.instance.database;
    List<DsActivityDone> finalData = [];

    List<Map> rawData = await db.query(
      TActivityDone.tableName,
      where: "${TActivityDone.name} LIKE ?",
      whereArgs: ["%$name%"],
      orderBy: "${TActivityDone.date} DESC",
    );
    for (var value in rawData) {
      finalData.add(DsActivityDone(
        value[TActivityDone.id],
        value[TActivityDone.name],
        DateTime.parse(value[TActivityDone.date]),
        value[TActivityDone.notes],
      ));
    }
    return finalData;
  }

  static Future<List<DsActivityDone>> getActivitesByDate(String date) async {
    final db = await SqlConnection.instance.database;
    List<DsActivityDone> finalData = [];

    List<Map> rawData = await db.query(
      TActivityDone.tableName,
      where: "${TActivityDone.date} LIKE ?",
      whereArgs: ["%$date%"],
      orderBy: "${TActivityDone.date} ASC",
    );
    for (var value in rawData) {
      finalData.add(DsActivityDone(
        value[TActivityDone.id],
        value[TActivityDone.name],
        DateTime.parse(value[TActivityDone.date]),
        value[TActivityDone.notes],
      ));
    }
    return finalData;
  }
}
