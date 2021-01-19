import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum NoteColor { Red, Green, Blue, Yellow, Orange, Purple, Cyan }

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

var NOTES = <Note>[
  //Note(title: 'Hola', content: 'Adios', color: NoteColor.Cyan),
  //Note(title: 'Hello', content: 'Bye', color: NoteColor.Green),
  //Note(title: 'Bonjour', content: 'Ar voir', color: NoteColor.Purple),
];
