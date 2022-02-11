class NoteModel {
  int id;
  String title;
  String body;
  DateTime creation_date;

  NoteModel(
      {required this.id,
      required this.body,
      required this.title,
      required this.creation_date});

  //creating a function to convert our item a map

  Map<String, dynamic> toMap() {
    return ({
      "id": id,
      "title": title,
      "body": body,
      "creation_date": creation_date
    });
  }
}
