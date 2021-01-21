import 'package:http/http.dart' as http;
import 'package:notas_flutter/models/note.dart';

class NotesApiService {
  static final baseUrl = 'http://192.168.18.96:3000/notes';

  Future<List<Note>> getNotes() async {
    final response = await http.get(baseUrl);
    if (response.statusCode == 200) {
      return Note.notesFromJson(response.body);
    }
  }
}
