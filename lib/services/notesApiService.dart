import 'package:http/http.dart' as http;
import 'package:notas_flutter/models/note.dart';

class NotesApiService {
  static final baseUrl = 'http://192.168.1.41:3000';

  Future<List<Note>> getNotes() async {
    final response = await http.get(baseUrl + '/notes');
    if (response.statusCode == 200) {
      return Note.notesFromJson(response.body);
    }
  }

  Future<Note> addNotes(Note note) async {
    final response = await http.post(baseUrl + '/notes',
        headers: {"Content-type": "application/json"}, body: note.toJson());
    if (response.statusCode == 201) {
      return Note.fromJson(response.body);
    }
  }

  Future<bool> removeNote(Note note) async {
    try {
      final response = await http.delete(baseUrl + '/notes/${note.id}');
      if (response.statusCode == 200)
        return true;
      else
        return false;
    } catch (error) {
      return false;
    }
  }
}
