import 'package:scoped_model/scoped_model.dart';
import 'note.dart';

class NotesModel extends Model {
  var _notes = <Note>[];

  get notes {
    return _notes;
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
