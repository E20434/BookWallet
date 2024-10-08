import 'dart:convert';
import 'package:book_wallert/controllers/token_controller.dart';
import 'package:book_wallert/functions/global_user_provider.dart';
import 'package:book_wallert/ipaddress.dart';
import 'package:book_wallert/models/user.dart';
import 'package:http/http.dart' as http;

class UserApiService {
  static final String _baseUrl = '${ip}/api/auth';

  Future<User> editUserDetailsService(String username, String email,
      String password, String description) async {
    if (globalUser == null) {
      throw Exception('User is not logged in');
    }
    print('$_baseUrl/updatealldetails/${globalUser!.userId}');
    final token = await getToken();
    if (token == null) {
      throw Exception('Session has expired. Please login again.');
    }
    final response = await http.put(
      Uri.parse('$_baseUrl/updatealldetails/${globalUser!.userId}'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'username': username,
        'email': email,
        'password': password,
        'description': description,
        'token': token,
      }),
    );
    print(response.body);
    if (response.statusCode == 200) {
      return User(
          userId: int.parse(jsonDecode(response.body)['user']['userId']),
          username: jsonDecode(response.body)['user']['username'],
          email: jsonDecode(response.body)['user']['email'],
          description: jsonDecode(response.body)['user']['description']);
    } else {
      throw Exception('Failed to update');
    }
  }
}
