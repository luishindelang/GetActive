class DsActivityDone {
  String _id;
  String _name;
  DateTime _date;
  String _notes;

  DsActivityDone(
    this._id,
    this._name,
    this._date,
    this._notes,
  );

  String get getId => _id;
  String get getName => _name;
  DateTime get getDate => _date;
  String get getNotes => _notes;

  set setId(String id) => _id = id;
  set setName(String name) => _name = name;
  set setDate(DateTime date) => _date = date;
  set setNotes(String notes) => _notes = notes;
}
