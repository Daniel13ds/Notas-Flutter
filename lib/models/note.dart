import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum NoteColor { Red, Green, Blue, Yellow, Orange, Purple, Cyan }

NoteColor enumFromString<T>(Iterable<NoteColor> values, String value) {
  return values.firstWhere(
    (type) => type.toString() == value,
    orElse: () => null,
  );
}

class Note {
  int id;
  String title;
  String content;
  NoteColor color;

  static final NoteColorMap = <NoteColor, Color>{
    NoteColor.Red: Colors.red,
    NoteColor.Green: Colors.greenAccent[400],
    NoteColor.Blue: Colors.blue,
    NoteColor.Yellow: Colors.yellow,
    NoteColor.Orange: Colors.orange,
    NoteColor.Purple: Colors.purpleAccent,
    NoteColor.Cyan: Colors.tealAccent[400],
  };

  Note(
      {this.id,
      @required this.title = '',
      this.content,
      @required this.color = NoteColor.Red});

  static Note fromMap(Map<String, dynamic> note) => Note(
      id: note['id'],
      title: note['title'],
      content: note['content'],
      color: enumFromString(NoteColor.values, note['color']));

  Map<String, dynamic> toMap() =>
      {"id": id, "title": title, "content": content, "color": color.toString()};

  static List<Note> notesFromJson(String jsonData) {
    final data = json.decode(jsonData);
    return List<Note>.from(data.map((note) => Note.fromMap(note)));
  }

  static fromJson(String jsonData) {
    final data = json.decode(jsonData);
    return fromMap(data);
  }

  toJson() => json.encode(toMap());

  void copyFrom(Note otherNote) {
    id = otherNote.id;
    title = otherNote.title;
    content = otherNote.content;
    color = otherNote.color;
  }

  getMaterialColor() {
    return NoteColorMap[color];
  }

  static Color getMaterialEnumColor(NoteColor color) {
    return NoteColorMap[color];
  }
}
