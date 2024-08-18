class TActivityDone {
  static const String tableName = "ActivityDone";
  static const String id = "Id";
  static const String name = "Name";
  static const String date = "Date";
  static const String notes = "Notes";

  static String createTable() {
    return """
      CREATE TABLE IF NOT EXISTS $tableName (
        $id TEXT PRIMARY KEY,
        $name TEXT NOT NULL,
        $date TEXT NOT NULL,
        $notes TEXT NOT NULL
      );
    """;
  }

  static String deleteTable() {
    return """
      DROP TABLE IF EXISTS $tableName;
    """;
  }
}
