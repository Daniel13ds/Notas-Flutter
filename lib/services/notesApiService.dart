import 'package:http/http.dart' as http;
import 'package:notas_flutter/models/note.dart';

class NotesApiService {
  static final baseUrl = 'http://192.168.1.41:3000';

  Future<List<Note>> getNotes() async {
    final response = await http.get("$baseUrl/notes");
    if (response.statusCode == 200) {
      return Note.notesFromJson(response.body);
    }
  }
}
