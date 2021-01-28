import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:notas_flutter/models/note.dart';

class NotesApiService {
  static final baseUrl = 'http://192.168.1.41:3000';
  String token;

  NotesApiService(this.token);

  int _getUserIdFromToken(String token) {
    final mapJwt = JwtDecoder.decode(token);
    return int.parse(mapJwt['sub']);
  }

  Future<List<Note>> getNotes() async {
    final response = await http
        .get(baseUrl + '/notes', headers: {"Authorization": "Bearer $token"});
    if (response.statusCode == 200) {
      final mapJwt = JwtDecoder.decode(token);
      final userId = _getUserIdFromToken(token);
      return Note.notesFromJson(response.body, userId);
    }
  }

  Future<Note> addNotes(Note note) async {
    final userId = _getUserIdFromToken(token);
    note.userId = userId;
    final response = await http.post(baseUrl + '/notes',
        headers: {
          "Content-type": "application/json",
          "Authorization": "Bearer $token"
        },
        body: note.toJson());
    if (response.statusCode == 201) return Note.fromJson(response.body);
  }

  Future<bool> removeNote(Note note) async {
    try {
      final response = await http.delete(baseUrl + '/notes/${note.id}',
          headers: {"Authorization": "Bearer $token"});
      if (response.statusCode == 200)
        return true;
      else
        return false;
    } catch (error) {
      return false;
    }
  }

  Future<bool> updateNote(Note note) async {
    try {
      final response = await http.put(baseUrl + '/notes/${note.id}',
          headers: {
            "Content-type": "application/json",
            "Authorization": "Bearer $token"
          },
          body: note.toJson());
      if (response.statusCode == 200)
        return true;
      else
        return false;
    } catch (error) {
      return false;
    }
  }
}
