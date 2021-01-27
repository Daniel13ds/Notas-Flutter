import 'package:notas_flutter/models/preferences.dart';
import 'package:notas_flutter/models/userCredentials.dart';
import 'package:notas_flutter/services/authApiService.dart';
import 'package:notas_flutter/services/notesApiService.dart';
import 'package:scoped_model/scoped_model.dart';
import 'note.dart';

class NotesModel extends Model {
  NotesApiService api = NotesApiService();
  AuthApiService authApi = AuthApiService();
  Preferences _preferences = Preferences();
  bool logged = false;

  Future<List<Note>> get notes {
    return api.getNotes();
  }

  Future<void> refresh() async => notifyListeners();

  addNote(Note note) async {
    await api.addNotes(note);
    notifyListeners();
  }

  removeNote(Note note) async {
    await api.removeNote(note);
    notifyListeners();
  }

  updateNote(Note note) async {
    await api.updateNote(note);
    notifyListeners();
  }

  Future<bool> login(UserCredentials credentials) async {
    final token = await authApi.login(credentials);
    if (token != null) {
      logged = true;
      _preferences.token = token;
    } else {
      logged = false;
      _preferences.token = null;
    }
    return logged;
  }
}
