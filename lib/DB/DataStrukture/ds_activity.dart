class DsActivity {
  String _id;
  String _name;
  int _index;
  DateTime _lastDone;
  String _notes;

  DsActivity(
    this._id,
    this._name,
    this._index,
    this._lastDone,
    this._notes,
  );

  String get getId => _id;
  String get getName => _name;
  int get getIndex => _index;
  DateTime get getLastDone => _lastDone;
  String get getNotes => _notes;

  set setId(String id) => _id = id;
  set setName(String name) => _name = name;
  set setIndex(int index) => _index = index;
  set setLastDone(DateTime lastDone) => _lastDone = lastDone;
  set setNotes(String notes) => _notes = notes;
}
