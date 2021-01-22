import 'package:notas_flutter/services/notesApiService.dart';
import 'package:scoped_model/scoped_model.dart';
import 'note.dart';

class NotesModel extends Model {
  var _notes = <Note>[];

  NotesApiService api = NotesApiService();

  Future<List<Note>> get notes {
    return api.getNotes();
  }

  Future<void> refresh() async => notifyListeners();

  addNote(Note note) async {
    await api.addNotes(note);
    notifyListeners();
  }

  Future<bool> removeNote(Note note) async {
    bool deleted = await api.removeNote(note);
    if (deleted) notifyListeners();
    return deleted;
  }

  updateNote() {
    notifyListeners();
  }
}
