import 'package:untitled1/database/DbHelper.dart';

class NoteModel {
  int? id;
  String title;
  String desc;

  NoteModel({required this.title, required this.desc, this.id});

  factory NoteModel.fromMap(Map<String, dynamic> map) {
    return NoteModel(
        title: map[DbHelper.NoteTitle],
        desc: map[DbHelper.NoteDecs],
        id: map[DbHelper.NoteId]);
  }

  Map<String, dynamic> ToMap() {
    return {
      DbHelper.NoteTitle: title,
      DbHelper.NoteDecs: desc,
      DbHelper.NoteId: id
    };
  }
}
