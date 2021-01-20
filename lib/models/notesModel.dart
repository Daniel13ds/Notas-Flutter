import 'package:notas_flutter/services/notesApiService.dart';
import 'package:scoped_model/scoped_model.dart';
import 'note.dart';

class NotesModel extends Model {
  var _notes = <Note>[];

  NotesApiService api = NotesApiService();

  Future<List<Note>> get notes {
    return api.getNotes();
  }

  addNote(Note note) {
    _notes.add(note);
    notifyListeners();
  }

  removeNote(Note note) {
    _notes.remove(note);
    notifyListeners();
  }

  updateNote() {
    notifyListeners();
  }
}