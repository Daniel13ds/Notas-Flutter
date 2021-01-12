import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum NoteColor { Red, Green, Blue, Yellow, Orange, Purple, Cyan }

class Note {
  int id;
  String title;
  String content;
  NoteColor color;

  final NoteColorMap = <NoteColor, Color>{
    NoteColor.Red: Colors.red,
    NoteColor.Green: Colors.green,
    NoteColor.Blue: Colors.blue,
    NoteColor.Yellow: Colors.yellow,
    NoteColor.Orange: Colors.orange,
    NoteColor.Purple: Colors.purple,
    NoteColor.Cyan: Colors.cyan,
  };

  Note(
      {this.id,
      @required this.title = '',
      this.content,
      @required this.color = NoteColor.Orange});

  getMaterialColor() {
    return NoteColorMap[color];
  }
}

var NOTES = <Note>[
  Note(title: 'Hola', content: 'Adios'),
  Note(title: 'Hello', content: 'Bye'),
  Note(title: 'Bonjour', content: 'Ar voir'),
];
