import 'package:notas_flutter/services/notesApiService.dart';
import 'package:scoped_model/scoped_model.dart';
import 'note.dart';

class NotesModel extends Model {
  NotesApiService api = NotesApiService();

  Future<List<Note>> get notes {
    return api.getNotes();
  }

  Future<void> refresh() async => notifyListeners();

  addNote(Note note) async {
    bool added = await api.addNotes(note);
    if (added) notifyListeners();
    return added;
  }

  Future<bool> removeNote(Note note) async {
    bool deleted = await api.removeNote(note);
    if (deleted) notifyListeners();
    return deleted;
  }

  Future<bool> updateNote(Note note) async {
    bool updated = await api.updateNote(note);
    if (updated) notifyListeners();
    return updated;
  }
}
