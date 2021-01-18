import 'package:flutter/material.dart';
import 'package:notas_flutter/models/note.dart';

class ColorPicker extends StatefulWidget {
  void Function(NoteColor) onChanged;
  NoteColor initialValue;

  ColorPicker({this.onChanged, this.initialValue}) {}

  @override
  _ColorPickerState createState() => _ColorPickerState();
}

class _ColorPickerState extends State<ColorPicker> {
  NoteColor _selectedColor;
  @override
  Widget build(BuildContext context) {
    if (_selectedColor == null) _selectedColor = widget.initialValue;
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: NoteColor.values.map((NoteColor color) {
          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedColor = color;
              });
              widget.onChanged(_selectedColor);
            },
            child: Container(
              width: color == _selectedColor ? 35 : 30,
              height: color == _selectedColor ? 35 : 30,
              color: Note.getMaterialEnumColor(color),
            ),
          );
        }).toList());
  }
}
