import 'package:getactive/DB/DataStrukture/ds_activity.dart';
import 'package:getactive/DB/Sqlite/Tables/t_activity.dart';
import 'package:getactive/DB/Sqlite/sql_connection.dart';

class DaoActivity {
  static Future<void> insertActivity(DsActivity activity) async {
    final db = await SqlConnection.instance.database;

    await db.insert(TActivity.tableName, {
      TActivity.id: activity.getId,
      TActivity.name: activity.getName,
      TActivity.index: activity.getIndex,
      TActivity.lastDone: activity.getLastDone.toString(),
      TActivity.notes: activity.getNotes,
    });
  }

  static Future<void> updateActivity(DsActivity activity) async {
    final db = await SqlConnection.instance.database;

    await db.update(
      TActivity.tableName,
      {
        TActivity.name: activity.getName,
        TActivity.lastDone: activity.getLastDone.toString(),
        TActivity.notes: activity.getNotes,
      },
      where: "${TActivity.id} = ?",
      whereArgs: [activity.getId],
    );
  }

  static Future<void> updateActivityIndexes(List<DsActivity> activities) async {
    final db = await SqlConnection.instance.database;

    int index = 1;
    for (var value in activities) {
      await db.update(
        TActivity.tableName,
        {TActivity.index: index},
        where: "${TActivity.id} = ?",
        whereArgs: [value.getId],
      );
      index++;
    }
  }

  static Future<List<DsActivity>> getAllActivities() async {
    final db = await SqlConnection.instance.database;
    List<DsActivity> finalData = [];

    List<Map> rawData = await db.query(
      TActivity.tableName,
      orderBy: "${TActivity.index} ASC",
    );
    for (var value in rawData) {
      finalData.add(DsActivity(
        value[TActivity.id],
        value[TActivity.name],
        value[TActivity.index],
        DateTime.parse(value[TActivity.lastDone]),
        value[TActivity.notes],
      ));
    }
    return finalData;
  }

  static Future<List<DsActivity>> searchActivity(String name) async {
    final db = await SqlConnection.instance.database;

    List<DsActivity> finalData = [];

    List<Map> rawData = await db.query(
      TActivity.tableName,
      where: "${TActivity.name} LIKE ?",
      whereArgs: ["%$name%"],
    );
    for (var value in rawData) {
      finalData.add(DsActivity(
        value[TActivity.id],
        value[TActivity.name],
        value[TActivity.index],
        DateTime.parse(value[TActivity.lastDone]),
        value[TActivity.notes],
      ));
    }
    return finalData;
  }

  static Future<void> deleteActivity(String id) async {
    final db = await SqlConnection.instance.database;

    await db.delete(
      TActivity.tableName,
      where: "${TActivity.id} = ?",
      whereArgs: [id],
    );
  }
}
