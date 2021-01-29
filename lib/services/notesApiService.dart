import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:notas_flutter/models/note.dart';
import 'package:notas_flutter/services/apiService.dart';

class NotesApiService extends ApiService {
  NotesApiService(token) : super(token);

  Future<List<Note>> getNotes() async {
    final response = await http.get(ApiService.baseUrl + '/notes',
        headers: {"Authorization": "Bearer $token"});
    if (response.statusCode == 200) {
      final mapJwt = JwtDecoder.decode(token);
      final userId = getUserIdFromToken();
      return Note.notesFromJson(response.body, userId);
    }
  }

  Future<Note> addNotes(Note note) async {
    final userId = getUserIdFromToken();
    note.userId = userId;
    final response = await http.post(ApiService.baseUrl + '/notes',
        headers: {
          "Content-type": "application/json",
          "Authorization": "Bearer $token"
        },
        body: note.toJson());
    if (response.statusCode == 201) return Note.fromJson(response.body);
  }

  Future<bool> removeNote(Note note) async {
    try {
      final response = await http.delete(
          ApiService.baseUrl + '/notes/${note.id}',
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
      final response = await http.put(ApiService.baseUrl + '/notes/${note.id}',
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
