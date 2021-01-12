import 'package:flutter/cupertino.dart';

enum NoteColor { Red, Green, Blue, Yellow, Orange, Violet, Cyan }

class Note {
  int id;
  String title;
  String content;
  NoteColor color;

  Note(
      {this.id,
      @required this.title = '',
      this.content,
      @required this.color = NoteColor.Orange});
}

var NOTES = <Note>[];
