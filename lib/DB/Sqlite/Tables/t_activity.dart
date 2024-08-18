class TActivity {
  static const String tableName = "Activity";
  static const String id = "Id";
  static const String name = "Name";
  static const String index = "ActivityIndex";
  static const String lastDone = "LastDone";
  static const String notes = "Notes";

  static String createTable() {
    return """
      CREATE TABLE IF NOT EXISTS $tableName (
        $id TEXT PRIMARY KEY,
        $name TEXT NOT NULL,
        $index INTEGER NOT NULL,
        $lastDone TEXT NOT NULL,
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
